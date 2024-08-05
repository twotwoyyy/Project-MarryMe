package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;

public class HallModel {
	@RequestMapping("hall/list.do")
	public String hall_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../hall/list.jsp");
		return "../main/main.jsp";
	}
}
