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
	let hno=${vo.hno};
	$.ajax({
		type:'POST',
		url:'../reserve/reserve_exist.do',
		data:{"pno":hno, "cate":1}, 
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
	$('.wish').click(function(){
		if(${sessionScope.id==null}){
			alert('로그인 후 이용해주세요')
			location.href="../member/login.do";
		}else{
			let hno=${vo.hno};
			$.ajax({
				type:'POST',
				url:'../wish/control.do',
				data:{"cno":hno, "cate":1},
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
				data:{"pno":hno, "rdate":date_print, "rtime":time_print, "cate":1}, 
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
<style type="text/css">
#hallimg{
	width: 90%;
	height: 100%;
}

#map p {
        margin-top: 20px; /* 원하는 만큼의 여백을 설정합니다. */
}
.mapinfo::before {
        content: "지하철 🚇 ";
        color: #0b3a1e; /* 원하는 색상으로 설정 */
}

</style>
</head>
<body>
	<div id="detail" class="studio">
        <div class="tt_box">
            <h2>${vo.name }</h2>
            <p>${vo.homepage }</p>
        </div>
        <div class="detail_wrap">
            <div class="left">
                <section class="thumbnail">
                    <div class="img_wrap">
                        <img src="${vo.image }" alt="" id="hallimg">
                    </div>
                </section>
                <section class="bottom_wrap">
                    <ul class="detail_tab">
                        <li><a href="#brand" class="active">브랜드정보</a></li>
                        <li><a href="#map">위치</a></li>
                        <li><a href="#review">후기()</a></li>
                        <li><a href="#qna">문의()</a></li>
                    </ul>
                    <div class="bottom_content">
                        <div id="brand">
                            <h3>${vo.name }홀 정보</h3>
                            <table>
                                <tbody>
                                    <tr>
                                        <th scope="row">업체명</th>
                                        <td>✅${vo.name }</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">형태</th>
                                        <td>🏢${vo.type }</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">메뉴</th>
                                        <td>🍽️${vo.menu }</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">식대</th>
                                        <td>💰${vo.mealcost }</td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <th scope="row">위치</th>
                                        <td>📌${vo.addr }</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">특징</th>
                                        <td>✔️${vo.point }</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">홈페이지</th>
                                        <td>🌏${vo.homepage }</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <hr>
                        <div id="map">
                            <h3>위치</h3>
                            <address>${vo.addr }</address>
                            <div id="detail_map" style="width:100%;height:350px;"></div>
                            <p class="mapinfo">${vo.map }</p> 
                        </div>
                        <hr>
                       	<jsp:include page="../review/list.jsp"></jsp:include>
                       	<input type="hidden" value="${vo.hno}" id="postNo">
 					 	<input type="hidden" value="1" id="rCate">
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
    geocoder.addressSearch('${vo.addr}', function(result, status) {
    
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
                content: '<div style="width:150px;text-align:center;padding:6px 0;">${vo.name}</div>'
            });
            infowindow.open(map, marker);
    
            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
        } 
    });    
    </script>
</body>
</html>