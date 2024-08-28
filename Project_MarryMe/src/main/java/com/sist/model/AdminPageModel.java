package com.sist.model;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.Servlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

public class AdminPageModel {
	private String[] types = {"", "공지1", "공지2", "공지3", "공지4"};
	
	@RequestMapping("adminpage/adminpage_main.do")
	public String adminpage_main(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");
	    MemberVO vo = MemberDAO.memberUpdateData(id);
	    
	    request.setAttribute("vo", vo);
	    request.setAttribute("title", "💐관리자 페이지💐");
		request.setAttribute("admin_jsp", "../adminpage/adminpage_home.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		
		return "../main/main.jsp";
	}
	
	@RequestMapping("adminpage/member_list.do")
	public String member_list(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("admin_jsp", "../adminpage/member_list.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		
		return "../main/main.do";
	}
	   
	   @RequestMapping("adminpage/reply_insert.do")
	   public String reply_insert(HttpServletRequest request,HttpServletResponse response)
	   {
		   String no=request.getParameter("no");
		   request.setAttribute("no", no);
		   request.setAttribute("admin_jsp", "../adminpage/adminpage_reply_insert.jsp");
		   request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");

		   return "../main/main.jsp";
	   }
	   
	   @RequestMapping("adminpage/adminpage_qna.do")
	   public String qna_list(HttpServletRequest request,HttpServletResponse response) {
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

			List<QnaVO> list=QnaDAO.adminQnaListData(map);
		    List<QnaVO> relist = new ArrayList();
		    for (QnaVO qna : list) {
		        int groupId = qna.getGroup_id();
		        List<QnaVO> replies = QnaDAO.adminQnaListReData(groupId);
		        relist.addAll(replies); // 답변 리스트를 모읍니다
		    }

			int count = QnaDAO.adminQnaTotalPage(id);
			int total = count;
					
			int totalpage = (int)(Math.ceil(count/10.0));
			count = count - ((curpage * 10) - 10);

			for (QnaVO qna : list) {
			    int groupCount = QnaDAO.getGroupIdCount(qna.getGroup_id());  // group_id를 사용하여 count 조회
			    qna.setGroupCount(groupCount);  // 조회된 count 값을 QnaVO 객체에 설정
			}
			request.setAttribute("total", total);
			request.setAttribute("count", count);
			request.setAttribute("adminqSize", list.size());
			request.setAttribute("curpage", curpage);
			request.setAttribute("totalpage", totalpage);
			request.setAttribute("adminqList", list);
			request.setAttribute("reList", relist);
			request.setAttribute("title", "문의 내역");
			request.setAttribute("admin_jsp", "../adminpage/adminpage_qna.jsp");
			request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");

		   return "../main/main.jsp";
	   }
}
