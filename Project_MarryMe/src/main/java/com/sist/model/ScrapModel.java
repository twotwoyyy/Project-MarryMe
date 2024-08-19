package com.sist.model;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class ScrapModel {
	@RequestMapping("scrap/insert.do")
	public void scrap_insert(HttpServletRequest request, HttpServletResponse response) {
		String cno=request.getParameter("cno");
		String cate=request.getParameter("cate");
		HttpSession session=request.getSession();
		String isLoggedIn = (session.getAttribute("id") != null) ? "true" : "false";
		String id=(String)session.getAttribute("id");
		Map map=new HashMap();
		map.put("cno", cno);
		map.put("cate", cate);
		map.put("id", id);
		String result="";
		try {
			ScrapDAO.scrapInsert(map);
			ScrapDAO.hallScrapCountIncrement(map);
			result="OK";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		
		try {
			PrintWriter out=response.getWriter();
			out.write(result);
		}catch(Exception ex){}
	}
}
