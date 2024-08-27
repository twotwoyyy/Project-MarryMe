package com.sist.model;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.DressDAO;
import com.sist.dao.StudioDAO;
import com.sist.dao.SuitDAO;
import com.sist.dao.WishDAO;
import com.sist.vo.DressVO;
import com.sist.vo.HairMakeupVO;
import com.sist.vo.StudioVO;
import com.sist.vo.SuitVO;

public class DressModel {

    // 드레스 목록 화면을 처리하는 메서드
    @RequestMapping("dress/dress_list.do") 
    public String dress_list(HttpServletRequest request, HttpServletResponse response) {
    	// 첫 페이지를 1페이지로 지정
        String page = request.getParameter("page"); 
        if (page == null) {
            page = "1";    
        }
        // 한 페이지에 표시할 출력물의 개수를 설정하고, 어떤 데이터를 표시할지 지정.
        // 1~12, 13~24, 25~36
        int curPage = Integer.parseInt(page); 
        int rowSize = 12; 
        int start = (rowSize * curPage) - (rowSize - 1); 
        int end = rowSize * curPage; 
        
        Map map = new HashMap();
        map.put("start", start);
        map.put("end", end);

        List<DressVO> dress_list = DressDAO.dressListData(map);
        int totalPage = DressDAO.dressTotalPage();
        
//        for(DressVO vo : dress_list) {
//        	System.out.println(vo.getD_subject());
//        }
        final int BLOCK = 5;
        int startPage = ((curPage - 1) / BLOCK * BLOCK) + 1;
        int endPage = ((curPage - 1) / BLOCK * BLOCK) + BLOCK;
        if (endPage > totalPage) 
            endPage = totalPage;
        
        // 쿠키
        Cookie[] cookies = request.getCookies();
        List<DressVO> dress_cookies = new ArrayList<DressVO>();
        if (cookies != null) {
        	for (int i = cookies.length - 1; i >= 0; i--) {
        		if (cookies[i].getName().startsWith("dress_")) {
        			String d_no = cookies[i].getValue();
        			DressVO vo = DressDAO.dressDetailData(Integer.parseInt(d_no));
        			dress_cookies.add(vo);
        		}
        	}
        }
        
        // 드레스 목록추가, 시작, 현재, 끝, 전체 페이지 등록
        request.setAttribute("curPage", curPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("startPage", startPage); 
        request.setAttribute("endPage", endPage); 
        request.setAttribute("dress_list", dress_list);
		request.setAttribute("dress_cookies", dress_cookies);
        request.setAttribute("main_jsp", "../dress/dress_list.jsp");
        return "../main/main.jsp";
    }
    
    @RequestMapping("dress/dress_detail_before.do")
    	public String dress_detail_before (HttpServletRequest request, HttpServletResponse response) {
    		String d_no = request.getParameter("d_no");
    		Cookie cookie = new Cookie("dress_" + d_no, d_no);
    		cookie.setMaxAge(60*60*24);
    		cookie.setPath("/");
    		response.addCookie(cookie);
    		return "redirect:../dress/dress_detail.do?d_no=" + d_no;
    	}

    // 드레스 상세 보기 화면을 처리하는 메서드
    @RequestMapping("dress/dress_detail.do")
    public String dress_detail(HttpServletRequest request, HttpServletResponse response) {
        String d_no = request.getParameter("d_no");
        DressVO vo = DressDAO.dressDetailData(Integer.parseInt(d_no));
        
        HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		boolean isWish = false;
		if (id != null) {
			Map map = new HashMap();
			map.put("cno", d_no);
			map.put("cate", 2);
			map.put("id", id);
			int existWish = WishDAO.wishCheck(map);
			if (existWish != 0) {
				isWish = true;
			}			
		}
        
        request.setAttribute("dress_vo", vo);
		request.setAttribute("isWish", isWish);
        request.setAttribute("main_jsp", "../dress/dress_detail.jsp");
        return "../main/main.jsp";
    }

    // 수트 목록 화면을 처리하는 메서드
    @RequestMapping("dress/suit_list.do")
    public String suit_list(HttpServletRequest request, HttpServletResponse response) {
    	// 첫 페이지를 1페이지로 지정
        String page = request.getParameter("page");
        if (page == null) {
            page = "1";
        }
        
        // 한 페이지에 표시할 출력물의 개수를 설정하고, 어떤 데이터를 표시할지 지정.
        // 1~12, 13~24, 25~36
        int curPage = Integer.parseInt(page);
        int rowSize = 12;
        int start = (rowSize * curPage) - (rowSize - 1);
        int end = rowSize * curPage;

        Map map = new HashMap();
        map.put("start", start);
        map.put("end", end);

        List<SuitVO> suit_list = SuitDAO.suitListData(map);
        int totalPage = SuitDAO.suitTotalPage();

        final int BLOCK = 5;
        int startPage = ((curPage - 1) / BLOCK * BLOCK) + 1;
        int endPage = ((curPage - 1) / BLOCK * BLOCK) + BLOCK;
        if (endPage > totalPage) {
            endPage = totalPage;
        }
        
        // 수트 목록추가, 시작, 현재, 끝, 전체 페이지 등록
        request.setAttribute("curPage", curPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("suit_list", suit_list);
        
        // 쿠키
        Cookie[] cookies=request.getCookies();
		List<SuitVO> suit_cookies = new ArrayList<SuitVO>();
		if(cookies!=null) {
			for (int i = cookies.length-1; i >= 0; i--) {
				if (cookies[i].getName().startsWith("suit_")) {
					String su_no = cookies[i].getValue();
					SuitVO vo = SuitDAO.suitDetailData(Integer.parseInt(su_no));
					suit_cookies.add(vo);
				}
			}
		}
		request.setAttribute("suit_cookies", suit_cookies);

        request.setAttribute("main_jsp", "../dress/suit_list.jsp");
        return "../main/main.jsp";
    }
    
    @RequestMapping("dress/suit_deteail_before.do")
    public String suit_detail_before(HttpServletRequest request, HttpServletResponse response) {
    	String su_no = request.getParameter("su_no");
    	Cookie cookie = new Cookie("suit_" + su_no, su_no);
    	cookie.setMaxAge(60 * 60 * 24);
    	cookie.setPath("/");
    	response.addCookie(cookie);
    	return "redirect:../dress/suit_detail.do?su_no=" + su_no;
    }
    
    // 수트 상세 보기 화면을 처리하는 메서드
    @RequestMapping("dress/suit_detail.do")
    public String suit_detail(HttpServletRequest request, HttpServletResponse response) {
    	String su_no = request.getParameter("su_no");
        SuitVO suit_vo = SuitDAO.suitDetailData(Integer.parseInt(su_no));

        HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		boolean isWish = false;
		if (id != null) {
			Map map = new HashMap();
			map.put("cno", su_no);
			map.put("cate", 3);
			map.put("id", id);
			int existWish = WishDAO.wishCheck(map);
			if (existWish != 0) {
				isWish = true;
			}			
		}
        request.setAttribute("suit_vo", suit_vo);
		request.setAttribute("isWish", isWish);
        request.setAttribute("main_jsp", "../dress/suit_detail.jsp");
        return "../main/main.jsp";
    }

}
