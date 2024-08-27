<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<link rel="stylesheet" href="../css/detail.css">

<style type="text/css">
.collect:hover{
	background-color: #bbbbbb;
}
#detail .reservation .tops{
    display:flex;
    justify-content:space-between;
    align-items:start;
    padding-bottom:20px;
    border-bottom:1px solid #303030;
}
#detail .reservation .tops .icons > *{
    background:no-repeat center center cover;
    text-indent:-9999em;
    cursor: pointer;
}
#detail .reservation .tops .icons .wish{
    width:32px;
    height:28px;
    background-image:url(../img/wish_list.png);
    margin-right:10px;
}
#detail .reservation .tops .icons .wish.active,
#detail .reservation .tops .icons .wish:hover{
    background-image:url(../img/wish_list_hover.png);
}
#detail .reservation .tops .icons .share{
    width:28px;
    height:32px;
    background-image:url(../img/share_link.png);
}
#detail .reservation .tops .icons .share:hover{
    background-image:url(../img/share_link_hover.png);
}
.buyBtn{
	display: flex;
	width: 225px ;;
    height: 40px;
    line-height: 40px;
    text-align: center;
    background: #303A1F;
    align-items: center; /* 텍스트 수직 가운데 정렬 */
    justify-content: center; /* 텍스트 수평 가운데 정렬 */
    color: #dcdcdc;
    cursor: pointer;
    position: relative;
}
 .star-container {
            position: relative;
            width: 20px; /* SVG의 너비 */
            height: 20px; /* SVG의 높이 */
        }
        .stars {
            position: absolute;
            width: 100%;
            height: 100%;
            clip-path: polygon(50% 0%, 61% 35%, 98% 35%, 68% 57%, 79% 91%, 50% 70%, 21% 91%, 32% 57%, 2% 35%, 39% 35%);
        }
        .stars-left {
            fill: #0b3a1e; /* 왼쪽 색상 */
            clip-path: inset(0 50% 0 0); /* 오른쪽 절반을 잘라냅니다 */
        }
        .stars-right {
            fill: #bbbbbb; /* 오른쪽 색상 */
            clip-path: inset(0 0 0 50%); /* 왼쪽 절반을 잘라냅니다 */
        }
</style>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
let sel=0;
var IMP = window.IMP; 
IMP.init("imp68206770"); 
$(function(){
	let pno=${pno}
	$('.wish').click(function(){
		if(${sessionScope.id==null}){
			alert('로그인 후 이용해주세요')
			location.href="../member/login.do";
		}else{
			$.ajax({
				type:'POST',
				url:'../wish/control.do',
				data:{"cno":pno, "cate":6},
				success:function(result){
					if(result==="OK"){
						$('.wish').addClass('active');
						alert('위시 리스트에 저장되었습니다')
					}else{
						$('.wish').removeClass('active');
						alert('위시 리스트가 삭제되었습니다')
					}
				},
				error:function(request, status, error){
					console.log(error)
				}
			})			
		}
	})
	$('.share').click(function(){
		let temp=document.createElement("textarea");
		document.body.appendChild(temp);
		let current_url=window.document.location.href;
		temp.value = current_url;
		temp.select();
		document.execCommand("copy");
		document.body.removeChild(temp);
		alert("현재 URL이 복사되었습니다.");
	})
	$('#sel').change(function(){
		let account=$('#sel').val()
		let EA=$('#ea').data('ea')
		if(account===0)
		{
			alert("수량을 선택하세요")
			return
		}
		if(EA!==0){
		let price=$('#sel').attr("data-price")
		let total=Number(price)*Number(account)
		$('#total').text(total.toLocaleString()+"원")
		$('#account').val(account)
		sel=1;
		}
	})
	$('#buy').click(function(){
		if(sel===0)
		{
			alert("수량을 선택하세요")
			return
		}
		
		let gno=$('#pno').val()
		let price=$('#sel').data('price')
		let account=$('#sel').val()
		let name=$('#title').text()
		$.ajax({
			type:'post',
			url:'../goods/buy_insert.do',
			data:{"gno":gno,"price":price,"account":account},
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
    	location.href='http://localhost/JSPLastProject/mypage/mypage_buy.do' 
    });
}
</script>
</head>
<body>
	<div id="detail" class="studio">
        <div class="tt_box">
            <h2 id="title">${vo.title }</h2>
            <p>${vo.category }</p>
        </div>
        <div class="detail_wrap">
            <div class="left">
                <section class="thumbnail">
                    <div class="img_wrap">
                        <img src="${vo.poster }" alt="">
                    </div>
                </section>
                <section class="bottom_wrap">
                    <ul class="detail_tab">
                        <li><a href="#brand" class="active">
                        제품 정보
                        <input type="hidden" value="${pno }" id="pno">
                        <input type="hidden" value="${cate }" id="cate">
                        </a>         
                        </li>
                        <li><a href="#review">후기()</a></li>
                        <li><a href="#qna">문의()</a></li>
                    </ul>
                    <div class="bottom_content">
                        <div id="brand">
                            <h3>제품 상세</h3>
                            <table>
                                <tbody>
                                 <c:if test="${cList.size()==0}">
                                 	<tr>
                                        <th scope="row">-</th>
                                        <td></td>
                                    </tr>
                                 </c:if>
                                 <c:forEach var="content" items="${cList }">
                                    <tr>
                                        <th scope="row">-</th>
                                        <td>${content}</td>
                                    </tr>
                                 </c:forEach>   
                                </tbody>
                            </table>
                        </div>
                        <!-- <hr>
                        <div id="video">
                            <h3>영상</h3>
                            <iframe width="100%" height="400" class="youtube_wrap" src="https://www.youtube.com/embed/xp6XpRINNbg" frameborder="0" ></iframe>
                        </div>
                        <div id="info">
                            <h3>상세안내</h3>
                            <table>
                                <tbody>
                                    <tr>
                                        <th scope="row">컨셉</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">추천포인트</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">촬영의상</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">촬영시간</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">보유소품</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">유의사항</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">일정변경/취소</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">위약금/환불</th>
                                        <td>-</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <hr> -->
                        <!-- <div id="map">
                            <h3>위치</h3>
                            <address>서울시 마포구 서교동</address>
                            <div id="detail_map" style="width:100%;height:350px;"></div> 
                        </div> -->
                        <hr>
                      	<!-- <div id="review">
      					    <div class="board_top">
                                <h3>후기</h3>
                                <button>후기 작성</button>
                            </div>
                            <div class="detail_input">
                                <label for="review_content">후기를 작성해주세요</label>
                                <textarea name="review_content" id="review_content"></textarea>
                                <label for="review_photo" class="hidden">파일업로드</label>
                                <input type="file" id="review_photo">
                                <input type="button" value="작성완료" id="reviewBtn">
                            </div>
                            
                            <ul class="review_list"> -->
                            <jsp:include page="../review/list.jsp"></jsp:include>
                            <!-- 리뷰출력 -->
                            <!-- </ul>
                            <ul class="page">
                            페이징
                            </ul>
                        </div> -->
                        <hr>
                        <jsp:include page="../qna/list.jsp"></jsp:include>
                   </div>
                </section>
            </div>
            <div class="right">
                <aside class="reservation" style="width: 535px">
                    <div class="tops">
                        <div style="width: 393px">
                            <h3>${vo.title }</h3>
                            <c:if test="${reviewtotal!=0 }">
                            <div style="display: flex;">
                              <c:forEach var="star" begin="1" end="${score }">
                              	<svg class="star" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
    							    <path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" fill="#0b3a1e"/>
   								</svg>
                              </c:forEach>
                              <c:if test="${point==1 }">
                         	     <div class="star-container">
							        <svg class="stars stars-left" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
							            <path d="M10 1.293l2.165 4.59 5.04.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l5.04-.74L10 1.293z"/>
							        </svg>
							        <svg class="stars stars-right" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
							            <path d="M10 1.293l2.165 4.59 5.04.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l5.04-.74L10 1.293z"/>
							        </svg>
							    </div>	
                              </c:if>
                              <c:forEach var="star" begin="${point==1?score+1:score }" end="4">
                              	<svg class="star" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
    							    <path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" fill="#bbbbbb"/>
   								</svg>
                              </c:forEach>
                          	  <p style="font-size: 120%">&nbsp;${reviewtotal}개의 리뷰</p>
                            </div>
                            </c:if>
                            <c:if test="${reviewtotal==0 }">
                              <p style="font-size: 120%">리뷰가 없습니다</p>
                            </c:if>
                        </div>
                        <div class="icons">
                            <button class="wish ${isWish==true?'active':''}">wish list</button>
                            <button class="share">share link</button>
                        </div>
                    </div>
                    <form method="POST" action="">
                        <div class="date">
                          <div style="display: grid;">
                            <c:if test="${vo.discount!='할인없음' }">
                            	<p>${vo.discount }</p>
                            	<p style="text-decoration-line: line-through;">${fPrice}원</p>
                            </c:if>
                            <p>${vo.price }</p>
                            <c:choose>
                              <c:when test="${vo.EA!=0 }">
                            	<p id="ea" data-ea="${vo.EA }">남은 수량:&nbsp;${vo.EA }</p>
                              </c:when>	
                          	  <c:when test="${vo.EA==0 }">
                          	    <p id="ea" data-ea="${vo.EA }">품절</p>
                          	  </c:when>
                          	</c:choose>
                          </div>
                        </div>
                        <div class="time">
                            <label for="time">배송사항</label>
                            <ul class="reserve_time">
                                <li>${vo.delivery }</li>
                            </ul>
                            <input type="number" id="sel" class="collect" value="1" min="1" max="${vo.EA }" style="font-weight: bold;" data-price="${price }">
                        	<span id="total">${vo.price}원</span>
                        </div>  
                      <a href="#" class="buyBtn" style="float: left ;margin-right: 20px">장바구니</a>
                      <a href="#" class="buyBtn" id="buy">바로구매</a>
                    </form>
                </aside>
            </div>
        </div>
    </div>
 <div>
 <input type="hidden" value="${pno }" id="postNo">
 <input type="hidden" value="${cate }" id="rCate">
 </div>
</body>
</html>