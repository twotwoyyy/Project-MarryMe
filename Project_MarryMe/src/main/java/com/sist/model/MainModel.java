package com.sist.model;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

public class MainModel {
	@RequestMapping("main/main.do")
	public String main_page(HttpServletRequest request, HttpServletResponse response) {

		List<HallVO> hall_list=HallDAO.mainHallData();
		List<StudioVO> studio_list=StudioDAO.mainStudioData();
		List<HairMakeupVO> hair_makup_list=StudioDAO.mainHairMakeupData();
		
		request.setAttribute("hall_list", hall_list);
		request.setAttribute("studio_list", studio_list);
		request.setAttribute("hair_makeup_list", hair_makup_list);
		request.setAttribute("main_jsp", "../main/home.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("main/main_goods.do")
	public String main_goods(HttpServletRequest request, HttpServletResponse response) {
		String cate=request.getParameter("cate");
		if(cate==null) {
			cate="가구";
		}
		List<GoodsVO> goods_list=GoodsDAO.mainGoodsData(cate);
		request.setAttribute("goods_list", goods_list);
		return "../main/main_goods.jsp";
	}
	@RequestMapping("main/find.do")
	public String main_find(HttpServletRequest request, HttpServletResponse response) {
		String keyword=request.getParameter("search");
		String page=request.getParameter("page");
		if(page==null) {
			page="1";
		}
		int curpage=Integer.parseInt(page);
		Map map=new HashMap();
		int rowSize=12;
		int start=(rowSize*curpage)-(rowSize-1);
		int end=rowSize*curpage;
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		
		List<FindVO> find_list=FindDAO.findListData(map);
		System.out.println(find_list);
		int totalpage=FindDAO.findTotalpage(keyword);
		
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
		request.setAttribute("find_list", find_list);
		request.setAttribute("main_jsp", "../main/find.jsp");
		return "../main/main.jsp";
	}
}
