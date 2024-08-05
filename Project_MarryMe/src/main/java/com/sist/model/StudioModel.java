package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;

public class StudioModel {
	@RequestMapping("studio/list.do")
	public String studio_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../studio/list.jsp");
		return "../main/main.jsp";
	}
}
