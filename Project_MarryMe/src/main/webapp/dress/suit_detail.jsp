<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<script src="https://unpkg.com/imagesloaded@5/imagesloaded.pkgd.min.js"></script>
<link rel="stylesheet" href="../css/detail.css">
<script defer src="../js/main.js"></script>
<script type="text/javascript">
$(function(){
	let su_no=${su_vo.su_no};
	
	//이미 예약된 날짜, 시간 비활성화 
	$.ajax({
		type:'POST',
		url:'../reserve/reserve_exist.do',
		data:{"pno":su_no, "cate":3}, //각자 no, 카테고리 번호로
		success:function(json){
			let reserve_list=JSON.parse(json);
			time_btn_impossible(reserve_list);
			$(document).on("click", '.ui-datepicker-next', function(){
				time_btn_impossible(reserve_list);
			})
			$(document).on("click", '.ui-datepicker-prev', function(){
				time_btn_impossible(reserve_list);
			})
		},
		error:function(request, status, error){
			console.log(error)
		}
	})
	function time_btn_impossible(reserve_list){
		$('.ui-datepicker-calendar td[data-handler="selectDay"]').click(function(){
			let time_btn=$('.reserve_time .time_btn');
			let oneday_count=0;
			time_btn.removeClass("impossible");
			for(i=0;i<reserve_list.length;i++){
				if($('.date_print').text()===reserve_list[i].rdate){
					time_btn.each(function(){
					if($(this).text()===reserve_list[i].rtime){
							$(this).addClass("impossible");
							$('.time_print').text("") 
						}
					})
					oneday_count++;
					if(oneday_count===time_btn.length){
						$(this).addClass('ui-datepicker-unselectable');
						$(this).addClass('ui-state-disabled');
						$('.date_print').text("해당 일자는 예약이 마감되었습니다");
					}
				}
			}
		})
	}
	//위시리스트 
	$('.wish').click(function(){
		if(${sessionScope.id==null}){
			alert('로그인 후 이용해주세요')
			location.href="../member/login.do";
		}else{
			$.ajax({
				type:'POST',
				url:'../wish/control.do',
				data:{"cno":su_no, "cate":3},
				success:function(result){
					if(result==="OK"){
						$('.wish').addClass('active');
					}else{
						$('.wish').removeClass('active');
					}
				},
				error:function(request, status, error){
					console.log(error)
				}
			})			
		}
	})
	
	//공유 버튼  	
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
	
	//예약 버튼 
	$('.reserve_form .reserve_btn').click(function(){
		if(${sessionScope.id==null}){
			alert('로그인 후 이용해주세요')
			location.href="../member/login.do";
		}else{
			let	date_print=$('.date_print').text(),
				time_print=$('.time_print').text();
			if(date_print==""){
				alert("상담 날짜를 선택해주세요");
				return;
			}
			if(time_print==""){
				alert("상담 시간을 선택해주세요");
				return;
			}
			$.ajax({
				type:'POST',
				url:'../reserve/reserve.do',
				data:{"pno":su_no, "rdate":date_print, "rtime":time_print, "cate":3}, //각자 no, 카테고리 번호로
				success:function(result){
					if(result=="OK"){
						alert("예약요청 되었습니다\n마이페이지 예약내역에서 확인 가능합니다");
					}else{
						alert("이미 요청된 예약입니다");
					}
				},
				error:function(request, status, error){
					console.log(error)
				}
			})
		}
	})
})
</script>
</head>
<body>
	<div id="detail" class="studio">
        <div class="tt_box">
            <h2>제이진 슈트</h2>
            <p>주인공의 자신감을 예복에 담다</p>
        </div>
        <div class="detail_wrap">
            <div class="left">
                <section class="thumbnail">
                    <div class="img_wrap">
                        <img src="${su_vo.su_image}" alt="">
                    </div>
                </section>
                <section class="bottom_wrap">
                    <ul class="detail_tab">
                        <li><a href="#brand" class="active">상세 이미지</a></li>
                        <li><a href="#image">교환 반품 안내</a></li>
                        <li><a href="#info">매장 운영 정보</a></li>
                        <li><a href="#map">위치</a></li>
                        <li><a href="#review">후기()</a></li>
                        <li><a href="#qna">문의()</a></li>
                    </ul>
                    
                    <div class="bottom_content">
<!--                         <div id="image"> -->
<!--                             <h3>상세 이미지</h3> -->
<!--                             <table> -->
<!--                                 <tbody> -->
<!--                                     <tr> -->
<!--                                         <th scope="row"></th> -->
<!--                                         <td> -->
<%--                                         	<c:out value="${'https:' + su_vo.su_detail_image}" />		 --%>
<!--                                        	</td> -->
<!--                                     </tr> -->
<!--                                 </tbody> -->
<!--                             </table> -->
<!--                         </div> -->
                        <hr>
                        
                        <div id="image">
                            <h3>상세 이미지</h3>
                            <div class="masonry_wrap">
<%--                             	<c:forEach var="i" begin="0" end="${hm_image_list.size()-1}"> --%>
	                                <div class="img_wrap">
	                                    <img src="${suit_vo.su_detail_image}" alt="${suit_vo.su_subject} 이미지">
	                                    <img src="${suit_vo.su_detail_image2}" alt="${suit_vo.su_subject} 이미지">
	                                    <img src="${suit_vo.su_detail_image3}" alt="${suit_vo.su_subject} 이미지">
	                                    <img src="${suit_vo.su_detail_image4}" alt="${suit_vo.su_subject} 이미지">
	                                    <img src="${suit_vo.su_detail_image5}" alt="${suit_vo.su_subject} 이미지">
	                                </div>
<%--                              	</c:forEach> --%>
                            </div>
                        </div>
<!--                         <hr> -->
<%--                         <c:if test="${hm_vo.video!=null}"> --%>
<!-- 	                        <div id="video"> -->
<!-- 	                            <h3>영상</h3> -->
<%-- 	                            <iframe width="100%" height="400" class="youtube_wrap" src="${hm_vo.video}" frameborder="0" ></iframe> --%>
<!-- 	                        </div> -->
<%--                         </c:if> --%>
                        <div id="info">
                            <h3>상세안내</h3>
                            <table>
                                <tbody>
                                    <tr>
                                        <th scope="row">교환 / 반품 안내</th>
                                        <td>
									    본 제품은 1:1 주문제작(선주문 후 제작) 상품으로 <br>
									    주문 취소 및 환불, 교환이 불가능하니 신중한 구매 부탁드립니다.<br>
						                <br>
						                고객센터와 제품 확인 후 제품 불량으로 판명되어 교환이 불가피할 경우<br>
						                같은 상품으로 재제작해 드립니다.<br>
						                <br>
						                
						               	빠른 해결을 위해 상품 하자 발견 즉시 고객센터로 연락 부탁드립니다.<br>
						               	<br>
						               	
						                
						                사전 협의 없이 상품을 보내시는 경우에는 수취 거부되오니<br>
						                반드시 게시판 접수 및 고객센터 연락 후 보내주시기 바랍니다.<br>
						                <br>
						                
						                상품을 공급 받으신 날로부터 7일 이내 접수해 주셔야 합니다.<br>
						                <br>
						                
						                당사 택배를 이용하여 주셔야 하며<br>
						                타 택배 이용 시 선불로 지불하신 후 보내주셔야 합니다.

						                상품은 출고 후 어떠한 경우에도 취소/교환/환불이 불가합니다.<br>
						                <br>
						                소모품은 분실 시 유상 구입을 원칙으로 합니다.<br>
						                <br>
						                <br>
						                
						                <h4>화이트 원단 및 기타 주의 사항</h4>
						                <br><br>
						                
										화이트 원단 특성상(더블 구입, 단순 변심) 교환, 반품, 환불이 불가하니<br>
										신중한 선택과 충분한 상담 후 구입해 주세요.<br>
										<br>
										
										냄새(향수), 구김이 심한 경우, 기타 오염, 판매 상품으로<br>
										가치가 상실된 경우 교환 및 반품이 불가합니다.<br>
										<br>
										
										인수 후에는 제품 하자나 오배송의 경우를 제외한 <br>
										고객님의 단순 변심에 의한 교환, 반품이 불가능할 수 있습니다.<br>
										<br>
										보낸 상태(포장, 택) 유지되어 있어야 교환 및 반품이 가능합니다.

						            </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">주문 취소 안내</th>
                                        <td>
개인적인 견해는 불량 사유가 아닙니다.<br>
(예: 원단이 뻣뻣하다 / 덜 반짝인다 등)<br>
<br>
상품 택 불량 / 배송 중 상품의 구김, 펄 비즈 떨어짐 / 제작 중 발생한 실밥, 올풀림 <br>
세탁 후 지워지는 가벼운 얼룩, 초크 자국 / 경미한 바느질 미흡 등은<br>
불량의 사유가 아닙니다.<br>
<br>
측정 위치나 원단, 디자인에 따라 약간의 오차는 발생될 수 있습니다.<br>
이는 불량의 사유가 아닙니다.<br>
<br>
화이트와 같은 밝은 색상의 상품은 원단 생산 과정에서 발생되는<br>
미세한 이염이나 잡사가 있을 수 있습니다.<br>
<br>
이용 전 주의 사항 및 약관 사항을 읽지 않아 생기는 불이익에 대해서는<br>
본사의 책임이 없음을 알려드립니다.<br>
<br>

한 달 전 취소 - 100% 환불<br>
<br>
3주 전 취소 - 80% 환불<br>
<br>
2주 전 취소 - 50% 환불<br>
<br>
1주 전 취소 - 20% 환불<br>
<br>
6일 이내 환불 불가

									</td>
                                    </tr>
<!--                                     <tr> -->
<!--                                         <th scope="row">매장 운영 정보</th> -->
<%--                                         <td>${hm_vo.notice}</td> --%>
<!--                                     </tr> -->
                                    <tr>
                                        <th scope="row">영업 시간</th>
                                        <td> 
<%--                                         ${suit_vo.su_hour } --%>
	월~금 10:00~18:00<br>
						            </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">영업 / 휴무일</th>
                                        <td>
<%--                                         ${suit_vo.su_dayoff} --%>
	토요일, 일요일, 공휴일 휴무<br>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        
                        <hr>
                        <div id="map">
                            <h3>위치</h3>
                            <address>${su_vo.su_address}</address>
                            <div id="detail_map" style="width:100%;height:350px;"></div> 
                        </div>
                        <hr>
                        <div id="review">
                            <div class="board_top">
                                <h3>후기</h3>
                                <button>후기 작성</button>
                            </div>
                            <div class="detail_input">
                                <label for="review_content">후기를 작성해주세요</label>
                                <textarea name="review_content" id="review_content"></textarea>
                                <label for="review_photo" class="hidden">파일업로드</label>
                                <input type="file" id="review_photo">
                                <input type="button" value="작성완료">
                            </div>
                            <ul class="review_list">
                                <li>
                                    <div class="top">
                                        <div class="profile">
                                            <img src="../img/profile_img.png" alt="">
                                            <p class="name">작성자이름</p>
                                        </div>
                                        <p>2024-00-00</p>
                                    </div>
                                    <div class="content">
                                        <div class="star">
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star active">
                                                <defs>
                                                    <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                                </defs>
                                                <use xlink:href="#star-full"></use>
                                            </svg>
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star active">
                                                <defs>
                                                    <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                                </defs>
                                                <use xlink:href="#star-full"></use>
                                            </svg>
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star active">
                                                <defs>
                                                    <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                                </defs>
                                                <use xlink:href="#star-full"></use>
                                            </svg>
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star active">
                                                <defs>
                                                    <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                                </defs>
                                                <use xlink:href="#star-full"></use>
                                            </svg>
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star active">
                                                <defs>
                                                    <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                                </defs>
                                                <use xlink:href="#star-full"></use>
                                            </svg>
                                        </div>
                                        <div class="content_text">
                                            <pre>상세 너무 길어ㅠㅠ 잠와죽겠넴 아앙아아아아ㅏ아아
요고 너무 제 위주로 만들었는데 각자 상세에 맞게 수정해서 사용하시고 어려운 부분있으시면 언제든지 괜찮으니까 같이해결해봐욤
저 이제 문의 만들러 갈게요 😩
                                            </pre>
                                        </div>
                                        <div class="img_box">
                                            <img src="../img/banner_02.jpg" alt="">
                                            <img src="../img/dress_demo.jpg" alt="">
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="top">
                                        <div class="profile">
                                            <img src="../img/profile_img.png" alt="">
                                            <p class="name">작성자이름</p>
                                        </div>
                                        <p>2024-00-00</p>
                                    </div>
                                    <div class="content">
                                        <div class="star">
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star active">
                                                <defs>
                                                    <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                                </defs>
                                                <use xlink:href="#star-full"></use>
                                            </svg>
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star active">
                                                <defs>
                                                    <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                                </defs>
                                                <use xlink:href="#star-full"></use>
                                            </svg>
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star active">
                                                <defs>
                                                    <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                                </defs>
                                                <use xlink:href="#star-full"></use>
                                            </svg>
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star active">
                                                <defs>
                                                    <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                                </defs>
                                                <use xlink:href="#star-full"></use>
                                            </svg>
                                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star ">
                                                <defs>
                                                    <path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>
                                                </defs>
                                                <use xlink:href="#star-full"></use>
                                            </svg>
                                        </div>
                                        <div class="content_text">
                                            <pre>그래도 두개는 만들어야 리스트 모양이 나오겠지..
                                            </pre>
                                        </div>
                                        <div class="img_box">
                                            <img src="../img/hanbok_demo.jpg" alt="">
                                            <img src="../img/bouquet_demo.jpg" alt="">
                                            <img src="../img/banner_01.jpg" alt="">
                                            <img src="../img/hanbok_demo.jpg" alt="">
                                            <img src="../img/bouquet_demo.jpg" alt="">
                                            <img src="../img/banner_01.jpg" alt="">
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <ul class="page">
                                <li><a href="">&lt;</a></li>
                                <li class="active"><a href="#">1</a></li>
                                <li><a href="#">2</a></li>
                                <li><a href="#">3</a></li>
                                <li><a href="#">4</a></li>
                                <li><a href="#">5</a></li>
                                <li><a href="#">&gt;</a></li>
                            </ul>
                        </div>
                        <hr>
                        <div id="qna">
                            <div class="board_top">
                                <h3>문의</h3>
                                <button>문의 작성</button>
                            </div>
                            <div class="detail_input">
                                <label for="qna_content">문의를 작성해주세요</label>
                                <textarea name="qna_content" id="qna_content"></textarea>
                                <div>
                                    <div class="qna_pwbox">
                                        <label for="qna_pw">비밀번호</label>
                                        <input type="password" id="qna_pw">
                                    </div>
                                    <input type="button" value="작성완료">
                                </div>
                            </div>
                            <ul class="qna_list">
                                <li>
                                    <div class="close">
                                        <p class="number">2</p>
                                        <div class="subject">
                                            <img src="../img/qna_lock.gif" alt="">
                                            <p>내일하고 싶은데 미뤄도 되나요</p>
                                        </div>
                                        <p class="writer">잠만보</p>
                                        <p class="regdate">2024-00-00<br>00:00:00</p>
                                    </div>
                                    <div class="write_pw">
                                        <form method="POST" action="">
                                            <label for="review_pw2">비밀번호</label>
                                            <input type="password" id="review_pw2" name="review_pw" class="review_pw_input">
                                            <button>확인</button>
                                        </form>
                                    </div>
                                    <div class="open">
                                        <pre>요기는 비밀번호 관문을 통과한 자에게만 허용된 구역입니당
아코디언으로 만들까하는데 아몰라 그거 기능이랑 예약폼 픽스랑 작성페이지는 내일할래 수요일까지 다해서 쉬는날 작업할 사람 작업하게 해주고 싶었는데</pre>
                                    </div>
                                </li>
                                <li>
                                    <div class="close">
                                        <p class="number">1</p>
                                        <div class="subject">
                                            <span class="reply">RE</span>
                                            <img src="../img/qna_lock.gif" alt="">
                                            <p>내일하고 싶은데 미뤄도 되나요</p>
                                        </div>
                                        <p class="writer">관리자</p>
                                        <p class="regdate">2024-00-00<br>00:00:00</p>
                                    </div>
                                    <div class="write_pw">
                                        <form method="POST" action="">
                                            <label for="review_pw1">비밀번호</label>
                                            <input type="password" id="review_pw1" name="review_pw" class="review_pw_input">
                                            <button>확인</button>
                                        </form>
                                    </div>
                                    <div class="open">
                                        <pre>여기는 답변 나오게</pre>
                                    </div>
                                </li>
                            </ul>
                            <ul class="page">
                                <li><a href="">&lt;</a></li>
                                <li class="active"><a href="#">1</a></li>
                                <li><a href="#">2</a></li>
                                <li><a href="#">3</a></li>
                                <li><a href="#">4</a></li>
                                <li><a href="#">5</a></li>
                                <li><a href="#">&gt;</a></li>
                            </ul>
                        </div>
                    </div>
                </section>
            </div>
            <div class="right">
                <aside class="reservation">
                    <div class="top">
                        <div>
                            <h3>예약</h3>
                            <p>원하는 상담 예약 날짜를 선택해주세요</p>
                        </div>
                        <div class="icons">
                            <button class="wish ${isWish==true?'active':''}">wish list</button>
                            <button class="share">share link</button>
                        </div>
                    </div>
                    <div class="reserve_form">
                        <div class="date">
                            <label for="calendar">예약 날짜</label>
                            <input type="text" name="reserve_date" id="calendar">
                        </div>
                        <div class="time">
                            <label for="time">예약 시간</label>
                            <ul class="reserve_time">
                                <li><button class="time_btn">10:00</button></li>
                                <li><button class="time_btn">11:00</button></li>
                                <li><button class="time_btn">12:00</button></li>
                                <li><button class="time_btn">13:00</button></li>
                                <li><button class="time_btn">14:00</button></li>
                                <li><button class="time_btn">15:00</button></li>
                                <li><button class="time_btn">16:00</button></li>
                                <li><button class="time_btn">17:00</button></li>
                            </ul>
                        </div>
                        <div class="total">
                            <p class="label">희망 상담 예약 일시</p>
                            <span class="date_print"></span>
                            <span class="time_print"></span>
                        </div>
                    	<input type="submit" value="예약" class="reserve_btn">
                    </div>
                </aside>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dee4629f5156da2c49e694161e31a96a&libraries=services"></script>
    <script defer src="../js/main.js"></script>
    <script>
    var mapContainer = document.getElementById('detail_map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };  
    
    // 지도를 생성합니다    
    var map = new kakao.maps.Map(mapContainer, mapOption); 
    
    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();
    
    // 주소로 좌표를 검색합니다
    geocoder.addressSearch('${studio_vo.address}', function(result, status) {
    
        // 정상적으로 검색이 완료됐으면 
         if (status === kakao.maps.services.Status.OK) {
    
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
    
            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });
    
            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0;">${studio_vo.name}</div>'
            });
            infowindow.open(map, marker);
    
            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
        } 
    });    
    </script>
</body>
</html>