package com.sist.model;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class MemberModel {
	@RequestMapping("member/login.do")
	public String member_login(HttpServletRequest request, HttpServletResponse response) {
		return "../member/login.jsp";
	}
	@RequestMapping("member/join.do")
	public String member_join(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../member/join.jsp");
		return "../main/main.jsp";
	}
}
