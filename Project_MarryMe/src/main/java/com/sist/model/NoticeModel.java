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
	private String[] types={"","공지1","공지2","공지3","공지4"};
	
	@RequestMapping("notice/insert.do")
	public String notice_insert(HttpServletRequest request,HttpServletResponse response) {
	
		request.setAttribute("main_jsp", "../notice/insert.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("notice/insert_ok.do")
	public String notice_insert_ok(HttpServletRequest request,HttpServletResponse response) {
		try
	  {
		  request.setCharacterEncoding("UTF-8");
		  String path="c:\\project_upload";
		  String enctype="UTF-8";// 한글 파일명 
		  int max_size=1024*1024*100;
		  MultipartRequest mr=
				  new MultipartRequest(request, path,max_size,enctype,
						  new DefaultFileRenamePolicy());
		  // 자동 변경 => a.jpg , a1.jpg
		  String name=mr.getParameter("name");
		  String subject=mr.getParameter("subject");
		  String content=mr.getParameter("content");
		  String pwd=mr.getParameter("pwd");
		  String filename=mr.getFilesystemName("upload");
		  // a.jpg
		  // a.jpg => a1.jpg
		  
		  NoticeVO vo=new NoticeVO();
		  if(filename==null) // 업로드가 없는 상태 
		  {
			  vo.setFilename("");
			  vo.setFilesize(0);
		  }
		  else // 업로드가 된 상태 
		  {
			  File file=new File(path+"\\"+filename);
			  vo.setFilename(filename);
			  vo.setFilesize((int)file.length()); // int => 2byte
		  }
		  
		  NoticeDAO.noticeInsert(vo);
	  }catch(Exception ex){}
		 
		return "redirect:../notice/list.do";
	}
	
	@RequestMapping("notice/list.do")
	public String notice_list(HttpServletRequest request,HttpServletResponse response) {
		
	String page=request.getParameter("page");
	  if(page==null)
		  page="1";
	  
	  int curpage=Integer.parseInt(page);
	  
	  Map map=new HashMap();
	  map.put("start", (curpage*10)-9);
	  map.put("end", curpage*10);
	  
	  List<NoticeVO> list=NoticeDAO.noticeListData(map);
//	  for(NoticeVO vo:list)
//	   {
//		   vo.setNotice_type(types[vo.getType()]);
//	   }
	  int count=NoticeDAO.noticeTotal();
	  int totalpage=(int)(Math.ceil(count/10.0));
	  count=count-((curpage*10)-10);
	  
	  final int BLOCK=10;
		int startpage=((curpage-1)/BLOCK*BLOCK)+1;
		int endpage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
	  
		if(endpage>totalpage)
			endpage=totalpage;
	  
	  request.setAttribute("list", list);
	  request.setAttribute("curpage", curpage);
	  request.setAttribute("totalpage", totalpage);
	  request.setAttribute("startpage", startpage);
	  request.setAttribute("endpage", endpage);
	  request.setAttribute("count", count);
	  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	  Date date=new Date();
	  String today=sdf.format(date);
	  // new SimpleDateFormat("yyyy-MM-dd").format(new Date())
	  request.setAttribute("today", today);
	
		
		request.setAttribute("main_jsp", "../notice/list.jsp");
		return "../main/main.jsp";
	}
	
	// 상세보기 
	   @RequestMapping("notice/detail.do")
	   public String notice_detail(HttpServletRequest request,HttpServletResponse response)
	   {
		   String no=request.getParameter("no");
		   NoticeVO vo=NoticeDAO.noticeDetilData(Integer.parseInt(no));
		   vo.setNotice_type(types[vo.getType()]);
		   request.setAttribute("vo", vo);
		   request.setAttribute("main_jsp", "../notice/detail.jsp");
		   return "../main/main.jsp";
	   }
}
