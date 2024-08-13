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
	AOS.init();
})
</script>
</head>
<body>
    <ul class="brand_list container studio active">
   		<c:forEach var="studio" items="${studio_list}">
       	 	<li data-aos="fade-up" data-aos-duration="1000">
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
</body>
</html>