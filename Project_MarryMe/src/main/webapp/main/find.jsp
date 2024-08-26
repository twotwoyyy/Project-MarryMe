<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/find.css">
<script type="text/javascript">
$(function(){
	readmore();
	let find_tabs=$('#find .find_tab li'),
		find_li=$('#find .find_list li');
	find_tabs.click(function(){
		let target=$(this).attr('data-cate')
		find_tabs.removeClass('active');
		$(this).addClass('active');
		if(target==="all"){
			//find_li.css({display:'block'})
			find_li.addClass('show')
			$(this).siblings('li').removeClass('active');
			$('.find_list .no_list').css({display:'none'})
			$('.find_list .no_list').removeClass('show');
		}else{
			if($('.find_list li.'+target).length===0){
				if($('.no_list').length===0){
					find_li.css({display:'none'})
					find_li.removeClass('show')
					$('.find_list').append('<li class="no_list">해당 카테고리에 검색결과가 없습니다<br><span>😢</span></li>')
					$('.find_list .no_list').css({display:'block'})
					$('.find_list .no_list').addClass('show')
					readmore()
				}else{
					find_li.css({display:'none'})
					find_li.removeClass('show')
					$('.find_list .no_list').css({display:'block'})
					$('.find_list .no_list').addClass('show')
				}
			}else{
				find_li.css({display:'none'})
				find_li.removeClass('show')
				//$('.find_list li.'+target).css({display:'block'})
				$('.find_list li.'+target).addClass('show')
				$('.find_list .no_list').css({display:'none'})
				$('.find_list .no_list').removeClass('show')
				readmore()
			}		
		}
		readmore()
	})
	function readmore(){
		let find_li_show=$('#find .find_list li.show');
		if(find_li_show.length < 16){
			find_li_show.show();
			$('#find .readmore').css({display:'none'});
		}else{
			$('#find .readmore').css({display:'block'});
			find_li_show.hide();
			find_li_show.slice(0,16).show();
			$('#find .readmore').click(function(e){
				e.preventDefault();
				$('.find_list li.show:hidden').slice(0,16).fadeIn(300).show();
				if($('.find_list li.show:hidden').length===0){
					$('#find .readmore').css({display:'none'});
				}
			})		
		}
	}
})
</script>
</head>
<body>
	<div id="find">
		<div class="container">
			<ul class="find_tab">
				<li data-cate="all" class="active">통합</li>
				<li data-cate="hall">웨딩홀</li>
				<li data-cate="dress">드레스</li>
				<li data-cate="suit">예복</li>
				<li data-cate="studio">스튜디오</li>
				<li data-cate="hairmakeup">헤어메이크업</li>
				<li data-cate="goods">혼수</li>
			</ul>
			<ul class="find_list">
				<c:forEach var="hall" items="${find_hall}">
				<li class="hall show">
	               <a href="../hall/detail.do?hno=${hall.hno}" class="pro_link">
	                   <div class="img_wrap">
	                       <img src="${hall.image}" alt="${hall.name}">
	                   </div>
	                   <p class="product_name">${hall.name}</p>
	                   <p class="product_sub">${hall.type}</p>
	               </a>
	           </li>
	           </c:forEach>
	           <c:forEach var="dress" items="${find_dress}">
				<li class="dress show">
	               <a href="../dress/dress_detail.do?d_no=${dress.d_no}" class="pro_link">
	                   <div class="img_wrap">
	                       <img src="${dress.d_image}" alt="${dress.d_subject}">
	                   </div>
	                   <p class="product_name">${dress.d_subject}</p>
	                   <p class="product_sub">${dress.d_price}</p>
	               </a>
	           </li>
	           </c:forEach>
	           <c:forEach var="suit" items="${find_suit}">
				<li class="suit show">
	               <a href="../dress/suit_detail.do?su_no=${suit.su_no}" class="pro_link">
	                   <div class="img_wrap">
	                       <img src="${suit.su_image}" alt="${suit.su_subject}">
	                   </div>
	                   <p class="product_name">${suit.su_subject}</p>
	                   <p class="product_sub">${suit.su_price}</p>
	               </a>
	           </li>
	           </c:forEach>         
	           <c:forEach var="studio" items="${find_studio}">
				<li class="studio show">
	               <a href="../studio/studio_detail.do?sno=${studio.sno}" class="pro_link">
	                   <div class="img_wrap">
	                       <img src="${studio.thumb}" alt="${studio.name}">
	                   </div>
	                   <p class="product_name">${studio.name}</p>
	                   <p class="product_sub">${studio.keyword}</p>
	               </a>
	           </li>
	           </c:forEach>
	           <c:forEach var="hm" items="${find_hm}">
				<li class="hairmakeup show">
	               <a href="../studio/hairmakeup_detail.do?mno=${hm.mno}" class="pro_link">
	                   <div class="img_wrap">
	                       <img src="${hm.thumb}" alt="${hm.name}">
	                   </div>
	                   <p class="product_name">${hm.name}</p>
	                   <p class="product_sub">${hm.keyword}</p>
	               </a>
	           </li>
	           </c:forEach>
	           <c:forEach var="goods" items="${find_goods}">
				<li class="goods show">
	               <a href="../goods/detail.do?cate=6&pno=${goods.mgno}" class="pro_link">
	                   <div class="img_wrap">
	                       <img src="${goods.poster}" alt="${goods.title}">
	                   </div>
	                   <p class="product_name">${goods.title}</p>
	                   <p class="product_sub">${goods.price}</p>
	               </a>
	           </li>
	           </c:forEach>
			</ul>
			<button class="readmore">read more</button>
       	</div>
	</div>
</body>
</html>