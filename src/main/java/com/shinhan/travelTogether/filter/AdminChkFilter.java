package com.shinhan.travelTogether.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shinhan.travelTogether.member.MemberDTO;


public class AdminChkFilter implements Filter {

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		HttpSession session = req.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		
		if(req.getRequestURI().contains("admin")) {	// 관리자 페이지일 경우 관리자 계정 체크
			
			if(member == null || !member.getIs_manager()) {	// 관리자페이지에 접근하는 유저가 관리자 계정이 아닐 경우
				System.out.println("!!!!!관리자 외 접근!!!!!");
				String path = req.getContextPath();
				res.sendRedirect(path);
				return;
			} 
		} else if(req.getRequestURI().contains("mypage")) {	// 마이페이지일 경우 일반 회원만 접근 가능
			if(member != null && member.getIs_manager()) {	// 마이페이지에 접근하는 유저가 관리자 계정일 경우
				System.out.println("!!!!!마이페이지 관리자 접근!!!!!");
				String path = req.getContextPath();
				res.sendRedirect(path+"/admin/dashboard.do");
				return;
			} 
		}
		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
