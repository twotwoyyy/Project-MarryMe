package com.sist.model;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class ReviewModel {
	/*
	 * @RequestMapping("review/insert.do") public String
	 * review_insert(HttpServletRequest request,HttpServletResponse response) {
	 * 
	 * request.setAttribute("main_jsp", "../review/insert.jsp"); return
	 * "../main/main.jsp"; }
	 */
	@RequestMapping("review/insert_ok.do")
	public void review_insert_ok(HttpServletRequest request,HttpServletResponse response) {
		
		  try {
				request.setCharacterEncoding("UTF-8");
		  
		  String realFolder = "";

		  // 파일이 업로드 되는 폴더를 지정한다.
		  //String saveFolder = "JSP_File/01_file_basic";

		  // 인코딩 타입
		  String encType = "utf-8";

		  // 최대 업로드 될 파일의 크기
		  int maxSize = 5 * 1024 * 1024;

		  // 현재 jsp 페이지의 웹 어플리케이션 상의 경로를 구한다.
		  ServletContext context = request.getServletContext();
		  
		  realFolder = context.getRealPath("");
		  System.out.println(realFolder);
		  MultipartRequest mr=
				  new MultipartRequest(request, realFolder,maxSize,encType,
						  new DefaultFileRenamePolicy());
		  
		  String id=request.getParameter("id");
		  String msg=request.getParameter("msg");
		  String cate=request.getParameter("cate");
		  String pw=request.getParameter("pw");
		  String pno=request.getParameter("pno");
		  String score=request.getParameter("score");
		  // a.jpg
		  // a.jpg => a1.jpg
		  
		  ReviewVO vo=new ReviewVO();
		  vo.setId(id);
		  vo.setMsg(msg);
		  vo.setCate(Integer.parseInt(cate));
		  vo.setPw(pw);
		  vo.setPno(Integer.parseInt(pno));
		  vo.setScore(Double.parseDouble(score));
		  
		  String result="";
		  try {
		  	ReviewDAO.reviewInsert(vo);
		  	result="OK";
		  }catch(Exception ex) {
			  result=ex.getMessage();
		  }
		  try {
				
				PrintWriter out=response.getWriter();
				out.write(result);
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		 }catch(Exception ex) {}
	}
	
	@RequestMapping("review/list.do")
	public String review_list(HttpServletRequest request, HttpServletResponse response) {
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
		List<ReviewVO> list=ReviewDAO.reviewListData(map);
		int total=ReviewDAO.reviewTotalPage();
		
		int totalpage=(int)(Math.ceil(total/rowSize));
		
		// 페이지 개수 표시
		final int BLOCK=5;
		
		
		int startpage=((curpage-1)/BLOCK*BLOCK)+1;
		int endpage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		
		if(endpage>totalpage)
			endpage=totalpage;
		
		request.setAttribute("list", list);
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
		
		request.setAttribute("main_jsp", "../review/list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("review/update.do")
	public void review_update(HttpServletRequest request,HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {
			// TODO: handle exception
		}
		String rno=request.getParameter("rno");
		String msg=request.getParameter("msg");
		System.out.println(msg+"크아악");
		String result="";
		try {
			Map map=new HashMap();
			map.put("rno", rno);
			map.put("msg", msg);
			
			result="OK";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		
		try {
			PrintWriter out=response.getWriter();
			out.write(result);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
