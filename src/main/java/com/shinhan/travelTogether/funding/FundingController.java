package com.shinhan.travelTogether.funding;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shinhan.travelTogether.member.MemberDTO;
import com.shinhan.travelTogether.photo.PhotoDTO;
import com.shinhan.travelTogether.photo.PhotoService;
import com.shinhan.travelTogether.theme.FundingThemeDTO;
import com.shinhan.travelTogether.theme.ThemeService;

@Controller
@RequestMapping("/funding")
public class FundingController {
	
	@Autowired
	FundingService fService;
	
	@Autowired
	PhotoService pService;
	
	@Autowired
	ThemeService tService;
	
	@Value("${s3.bucket}")
	private String bucket;
	
	@GetMapping("/fundingList.do") 
	public void selectAll(Model model) {
		model.addAttribute("theme", tService.selectTheme());
	}
	
	//펀딩 목록
	@GetMapping("/fundingListItem.do") 
	public void selectItem(Model model, String selectOption) {
		
		model.addAttribute("fundlist", fService.selectAll(selectOption));
		model.addAttribute("tlist", fService.selectFudingTheme());
		model.addAttribute("plist", pService.selectMainPhoto());
	}
	
	//펀딩 검색
	@GetMapping("/searchFunding.do")
	public String selectByCondition(Model model,
			String search_title,
			String search_area,
			@RequestParam(value="search_start", required=false, defaultValue="2023-01-01") Date search_start,
			int theme,
			@RequestParam(value="search_end", required=false, defaultValue="2050-01-01") Date search_end ) {
	
		/*
		 * Date start = Date.valueOf(search_start); Date end = Date.valueOf(search_end);
		 */
		model.addAttribute("fundlist", fService.selectByCondition(search_title, search_area, theme, search_start, search_end));
		model.addAttribute("tlist", fService.selectFudingTheme());
		model.addAttribute("plist", pService.selectMainPhoto());

		return "funding/fundingListItem";
		
	}


	@GetMapping("/fundingInput.do")
	public void inputPage(Model model, HttpSession session){
		model.addAttribute("theme", tService.selectTheme());
	}
	
	@GetMapping("/fundingDetail.do")
	public void showDetail(Model model, int funding_id) {
		model.addAttribute("fund", fService.selectFundingById(funding_id));
		model.addAttribute("pic", pService.selectUserPhoto(funding_id));
		System.out.println(pService.selectUserPhoto(funding_id));
	}
	
	@ResponseBody
	@PostMapping("/fundingInput.do") 
	public int inputFunding (HttpSession session,
								@RequestParam(value="accPicArr", required=false) MultipartFile accPicArr, 
								@RequestParam(value="trafficPicArr", required=false) MultipartFile trafficPicArr,
								@RequestParam(value="mainPicArr", required=false) MultipartFile mainPicArr,
								@RequestParam(value="extraPicArr", required=false) List<MultipartFile> extraPicArr,
								@RequestParam("fund") String fundJson,
								@RequestParam("theme") String[] themeList
								) throws IOException {
		
		 
		 System.out.println(accPicArr);
		 if(trafficPicArr==null)
			 System.out.println("null 이다 이놈아");
		 System.out.println(mainPicArr);
		 System.out.println(extraPicArr);
		 System.out.println(themeList);
		 ObjectMapper objectMapper = new ObjectMapper();
		 Map<String, Object> fund = objectMapper.readValue(fundJson, Map.class);
		

		//세션이 없으면 로그인 페이지로
		MemberDTO member = (MemberDTO)session.getAttribute("member");

		FundingDTO funding = null;
		try {
			funding = makeFundingDTO(fund);
			System.out.println(funding);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(funding==null) {
			return 0;
		}
		if(funding.traffic==null && funding.accommodation == null)
			funding.setConfirm_option(0);
		else if(funding.traffic != null && funding.accommodation != null) {
			funding.setConfirm_option(3);
		} else if(funding.accommodation !=null) {
			funding.setConfirm_option(1);
		} else {
			funding.setConfirm_option(2);
		}
		funding.setFunding_state(0);
		funding.setViews(0);
		funding.setMember_id(member.getMember_id());
		System.out.println("Funding Input 확인 2 : " + fund);
		int result = fService.insertFunding(funding);
		
		 if(result==1) { 
			 System.out.println(themeList); 
			 for(String themeItem: themeList) {
				 FundingThemeDTO theme = new FundingThemeDTO();
				 theme.setFunding_id(fService.getFundingId());
				 theme.setTheme_id(Integer.parseInt(themeItem));
				 tService.insertFundingTheme(theme); 
			 }
			 
			if(mainPicArr != null) {
				insertPhoto(mainPicArr, "/normal",  1);
			}
			if(accPicArr != null) {
				insertPhoto(accPicArr, "/proof", 0);
			}
			if(trafficPicArr != null) {	
				insertPhoto(trafficPicArr, "/proof", 0);
			}
			if(extraPicArr != null) {
				System.out.println(extraPicArr);
				insertPhotoList(extraPicArr, "/normal",  1);
			}
		 }
		 

		return result;
	}
	

	public void insertPhoto(MultipartFile accPicArr, String detailPath, int option) throws IOException {

			if(!accPicArr.isEmpty()) {
					String imgPath = pService.upload(accPicArr, detailPath);
				

				PhotoDTO photo = new PhotoDTO();
				photo.setFunding_id(fService.getFundingId());
				photo.setPhoto_name(imgPath);
				photo.setPurpose(option);
				photo.setReview_id(null);
				
				String photoResult = pService.insertPhoto(photo) + "개 db등록";
				System.out.println(photoResult);
			}
		
	}
	public void insertPhotoList(List<MultipartFile> fileList, String detailPath, int option) throws IOException {
		if(!fileList.isEmpty()) {
			for (MultipartFile mf : fileList) {
				
				if(mf.isEmpty())
					continue;
				
				String imgPath = pService.upload(mf, detailPath);
				
				
				PhotoDTO photo = new PhotoDTO();
				photo.setFunding_id(fService.getFundingId());
				photo.setPhoto_name(imgPath);
				photo.setPurpose(option);
				photo.setReview_id(null);
				
				String photoResult = pService.insertPhoto(photo) + "개 db등록";
				System.out.println(photoResult);
			}
		}
	}

	private FundingDTO makeFundingDTO(Map<String, Object> fund2) throws ParseException {
		System.out.println(fund2.get("title"));
		System.out.println(fund2.get("start_date"));

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		
		java.util.Date startDate = dateFormat.parse((String) fund2.get("start_date"));
		Date start_date = new Date(startDate.getTime());
		
		java.util.Date endDate = dateFormat.parse((String) fund2.get("end_date"));
		Date end_date = new Date(endDate.getTime());
		
		java.util.Date deadlineDate = dateFormat.parse((String) fund2.get("deadline"));
		Date deadline = new Date(deadlineDate.getTime());
		
		FundingDTO fund = new FundingDTO();
		fund.setTitle((String) fund2.get("title"));
		fund.setArea((String) fund2.get("area"));
		fund.setStart_date(start_date);
		fund.setEnd_date(end_date);
		fund.setAccommodation((String) fund2.get("accommodation"));
		fund.setDeadline(deadline);
		fund.setPeople_num(Integer.parseInt((String) fund2.get("people_num")));
		fund.setPrice(Integer.parseInt((String) fund2.get("price")));
		fund.setDeparture((String) fund2.get("departure"));
		fund.setTraffic((String) fund2.get("traffic"));
		fund.setFunding_content((String) fund2.get("funding_content"));
		return fund;
	}


}
