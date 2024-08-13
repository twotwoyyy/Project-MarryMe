package com.sist.model;

import java.io.PrintWriter;
import java.util.List;

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
}
