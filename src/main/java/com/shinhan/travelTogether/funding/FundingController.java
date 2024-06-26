package com.shinhan.travelTogether.funding;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	public void inputPage(Model model){
		model.addAttribute("theme", tService.selectTheme());
	}
	
	@GetMapping("/fundingDetail.do")
	public void showDetail(Model model, int funding_id) {
		model.addAttribute("fund", fService.selectFundingById(funding_id));
		model.addAttribute("pic", pService.selectUserPhoto(funding_id));
		System.out.println(pService.selectUserPhoto(funding_id));
	}
	
	
	//펀딩 글 작성
	@PostMapping("/fundingInput.do") 
	public String inputFunding(HttpSession session, MultipartHttpServletRequest multipart ) throws IOException {
		HttpServletRequest request = (HttpServletRequest) multipart;

		//세션이 없으면 로그인 페이지로
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		if(member == null) {
			return "redirect:../auth/login.do";
		}
		FundingDTO fund = null;
		try {
			fund = makeFundingDTO(request);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(fund==null) {
			return "redirect";
		}
		if(fund.traffic==null && fund.accommodation == null)
			fund.setConfirm_option(0);
		else if(fund.traffic != null && fund.accommodation != null) {
			fund.setConfirm_option(3);
		} else if(fund.accommodation !=null) {
			fund.setConfirm_option(1);
		} else {
			fund.setConfirm_option(2);
		}
		fund.setFunding_state(0);
		fund.setViews(0);
		fund.setMember_id(member.getMember_id());
		System.out.println("Funding Input 확인 2 : " + fund);
		int result = fService.insertFunding(fund);
		if(result==1) {
			String[] themeList = request.getParameterValues("theme");
			System.out.println(themeList);
			for(String themeItem: themeList) {
				FundingThemeDTO theme = new FundingThemeDTO();
				theme.setFunding_id(fService.getFundingId());
				theme.setTheme_id(Integer.parseInt(themeItem));
				tService.insertFundingTheme(theme);
			}
			 
		}
		System.out.println(result + "건 입력");
		
		setPhoto(multipart, request);

		return "redirect:fundingList.do";
	}
	
	//사진 넣기
	public void setPhoto(MultipartHttpServletRequest multipart, HttpServletRequest request) throws IOException {
		List<MultipartFile> provFileList = multipart.getFiles("prov_pics");
		List<MultipartFile> extraFileList = multipart.getFiles("extra_pics");
		List<MultipartFile> fileList = multipart.getFiles("main_pic");

		
		insertPhoto(fileList, "/normal",  1);
		insertPhoto(provFileList, "/proof", 0);
		insertPhoto(extraFileList, "/normal",  1);

	}
	

	public void insertPhoto(List<MultipartFile> fileList, String detailPath, int option) throws IOException {
		if(!fileList.isEmpty()) {
			for (MultipartFile mf : fileList) {
				
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

	private FundingDTO makeFundingDTO(HttpServletRequest request) throws ParseException {
		System.out.println(request.getParameter("title"));
		String start_date = request.getParameter("start_date");
		Date startDate = Date.valueOf(start_date);
		
		String end_date = request.getParameter("end_date");
		Date endDate = Date.valueOf(end_date);
		
		String deadline = request.getParameter("deadline");
		Date deadlineDate = Date.valueOf(deadline);
		
		FundingDTO fund = new FundingDTO();
		fund.setTitle(request.getParameter("title"));
		fund.setArea(request.getParameter("area"));
		fund.setStart_date((Date) startDate);
		fund.setEnd_date((Date) endDate);
		fund.setAccommodation(request.getParameter("accommodation"));
		fund.setDeadline((Date) deadlineDate);
		fund.setPeople_num(Integer.parseInt(request.getParameter("people_num")));
		fund.setPrice(Integer.parseInt(request.getParameter("price")));
		fund.setDeparture(request.getParameter("departure"));
		fund.setTraffic(request.getParameter("traffic"));
		fund.setFunding_content(request.getParameter("funding_content"));
		return fund;
	}


}
