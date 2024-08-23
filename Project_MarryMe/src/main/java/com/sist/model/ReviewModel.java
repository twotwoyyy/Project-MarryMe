package com.sist.model;
import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.naming.Context;
import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

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
	@RequestMapping("review/insert.do")
	public void review_insert_ok(HttpServletRequest request,HttpServletResponse response) {
		
		  try {
				request.setCharacterEncoding("UTF-8");
		  
		  String path = "C:\\webDev\\webStudy\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project_MarryMe\\img\\review_img";

		  // 파일이 업로드 되는 폴더를 지정한다.
		  //String saveFolder = "JSP_File/01_file_basic";
		  
		  // 인코딩 타입
		  String encType = "utf-8";

		  // 최대 업로드 될 파일의 크기
		  int maxSize = 1 * 1024 * 1024; // 1메가바이트

		  // 현재 jsp 페이지의 웹 어플리케이션 상의 경로를 구한다.
		  
		  MultipartRequest mr=
				  new MultipartRequest(request, path,maxSize,encType,
						  new DefaultFileRenamePolicy());
		  HttpSession session=request.getSession();
		  String id=(String)session.getAttribute("id");
		  String msg=mr.getParameter("msg");
		  String cate=mr.getParameter("cate");
		  String pno=mr.getParameter("pno");
		  String score=mr.getParameter("score");
		  String image=mr.getFilesystemName("upload");
		  
		  
		  
		  
		  // a.jpg
		  // a.jpg => a1.jpg
		  
		  ReviewVO vo=new ReviewVO();
		  vo.setId(id);
		  vo.setMsg(msg);
		  vo.setCate(Integer.parseInt(cate));
		  vo.setPno(Integer.parseInt(pno));
		  vo.setScore(Integer.parseInt(score));
		  vo.setImage(image);
		  if(vo.getImage()==null) {
			  vo.setImage("NOIMAGE");
		  }
		  String result="";
		  try {
		  	ReviewDAO.reviewInsert(vo);
		  	result="OK";
		  }catch(Exception ex) {
			  result=ex.getMessage();
		  }
		  
		  JSONObject obj=new JSONObject();
		  obj.put("result", result);
		  obj.put("fileName", image);
		  
		  try {
				
				PrintWriter out=response.getWriter();
				out.write(obj.toJSONString());
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		 }catch(Exception ex) {
			 ex.printStackTrace();
		 }
	}
	
	@RequestMapping("review/review_list.do")
	public void review_list(HttpServletRequest request,HttpServletResponse response) {
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		String cate=request.getParameter("cate");
		String pno=request.getParameter("pno");
		int curpage=Integer.parseInt(page);
		int rowSize=3;
		int start=(rowSize*curpage)-(rowSize-1);
		int end=rowSize*curpage;
		
		Map map=new HashMap();
		
		map.put("start", start);
		map.put("end", end);
		map.put("cate", Integer.parseInt(cate));
		map.put("pno", Integer.parseInt(pno));
		try {
			List<ReviewVO> list=ReviewDAO.reviewListData(map);
			
			
			int total=ReviewDAO.reviewTotalPage(map);
			//System.out.println(total+"개 있음");
			int totalpage=(int)(Math.ceil(total/(double)rowSize));
			
			// 페이지 개수 표시
			final int BLOCK=5;
			
			
			int startpage=((curpage-1)/BLOCK*BLOCK)+1;
			int endpage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
			
			if(endpage>totalpage)
				endpage=totalpage;
			
			
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			Date date=new Date();
			String today=sdf.format(date);
			  // new SimpleDateFormat("yyyy-MM-dd").format(new Date())
			HttpSession session=request.getSession();
			String sid=(String)session.getAttribute("id");
			if(sid==null) {
				sid="guest";
			}
			
			ServletContext context = request.getServletContext();
			String realFolder="";
			realFolder = "C:\\webDev\\webStudy\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project_MarryMe\\img\\review_img";
			//review_no,image,msg,TO_CHAR(regdate, 'YYYY-MM-DD') as dbday,cate,name,score,hit,num
			JSONArray arr=new JSONArray();
			int h=0;
			for(ReviewVO vo:list) {
				JSONObject obj=new JSONObject();
				obj.put("rno", vo.getReview_no());
				
				obj.put("img", vo.getImage());
				obj.put("id", vo.getId());
				obj.put("name", vo.getMvo().getName());
				obj.put("dbday", vo.getDbday());
				obj.put("cate", vo.getCate());
				obj.put("score", vo.getScore());
				obj.put("hit", vo.getHit());
				obj.put("msg", vo.getMsg());
				obj.put("today", today);
				if(h==0) {
				obj.put("startpage", startpage);
				obj.put("endpage", endpage);
				obj.put("totalpage", totalpage);
				obj.put("curpage", curpage);
				h=1;
				}
				obj.put("sessionId", sid);
				arr.add(obj);
			}
	//		System.out.println(arr.toJSONString());
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(arr.toJSONString());
			
			
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	@RequestMapping("review/update.do")
	public void review_update(HttpServletRequest request,HttpServletResponse response) {
		
		  try {
				request.setCharacterEncoding("UTF-8");
		  
		 // String path = "C:\\Users\\user\\git\\Project_MarryMe\\Project_MarryMe\\src\\main\\webapp\\img\\review_img";
		  String path = "C:\\webDev\\webStudy\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project_MarryMe\\img\\review_img";
		  // 파일이 업로드 되는 폴더를 지정한다.
		  //String saveFolder = "JSP_File/01_file_basic";

		  // 인코딩 타입
		  String encType = "utf-8";

		  // 최대 업로드 될 파일의 크기
		  int maxSize = 1 * 1024 * 1024; // 1메가바이트

		  // 현재 jsp 페이지의 웹 어플리케이션 상의 경로를 구한다.
		  
		  MultipartRequest mr=
				  new MultipartRequest(request, path,maxSize,encType,
						  new DefaultFileRenamePolicy());
		  HttpSession session=request.getSession();
		  
		  String msg=mr.getParameter("msg");
		  String rno=mr.getParameter("rno");
		  String score=mr.getParameter("score");
		  String image=mr.getFilesystemName("upload");
		  if(image==null) {
			  image=mr.getParameter("img");
		  }
		  
		  
		  
		  // a.jpg
		  // a.jpg => a1.jpg
		  
		  ReviewVO vo=new ReviewVO();
		  
		  vo.setMsg(msg);
		  vo.setReview_no(Integer.parseInt(rno));
		  vo.setScore(Integer.parseInt(score));
		  vo.setImage(image);
		  String result="";
		  try {
		  	ReviewDAO.reviewUpdate(vo);
		  	result="OK";
		  }catch(Exception ex) {
			  result=ex.getMessage();
		  }
		  
		  JSONObject obj=new JSONObject();
		  obj.put("result", result);
		  obj.put("fileName", image);
		  
		  try {
				
				PrintWriter out=response.getWriter();
				out.write(obj.toJSONString());
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		 }catch(Exception ex) {
			 ex.printStackTrace();
		 }
	}
	@RequestMapping("review/delete.do")
	public void review_delete(HttpServletRequest request,HttpServletResponse response) {
		String rno=request.getParameter("rno");
		String image=ReviewDAO.reviewInfo(Integer.parseInt(rno));
		ReviewDAO.reviewDelete(Integer.parseInt(rno));
		String result="";
		try
		  {
			  if(image!="NOIMAGE")
			  {
				  File file=new File("C:\\webDev\\webStudy\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project_MarryMe\\img\\review_img\\"+image);
				  file.delete();
			  }
			  result="OK";
		  }catch(Exception ex) {}
		  // 결과값을 받아서 Ajax로 전송 
		  try
		  {
			  PrintWriter out=response.getWriter();
			  out.write(result);
		  }catch(Exception ex) {}
	}
}

