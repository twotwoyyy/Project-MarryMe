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
                        <jsp:include page="../qna/list.jsp"></jsp:include>
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
 <div>
 <input type="hidden" value="${pno }" id="postNo">
 <input type="hidden" value="${cate }" id="rCate">
 </div>
</body>
</html>