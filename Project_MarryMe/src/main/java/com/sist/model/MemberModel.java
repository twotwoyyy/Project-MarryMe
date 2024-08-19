package com.sist.model;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class MemberModel {
	@RequestMapping("member/login.do")
	public String member_login(HttpServletRequest request, HttpServletResponse response) {
		return "../member/login.jsp";
	}
	
	@RequestMapping("member/login_ok.do")
	public void member_login_ok(HttpServletRequest request, HttpServletResponse response) {
		String id=request.getParameter("id");
		String pw=request.getParameter("pw");
		MemberVO vo=MemberDAO.memberLogin(id, pw);
		if(vo.getMsg().equals("correct")) {
			HttpSession session=request.getSession();
			session.setAttribute("id", vo.getId());
			session.setAttribute("name", vo.getName());
			session.setAttribute("admin", vo.getAdmin());
		}
		try {
			PrintWriter out=response.getWriter();
			out.write(vo.getMsg());
		}catch(Exception ex) {}
	}
	
	@RequestMapping("member/logout.do")
	public String member_logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		session.invalidate();
		return "redirect:../main/main.do";
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
		String email_id=request.getParameter("email");
		String email_domain=request.getParameter("email_domain");
		String email=email_id+"@"+email_domain;
		String post=request.getParameter("post");
		String address1=request.getParameter("address1");
		String address2=request.getParameter("address2");
		String gender=request.getParameter("gender");
		String wedding_date=request.getParameter("wedding_date");
		SimpleDateFormat wedding_form=new SimpleDateFormat("yyyy-MM-dd");
		Date weddingday=new Date();
		try {
			weddingday = wedding_form.parse(wedding_date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
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
		vo.setWeddingday(weddingday);
		MemberDAO.memberInsert(vo);
		
		return "redirect:../main/main.do";
	}
}
