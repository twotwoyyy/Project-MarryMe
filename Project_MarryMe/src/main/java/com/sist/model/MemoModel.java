package com.sist.model;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class MemoModel {
	@RequestMapping("memo/list.do")
	public void memo_list(HttpServletRequest request, HttpServletResponse response) {
		String cno=request.getParameter("cno");
		String cate=request.getParameter("cate");
		Map map=new HashMap();
		map.put("cno", cno);
		map.put("cate", cate);
		List<MemoVO> list=MemoDAO.memoListData(map);
		JSONArray arr=new JSONArray();
		int i=0;
		HttpSession session=request.getSession();
		String sid=(String)session.getAttribute("id");
		if(sid==null) {
			sid="guest";
		}
		for(MemoVO vo:list) {
			JSONObject obj=new JSONObject();
			obj.put("mno", vo.getMno()); // 댓글 번호
			obj.put("cno", vo.getCno());
			obj.put("cate", vo.getCate());
			obj.put("id", vo.getId());
			obj.put("name", vo.getName());
			obj.put("msg",vo.getMsg());
			obj.put("dbday", vo.getDbday());
			obj.put("sessionId", sid);
			arr.add(obj);

		}
		// JavaScript로 값을 전송
		try {
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(arr.toJSONString());
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	@RequestMapping("memo/insert.do")
	public void memo_insert(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		}catch(Exception ex) {}
		String cno=request.getParameter("cno");
		String cate=request.getParameter("cate");
		String msg=request.getParameter("msg");
		HttpSession session=request.getSession();
		// 로그인 후에 사용 가능 
		String id=(String)session.getAttribute("id");
		String name=(String)session.getAttribute("name");

		MemoVO vo=new MemoVO();
		vo.setCno(Integer.parseInt(cno));
		vo.setCate(Integer.parseInt(cate));
		vo.setId(id);
		vo.setName(name);
		vo.setMsg(msg);
		String result="";
		try {
			MemoDAO.memoInsert(vo);
			result="OK";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		try {
			PrintWriter out=response.getWriter();
			out.write(result);
		}catch(Exception ex) {}
	}
	@RequestMapping("memo/delete.do")
	public void memo_delete(HttpServletRequest request,HttpServletResponse response){
		String mno=request.getParameter("mno");
		String result="";
		try{
			MemoDAO.memoDelete(Integer.parseInt(mno));
			result="OK";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
	// Ajax로 전송 
		try{
			PrintWriter out=response.getWriter();
			out.write(result);
		}catch(Exception ex) {}
	}
	@RequestMapping("memo/update.do")
	public void memo_update(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		}catch(Exception ex) {}
		String mno=request.getParameter("mno");
		String msg=request.getParameter("msg");
		
		String result="";
		try {
			Map map=new HashMap();
			map.put("mno", mno);
			map.put("msg", msg);
			MemoDAO.memoUpdate(map);
			result="OK";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		
		// Ajax 전송
		try {
			PrintWriter out=response.getWriter();
			out.write(result);
		}catch(Exception ex) {}
	}
}