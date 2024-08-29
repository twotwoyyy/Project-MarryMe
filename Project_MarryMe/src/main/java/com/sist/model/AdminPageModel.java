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
			
			for(QnaVO vo : list) {
				int count = QnaDAO.adminQnaOk(vo.getGroup_id());
				vo.setGroupCount(count);
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
			request.setAttribute("title", "문의 내역");
			request.setAttribute("admin_jsp", "../adminpage/adminpage_qna.jsp");
			request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");

		   return "../main/main.jsp";
	   }
		@RequestMapping("adminpage/adminpage_reserve.do")
		public String admimReserve(HttpServletRequest request, HttpServletResponse response) {
			
			List<ReserveVO> hallrList=ReserveDAO.hallReserveAdminpageData();
			List<ReserveVO> suitrList=ReserveDAO.suitReserveAdminpageData();
			List<ReserveVO> dressrList=ReserveDAO.dressReserveAdminpageData();
			List<ReserveVO> studiorList=ReserveDAO.studioReserveAdminpageData();
			List<ReserveVO> hairmakeuprList=ReserveDAO.hairmakeupReserveAdminpageData();
			int hSize=hallrList.size();
			int dSize=dressrList.size();
			int suSize=suitrList.size();
			System.out.println(suSize);
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
			System.out.println("123");
			
			
			try {
			request.setAttribute("admin_jsp", "../adminpage/adminpage_reserve.jsp");
			request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
			
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			return "../main/main.jsp";
		}
	   
		@RequestMapping("adminpage/adminpage_reserve_ok.do")
		public String admimReserve_ok(HttpServletRequest request, HttpServletResponse response) {
			String reNumber = request.getParameter("resno");
			
			ReserveDAO.adminReserveOK(Integer.parseInt(reNumber));
			
			
			return "redirect:../adminpage/adminpage_reserve.do";
		}
}
