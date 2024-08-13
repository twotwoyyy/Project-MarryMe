<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$('#list .cate_list > li').click(function(){
		let type=$(this).attr('data-list');
		$.ajax({
			type:'POST',
			url:'../studio/list.do',
			data:{"type":type},
			success:function(result){
				
			},
			error:function(request, status, error){
				console.log(error);
			}
		})
	})
})
</script>
</head>
<body>
	  <div id="list" class="studio_hair">
        <section class="list_banner">
            <h2>Studio & Hair Makeup</h2>
        </section>
        <section class="list_sc">
            <ul class="cate_list">
                <li data-list="studio" class="active">스튜디오</li>
                <li data-list="hair">헤어/메이크업</li>
            </ul>
            <ul class="brand_list container studio active">
            	<c:forEach var="studio" items="${studio_list}">
	                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="">
	                    <a href="../studio/detail.do?shno=${studio.shno}">
	                        <div class="img_wrap">
	                            <img src="${studio.thumb}" alt="${studio.name}">
	                        </div>
	                        <div class="text_box">
	                            <p class="brand_name">${studio.name}</p>
	                            <p class="brand_sub">${studio.keyword}</p>
	                        </div>
	                    </a>
	                </li>
                </c:forEach>
            </ul>
            <ul class="brand_list container hair">
                <li data-aos="fade-up" data-aos-duration="1000">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="300">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="600">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="900">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
                <li data-aos="fade-up" data-aos-duration="1000">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="300">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="600">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="900">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
                <li data-aos="fade-up" data-aos-duration="1000">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="300">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>            
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="600">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="900">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/hair_demo.jpg" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name">업체 이름</p>
                            <p class="brand_sub">브랜드 부제</p>
                        </div>
                    </a>
                </li>
            </ul>
            <ul class="page">
            	<c:if test="${curpage>1}">
                	<li><a href="../studio/list.do?page=${startpage-1}">&lt;</a></li>
                </c:if>
                <c:forEach var="i" begin="${startpage}" end="${endpage}">
                	<li ${curpage==i?"class=active":""}><a href="../studio/list.do?page=${i}">${i}</a></li>
                </c:forEach>
                <c:if test="${curpage<totalpage}">
                	<li><a href="../studio/list.do?page=${endpage+1}">&gt;</a></li>
                </c:if>
            </ul>
        </section>
        <section class="latest container">
            <h3>최근 본 목록</h3>
            <div class="latest_slide">
                <div class="slides">
                    <a href="detail.html">
                        <div class="img_wrap">
                            <img src="../img/studio_demo.jpg" alt="">
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
                            <img src="../img/studio_demo.jpg" alt="">
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
                            <img src="../img/studio_demo.jpg" alt="">
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
                            <img src="../img/studio_demo.jpg" alt="">
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
                            <img src="../img/studio_demo.jpg" alt="">
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
                            <img src="../img/studio_demo.jpg" alt="">
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