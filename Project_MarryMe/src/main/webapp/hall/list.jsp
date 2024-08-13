<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>project marry me - hall</title>
<style>
    #list .list_sc .brand_list {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 40px;
        padding-top: 50px;
        list-style: none;
        padding: 1;
    }
    .brand_list li {
        flex: 1 1 200px;
    }
    .img_wrap img {
        max-width: 100%;
        height: 100%;
    }
    .text_box {
        text-align: center;
    }
    .centered {
    display: flex;
    justify-content: right;
    margin-top: 10px;
    margin-right: 15%;
	}
</style>
</head>
<body>
	<div id="list" class="hall">
        <section class="list_banner">
            <h2>Wedding Hall</h2>
        </section>
		<section class="centered">
		    <form method="GET" action="#">
		        <label for="search" class="hidden">검색</label>
		        <input type="search" id="search" name="search">
		        <input type="submit" value="검색">
		    </form>
		</section>
        <section class="list_sc">
            <!--
            <ul class="cate_list">
                <li data-list="studio" class="active">스튜디오</li>
                <li data-list="hair">헤어/메이크업</li>
            </ul>
            -->
            <ul class="brand_list container studio active">
                  <c:set var="delay" value="0"/>
                <!-- 첫 9개만 출력하도록 설정 -->
                <c:forEach var="vo" items="${list}" begin="0" end="8">
                    <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="${delay}">
                        <a href="detail.html">
                            <div class="img_wrap">
                                <img src="${vo.image}" alt="${vo.name}">
                            </div>
                            <div class="text_box">
                                <p class="brand_name">${vo.name}</p>
                             <!--  <p class="brand_sub">${vo.homepage}</p> --> 
                                <span class="hall_price text-right">#${vo.type} #${vo.menu } #${vo.mealcost }</span>
                            </div>
                        </a>
                    </li>
                    <c:set var="delay" value="${(delay + 300) % 900}"/>
                </c:forEach>
            </ul>
			<ul class="page">
			    <!-- 이전 페이지 링크 -->
			        <c:if test="${startPage>1}">
			            <li><a href="../hall/list.do?page=${startPage - 1}">&lt;</a></li>
			        </c:if>
			    <c:forEach var="i" begin="${startPage}" end="${endPage}">
			        <li class="${i == curpage ? 'active' : ''}">
			            <a href="../hall/list.do?page=${i}">${i}</a>
			        </li>
			    </c:forEach>
			    <!-- 다음 페이지 링크 -->
		        <c:if test="${endPage < totalpage}">
		            <li><a href="../hall/list.do?page=${endPage + 1}">&gt;</a></li>
		        </c:if>
			</ul>
        </section>
        <section class="latest container">
            <h3>최근 본 목록</h3>
            <div class="latest_slide">
                <div class="slides">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hall_demo.jpg" alt="">
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
                            <img src="../img/hall_demo.jpg" alt="">
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
                            <img src="../img/hall_demo.jpg" alt="">
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
                            <img src="../img/hall_demo.jpg" alt="">
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
                            <img src="../img/hall_demo.jpg" alt="">
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
                            <img src="../img/hall_demo.jpg" alt="">
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