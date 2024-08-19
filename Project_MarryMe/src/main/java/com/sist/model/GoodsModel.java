package com.sist.model;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.RequestMapping;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;

import oracle.net.ns.SessionAtts;
public class GoodsModel {
	private String[] category={"","종합","침대","가구","가전","카드"};
	@RequestMapping("goods/list.do")
	public String goods_list(HttpServletRequest request, HttpServletResponse response) {
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		String cno=request.getParameter("cno");
		if(cno==null)
			cno="1";
		int curpage=Integer.parseInt(page);
		int rowSize=12;
		int start=(rowSize*curpage)-(rowSize-1);
		int end=rowSize*curpage;
		String realFolder="";
		ServletContext context = request.getServletContext();
		  
		  realFolder = context.getRealPath("");
		  System.out.println(realFolder);
		Map map=new HashMap();
		if(cno.equals("1")) {
			map.put("category", "");
		}else {
			map.put("category", category[Integer.parseInt(cno)]);
		}
		map.put("start", start);
		map.put("end", end);
		List<GoodsVO> list=GoodsDAO.goodsListData(map);
		int total=GoodsDAO.goodsTotalPage(map);
		
		int totalpage=(int)(Math.ceil(total/rowSize));
		
		// 페이지 개수 표시
		final int BLOCK=5;
		
		
		int startpage=((curpage-1)/BLOCK*BLOCK)+1;
		int endpage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		
		if(endpage>totalpage)
			endpage=totalpage;
		
		request.setAttribute("list", list);
		request.setAttribute("cno", cno);
		request.setAttribute("curpage", curpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("total", total);	
		
		request.setAttribute("main_jsp", "../goods/list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("goods/detail.do")
	public String goods_detail(HttpServletRequest request,HttpServletResponse response) {
		String pno=request.getParameter("pno");
		String cate=request.getParameter("cate");
		System.out.println(pno);
		System.out.println(cate);
		request.setAttribute("pno", pno);
		request.setAttribute("cate", cate);
		request.setAttribute("main_jsp", "../goods/detail.jsp");
		return "../main/main.jsp";
	}
}
