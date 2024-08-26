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

})
</script>
</head>
<body>
	<div id="find">
		<ul class="find_tab">
			<li>통합</li>
			<li>웨딩홀</li>
			<li>드레스</li>
			<li>예복</li>
			<li>스튜디오</li>
			<li>헤어메이크업</li>
			<li>혼수</li>
		</ul>
		<ul class="find_list">
			<c:forEach var="findlist" items="${find_list}">
			<li>
               <a href="#" class="pro_link">
                   <div class="img_wrap">
                       <img src="" alt="">
                   </div>
                   <p class="product_name"></p>
                   <p class="product_sub"></p>
               </a>
           </li>
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
</body>
</html>