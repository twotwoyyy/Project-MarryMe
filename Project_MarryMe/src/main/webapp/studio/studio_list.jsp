<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	  <div id="list" class="studio_hair">
        <section class="list_banner">
            <h2>Studio & Hair Makeup</h2>
        </section>
        <section class="list_sc">
            <ul class="cate_list">
                <li data-list="studio" class="active"><a href="../studio/studio_list.do">스튜디오</a></li>
                <li data-list="hair"><a href="../studio/hairmakeup_list.do">헤어/메이크업</a></li>
            </ul>
            <div id="list_content">
            <ul class="brand_list container studio active">
            	<c:set var="delay" value="0"/>
            	<c:forEach var="studio" items="${studio_list}">
	                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="${delay}">
	                    <a href="../studio/studio_detail_before.do?sno=${studio.sno}">
	                        <div class="img_wrap">
	                            <img src="${studio.thumb}" alt="${studio.name}">
	                        </div>
	                        <div class="text_box">
	                            <p class="brand_name">${studio.name}</p>
	                            <p class="brand_sub">${studio.keyword}</p>
	                        </div>
	                    </a>
	                </li>
	                <c:set var="delay" value="${(delay + 300) % 1200}"/>
                </c:forEach>
            </ul>
            <ul class="page">
            	<c:if test="${startpage>1}">
                	<li><a href="../studio/studio_list.do?page=${startpage-1}">&lt;</a></li>
                </c:if>
                <c:forEach var="i" begin="${startpage}" end="${endpage}">
                	<li ${curpage==i?"class=active":""}><a href="../studio/studio_list.do?page=${i}">${i}</a></li>
                </c:forEach>
                <c:if test="${endpage<totalpage}">
                	<li><a href="../studio/studio_list.do?page=${endpage+1}">&gt;</a></li>
                </c:if>
            </ul>
            </div>
        </section>
        <section class="latest container">
            <h3>최근 본 목록</h3>
            <div class="latest_slide">
            	<c:forEach var="studio_ck" items="${studio_cookies}">
	                <div class="slides">
	                    <a href="../studio/studio_detail.do?sno=${studio_ck.sno}">
	                        <div class="img_wrap">
	                            <img src="${studio_ck.thumb}" alt="${studio_ck.name}">
	                        </div>
	                        <div class="text_box">
	                            <p class="brand_name">${studio_ck.name}</p>
	                            <p class="brand_sub">${studio_ck.keyword}</p>
	                        </div>
	                    </a>
	                </div>
                </c:forEach>
            </div>
        </section>
    </div>
</body>
</html>