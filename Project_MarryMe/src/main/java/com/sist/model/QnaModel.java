package com.sist.model;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class QnaModel {
	@RequestMapping("qna/insert.do")
	public String qna_insert(HttpServletRequest request,HttpServletResponse response) {
		request.setAttribute("main_jsp", "../qna/insert.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("qna/insert_ok.do")
	public String qna_insert_ok(HttpServletRequest request,HttpServletResponse response) {
		try
	  {
		  request.setCharacterEncoding("UTF-8");
		  
		  String id=request.getParameter("id");
		  String msg=request.getParameter("msg");
		  String cate=request.getParameter("cate");
		  // a.jpg
		  // a.jpg => a1.jpg
		  
		  QnaVO vo=new QnaVO();
		  vo.setId(id);
		  vo.setMsg(msg);
		  vo.setCate(Integer.parseInt(cate));
		  QnaDAO.qnaInsert(vo);
	  }catch(Exception ex){}
		 
		return "redirect:../qna/list.do";
	}
	 
	
	@RequestMapping("qna/list.do")
	public String qna_list(HttpServletRequest request,HttpServletResponse response) {
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
		
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		List<QnaVO> list=QnaDAO.qnaListData(map);
		
		
		int total=QnaDAO.qnaTotalPage();
		
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
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		  Date date=new Date();
		  String today=sdf.format(date);
		  // new SimpleDateFormat("yyyy-MM-dd").format(new Date())
		  request.setAttribute("today", today);
		
		request.setAttribute("main_jsp", "../qna/list.jsp");
		return "../main/main.jsp";
	}
}
