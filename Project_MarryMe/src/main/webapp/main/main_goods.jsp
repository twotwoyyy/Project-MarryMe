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
	<c:forEach var="goods" items="${goods_list}">
	    <li>
	        <a href="#" class="pro_link active">
	            <img src="${goods.poster}" alt="${goods.title}">
	            <p class="product_name">${goods.title}</p>
	            <p class="product_sub">${goods.price}</p>
	        </a>
	    </li>
    </c:forEach>
</body>
</html>