package com.sist.model;

import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.RequestMapping;
import com.sist.dao.StudioDAO;
import com.sist.vo.*;
public class StudioModel {
	@RequestMapping("studio/studio_list.do")
	public String studio_list(HttpServletRequest request, HttpServletResponse response) {
		String page=request.getParameter("page");
		if(page==null) {
			page="1";
		}
		int curpage=Integer.parseInt(page);
		Map map=new HashMap();
		int rowSize=12;
		int start=(rowSize*curpage)-(rowSize-1);
		int end=rowSize*curpage;
		map.put("start", start);
		map.put("end", end);

		List<StudioVO> studio_list=StudioDAO.studioListData(map);
		int totalpage=StudioDAO.studioTotalPage();
		
		final int BLOCK=5;
		int startpage=((curpage-1)/BLOCK*BLOCK)+1;
		int endpage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endpage>totalpage) {
			endpage=totalpage;
		}
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("studio_list", studio_list);

		request.setAttribute("main_jsp", "../studio/studio_list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("studio/hairmakeup_list.do")
	public String hairmakeup_list(HttpServletRequest request, HttpServletResponse response) {
		String page=request.getParameter("page");
		if(page==null) {
			page="1";
		}
		int curpage=Integer.parseInt(page);
		Map map=new HashMap();
		int rowSize=12;
		int start=(rowSize*curpage)-(rowSize-1);
		int end=rowSize*curpage;
		map.put("start", start);
		map.put("end", end);

		List<HairMakeupVO> hm_list=StudioDAO.hairmakeupListData(map);
		int totalpage=StudioDAO.hairmakeupTotalPage();
		
		final int BLOCK=5;
		int startpage=((curpage-1)/BLOCK*BLOCK)+1;
		int endpage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endpage>totalpage) {
			endpage=totalpage;
		}
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("hm_list", hm_list);

		request.setAttribute("main_jsp", "../studio/hairmakeup_list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("studio/detail.do")
	public String studio_detail(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../studio/detail.jsp");
		return "../main/main.jsp";
	}
}
