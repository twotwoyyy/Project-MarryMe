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
		
		List<HallVO> find_hall=FindDAO.findHallListData(keyword);
		List<DressVO> find_dress=FindDAO.findDressListData(keyword);
		List<SuitVO> find_suit=FindDAO.findSuitListData(keyword);
		List<StudioVO> find_studio=FindDAO.findStudioListData(keyword);
		List<HairMakeupVO> find_hm=FindDAO.findHairMakeupListData(keyword);
		List<GoodsVO> find_goods=FindDAO.findGoodsListData(keyword);

		int hall_count=FindDAO.findHallCount(keyword);
		int dress_count=FindDAO.findDressCount(keyword);
		int suit_count=FindDAO.findSuitCount(keyword);
		int studio_count=FindDAO.findStudioCount(keyword);
		int hm_count=FindDAO.findHairMakeupCount(keyword);
		int goods_count=FindDAO.findGoodsCount(keyword);
		
		int count=hall_count+dress_count+suit_count+studio_count+hm_count+goods_count;
		int totalpage=(int)(Math.ceil(count/12.0));
		
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
		request.setAttribute("find_hall", find_hall);
		request.setAttribute("find_dress", find_dress);
		request.setAttribute("find_suit", find_suit);
		request.setAttribute("find_studio", find_studio);
		request.setAttribute("find_hm", find_hm);
		request.setAttribute("find_goods", find_goods);
		request.setAttribute("main_jsp", "../main/find.jsp");
		return "../main/main.jsp";
	}
}
