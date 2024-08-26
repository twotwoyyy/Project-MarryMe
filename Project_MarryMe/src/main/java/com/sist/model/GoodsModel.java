package com.sist.model;

import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.RequestMapping;

import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;

import oracle.net.ns.SessionAtts;
public class GoodsModel {
	private String[] category={"","종합","침대","가구","가전","카드"};
	@RequestMapping("goods/list.do")
	public String goods_list(HttpServletRequest request, HttpServletResponse response) {
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		String cno=request.getParameter("cno");
		if(cno==null)
			cno="1";
		int curpage=Integer.parseInt(page);
		int rowSize=12;
		int start=(rowSize*curpage)-(rowSize-1);
		int end=rowSize*curpage;
		String realFolder="";
		ServletContext context = request.getServletContext();
		  
		  realFolder = context.getRealPath("");
		Map map=new HashMap();
		if(cno.equals("1")) {
			map.put("category", "");
		}else {
			map.put("category", category[Integer.parseInt(cno)]);
		}
		map.put("start", start);
		map.put("end", end);
		List<GoodsVO> list=GoodsDAO.goodsListData(map);
		int total=GoodsDAO.goodsTotalPage(map);
		
		int totalpage=(int)(Math.ceil(total/rowSize));
		
		// 페이지 개수 표시
		final int BLOCK=5;
		
		
		int startpage=((curpage-1)/BLOCK*BLOCK)+1;
		int endpage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		
		if(endpage>totalpage)
			endpage=totalpage;
		
		request.setAttribute("list", list);
		request.setAttribute("cno", cno);
		request.setAttribute("curpage", curpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("total", total);	
		
		request.setAttribute("main_jsp", "../goods/list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("goods/detail.do")
	public String goods_detail(HttpServletRequest request,HttpServletResponse response) {
		String pno=request.getParameter("pno");
		String cate=request.getParameter("cate");
		GoodsVO vo=GoodsDAO.goodsDetailData(Integer.parseInt(pno));
		List<String> list=GoodsDAO.goodsContentData(Integer.parseInt(pno));
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		boolean isWish=false;
		
		if(id!=null) {
			Map map=new HashMap();
			map.put("cno", pno);
			map.put("cate", 6);
			map.put("id", id);
			int existWish=WishDAO.wishCheck(map);
			if(existWish!=0) {
				isWish=true;
			}			
		}
		int price=Integer.parseInt(vo.getPrice().replaceAll("[^0-9]", ""));
		int discount=0;
		if(!vo.getDiscount().equals("할인없음")){
			 discount=Integer.parseInt(vo.getDiscount().replaceAll("[^0-9]", ""));
		}
		int firstprice=(int)Math.ceil((double)price/(100-discount))*100;
		String fPrice=new DecimalFormat("###,###,###").format(firstprice);
				
		vo.setPoster(vo.getPoster().replace("230x230ex", "480x480ex")); // 이미지 크기 조절
		Map map=new HashMap();
		
		map.put("cate", Integer.parseInt(cate));
		map.put("pno", Integer.parseInt(pno));
		int totalscore=0;
		int score=0;
		int point=0;
		int reviewtotal=0;
		try {
			reviewtotal=ReviewDAO.reviewTotalPage(map);
		
			List<Integer> sList=ReviewDAO.reviewScoreData(map);
			for(int i:sList) {
				totalscore=totalscore+i;
			}
			
			score=(int)Math.floor(totalscore/(double)reviewtotal);	
			
			if(totalscore%reviewtotal!=0) {
				point=1;
			}
		
		}catch(Exception ex) {
			System.out.println("NoReview");
		}
		
		
		
		//System.out.println("score: "+score);
		//System.out.println("point: "+point);
		request.setAttribute("isWish", isWish);
		request.setAttribute("fPrice", fPrice);
		request.setAttribute("score", score);
		request.setAttribute("point", point);
		request.setAttribute("reviewtotal", reviewtotal);
		request.setAttribute("cList", list);
		request.setAttribute("vo", vo);
		request.setAttribute("pno", pno);
		request.setAttribute("cate", cate);
		request.setAttribute("main_jsp", "../goods/detail.jsp");
		return "../main/main.jsp";
	}
}
