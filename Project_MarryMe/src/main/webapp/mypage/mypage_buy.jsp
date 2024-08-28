<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
<style type="text/css">
	.sixth{
		margin-bottom: 30px;
	}
</style>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
    <div class="cart-container">
        <div class="sixth" id="myh1">
            <h1>🛒${sessionScope.name}님 구매내역 목록</h1>
        </div>
        <c:if test="${count==0 }">
       		<h4>구매한 상품이 없습니다</h4>
  		</c:if>
        <!-- 장바구니 항목 1 -->
        <c:if test="${count!=0 }">
        <div class="all-cart-item">
          <c:forEach var="vo" items="${buyList }" varStatus="status">
	        <div class="cart-item">
	            <img src="${vo.gvo.poster }" alt="상품 이미지">
	            <label id="gname${vo.cart_no }">${ vo.gvo.title}</label>
	            <input type="text" value="${vo.account }개" style="text-align: center;">
	            <span>${ vo.won}₩</span>
	            <input type="hidden" value="${vo.cart_no }" class="cart">
	            <input type="hidden" value="${vo.gno }" id="cart${vo.gno}">
	        </div>
	      </c:forEach> 
        </div>

        <!-- 총 금액 및 구매 버튼 -->
        <div class="cart-summary">
            <span>총 금액: <span id="totalAmount">${total}</span> 원</span>
        </div>
        </c:if>
    </div>
</body>
</html>
