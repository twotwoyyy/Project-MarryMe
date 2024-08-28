<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>project marry me - dress</title>
</head>
<body>
	 <div id="list" class="dress_suit">
        <section class="list_banner">
            <h2>Dress & Suit</h2>
        </section>
        <section class="list_sc">
            <ul class="cate_list">
                <li data-list="dress" class="active"><a href="../dress/dress_list.do">드레스</a></li>
                <li data-list="suit"><a href="../dress/suit_list.do">예복</a></li>
            </ul>
            <div id="list_content">
            <ul class="brand_list container dress active">
              <c:set var="delay" value="0"/>
               <c:forEach var="dress" items="${dress_list }">
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="${delay}">
                    <a href="../dress/dress_detail_before.do?d_no=${dress.d_no }">
                        <div class="img_wrap">
                            <img src="${dress.d_image}" alt="${dress.d_subject }">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">${dress.d_subject }</p>
                            <p class="brand_sub">${dress.d_price }</p>
                        </div>
                    </a>
                </li>
               <c:set var="delay" value="${(delay + 300) % 1200 }"/>
              </c:forEach>
            </ul>
				 <ul class="page">
				    <c:if test="${startPage > 1}">
				        <li><a href="../dress/dress_list.do?page=${startPage - 1}">&lt;</a></li>
				    </c:if>
				    <c:forEach var="i" begin="${startPage}" end="${endPage}">
				        <li class="${i == curPage ? 'active' : ''}"><a href="../dress/dress_list.do?page=${i}">${i}</a></li>
				    </c:forEach>
				    <c:if test="${endPage < totalPage}">
				        <li><a href="../dress/dress_list.do?page=${endPage + 1}">&gt;</a></li>
				    </c:if>
				</ul>
            </div>
        </section>
        <section class="latest container">
            <h3>최근 본 목록</h3>
            <div class="latest_slide">
            	<c:forEach var="dress_ck" items="${dress_cookies}">
	                <div class="slides">
	                    <a href="detail.html">
	                        <div class="img_wrap">
	                            <img src="${dress_ck.d_image}" alt="${dress_ck.d_subject}">
	                        </div>
	                        <div class="text_box">
	                            <p class="brand_name">${dress_ck.d_subject}</p>
	                            <p class="brand_sub">${dress_ck.d_price}</p>
	                        </div>
	                    </a>
	                </div>
                </c:forEach>
            </div>
        </section>
    </div>
</body>
</html>