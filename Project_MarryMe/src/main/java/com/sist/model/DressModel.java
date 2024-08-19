package com.sist.model;

import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.controller.RequestMapping;
import com.sist.dao.DressDAO;
import com.sist.dao.SuitDAO;
import com.sist.vo.DressVO;
import com.sist.vo.SuitVO;

public class DressModel {

    // 드레스 목록 화면을 처리하는 메서드
    @RequestMapping("dress/dress_list.do") // URL 매핑을 지정합니다.
    public String dress_list(HttpServletRequest request, HttpServletResponse response) {
        String page = request.getParameter("page"); // 페이지 번호를 요청에서 가져옵니다.
        if (page == null) { // 페이지 번호가 없는 경우
            page = "1";    // 기본 페이지를 1로 설정합니다.
        }
        int curPage = Integer.parseInt(page); // 페이지 번호를 정수로 변환합니다.
        int rowSize = 12; // 한 페이지에 표시할 출력물의 개수를 설정합니다.
        int start = (rowSize * curPage) - (rowSize - 1); // 현재 페이지에 몇 번째 데이터부터 출력할지 설정
        int end = rowSize * curPage; // 현재 페이지에 몇 번째 데이터까지 출력할지 설정
        
        Map map = new HashMap(); // Map 객체를 생성합니다.
        map.put("start", start); // 설정한 start의 값을 Map에 추가.
        map.put("end", end); // 설정한 end의 값을 Map에 추가.

        List<DressVO> dress_list = DressDAO.dressListData(map); // 드레스 목록 데이터를 가져옵니다.
        int totalPage = DressDAO.dressTotalPage(); // 전체 페이지 수를 가져옵니다.
        
        for (DressVO vo : dress_list) {
            String d_image = vo.getD_image();
            if (d_image != null && !d_image.trim().isEmpty()) {
                if (!d_image.startsWith("http:") && !d_image.startsWith("https:")) {
                    d_image = "https:" + d_image;
                }
                vo.setD_image(d_image);
            }
        }

        final int BLOCK = 5;
        int startPage = ((curPage - 1) / BLOCK * BLOCK) + 1;
        int endPage = ((curPage - 1) / BLOCK * BLOCK) + BLOCK;
        if (endPage > totalPage) 
            endPage = totalPage;
        
        request.setAttribute("dress_list", dress_list); // 드레스 목록을 요청에 추가합니다.
        request.setAttribute("curPage", curPage); // 현재 페이지를 요청에 추가합니다.
        request.setAttribute("totalPage", totalPage); // 전체 페이지를 요청에 추가합니다.
        request.setAttribute("startPage", startPage); // 시작 페이지를 요청에 추가합니다.
        request.setAttribute("endPage", endPage); // 끝 페이지를 요청에 추가합니다.

        request.setAttribute("main_jsp", "../dress/dress_list.jsp");
        return "../main/main.jsp";
    }

    // 드레스 상세 보기 화면을 처리하는 메서드
    @RequestMapping("dress/dress_detail.do")
    public String dress_detail(HttpServletRequest request, HttpServletResponse response) {
        String d_no = request.getParameter("d_no");
        Map map = new HashMap();
        
        DressVO vo = DressDAO.dressDetailData(map);
        request.setAttribute("vo", vo);
//		 CommonsModel.footerPrint(request); // 각 return "main.jsp"마다 footer에 내용 출력하는 코드

        request.setAttribute("main_jsp", "../dress/dress_detail.jsp");
        return "../main/main.jsp";
    }

    // 수트 목록 화면을 처리하는 메서드
    @RequestMapping("dress/suit_list")
    public String suit_list(HttpServletRequest request, HttpServletResponse response) {
        String page = request.getParameter("page");
        if (page == null) {
            page = "1";
        }
        int curPage = Integer.parseInt(page);
        int rowSize = 12;
        int start = (rowSize * curPage) - (rowSize - 1);
        int end = rowSize * curPage;

        Map map = new HashMap();
        map.put("start", start);
        map.put("end", end);

        List<SuitVO> suit_list = SuitDAO.suitListData(map);
        int totalPage = SuitDAO.suitTotalPage();
        
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
        request.setAttribute("curPage", curPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("suit_list", suit_list);

        request.setAttribute("main_jsp", "../dress/suit_list.jsp");
        return "../main/main.jsp";
    }
    
    // 수트 상세 보기 화면을 처리하는 메서드
    @RequestMapping("dress/suit_detail.do")
    public String suit_detail(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("main_jsp", "../dress/suit_detail.jsp");
        return "../main/main.jsp";
    }
}
