<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <div id="list" class="goods">
	   <c:if test="${curpage==1 && cno==1}">
        <section class="list_banner">
            <h2>Marriage articles</h2>
        </section> 
       </c:if>
        <section class="list_sc">
            <!--
            <ul class="cate_list">
                <li data-list="studio" class="active">스튜디오</li>
                <li data-list="hair">헤어/메이크업</li>
            </ul>
            -->
            <ul class="brand_list container studio active">
            <c:set var="delay" value="0"></c:set>
              <c:forEach var="vo" items="${list }">
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="${delay }">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="${vo.poster }" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name" >${vo.title }</p>
                            <p class="brand_sub">${vo.price }</p>
                        </div>
                    </a>
                </li>
              	<c:set var="delay" value="${(delay + 300) % 1200}"/>
              </c:forEach>          
            </ul>
            <ul class="page">
              <c:if test="${startpage>1 }">
                <li><a href="../goods/list.do?page=${startpage-1 }">&lt;</a></li>
              </c:if>
                <c:forEach var="i" begin="${startpage }" end="${endpage }">
             
                	<li ${i==curpage?"class=active":""}><a href="../goods/list.do?page=${i }" >${ i}</a></li>
            
                </c:forEach>
              <c:if test="${endpage<totalpage }">
                <li><a href="../goods/list.do?page=${endpage+1 }">&gt;</a></li>
              </c:if>
            </ul>
        </section>
        <section class="latest container">
            <h3>최근 본 목록</h3>
            <div class="latest_slide">
                <div class="slides">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/marriage_goods_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </div>
                <div class="slides">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/marriage_goods_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </div>
                <div class="slides">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/marriage_goods_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </div>
                <div class="slides">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/marriage_goods_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </div>
                <div class="slides">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/marriage_goods_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </div>
                <div class="slides">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/marriage_goods_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </div>
            </div>
        </section>
    </div>
</body>
</html>