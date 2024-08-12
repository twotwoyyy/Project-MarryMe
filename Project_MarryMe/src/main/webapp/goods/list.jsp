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
        <section class="list_banner">
            <h2>Marriage articles</h2>
        </section>
        <section class="list_sc">
            <!--
            <ul class="cate_list">
                <li data-list="studio" class="active">스튜디오</li>
                <li data-list="hair">헤어/메이크업</li>
            </ul>
            -->
            <ul class="brand_list container studio active">
            <c:set var="count" value="${count }"></c:set>
              <c:forEach var="vo" items="${list }">
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="${count*300 }">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="${vo.poster }" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">${vo.title }</p>
                            <p class="brand_sub">${vo.price }</p>
                        </div>
                    </a>
                </li>
                <c:if test="${count<3 }">    
              		<c:set var="count" value="${count+1 }"></c:set>
              	</c:if>
              	<c:if test="${count>=4 }">
              		<c:set var="count" value="${count=0 }"></c:set>
              	</c:if>
              </c:forEach>          
            </ul>
            <ul class="page">
                <li><a href="">&lt;</a></li>
                <li class="active"><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">&gt;</a></li>
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