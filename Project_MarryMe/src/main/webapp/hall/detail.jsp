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
<link rel="stylesheet" href="../css/detail.css">
<script defer src="../js/main.js"></script>
<script type="text/javascript">
$(function() {
    $('#scrapBtn').on('click', function() {
        let cno = $(this).attr("data-cno");
        
        $.ajax({
            type: 'post',
            url: '../scrap/checklogin.do',
            success: function(loginResult) {
                if (loginResult === 'NO') {  
                    alert("로그인 후 스크랩이 가능합니다!!");
                    window.location.href = "../member/login.do";
                } else {
                    $.ajax({
                        type: 'post',
                        url: '../scrap/insert.do',
                        data: {"cno": cno, "cate": 1},
                        success: function(result) {
                            if (result === 'OK') {
                                alert("스크랩 되었습니다");
                                location.href = "../hall/detail.do?hno=" + cno;
                            } else {
                                alert("스크랩 실패");
                            }
                        },
                        error: function(request, status, error) {
                            console.log(error);
                        }
                    });
                }
            }
        });
    });

    $(document).ready(function() {
        var check = '${check}'; // JSP에서 전달된 값
        // check 값을 Boolean으로 변환
        if (check === 'true') {
            check = true;
        } else if (check === 'false') {
            check = false;
        }

        // 체크 값을 사용하여 버튼 상태 설정
        if (check) {
            $('#scrapBtn').addClass('active');
        } else {
            $('#scrapBtn').removeClass('active');
        }
    });
});
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
                            <button class="wish" id="scrapBtn" data-cno="${vo.hno }">wish list</button>
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