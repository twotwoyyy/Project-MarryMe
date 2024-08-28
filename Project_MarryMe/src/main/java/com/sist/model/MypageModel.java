package com.sist.model;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
public class MypageModel {
	@RequestMapping("mypage/mypage_main.do")
	public String mypage_main(HttpServletRequest request, HttpServletResponse response) {
	    HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");
	    MemberVO vo = MemberDAO.memberUpdateData(id);

	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
	    String weddingdayStr = sdf.format(vo.getWeddingday());
	    
	    request.setAttribute("vo", vo);
	    request.setAttribute("weddingday", weddingdayStr); 
	    request.setAttribute("title", "💐마이페이지💐");
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
      request.setAttribute("title", "📝회원정보 수정📝");
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
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
      String weddingdayStr = sdf.format(vo.getWeddingday());
      
      boolean bCheck=MemberDAO.memberUpdate(vo);
      request.setAttribute("weddingday", weddingdayStr);
      request.setAttribute("result", bCheck);
      
      return "../member/join_update_ok.jsp";
   }
   
	@RequestMapping("mypage/mypage_wish.do")
	public String mypage_wish(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		List<WishVO> hallList=WishDAO.hallWishMypageData(id);
		List<WishVO> dList=WishDAO.dressMypageData(id);
		List<WishVO> suList=WishDAO.suitMypageData(id);
		List<WishVO> studioList=WishDAO.studioMypageData(id);
		List<WishVO> hairmakeList=WishDAO.hairmakeupMypageData(id);
		List<WishVO> gList=WishDAO.goodsMypageData(id);
		
		int hSize=hallList.size();
		int dSize=dList.size();
		int suSize=suList.size();
		int sSize=studioList.size();
		int mSize=hairmakeList.size();
		int gSize=gList.size();
		int totalWish=hSize+dSize+suSize+sSize+mSize+gSize;
		
		request.setAttribute("hCount", hallList.size());
		request.setAttribute("dCount", dList.size());
		request.setAttribute("suCount", suList.size());
		request.setAttribute("sCount", studioList.size());
		request.setAttribute("mCount", hairmakeList.size());
		request.setAttribute("gCount", gList.size());
		request.setAttribute("totalWish", totalWish);
		request.setAttribute("title", "나의 위시리스트");
		request.setAttribute("hallList", hallList);
		request.setAttribute("dressList", dList);
		request.setAttribute("suitList", suList);
		request.setAttribute("studioList", studioList);
		request.setAttribute("hairmakeList", hairmakeList);
		request.setAttribute("goodsList", gList);
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
	

	@RequestMapping("mypage/mypage_review.do")
	public String mypage_review(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		Map map=new HashMap();
		map.put("id", id);
		map.put("start", (curpage*10)-9);
		map.put("end", curpage*10);
		
		List<ReviewVO> list=ReviewDAO.mypageReviewListData(map);
		
		int count=ReviewDAO.mypageTotalPage(id);
		int totalpage=(int)(Math.ceil(count/10.0));
		count=count-((curpage*10)-10);
		
		request.setAttribute("myrSize", list.size());
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("myrList", list);
		request.setAttribute("title", "리뷰 내역");
		request.setAttribute("mypage_jsp", "../mypage/mypage_review.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/mypage_review_delete.do")
	public String mypage_review_delete(HttpServletRequest request, HttpServletResponse response) {

		String rno=request.getParameter("rno");
		ReviewDAO.reviewDelete(Integer.parseInt(rno));
		return "redirect:../mypage/mypage_review.do";
	}
	
	@RequestMapping("mypage/mypage_qna.do")
	public String mypage_qna(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		String group_id=request.getParameter("group_id");
		if(group_id==null)
			group_id="1";
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		Map map=new HashMap();
		map.put("id", id);
		map.put("start", (curpage*10)-9);
		map.put("end", curpage*10);

		List<QnaVO> list=QnaDAO.mypageQnaListData(map);
	    List<QnaVO> relist = new ArrayList();
	    for (QnaVO qna : list) {
	        int groupId = qna.getGroup_id();
	        List<QnaVO> replies = QnaDAO.mypageQnaListReData(groupId);
	        relist.addAll(replies); // 답변 리스트를 모읍니다
	    }

		int count=QnaDAO.mypageQnaTotalPage(id);
		int totalpage=(int)(Math.ceil(count/10.0));
		count=count-((curpage*10)-10);

		for (QnaVO qna : list) {
		    int groupCount = QnaDAO.getGroupIdCount(qna.getGroup_id());  // group_id를 사용하여 count 조회
		    qna.setGroupCount(groupCount);  // 조회된 count 값을 QnaVO 객체에 설정
		}

		request.setAttribute("myqSize", list.size());
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("myqList", list);
		request.setAttribute("reList", relist);
		request.setAttribute("title", "문의 내역");
		request.setAttribute("mypage_jsp", "../mypage/mypage_qna.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/main.jsp";
	}

	@RequestMapping("mypage/mypage_qna_delete.do")
	public String mypage_qna_delete(HttpServletRequest request, HttpServletResponse response) {

		String qna_no=request.getParameter("qna_no");
		QnaDAO.mypageQnaDelete(Integer.parseInt(qna_no));
		return "redirect:../mypage/mypage_qna.do";
	}
	
	@RequestMapping("mypage/mypage_reserve.do")
	public String mypage_reserve(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		
		
		List<ReserveVO> hallrList=ReserveDAO.hallReserveMypageData(id);
		List<ReserveVO> suitrList=ReserveDAO.suitReserveMypageData(id);
		List<ReserveVO> dressrList=ReserveDAO.dressReserveMypageData(id);
		List<ReserveVO> studiorList=ReserveDAO.studioReserveMypageData(id);
		List<ReserveVO> hairmakeuprList=ReserveDAO.hairmakeupReserveMypageData(id);
		
		int hSize=hallrList.size();
		int dSize=dressrList.size();
		int suSize=suitrList.size();
		int sSize=studiorList.size();
		int mSize=hairmakeuprList.size();
		int totalRes=hSize+dSize+suSize+sSize+mSize;
		
		request.setAttribute("hCount", hallrList.size());
		request.setAttribute("dCount", dressrList.size());
		request.setAttribute("suCount", suitrList.size());
		request.setAttribute("sCount", studiorList.size());
		request.setAttribute("mCount", hairmakeuprList.size());
		request.setAttribute("totalRes", totalRes);
		
		request.setAttribute("title", "🕦예약내역🕦");
		request.setAttribute("hallrList", hallrList);
		request.setAttribute("suitrList", suitrList);
		request.setAttribute("dressrList", dressrList);
		request.setAttribute("studiorList", studiorList);
		request.setAttribute("hairmakeuprList", hairmakeuprList);
		request.setAttribute("mypage_jsp", "../mypage/mypage_reserve.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/mypage_reserve_cancel.do")
	public String mupage_reserve_cancel(HttpServletRequest request, HttpServletResponse response) {
		
		String resno=request.getParameter("resno");
		ReserveDAO.reserveCancel(Integer.parseInt(resno));
		return "redirect:../mypage/mypage_reserve.do";
	}

}