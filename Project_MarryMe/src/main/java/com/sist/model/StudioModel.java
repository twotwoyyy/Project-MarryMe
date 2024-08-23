package com.sist.model;

import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.RequestMapping;
import com.sist.dao.StudioDAO;
import com.sist.dao.WishDAO;
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
		
		Cookie[] cookies=request.getCookies();
		List<StudioVO> studio_cookies=new ArrayList<StudioVO>();
		if(cookies!=null) {
			for(int i=cookies.length-1;i>=0;i--) {
				if(cookies[i].getName().startsWith("studio_")) {
					String sno=cookies[i].getValue();
					StudioVO vo=StudioDAO.studioDetailData(Integer.parseInt(sno));
					studio_cookies.add(vo);
				}
			}
		}
		request.setAttribute("studio_cookies", studio_cookies);

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
		
		Cookie[] cookies=request.getCookies();
		List<HairMakeupVO> hm_cookies=new ArrayList<HairMakeupVO>();
		if(cookies!=null) {
			for(int i=cookies.length-1;i>=0;i--) {
				if(cookies[i].getName().startsWith("hairmakeup_")) {
					String mno=cookies[i].getValue();
					HairMakeupVO vo=StudioDAO.hmDetailData(Integer.parseInt(mno));
					hm_cookies.add(vo);
				}
			}
		}
		request.setAttribute("hm_cookies", hm_cookies);

		request.setAttribute("main_jsp", "../studio/hairmakeup_list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("studio/studio_detail_before.do")
	public String studio_detail_before(HttpServletRequest request, HttpServletResponse response) {
		String sno=request.getParameter("sno");
		Cookie cookie=new Cookie("studio_"+sno, sno);
		cookie.setMaxAge(60*60*24);
		cookie.setPath("/");
		response.addCookie(cookie);
		return "redirect:../studio/studio_detail.do?sno="+sno;
	}
	@RequestMapping("studio/studio_detail.do")
	public String studio_detail(HttpServletRequest request, HttpServletResponse response) {
		String sno=request.getParameter("sno");
		StudioVO studio_vo=StudioDAO.studioDetailData(Integer.parseInt(sno));
		List<StudioImageVO> studio_image_list=StudioDAO.studioDetailImageData(Integer.parseInt(sno));
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		boolean isWish=false;
		if(id!=null) {
			Map map=new HashMap();
			map.put("cno", sno);
			map.put("cate", 4);
			map.put("id", id);
			int existWish=WishDAO.wishCheck(map);
			if(existWish!=0) {
				isWish=true;
			}			
		}
		request.setAttribute("studio_vo", studio_vo);
		request.setAttribute("studio_image_list", studio_image_list);
		request.setAttribute("isWish", isWish);
		request.setAttribute("main_jsp", "../studio/studio_detail.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("studio/hairmakeup_detail_before.do")
	public String hairmakeup_detail_before(HttpServletRequest request, HttpServletResponse response) {
		String mno=request.getParameter("mno");
		Cookie cookie=new Cookie("hairmakeup_"+mno, mno);
		cookie.setMaxAge(60*60*24);
		cookie.setPath("/");
		response.addCookie(cookie);
		return "redirect:../studio/hairmakeup_detail.do?mno="+mno;
	}
	@RequestMapping("studio/hairmakeup_detail.do")
	public String hairmakeup_detail(HttpServletRequest request, HttpServletResponse response) {
		String mno=request.getParameter("mno");
		HairMakeupVO hm_vo=StudioDAO.hmDetailData(Integer.parseInt(mno));
		List<HairMakeupImageVO> hm_image_list=StudioDAO.hmDetailImageData(Integer.parseInt(mno));
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		boolean isWish=false;
		if(id!=null) {
			Map map=new HashMap();
			map.put("cno", mno);
			map.put("cate", 5);
			map.put("id", id);
			int existWish=WishDAO.wishCheck(map);
			if(existWish!=0) {
				isWish=true;
			}			
		}
		
		request.setAttribute("hm_vo", hm_vo);
		request.setAttribute("hm_image_list", hm_image_list);
		request.setAttribute("isWish", isWish);
		request.setAttribute("main_jsp", "../studio/hairmakeup_detail.jsp");
		return "../main/main.jsp";
	}
}
