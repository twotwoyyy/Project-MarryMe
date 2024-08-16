package com.sist.model;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class MemberModel {
	@RequestMapping("member/login.do")
	public String member_login(HttpServletRequest request, HttpServletResponse response) {
		return "../member/login.jsp";
	}
	@RequestMapping("member/join.do")
	public String member_join(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../member/join.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("member/idcheck_ok.do")
	public void member_idcheck_ok(HttpServletRequest request, HttpServletResponse response) {
		String id=request.getParameter("id");
		int count=MemberDAO.memberIdCheck(id);
		try {
			PrintWriter out=response.getWriter();
			out.write(String.valueOf(count));
		}catch(Exception ex) {}
	}
	
	@RequestMapping("member/join_ok.do")
	public String member_insert(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		}catch(Exception ex) {}
		String id=request.getParameter("id");
		String pw=request.getParameter("pw");
		String name=request.getParameter("name");
		String phone=request.getParameter("phone");
		String email=request.getParameter("email");
		String post=request.getParameter("post");
		String address1=request.getParameter("address1");
		String address2=request.getParameter("address2");
		String gender=request.getParameter("gender");
		String weddingday=request.getParameter("weddingday");
		
		MemberVO vo=new MemberVO();
		vo.setId(id);
		vo.setPw(pw);
		vo.setName(name);
		vo.setPhone(phone);
		vo.setEmail(email);
		vo.setPost(post);
		vo.setAddress1(address1);
		vo.setAddress2(address2);
		vo.setGender(gender);
		vo.setDbwdday(weddingday);
		MemberDAO.memberInsert(vo);
		
		return "redirect:../main/main.do";
	}
}
