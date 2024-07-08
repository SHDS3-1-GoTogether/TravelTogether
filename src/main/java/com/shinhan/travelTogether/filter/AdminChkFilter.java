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
		
		if(req.getRequestURI().contains("admin")) {	// ������ �������� ��� ������ ���� üũ
			
			if(member == null || !member.getIs_manager()) {	// �������������� �����ϴ� ������ ������ ������ �ƴ� ���
				System.out.println("!!!!!������ �� ����!!!!!");
				String path = req.getContextPath();
				res.sendRedirect(path);
				return;
			} 
		} else if(req.getRequestURI().contains("mypage")) {	// ������������ ��� �Ϲ� ȸ���� ���� ����
			if(member != null && member.getIs_manager()) {	// ������������ �����ϴ� ������ ������ ������ ���
				System.out.println("!!!!!���������� ������ ����!!!!!");
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
