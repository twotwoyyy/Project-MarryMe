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
	let d_no=${dress_vo.d_no};
	
	//이미 예약된 날짜, 시간 비활성화 
	$.ajax({
		type:'POST',
		url:'../reserve/reserve_exist.do',
		data:{"pno":d_no, "cate":2}, //각자 no, 카테고리 번호로
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
			let time_btn = $('.reserve_time .time_btn');
			let oneday_count = 0;
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
				data:{"cno":d_no, "cate":2}, //각자 no, 카테고리 번호로 
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
	
	// 공유 버튼 (주소 복사)
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
				data:{"pno":d_no, "rdate":date_print, "rtime":time_print, "cate":2}, //각자 no, 카테고리 번호로
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
	<div id="detail" class="dress">
        <div class="tt_box">
            <h2>${dress_vo.d_subject }</h2>
            <p>${dress_vo.d_content }</p>
        </div>
        <div class="detail_wrap">
            <div class="left">
                <section class="thumbnail">
                    <div class="img_wrap">
                        <img src="${dress_vo.d_image}" alt="">
                    </div>
                </section>
                <section class="bottom_wrap">
                    <ul class="detail_tab">
                        <li><a href="#image" class="active">상세 이미지</a></li>
                       	<li><a href="#return_exchange">교환 반품 안내</a></li>
                        <li><a href="#info">매장 운영 정보</a></li>
                        <li><a href="#map">위치</a></li>
                        <li><a href="#review">후기(0)</a></li>
                        <li><a href="#qna">문의(0)</a></li>
                    </ul>
                    <div class="bottom_content">
                        <div id="image">
						    <h3>상세 이미지</h3>
					        <div>
					            <!-- 첫 번째 이미지 -->
					            <div class="img_wrap">
					                <img src="${dress_vo.d_detail_image}" alt="" style="width:100%">
					                <img src="${dress_vo.d_detail_image3}" alt="" style="width:100%">
					            </div>
					            
					            <div class="content_description">
							        <p></p> <!-- d_content를 <p> 태그로 감싸서 내용 출력 -->
							    </div>
					        </div>
						</div>

                        <hr>
                        <div id="return_exchange">
						    <h3>교환 / 반품 안내</h3>
						    <table>
						        <tr>
						            <th scope="row">교환 / 반품</th>
						            <td>
									    본 제품은 1:1 주문제작(선주문 후 제작) 상품으로 <br>
									    단순 주문 취소 및 환불, 교환이 불가능하니 신중한 구매 부탁드립니다.<br>
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
						                
						                당사 택배를 이용하여 주셔야 하며, 타 택배 이용 시 <br>
						                선불로 지불하신 후 보내주셔야 합니다.<br>
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
										고객님의 단순 변심에 의한 교환, 반품이 불가합니다.<br>
										<br>
										보낸 상태(포장, 택) 유지되어 있어야 교환 및 반품이 가능합니다.

						            </td>
						        </tr>
						        <tr>
						        	<th scope="row">주문 취소</th>
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
						    </table>
						</div>

                        <hr>
                        <div id="info">
						    <h3>매장 운영 정보</h3>
						    <table>
						        <tr>
						            <th scope="row">영업시간</th>
						            <td>
	월~금 10:30 ~ 20:00<br>
	토, 공휴일 10:30 ~ 20:00
						            </td>
						        </tr>
						        <tr>
						            <th scope="row">영업/휴무일</th>
						            <td>${dress_vo.d_dayoff}</td>
						        </tr>
						    </table>
						</div>

                        <hr>
                        <div id="map">
                            <h3>위치</h3>
                            <address>${dress_vo.d_address}</address>
                            <div id="detail_map" style="width:100%;height:350px;"></div> 
                        </div>
                        <hr>
                       	<jsp:include page="../review/list.jsp"></jsp:include>
                       	<input type="hidden" value="${dress_vo.d_no}" id="postNo">
 					 	<input type="hidden" value="2" id="rCate">
                        <hr>
                        <jsp:include page="../qna/list.jsp"></jsp:include>
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
                                <li><button class="time_btn">11:00</button></li>
                                <li><button class="time_btn">12:00</button></li>
                                <li><button class="time_btn">13:00</button></li>
                                <li><button class="time_btn">14:00</button></li>
                                <li><button class="time_btn">15:00</button></li>
                                <li><button class="time_btn">16:00</button></li>
                                <li><button class="time_btn">17:00</button></li>
                                <li><button class="time_btn">18:00</button></li>
                                <li><button class="time_btn">19:00</button></li>
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
    geocoder.addressSearch('${dress_vo.d_address}', function(result, status) {
    
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
                content: '<div style="width:150px;text-align:center;padding:6px 0;">라비토로사 (Labitorosa)</div>'
            });
            infowindow.open(map, marker);
    
            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
        } 
    });    
    </script>
</body>
</html>