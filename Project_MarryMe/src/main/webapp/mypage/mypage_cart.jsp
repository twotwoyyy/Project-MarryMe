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
var IMP = window.IMP; 
IMP.init("imp68206770"); 
$(function(){
	$('.buyBtn').click(function(){
		let cno=$(this).attr("data-cno");
		let name=$(this).attr("data-name");
		let fprice=$(this).attr("data-price");
		let account=$('#account'+cno).val();
		console.log(account)
		let price=fprice*account
		
		$.ajax({
			type:'post',
			url:'../mypage/mypage_cart_buy.do',
			data:{"cno":cno,"account":account},
			success:function(result)
			{
				let json=JSON.parse(result)
				console.log(json)
				requestPay(json,name,price)
				
			}
		})
		
	})
})
function requestPay(json,name,price) {
   IMP.request_pay({
     pg: "html5_inicis",
         pay_method: "card",
         merchant_uid: "ORD20180131-0000011",   // 주문번호
         name: name,
         amount: price,         // 숫자 타입
         buyer_email: json.email,
         buyer_name: json.name,
         buyer_tel: json.phone,
         buyer_addr: json.address,
         buyer_postcode: json.post
     }, function (rsp) { // callback
     	location.href='http://localhost/Project_MarryMe/mypage/mypage_buy.do' 
     });
}
$(document).ready(function() {
    function updateItemPrice() {
        $('.cart-item').each(function() {
            var quantityInput = $(this).find('.item-quantity');
            var price = parseFloat(quantityInput.data('price'));
            var quantity = parseInt(quantityInput.val(), 10);
            var totalPrice = price * quantity;
            $(this).find('.item-price').text(totalPrice.toLocaleString()+ '₩');
        });
    }

    // 수량 변경 시 금액 업데이트
    $('.item-quantity').on('input', updateItemPrice);

    // 초기 금액 업데이트
    updateItemPrice();
});
</script>
</head>
<body>
    <div class="cart-container">
        <div class="sixth" id="myh1">
            <h1>🛒${sessionScope.name}님 장바구니 목록</h1>
        </div>
        
        <!-- 장바구니 항목 1 -->
     	<c:if test="${cartList.size()==0 }">
       		<img src="http://mobile.iluvbabi.cafe24.com/data_m/common/img_cartnotice.jpg" style="width: 1000px;height: 600px">
  	    </c:if>
  	   <c:if test="${cartList.size()!=0 }">
        <div class="all-cart-item">
          
          <c:forEach var="vo" items="${cartList }" varStatus="status">
	        <div class="cart-item">
	            <img src="${vo.gvo.poster }" alt="상품 이미지">
	            <label id="gname${vo.cart_no }">${ vo.gvo.title}</label>
	            <input type="number" value="${vo.account }" min="1" data-item="Item${status.count }" class="item-quantity" id="account${vo.cart_no }" data-price="${vo.price}"> 
	            <span class="item-price">${(vo.price)*(vo.account)}₩</span>
	            <input type="hidden" value="${vo.cart_no }" id="cart${vo.cart_no }">
	            <input type="hidden" value="${vo.gno }" id="cart${vo.gno}">
	            <div class="action-buttons" style="display: flex">
	              <form method="post" action="../mypage/mypage_cart_cancel.do?cno=${vo.cart_no }">
	                <button>삭제</button>
	              </form> 
	                <button data-cno="${vo.cart_no }" data-name="${vo.gvo.title }" data-price="${vo.price }" class="buyBtn">구매</button>
	            </div>
	            <div>
	            	<span>단가: <span id="totalAmount">${ vo.won}</span> 원</span>
	            </div>
	        </div>
	      </c:forEach> 
        </div>
	  </c:if>
        <!-- 총 금액 및 구매 버튼 -->
    </div>
</body>
</html>
