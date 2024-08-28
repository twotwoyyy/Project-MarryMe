package com.sist.model;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;
import java.net.URLEncoder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.io.*;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class NoticeModel {
	private String[] types={"","전체 공지","웨딩홀","드레스/예복","스튜디오/헤메","혼수"};
	@RequestMapping("notice/list.do")
	public String notice_list(HttpServletRequest request, HttpServletResponse response) {
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		int rowSize=10;
		int start=(rowSize*curpage)-(rowSize-1);
		int end=rowSize*curpage;
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		List<NoticeVO> list=NoticeDAO.noticeListData(map);
		for(NoticeVO vo:list) {
			vo.setNotice_type(types[vo.getType()]);
		}
		int count=NoticeDAO.noticeRowCount();
		int totalpage=(int)(Math.ceil(count/10.0));
		count=count-((curpage*rowSize)-rowSize);
		
		final int BLOCK=10;
		int startpage=((curpage-1)/BLOCK*BLOCK)+1;
		int endpage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endpage>totalpage)
			endpage=totalpage;
		
		request.setAttribute("count", count);
		request.setAttribute("curpage",curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("noticeList", list);
		request.setAttribute("main_jsp", "../notice/list.jsp");
		
		return "../main/main.jsp";
	}
	// 상세 보기
	@RequestMapping("notice/detail.do")
	public String notice_detail(HttpServletRequest request, HttpServletResponse response) {
		String no=request.getParameter("no");
		NoticeVO vo=NoticeDAO.noticeDetailData(Integer.parseInt(no));
		vo.setNotice_type(types[vo.getType()]);
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../notice/detail.jsp");
		return "../main/main.jsp";
	}
}
