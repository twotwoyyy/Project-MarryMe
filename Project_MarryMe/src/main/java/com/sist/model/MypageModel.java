package com.sist.model;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.MemberDAO;
import com.sist.dao.WishDAO;
import com.sist.vo.MemberVO;
import com.sist.vo.WishVO;
public class MypageModel {
	@RequestMapping("mypage/mypage_main.do")
	public String mypage_main(HttpServletRequest request, HttpServletResponse response) {
	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");
	    MemberVO vo = MemberDAO.memberUpdateData(id);

	    // 날짜를 문자열 형식으로 변환
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 원하는 형식으로 변경
	    String weddingdayStr = sdf.format(vo.getWeddingday());
	    
	    request.setAttribute("vo", vo);
	    request.setAttribute("weddingday", weddingdayStr); // 날짜를 문자열로 전달
	    request.setAttribute("title", "마이페이지");
	    request.setAttribute("mypage_jsp", "../mypage/mypage_home.jsp");
	    request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
	    return "../main/main.jsp";
	}
   @RequestMapping("member/join_update.do")
   public String mypage_join_update(HttpServletRequest request, HttpServletResponse response) {
      HttpSession session=request.getSession();
      String id=(String)session.getAttribute("id");
      MemberVO vo=MemberDAO.memberUpdateData(id);
      String email=vo.getEmail();
      email = email.substring(0, email.lastIndexOf("@"));
      vo.setEmail(email);
      request.setAttribute("vo", vo);
      request.setAttribute("title", "회원정보 수정");
      request.setAttribute("mypage_jsp", "../member/join_update.jsp");
      request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
      return "../main/main.jsp";
   }

   @RequestMapping("member/join_update_ok.do")
   public String mypage_join_update_ok(HttpServletRequest request, HttpServletResponse response) {
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
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 원하는 형식으로 변경
      String weddingdayStr = sdf.format(vo.getWeddingday());
      
      boolean bCheck=MemberDAO.memberUpdate(vo);
      request.setAttribute("weddingday", weddingdayStr); // 날짜를 문자열로 전달
      request.setAttribute("result", bCheck);
      
      return "../member/join_update_ok.jsp";
   }
   
	@RequestMapping("mypage/mypage_wish.do")
	public String mypage_wish(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		List<WishVO> hallList=WishDAO.hallWishMypageData(id);
		List<WishVO> studioList=WishDAO.studioMypageData(id);
		List<WishVO> hairmakeList=WishDAO.hairmakeupMypageData(id);
		int hSize=hallList.size();
		int sSize=studioList.size();
		int mSize=hairmakeList.size();
		int totalWish=hSize+sSize+mSize;
		request.setAttribute("hCount", hallList.size());
		request.setAttribute("sCount", studioList.size());
		request.setAttribute("mCount", hairmakeList.size());
		request.setAttribute("totalWish", totalWish);
		request.setAttribute("title", "나의 위시리스트");
		request.setAttribute("hallList", hallList);
		request.setAttribute("studioList", studioList);
		request.setAttribute("hairmakeList", hairmakeList);
		request.setAttribute("mypage_jsp", "../mypage/mypage_wish.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/mypage_wish_cancel.do")
	public String mypage_wish_cancel(HttpServletRequest request, HttpServletResponse response) {
		String wno=request.getParameter("wno");
		String cno=request.getParameter("cno");
		// 데이터베이스 연동 
		WishDAO.wishCancel(Integer.parseInt(wno));
		return "redirect:../mypage/mypage_wish.do";
		
	}
	
	@RequestMapping("mypage/mypage_cart.do")
	public String mypage_cart(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		//List<GoodsVO> list=GoodsDAO.cartListData(id);
		//request.setAttribute("cartList", list);
		//request.setAttribute("count", list.size());
		request.setAttribute("title", "장바구니");
		request.setAttribute("mypage_jsp", "../mypage/mypage_cart.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/main.jsp";
	}
	
	
}