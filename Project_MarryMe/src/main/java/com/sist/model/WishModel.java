package com.sist.model;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class WishModel {
	
	@RequestMapping("wish/insert.do")
	public void wish_insert(HttpServletRequest request, HttpServletResponse response) {
		String cno=request.getParameter("cno");
		String cate=request.getParameter("cate");
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		Map map=new HashMap();
		map.put("cno", cno);
		map.put("cate", cate);
		map.put("id", id);
		
		int wnoCount=WishDAO.wishGetWnoCount(map);
		String result="";
		if(wnoCount==0) {
			WishDAO.wishInsert(map);
			WishDAO.hallWishCountIncrement(map);
			WishDAO.studioWishCountIncrement(map);
			result="OK";			
		}

		try {
			PrintWriter out=response.getWriter();
			out.write(result);
		}catch(Exception ex){}
	}
	
	
	 @RequestMapping("wish/checklogin.do")
		public void checklogin(HttpServletRequest request, HttpServletResponse response)
		{
		   try {
			   request.setCharacterEncoding("UTF-8");
			   
		   }catch(Exception e) {
			   e.printStackTrace();
			   }
		   HttpSession session=request.getSession();
		   String id=(String)session.getAttribute("id");
		   String result="NO";
		   if(id==null)
			   result="NO";
		   else
			   result="OK";   
		   try {
			   PrintWriter out=response.getWriter();
			   out.write(result);
		   }catch(Exception e) {
			   e.printStackTrace();
			   }
		}

}
