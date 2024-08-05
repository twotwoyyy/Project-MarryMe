package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;

public class DressModel {
	@RequestMapping("dress/list.do")
	public String dress_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../dress/list.jsp");
		return "../main/main.jsp";
	}
}
