<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Reservation List</title>
    <link rel="stylesheet" type="text/css" href="../css/mypage.css">
    <style type="text/css">
        body {
            font-family: 'SCoreDream', sans-serif;
            margin: 0;
            padding: 0;
        }
        .myreserve {
            margin: 0 auto;
            padding: 20px;
            width: 100%; /* 전체 너비 사용 */
            max-width: 1200px; /* 최대 너비 설정 */
        }
        .section {
            margin-bottom: 40px;
        }
        .section-label {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            border-bottom: 2px solid #DDDDDD;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        .reserveBtn {
            width: 30px;
            height: 30px;
            margin-right: 10px;
            vertical-align: middle;
        }
        .empty {
            text-align: center;
            font-size: 1.2em;
            padding: 20px;
        }
        .reservedetail {
            display: block;
        }
        
        .titbox {
            margin-bottom: 20px;
        }
        .reservedetail > div {
            display: flex;
            margin-bottom: 20px;
            border: 1px solid #e7e7e7;
            border-radius: 5px;
            padding: 10px;
            width: 100%;
            max-width: 1200px;
            overflow: hidden;
            box-sizing: border-box;
        }
        .reserveimage img {
            width: 100px;
            height: auto;
            display: block;
        }
        .reservename {
            font-size: 20px;
            line-height: 1.4;
            margin-left: 15px;
            flex: 1;
        }
        .reservename img {
            width: 23px;
            height: 25px;
            display: inline-block;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
            margin-left: 20px;
        }
        .action-buttons button {
            width: 100px;
            height: 50px;
            border: 1px solid #e7e7e7;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            line-height: 50px;
            font-size: 16px;
            background-color: #f4f4f4;
        }
        .action-buttons button:hover {
            background-color: #8FBC8B;
            color: white;
        }
        .action-buttons .cancel:hover {
            background-color: #DC143C;
            color: white;
        }
        .sixth {
            margin-top: 20px;
            margin-bottom: 20px;
        }
        #count {
            color: #DC143C;
            font-size: 20px;
            font-weight: bold;
        }
        .stline {
            display: flex;
        }
        .ws_info {
            flex: 1;
        }
        .tel {
            margin-left: 60px;
        }
        .date-info {
            font-size: 14px;
            color: #666;
            margin-top: 10px;
        }
    </style>
    <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
    <script type="text/javascript">
        $(function() {
            $('.cancel').click(function() {
                alert('예약이 취소되었습니다');
                let resno = $(this).attr('data-href');
                location.href = "../mypage/mypage_reserve_cancel.do?resno=" + resno;
            });
            $('.view-details').click(function() {
                alert('상세보기로 이동합니다');
                window.location.href = $(this).data('href');
            });
        });
    </script>
</head>
<body>
    <div class="myreserve">
        <div class="sixth"> 
            <h1>🕦예약 내역🕦</h1>
        </div>
        <div class="tab_contents_area">
            <p class="titbox" style="font-size: 20px; text-align: center;">총 <span id="count">${totalRes}</span>개의 중요한 예약 일정이 있습니다</p>
        </div>
        <!-- 웨딩홀 예약 리스트 -->
        <div class="section">
            <div class="section-label">웨딩홀 예약 리스트</div>
            <p class="titbox">웨딩홀 예약 리스트는 총 <span id="count" style="color: #228B22;">${hCount}</span>개입니다.</p>
            <c:choose>
                <c:when test="${empty hallrList}">
                    <div class="empty">나의 예약 목록이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <div class="reservedetail">
                        <c:forEach var="vo" items="${hallrList}">
                            <div>
                                <a class="reserveimage" href="../hall/detail.do?hno=${vo.hvo.hno}">
                                    <img src="${vo.hvo.image}" alt="${vo.hvo.name}">
                                </a>
                                <div class="reservename">
                                    <img src="../mypage/jjim.png" class="reserveBtn">
                                    <span>${vo.hvo.name}</span>
                                </div>
                                <div class="tel">
                                    <div class="date-info">예약 날짜: ${vo.rdate}</div>
                                    <div class="date-info">등록 날짜: ${vo.regdate}</div>
                                </div>
                                <div class="action-buttons">
                                    <button class="view-details" data-href="../hall/detail.do?hno=${vo.hvo.hno}">상세보기</button>
                                    <button class="cancel" data-href="${vo.resno}">예약 취소</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 드레스 예약 리스트 -->
        <div class="section">
            <div class="section-label">드레스 예약 리스트</div>
            <p class="titbox">드레스 예약 리스트는 총 <span id="count" style="color: #228B22;">${dCount}</span>개입니다.</p>
            <c:choose>
                <c:when test="${empty dressrList}">
                    <div class="empty">나의 예약 목록이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <div class="reservedetail">
                        <c:forEach var="vo" items="${dressrList}">
                            <div class="stline">
                                <a class="reserveimage" href="../dress/dress_detail.do?d_no=${vo.dvo.d_no}">
                                    <img src="${vo.dvo.d_image}" alt="${vo.dvo.d_subject}">
                                </a>
                                <div class="ws_info">
                                    <div class="reservename">
                                        <img src="../mypage/jjim.png" class="reserveBtn">
                                        <span>${vo.dvo.d_subject}</span>
                                    </div>
                                    <div class="tel">
                                        <div class="date-info">예약 날짜: ${vo.rdate}</div>
                                        <div class="date-info">등록 날짜: ${vo.regdate}</div>
                                    </div>
                                    <div class="date-info">${vo.dvo.d_price}</div>
                                </div>
                                <div class="action-buttons">
                                    <button class="view-details" data-href="../dress/dress_detail.do?d_no=${vo.dvo.d_no}">상세보기</button>
                                    <button class="cancel" data-href="${vo.resno}">예약 취소</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 예복 예약 리스트 -->
        <div class="section">
            <div class="section-label">예복 예약 리스트</div>
            <p class="titbox">예복 예약 리스트는 총 <span id="count" style="color: #228B22;">${suCount}</span>개입니다.</p>
            <c:choose>
                <c:when test="${empty suitrList}">
                    <div class="empty">나의 예약 목록이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <div class="reservedetail">
                        <c:forEach var="vo" items="${suitrList}">
                            <div class="stline">
                                <a class="reserveimage" href="../suit/suit_detail.do?su_no=${vo.suvo.su_no}">
                                    <img src="${vo.suvo.su_image}" alt="${vo.suvo.su_subject}">
                                </a>
                                <div class="ws_info">
                                    <div class="reservename">
                                        <img src="../mypage/jjim.png" class="reserveBtn">
                                        <span>${vo.suvo.su_subject}</span>
                                    </div>
                                    <div class="tel">
                                        <div class="date-info">예약 날짜: ${vo.rdate}</div>
                                        <div class="date-info">등록 날짜: ${vo.regdate}</div>
                                    </div>
                                    <div class="date-info">${vo.suvo.su_price}</div>
                                </div>
                                <div class="action-buttons">
                                    <button class="view-details" data-href="../suit/suit_detail.do?su_no=${vo.suvo.su_no}">상세보기</button>
                                    <button class="cancel" data-href="${vo.resno}">예약 취소</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 스튜디오 예약 리스트 -->
        <div class="section">
            <div class="section-label">스튜디오 예약 리스트</div>
            <p class="titbox">스튜디오 예약 리스트는 총 <span id="count" style="color: #228B22;">${sCount}</span>개입니다.</p>
            <c:choose>
                <c:when test="${empty studiorList}">
                    <div class="empty">나의 예약 목록이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <div class="reservedetail">
                        <c:forEach var="vo" items="${studiorList}">
                            <div class="stline">
                                <a class="reserveimage" href="../studio/studio_detail.do?sno=${vo.svo.sno}">
                                    <img src="${vo.svo.thumb}" alt="${vo.svo.name}">
                                </a>
                                <div class="ws_info">
                                    <div class="reservename">
                                        <img src="../mypage/jjim.png" class="reserveBtn">
                                        <span>${vo.svo.name}</span>
                                    </div>
                                    <div class="tel">
                                    <div class="date-info">☎ ${vo.svo.address}</div>
                                        <div class="date-info" style="color:red">예약일: ${vo.rdate}</div>
                                        <div class="date-info">예약시간: ${vo.rtime }</div>
                                        <div class="date-info">등록일: ${vo.dbday}</div>
                                    </div>
                                </div>
                                <div class="action-buttons">
                                    <button class="view-details" data-href="../studio/studio_detail.do?sno=${vo.svo.sno}">상세보기</button>
                                    <button class="cancel" data-href="${vo.resno}">예약 취소</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 헤어/메이크업 예약 리스트 -->
        <div class="section">
            <div class="section-label">헤어/메이크업 예약 리스트</div>
            <p class="titbox">헤어/메이크업 예약 리스트는 총 <span id="count" style="color: #228B22;">${mCount}</span>개입니다.</p>
            <c:choose>
                <c:when test="${empty hairmakeuprList}">
                    <div class="empty">나의 예약 목록이 없습니다.</div>
                </c:when>
                <c:otherwise>
                    <div class="reservedetail">
                        <c:forEach var="vo" items="${hairmakeuprList}">
                            <div class="stline">
                                <a class="reserveimage" href="../hairmakeup/hairmakeup_detail.do?mno=${vo.mvo.mno}">
                                    <img src="${vo.mvo.thumb}" alt="${vo.mvo.name}">
                                </a>
                                <div class="ws_info">
                                    <div class="reservename">
                                        <img src="../mypage/jjim.png" class="reserveBtn">
                                        <span>${vo.mvo.name}</span>
                                    </div>
                                    <div class="tel">
                                        <div class="date-info">예약 날짜: ${vo.rdate}</div>
                                        <div class="date-info">등록 날짜: ${vo.regdate}</div>
                                    </div>
                                    <div class="date-info">☎ ${vo.mvo.address}</div>
                                </div>
                                <div class="action-buttons">
                                    <button class="view-details" data-href="../hairmakeup/hairmakeup_detail.do?mno=${vo.mvo.mno}">상세보기</button>
                                    <button class="cancel" data-href="${vo.resno}">예약 취소</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
