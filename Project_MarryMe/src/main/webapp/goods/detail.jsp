<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
#curpage{
	background-color: #303A1F;
	color: #dcdcdc
}
.pageinfo:hover{
	
	cursor: pointer;
	background-color: #303A1F;
	color: #dcdcdc
}
.pageinfo{
	margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
	display:block;
    width:24px;
    height:24px;
    line-height:24px;
    text-align:center;
    transition:.3s;
}
</style>
<script defer src="../js/main.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
	<div id="detail" class="studio">
        <div class="tt_box">
            <h2>업체명</h2>
            <p>업체 소개글</p>
        </div>
        <div class="detail_wrap">
            <div class="left">
                <section class="thumbnail">
                    <div class="img_wrap">
                        <img src="../img/studio_demo.jpg" alt="">
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
                                    <tr>
                                        <th scope="row">브랜드</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">전화번호</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">스타일</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">영업/휴무일</th>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">영업시간</th>
                                        <td>-</td>
                                    </tr>
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
                                <li><a href="#">10</a></li>
                                <li><a href="#">12</a></li>
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
                            <button class="wish">wish list</button>
                            <button class="share">share link</button>
                        </div>
                    </div>
                    <form method="POST" action="">
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
                        <input type="submit" value="예약">
                    </form>
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
    geocoder.addressSearch('서울특별시 마포구 월드컵북로 21', function(result, status) {
    
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
                content: '<div style="width:150px;text-align:center;padding:6px 0;">업체명</div>'
            });
            infowindow.open(map, marker);
    
            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
        } 
    });    
    </script>
 <div>
 <input type="hidden" value="${pno }" id="postNo">
 <input type="hidden" value="${cate }" id="rCate">
 </div>
</body>
</html>