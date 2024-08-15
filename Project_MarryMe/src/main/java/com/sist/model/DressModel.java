package com.sist.model;

import java.util.HashMap;
import java.util.List;
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
        int curpage = Integer.parseInt(page); // 페이지 번호를 정수로 변환합니다.
        Map map = new HashMap(); // Map 객체를 생성합니다.
        int rowSize = 12; // 한 페이지에 표시할 출력물의 개수를 설정합니다.
        int start = (rowSize * curpage) - (rowSize - 1); // 현재 페이지에 몇 번째 데이터부터 출력할지 설정
        int end = rowSize * curpage; // 현재 페이지에 몇 번째 데이터까지 출력할지 설정
        map.put("start", start); // 설정한 start의 값을 Map에 추가.
        map.put("end", end); // 설정한 end의 값을 Map에 추가.

        List<DressVO> dress_list = DressDAO.dressListData(map); // 드레스 목록 데이터를 가져옵니다.
        int totalpage = DressDAO.dressTotalPage(map); // 전체 페이지 수를 가져옵니다.

        // 강사님 주석 참고해야 함 (제대로 이해 못함 / 얼추 감만 잡음)
        final int BLOCK = 5;
        int startpage = ((curpage - 1) / BLOCK * BLOCK) + 1;
        int endpage = ((curpage - 1) / BLOCK * BLOCK) + BLOCK;
        if (endpage > totalpage) {
            endpage = totalpage;
        }
        request.setAttribute("curpage", curpage); // 현재 페이지를 요청에 추가합니다.
        request.setAttribute("totalpage", totalpage); // 전체 페이지를 요청에 추가합니다.
        request.setAttribute("startpage", startpage); // 시작 페이지를 요청에 추가합니다.
        request.setAttribute("endpage", endpage); // 끝 페이지를 요청에 추가합니다.
        request.setAttribute("dress_list", dress_list); // 드레스 목록을 요청에 추가합니다.

        request.setAttribute("main_jsp", "../dress/dress_list.jsp");
        return "../main/main.jsp";
    }

    // 드레스 상세 보기 화면을 처리하는 메서드
    @RequestMapping("dress/dress_detail.do")
    public String dress_detail(HttpServletRequest request, HttpServletResponse response) {
        String no = request.getParameter("no");
        Map map = new HashMap();
        map.put("no", no);
        
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
        int curpage = Integer.parseInt(page);
        Map map = new HashMap();
        int rowSize = 12;
        int start = (rowSize * curpage) - (rowSize - 1);
        int end = rowSize * curpage;
        map.put("start", start);
        map.put("end", end);

        List<SuitVO> suit_list = SuitDAO.suitListData(map);
        int totalpage = SuitDAO.suitTotalPage(map);

        final int BLOCK = 5;
        int startpage = ((curpage - 1) / BLOCK * BLOCK) + 1;
        int endpage = ((curpage - 1) / BLOCK * BLOCK) + BLOCK;
        if (endpage > totalpage) {
            endpage = totalpage;
        }
        request.setAttribute("curpage", curpage);
        request.setAttribute("totalpage", totalpage);
        request.setAttribute("startpage", startpage);
        request.setAttribute("endpage", endpage);
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
