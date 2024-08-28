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
          <c:forEach var="vo" items="${cartList }" varStatus="status">
	        <div class="cart-item">
	            <input type="checkbox" data-price="${vo.price }" data-item="Item${status.count }" class="item-checkbox">
	            <img src="${vo.gvo.poster }" alt="상품 이미지">
	            <label>${ vo.gvo.title}</label>
	            <input type="number" value="${vo.account }" min="1" data-item="Item${status.count }" class="item-quantity">
	            <span>${ vo.won}₩</span>
	            <input type="hidden" value="${vo.cart_no }" class="cart">
	            <input type="hidden" value="${vo.cart_no }" class="cart">
	            <div class="action-buttons">
	              <form method="post" action="../mypage/mypage_cart_cancel.do?cno=${vo.cart_no }">
	                <button>삭제</button>
	              </form> 
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
        	const checkboxes = document.querySelectorAll('.item-checkbox');
            let totalAmount = 0;

            checkboxes.forEach(checkbox => {
                if (checkbox.checked) {
                    const price = parseFloat(checkbox.getAttribute('data-price'));
                    const item = checkbox.getAttribute('data-item');
                    const quantityInput = document.querySelector('.item-quantity[data-item="'+item+'"]');
                    const quantity = parseInt(quantityInput.value, 10);

                    totalAmount += price * quantity;
                }
            });
            const formatter = new Intl.NumberFormat('en-US');
            document.getElementById('totalAmount').innerText = formatter.format(totalAmount);
        }

        cartItems.forEach(item => {
            const checkbox = item.querySelector('input[type="checkbox"]');
            checkbox.addEventListener('change', updateTotal);
        });
		
        cartItems.forEach(item => {
            const number = item.querySelector('input[type="number"]');
            number.addEventListener('change', updateTotal);
        });
        
        
        // 초기 업데이트
        updateTotal();
    </script>
</body>
</html>
