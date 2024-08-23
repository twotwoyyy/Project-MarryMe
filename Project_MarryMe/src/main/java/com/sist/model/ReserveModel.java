package com.sist.model;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.RequestMapping;
import com.sist.dao.ReserveDAO;
import com.sist.vo.*;
public class ReserveModel {
	@RequestMapping("reserve/reserve.do")
	public void reserve(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		}catch(Exception ex) {}
		String pno=request.getParameter("pno");
		String rdate=request.getParameter("rdate");
		String rtime=request.getParameter("rtime");
		String cate=request.getParameter("cate");

		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		ReserveVO vo=new ReserveVO();
		vo.setPno(Integer.parseInt(pno));
		vo.setRdate(rdate);
		vo.setRtime(rtime);
		vo.setCate(Integer.parseInt(cate));
		vo.setId(id);
		
		int count=ReserveDAO.reserveCheck(vo);
		String result="";
		if(count==0) {
			ReserveDAO.reserveInsert(vo);
			result="OK";
		}else {
			result="exist";
		}
		
		try {
			PrintWriter out=response.getWriter();
			out.write(result);
		}catch(Exception ex) {}
	}
	
	@RequestMapping("reserve/reserve_exist.do")
	public void reserve_exist(HttpServletRequest request, HttpServletResponse response) {
		String pno=request.getParameter("pno");
		String cate=request.getParameter("cate");
		Map reserve_map=new HashMap();
		reserve_map.put("cate", Integer.parseInt(cate));
		reserve_map.put("pno", pno);
		List<ReserveVO> reserve_list=ReserveDAO.reserveExist(reserve_map);
		
		JSONArray reserve_arr=new JSONArray();
		for(ReserveVO vo:reserve_list) {
			JSONObject reserve_obj=new JSONObject();
			reserve_obj.put("rdate", vo.getRdate());
			reserve_obj.put("rtime", vo.getRtime());
			reserve_arr.add(reserve_obj);
		}
		
		try {
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(reserve_arr.toJSONString());
		}catch(Exception ex) {}
	}
}
