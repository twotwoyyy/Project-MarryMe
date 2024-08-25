package com.sist.model;

import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.DressDAO;
import com.sist.dao.SuitDAO;
import com.sist.dao.WishDAO;
import com.sist.vo.DressVO;
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
        
        for(DressVO vo : dress_list) {
        	System.out.println(vo.getD_subject());
        }
        final int BLOCK = 5;
        int startPage = ((curPage - 1) / BLOCK * BLOCK) + 1;
        int endPage = ((curPage - 1) / BLOCK * BLOCK) + BLOCK;
        if (endPage > totalPage) 
            endPage = totalPage;
        
        // 드레스 목록추가, 시작, 현재, 끝, 전체 페이지 등록
        request.setAttribute("dress_list", dress_list);
        request.setAttribute("curPage", curPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("startPage", startPage); 
        request.setAttribute("endPage", endPage); 

        request.setAttribute("main_jsp", "../dress/dress_list.jsp");
        return "../main/main.jsp";
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
//        request.setAttribute("dress_list", dress_list);
		request.setAttribute("isWish", isWish);
        request.setAttribute("main_jsp", "../dress/dress_detail.jsp");
//		 CommonsModel.footerPrint(request); // 각 return "main.jsp"마다 footer에 내용 출력하는 코드
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
        
        // 상대적 URL을 가지고 있는 데이터를 절대적 URL로 변경, 이미지 출력
        // d_image가 NULL값이 아니거니 공백이 아닌 데이터 중 http, https로 시작하지 않으면 https:를 앞에 붙여서 출력
        for (SuitVO su : suit_list) {
    		String su_image = su.getSu_image();
    		if (su_image != null && !su_image.trim().isEmpty()) {
    			if (!su_image.startsWith("http:") && !su_image.startsWith("https:")) {
    				su_image = "https:" + su_image;
    			}
    			su.setSu_image(su_image);
    		}
    	}

        final int BLOCK = 5;
        int startPage = ((curPage - 1) / BLOCK * BLOCK) + 1;
        int endPage = ((curPage - 1) / BLOCK * BLOCK) + BLOCK;
        if (endPage > totalPage) {
            endPage = totalPage;
        }
        
        // 수트 목록추가, 시작, 현재, 끝, 전체 페이지 등록
        request.setAttribute("suit_list", suit_list);
        request.setAttribute("curPage", curPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);

        request.setAttribute("main_jsp", "../dress/suit_list.jsp");
        return "../main/main.jsp";
    }
    
    // 수트 상세 보기 화면을 처리하는 메서드
    @RequestMapping("dress/suit_detail.do")
    public String suit_detail(HttpServletRequest request, HttpServletResponse response) {
    	String su_no = request.getParameter("su_no");
        DressVO su_vo = DressDAO.dressDetailData(Integer.parseInt(su_no));

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
		

        request.setAttribute("suit_vo", su_vo);
		request.setAttribute("isWish", isWish);
        
        request.setAttribute("main_jsp", "../dress/suit_detail.jsp");
        return "../main/main.jsp";
    }

}
