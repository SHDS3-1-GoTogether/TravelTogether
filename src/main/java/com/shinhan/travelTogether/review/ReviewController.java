package com.shinhan.travelTogether.review;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.travelTogether.comment.CommentDTO;
import com.shinhan.travelTogether.comment.CommentService;
import com.shinhan.travelTogether.funding.FundingDTO;
import com.shinhan.travelTogether.funding.FundingService;
import com.shinhan.travelTogether.like.LikeService;
import com.shinhan.travelTogether.member.MemberDTO;
import com.shinhan.travelTogether.photo.PhotoService;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	ReviewService reviewService;
	
	@Autowired
	FundingService fundingService;
	
	@Autowired
	PhotoService photoService;
	
	@Autowired
	CommentService commentService;
	
	@Autowired
	LikeService likeService;
	
	@GetMapping("/reviewList.do")
	public void showAllReview(Model model, HttpSession session) {
		
		List<ReviewDTO> reviewlist = reviewService.selectAllReview();
		List<FundingDTO> fundinglist = fundingService.selectAll("selectAllByDate");
		model.addAttribute("reviewlist", reviewlist);
		model.addAttribute("fundinglist", fundinglist);
		model.addAttribute("mainPic", photoService.selectMainReviewPhoto());
		//System.out.println(reviewlist);
		
		
		if (session.getAttribute("insertResult2") == null) {
		  session.setAttribute("insertResult2", -1); 
		}
		 
		if (session.getAttribute("deleteResult2") == null) {
			session.setAttribute("deleteResult2", -1);
		}
		if (session.getAttribute("updateResult2") == null) {
			session.setAttribute("updateResult2", -1);
		}
	}
	
	@GetMapping("/reviewDetail.do")
	public void showDetail(Model model,
			HttpServletRequest request,
			HttpSession session,
			int review_id) {
		reviewService.updateReviewViews(review_id);
		model.addAttribute("reviewDetail", reviewService.selectAllMainReview(review_id));
		model.addAttribute("fundingDetail", reviewService.selectAllMainFunding(review_id));
		model.addAttribute("pic", photoService.selectReviewPhoto(review_id));
		
		model.addAttribute("tlist", fundingService.selectFudingTheme());
		model.addAttribute("commentlist", commentService.selectAllComment(review_id));
		
	}
	
	@GetMapping("/commentInsert.do")
	public void commentInsert(Model model, HttpSession session, Integer review_id) {
		if(session.getAttribute("insertResult2") == null) {
			//session.setAttribute("review_id", review_id);
			session.setAttribute("insertResult2", -1);
		}
		model.addAttribute("review_id", review_id);
	}
	
	@PostMapping("/commentInsert.do")
	public String commentInsert(Model model, HttpServletRequest request,RedirectAttributes attr,
			 HttpSession session
			, String comment_content, Integer review_id
			, CommentDTO comment) {
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		comment.setMember_id(member_id);
		comment.setReview_id(review_id);
		//System.out.println("!!!!!!!!!!!!!" + member_id + review_id);
		int result = commentService.insertComment(comment);
		//System.out.println("!!!!!!!!!!!!!" + comment);
		//session.setAttribute("insertResult2", result);
		attr.addFlashAttribute("insertResult2", result);
		return "redirect:reviewDetail.do?review_id=" +review_id ;
	
	}
	
	@PostMapping("/commentUpdate.do")
	public String updateComment(Model model, HttpServletRequest request, RedirectAttributes attr, HttpSession session,
			CommentDTO comment, Integer review_id) {
		int member_id = ((MemberDTO)session.getAttribute("member")).getMember_id();
		comment.setMember_id(member_id);
		comment.setReview_id(review_id);
		int result = commentService.updateComment(comment);
		attr.addFlashAttribute("updateResult2", result);
		return "redirect:reviewDetail.do?review_id=" +review_id ;
		
	}
	
	@PostMapping("/commentDelete.do")
	@ResponseBody
	public String deleteComment(HttpServletRequest request) {
		int comment_id = Integer.parseInt(request.getParameter("comment_id"));
		//System.out.println(comment_id);
		Integer result = commentService.deleteComment(comment_id);
		return result.toString();
	}
	
	//ÆÝµù °Ë»ö
	@GetMapping("/searchReview.do")
	public String selectByCondition(Model model,
		String search_title,
		String search_area,
			//@RequestParam(value="search_start", required=false, defaultValue="2023-01-01") Date search_start,
			int theme
			//,@RequestParam(value="search_end", required=false, defaultValue="2050-01-01") Date search_end 
			) {
				/*
				 * Date start = Date.valueOf(search_start); Date end = Date.valueOf(search_end);
				 */
			//model.addAttribute("fundlist", fundingService.selectByCondition(search_title, search_area, theme));
			model.addAttribute("tlist", fundingService.selectFudingTheme());
			model.addAttribute("plist", photoService.selectMainPhoto());
			return "review/reviewListItem";
	}
	
		/*
		 * @GetMapping("/reviewDetail/like.do") public void like() {
		 * 
		 * }
		 */
}
