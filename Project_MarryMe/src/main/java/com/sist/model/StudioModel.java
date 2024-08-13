package com.sist.model;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;
import com.sist.dao.StudioDAO;
import com.sist.vo.*;
public class StudioModel {
	@RequestMapping("studio/list.do")
	public String studio_list(HttpServletRequest request, HttpServletResponse response) {
		String type=request.getParameter("type");
		if(type==null) {
			type="studio";
		}
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

		int totalpage=0;
		if(type=="studio") {
			totalpage=StudioDAO.studioTotalPage();
			List<StudioVO> studio_list=StudioDAO.studioListData(map);
			request.setAttribute("studio_list", studio_list);
		}else {
			totalpage=StudioDAO.hairmakeupTotalPage();
			List<HairMakeupVO> studio_list=StudioDAO.hairmakeupListData(map);
			request.setAttribute("studio_list", studio_list);
		}
		
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
		
		request.setAttribute("main_jsp", "../studio/list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("studio/type.do")
	public void studio_tab(HttpServletRequest request, HttpServletResponse response) {
		
	}
}
