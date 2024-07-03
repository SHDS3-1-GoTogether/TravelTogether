package com.shinhan.travelTogether.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.PatternMatchUtils;

import com.shinhan.travelTogether.member.MemberDTO;

/**
 * Servlet Filter implementation class LoginChkFilter
 */
@WebFilter("/LoginChkFilter")
public class LoginChkFilter implements Filter {

	private static final String[] whiteList = {
			"/", 
			"/funding/fundingList*", 
			"/funding/fundingDetail.do",
			"/funding/searchFunding.do",
			"/review/*",
			"/auth/*",
			"/resources/**",
			"/notifications/subscribe/*"
	};
	
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		HttpSession session = req.getSession();
		String requestURI = req.getRequestURI().replaceFirst(req.getContextPath(), "");
		System.out.println("req.getRequestURI() = "+requestURI);
		
		
		if(isLoginCheckPath(requestURI)){	// 로그인 페이지를 제외한 모든 페이지에 방문할 때
			// 로그인 전 머물렀던 페이지 URI 저장
			session.setAttribute("lastRequest", req.getRequestURI());
			session.setAttribute("queryString", req.getQueryString());
			MemberDTO member = (MemberDTO) session.getAttribute("member");
			String path = req.getContextPath();
			if(member == null) {
				res.sendRedirect(path+"/auth/login.do");
				return;
			}
		}
		
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}
	
	public boolean isLoginCheckPath(String requestURI) {
		return !PatternMatchUtils.simpleMatch(whiteList, requestURI);
	}

}
