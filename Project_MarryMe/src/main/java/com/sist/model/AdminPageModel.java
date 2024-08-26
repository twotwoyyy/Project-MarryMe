package com.sist.model;

import java.util.*;

import javax.servlet.Servlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

public class AdminPageModel {
	private String[] types = {"", "공지1", "공지2", "공지3", "공지4"};
	
	@RequestMapping("admin/adminpage_main.do")
	public String adminpage_main(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("admin_jsp", "../adminpage/adminpage_home.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		
		return "../main/main.do";
	}
	
	@RequestMapping("adminpage/member_list.do")
	public String member_list(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("admin_jsp", "../adminpage/member_list.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		
		return "../main/main.do";
	}
}
