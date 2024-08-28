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
</head>
<body>
    <div class="cart-container">
        <div class="sixth" id="myh1">
            <h1>🛒${sessionScope.name}님 장바구니 목록</h1>
        </div>
        
        <!-- 장바구니 항목 1 -->
       
        <div class="all-cart-item">
          <c:forEach var="vo" items="${cartList }">
	        <div class="cart-item">
	            <input type="checkbox">
	            <img src="${vo.gvo.poster }" alt="상품 이미지">
	            <label>vo.gvo.title</label>
	            <input type="number" value="${vo.account }" min="1">
	            <span>vo.price</span>
	            <div class="action-buttons">
	                <button>삭제</button>
	            </div>
	        </div>
	      </c:forEach> 
        </div>

        <!-- 총 금액 및 구매 버튼 -->
        <div class="cart-summary">
            <span>총 금액: <span id="totalAmount">0</span> 원</span>
            <br>
            <button id="checkoutButton">구매하기</button>
        </div>
    </div>

    <script>
        // 총 금액을 계산하는 스크립트
        const cartItems = document.querySelectorAll('.cart-item');
        const totalAmountElem = document.getElementById('totalAmount');

        function updateTotal() {
            let totalAmount = 0;
            cartItems.forEach(item => {
                const checkbox = item.querySelector('input[type="checkbox"]');
                const price = parseInt(item.querySelector('span').innerText.replace('₩', '').replace(',', ''), 10);
                if (checkbox.checked) {
                    totalAmount += price;
                }
            });
            totalAmountElem.innerText = totalAmount.toLocaleString();
        }

        cartItems.forEach(item => {
            const checkbox = item.querySelector('input[type="checkbox"]');
            checkbox.addEventListener('change', updateTotal);
        });

        // 초기 업데이트
        updateTotal();
    </script>
</body>
</html>
