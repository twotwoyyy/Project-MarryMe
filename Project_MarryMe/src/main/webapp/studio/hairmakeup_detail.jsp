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
	let mno=${hm_vo.mno};
	
	//이미 예약된 날짜, 시간 비활성화 
	$.ajax({
		type:'POST',
		url:'../reserve/reserve_exist.do',
		data:{"pno":mno, "cate":5}, //각자 no, 카테고리 번호로
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
				data:{"cno":mno, "cate":5},
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
				data:{"pno":mno, "rdate":date_print, "rtime":time_print, "cate":5}, //각자 no, 카테고리 번호로
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
            <h2>${hm_vo.name}</h2>
            <p>${hm_vo.info}</p>
        </div>
        <div class="detail_wrap">
            <div class="left">
                <section class="thumbnail">
                    <div class="img_wrap">
                        <img src="${hm_vo.thumb}" alt="">
                    </div>
                </section>
                <section class="bottom_wrap">
                    <ul class="detail_tab">
                        <li><a href="#brand" class="active">브랜드정보</a></li>
                        <li><a href="#image">이미지</a></li>
                        <c:if test="${hm_vo.video!=null}">
                        	<li><a href="#video">영상</a></li>
                        </c:if>
                        <li><a href="#info">상세안내</a></li>
                        <li><a href="#map">위치</a></li>
                        <li><a href="#review">후기()</a></li>
                        <li><a href="#qna">문의()</a></li>
                    </ul>
                    <div class="bottom_content">
                        <div id="brand">
                            <h3>브랜드 정보</h3>
                            <table>
                                <tbody>
                                    <tr>
                                        <th scope="row">브랜드</th>
                                        <td>${hm_vo.name}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">전화번호</th>
                                        <td>${hm_vo.tel}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">스타일</th>
                                        <td>${hm_vo.keyword}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">영업/휴무일</th>
                                        <td>${hm_vo.openday}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">영업시간</th>
                                        <td>${hm_vo.opentime}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <hr>
                        <div id="image">
                            <h3>이미지</h3>
                            <div class="masonry_wrap">
                            	<c:forEach var="i" begin="0" end="${hm_image_list.size()-1}">
	                                <div class="img_wrap">
	                                    <img src="${hm_image_list[i].image}" alt="${hm_vo.name} 이미지"> 
	                                </div>
                             	</c:forEach>
                            </div>
                        </div>
                        <hr>
                        <c:if test="${hm_vo.video!=null}">
	                        <div id="video">
	                            <h3>영상</h3>
	                            <iframe width="100%" height="400" class="youtube_wrap" src="${hm_vo.video}" frameborder="0" ></iframe>
	                        </div>
                        </c:if>
                        <div id="info">
                            <h3>상세안내</h3>
                            <table>
                                <tbody>
                                    <tr>
                                        <th scope="row">컨셉</th>
                                        <td>${hm_vo.concept}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">추천포인트</th>
                                        <td>${hm_vo.point}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">유의사항</th>
                                        <td>${hm_vo.notice}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">일정변경/취소</th>
                                        <td>${hm_vo.cancel}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">위약금/환불</th>
                                        <td>${hm_vo.refund}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <hr>
                        <div id="map">
                            <h3>위치</h3>
                            <address>${hm_vo.address}</address>
                            <div id="detail_map" style="width:100%;height:350px;"></div> 
                        </div>
                        <hr>
                        <jsp:include page="../review/list.jsp"></jsp:include>
                       	<input type="hidden" value="${hm_vo.mno}" id="postNo">
 					 	<input type="hidden" value="5" id="rCate">
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
                                <li><button class="time_btn">09:00</button></li>
                                <li><button class="time_btn">10:00</button></li>
                                <li><button class="time_btn">11:00</button></li>
                                <li><button class="time_btn">12:00</button></li>
                                <li><button class="time_btn">13:00</button></li>
                                <li><button class="time_btn">14:00</button></li>
                                <li><button class="time_btn">15:00</button></li>
                                <li><button class="time_btn">16:00</button></li>
                                <li><button class="time_btn">17:00</button></li>
                                <li><button class="time_btn">18:00</button></li>
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