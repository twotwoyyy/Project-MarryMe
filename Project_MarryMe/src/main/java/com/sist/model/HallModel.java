package com.sist.model;

import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

public class HallModel {
	@RequestMapping("hall/list.do")
	public String hall_list(HttpServletRequest request, HttpServletResponse response) { 
	    try{
		    request.setCharacterEncoding("UTF-8");
	    }catch(Exception ex) {}
	    String ss=request.getParameter("ss");
	    if(ss==null || ss.equals(""))
	    	ss="all";
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		int rowSize=10;
		int start=(rowSize*curpage)-(rowSize-1);
		int end=(rowSize*curpage);
		Map map=new HashMap();
		map.put("start",start);
		map.put("end", end);
		map.put("ss", ss);
		List<HallVO> list=HallDAO.hallListData(map);
		int totalpage=HallDAO.hallTotalPage(ss);
		
		final int BLOCK=5;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage)
			endPage=totalpage;
		
		// 전송
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);
		request.setAttribute("ss", ss);
		request.setAttribute("main_jsp", "../hall/list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("hall/detail_before.do")
	public String food_detail_before(HttpServletRequest request,HttpServletResponse response) {
		String hno=request.getParameter("hno");
		Cookie cookie=new Cookie("hall_"+hno,hno);
		cookie.setMaxAge(60*60*24);
		cookie.setPath("/");
		response.addCookie(cookie);
		return "redirect:../hall/detail.do?hno="+hno;
	}
	// 상세보기
	@RequestMapping("hall/detail.do")
	public String hall_detail(HttpServletRequest request, HttpServletResponse response) {
		String hno=request.getParameter("hno");
		HallVO vo=HallDAO.hallDetailData(Integer.parseInt(hno));
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../hall/detail.jsp");
		return "../main/main.jsp";
	}
}
