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
	$('#goods .goods_tab > li').click(function(){
		let cate=$(this).attr('data-list');
		$.ajax({
			type:'POST',
			url:'../main/main_goods.do',
			data:{"cate":cate},
			success:function(result){
				$('#goods .product .product_list').html(result);
			},
			error:function(request, status, error){
				console.log(error)
			}
		})
	})
	$('#goods .goods_tab > li:first-child').trigger('click');
})
</script>
</head>
<body>
	<main id="main">
        <section id="banner">
            <p>Will you with "Marry Me"?</p>
            <div class="banner_slide">
                <img src="../img/banner_01.jpg" alt="" class="banner_img">
                <img src="../img/banner_02.jpg" alt="" class="banner_img">
                <img src="../img/banner_03.jpg" alt="" class="banner_img">
            </div>
        </section>
        <section id="hall">
            <div class="hall_slide">
            	<c:forEach var="hall" items="${hall_list}">
	                <a href="#" class="hall_slides pro_link">
	                   	<img src="${hall.image}" alt="${hall.name}">
	                    <p class="product_name">${hall.name}</p>
	                    <p class="product_sub">${hall.type}</p>
	                </a>
                </c:forEach>
            </div>
            <div class="tt_box">
                <h2 class="cate_tt"><span>W </span>edding Hall</h2>
                <p class="cate_desc">새로운 시작의 설렘과 행복을 담은</p>
                <p class="cate_desc">가장 사랑받는 베스트 웨딩홀</p>
                <a href="../hall/list.do" class="viewmore">view more</a>
            </div>
        </section>
        <section id="dress">
            <ul class="dress_list">
                <li>
                    <a href="#" class="pro_link">
                        <div class="img_wrap">
                            <img src="../img/dress_demo.jpg" alt="">
                        </div>
                        <p class="product_name">드레스 이름</p>
                        <p class="product_sub">드레스 설명</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="pro_link">
                        <div class="img_wrap">
                            <img src="../img/dress_demo.jpg" alt="">
                        </div>
                        <p class="product_name">드레스 이름</p>
                        <p class="product_sub">드레스 설명</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="pro_link">
                        <div class="img_wrap">
                            <img src="../img/dress_demo.jpg" alt="">
                        </div>
                        <p class="product_name">드레스 이름</p>
                        <p class="product_sub">드레스 설명</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="pro_link">
                        <div class="img_wrap">
                            <img src="../img/dress_demo.jpg" alt="">
                        </div>
                        <p class="product_name">드레스 이름</p>
                        <p class="product_sub">드레스 설명</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="pro_link">
                        <div class="img_wrap">
                            <img src="../img/dress_demo.jpg" alt="">
                        </div>
                        <p class="product_name">드레스 이름</p>
                        <p class="product_sub">드레스 설명</p>
                    </a>
                </li>
            </ul>
            <div class="tt_box">
                <h2 class="cate_tt"><span>D </span>ress & <span>T</span>uxedo</h2>
                <p class="cate_desc">누구보다 빛나는 주인공</p>
                <p class="cate_desc">가장 사랑받는 베스트 드레스 & 예복</p>
                <a href="../dress/list.do" class="viewmore">view more</a>
            </div>
            <ul class="dress_list">
                <li>
                    <a href="#" class="pro_link">
                        <div class="img_wrap">
                            <img src="../img/suit_demo.jpg" alt="">
                        </div>
                        <p class="product_name">예복 이름</p>
                        <p class="product_sub">예복 설명</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="pro_link">
                        <div class="img_wrap">
                            <img src="../img/suit_demo.jpg" alt="">
                        </div>
                        <p class="product_name">예복 이름</p>
                        <p class="product_sub">예복 설명</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="pro_link">
                        <div class="img_wrap">
                            <img src="../img/suit_demo.jpg" alt="">
                        </div>
                        <p class="product_name">예복 이름</p>
                        <p class="product_sub">예복 설명</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="pro_link">
                        <div class="img_wrap">
                            <img src="../img/suit_demo.jpg" alt="">
                        </div>
                        <p class="product_name">예복 이름</p>
                        <p class="product_sub">예복 설명</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="pro_link">
                        <div class="img_wrap">
                            <img src="../img/suit_demo.jpg" alt="">
                        </div>
                        <p class="product_name">예복 이름</p>
                        <p class="product_sub">예복 설명</p>
                    </a>
                </li>
            </ul>
        </section>
        <section id="studio">
            <div class="studio_slide">
            	<c:forEach var="studio" items="${studio_list}">
	                <a href="#" class="pro_link">
	                   	<img src="${studio.thumb}" alt="${studio.name}">
	                    <p class="product_name">${studio.name}</p>
	                    <p class="product_sub">${studio.keyword}</p>
	                </a>
                </c:forEach>
            </div>
            <div class="tt_box">
                <h2 class="cate_tt"><span>S </span>tudio &<br> <span>H</span>air Makeup</h2>
                <p class="cate_desc">시간이 지나도 변하지 않을 순간</p>
                <p class="cate_desc">가장 사랑받는 베스트 스튜디오 & 헤어메이크업</p>
                <a href="../studio/list.do" class="viewmore">view more</a>
            </div>
            <div class="studio_slide">
            	<c:forEach var="hair_makeup" items="${hair_makeup_list}">
	                <a href="#" class="pro_link">
	                    <div class="img_wrap">
	                        <img src="${hair_makeup.thumb}" alt="${hair_makeup.name}">
	                    </div>
	                    <p class="product_name">${hair_makeup.name}</p>
	                    <p class="product_sub">${hair_makeup.keyword}</p>
	                </a>
                </c:forEach>
            </div>
        </section>
        <section id="goods">
            <div class="left">
                <div class="tt_box">
                    <h2 class="cate_tt"><span>M</span>arriage articles</h2>
                    <p class="cate_desc">함께하는 시간</p>
                    <p class="cate_desc">가장 사랑받는 베스트 혼수</p>
                    <a href="../goods/list.do" class="viewmore">view more</a>
                </div>
                <ul class="goods_tab">
                    <li class="active" data-list="가구">가구</li>
                    <li data-list="가전">가전</li>
                    <li data-list="카드">청첩장</li>
                </ul>
            </div>
            <div class="product">
                <ul class="product_list">
                	<%-- <c:forEach var="goods" items="${goods_list}">
	                    <li>
	                    	<p>${goods_list}</p>
	                        <a href="#" class="pro_link active">
	                            <div class="img_wrap">
	                                <img src="${goods.poster}" alt="${goods.title}">
	                            </div>
	                            <p class="product_name">${goods.title}</p>
	                            <p class="product_sub">${goods.price}</p>
	                        </a>
	                    </li>
                    </c:forEach> --%>
                </ul>
            </div>
        </section>
        <section id="community"></section>
    </main>
</body>
</html>