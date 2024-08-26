<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Wishlist</title>
    <link rel="stylesheet" type="text/css" href="../css/mypage.css">
    <style type="text/css">
        body {
            font-family: 'SCoreDream', sans-serif;
            margin: 0;
            padding: 0;
        }
        .myWish {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .titbox {
            margin-bottom: 20px;
           
        }
        .tab_area {
            display: flex;
            margin: 20px 0;
        }
        .tab_box button {
            flex: 1;
            width: 150px;
            height: 60px;
            border: 1px solid #e7e7e7;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            line-height: 60px;
            font-size: 16px;
            background-color: #f4f4f4;
        }
        .tab_box button:hover{
        background-color: #8FBC8B;
        }
        .tab_box button.on {
            background-color: #8FBC8B;
            color: white;
        }
        .tab_contents {
            display: none;
        }
        .tab_contents.active {
            display: block;
        }
        .wishBtn {
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
.wishdetail {
    display: block;
    margin-bottom: 20px; /* 항목 간의 간격 조정 */
}

.wishdetail > div {
    display: flex;
    align-items: center; /* 수직 정렬 */
    margin-bottom: 20px;
    border: 1px solid #e7e7e7;
    border-radius: 5px;
    padding: 10px;
    width: 100%;
    max-width: 930px;
    overflow: hidden;
    box-sizing: border-box;
}

.wishimage img {
    width: 200px; /* 이미지 크기 조정 */
    height: auto;
    display: block;
}

.wishname {
    font-size: 20px;
    line-height: 1.4;
    margin-left: 15px; /* 이미지와 제목 사이의 간격 조정 */
    flex: 1; /* 남은 공간을 차지하도록 설정 */
}

.wishname img {
    width: 23px;
    height: 25px;
    display: inline-block;
}

.action-buttons {
    display: flex;
    gap: 10px; /* 버튼 사이의 간격 조정 */
    margin-left: 20px; /* 제목과 버튼 사이의 간격 조정 */
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
        .sixth {
            margin-top: 20px;
            margin-bottom: 20px;
        }
#count{
	color: #DC143C;
	font-size: 20px;
	font-weight: bold;
}

.stline{
	display: flex;
}

.ws_info{
	flex: 1;
}
.tel{
	margin-left: 60px;
}
    </style>
    <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
    <script type="text/javascript">
        $(function() {
            // 탭 클릭 이벤트 핸들러
            $('.tab_box button').click(function() {
                var index = $(this).index();
                
                // 모든 탭 내용 숨기기
                $('.tab_contents').removeClass('active');

                // 모든 탭 비활성화
                $('.tab_box button').removeClass('on');

                // 선택한 탭의 내용만 표시하고 해당 탭 활성화
                $('.tab_contents').eq(index).addClass('active');
                $(this).addClass('on');
            });

            // 취소 버튼 클릭 이벤트 핸들러
            $('.cancel').click(function() {
            	alert('위시가 삭제되었습니다')
            	let wno=$(this).attr('data-href')
                location.href="../mypage/mypage_wish_cancel.do?wno="+wno
            });
            $('.view-details').click(function() {
            	alert('상세보기로 이동합니다')
            	window.location.href = $(this).data('href');
            });
        });
    </script>
</head>
<body>
    <div class="myWish">
        <div class="sixth"> 
            <h1>나의 위시리스트</h1>
        </div>
        <div class="tab_contents_area">
            <p class="titbox" style="font-size: 20px; text-align: center;">총 <span id="count">${totalWish}</span>개의 위시리스트가 있습니다</p>
        </div>
        <div class="tab_area">
            <div class="tab_box">
                <button class="on"><span>웨딩홀</span></button>
                <button><span>드레스</span></button>
                <button><span>예복</span></button>
                <button><span>스튜디오</span></button>
                <button><span>헤어/메이크업</span></button>
                <button><span>혼수</span></button>
            </div>
        </div>

        <!-- 탭 내용 섹션 -->
        <div id="table1" class="tab_contents active">
            <div class="tab_contents_area">
                <p class="titbox">웨딩홀 위시 리스트는 총 <span id="count" style="color: #228B22;">${hCount}</span>개입니다.</p>
            </div>
            <c:choose>
                <c:when test="${empty hallList}">
                    <div class="empty">
                        나의 위시 목록이 없습니다.
                    </div>
                </c:when>
                <c:otherwise>
					<div class="wishdetail">
					    <c:forEach var="vo" items="${hallList}">
					        <div>
					            <a class="wishimage" href="../hall/detail.do?hno=${vo.hvo.hno}">
					                <img src="${vo.hvo.image}" alt="${vo.hvo.name}">
					            </a>
					            <div class="wishname">
					                <img src="../mypage/jjim.png" class="wishBtn">
					                <span>${vo.hvo.name}</span>
					            </div>
					            <div class="action-buttons">
					                <button class="view-details" data-href="../hall/detail.do?hno=${vo.hvo.hno}">상세보기</button>
					                <button class="cancel" data-href="${vo.wno}">취소</button>
					            </div>
					        </div>
					    </c:forEach>
					</div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 각 탭에 맞는 내용 추가 -->
        <div id="table2" class="tab_contents">
            <!-- 드레스 관련 내용 추가 -->
            
        </div>
        <div id="table3" class="tab_contents">
            <!-- 예복 관련 내용 추가 -->
        </div>
		 <div id="table4" class="tab_contents">
		    <!-- 스튜디오 관련 내용 추가 -->
		    <div class="tab_contents_area">
		        <p class="titbox">스튜디오 위시 리스트는 총 <span id="count" style="color: #228B22;">${sCount}</span>개입니다.</p>
		    </div>
		    <c:choose>
		        <c:when test="${empty studioList}">
		            <div class="empty">나의 위시 목록이 없습니다.</div>
		        </c:when>
		        <c:otherwise>
		            <div class="wishdetail">
		                <c:forEach var="vo" items="${studioList}">
	                    	<div class="stline">
		                        <a class="wishimage" href="../hall/detail.do?hno=${vo.svo.sno}">
		                            <img src="${vo.svo.thumb}" alt="${vo.svo.name}">
		                        </a>
		                        <div class="ws_info">
			                        <div class="wishname">
			                            <img src="../mypage/jjim.png" class="wishBtn">
			                            <span>${vo.svo.name}</span>
			                        </div>
			                        <div class="tel"> <!-- tel 위치 변경 -->
			                            <span>☎ ${vo.svo.tel}</span>
			                        </div>
		                        </div>
		                        <div class="action-buttons">
		                            <button class="view-details" data-href="../studio/studio_detail.do?sno=${vo.svo.sno}">상세보기</button>
		                            <button class="cancel" data-href="${vo.wno}">취소</button>
		                        </div>
	                        </div>
		                </c:forEach>
		            </div>
		        </c:otherwise>
		    </c:choose>
		</div>
        <div id="table5" class="tab_contents">
            <!-- 헤어/메이크업 관련 내용 추가 -->
            <div class="tab_contents_area">
		        <p class="titbox">헤어/메이크업 위시 리스트는 총 <span id="count" style="color: #228B22;">${mCount}</span>개입니다.</p>
		    </div>
		    <c:choose>
		        <c:when test="${empty hairmakeList}">
		            <div class="empty">나의 위시 목록이 없습니다.</div>
		        </c:when>
		        <c:otherwise>
		            <div class="wishdetail">
		                <c:forEach var="vo" items="${hairmakeList}">
	                    	<div class="stline">
		                        <a class="wishimage" href="../hall/detail.do?hno=${vo.mvo.mno}">
		                            <img src="${vo.mvo.thumb}" alt="${vo.mvo.name}">
		                        </a>
		                        <div class="ws_info">
			                        <div class="wishname">
			                            <img src="../mypage/jjim.png" class="wishBtn">
			                            <span>${vo.mvo.name}</span>
			                        </div>
			                        <div class="tel"> <!-- tel 위치 변경 -->
			                            <span>☎ ${vo.mvo.tel}</span>
			                        </div>
		                        </div>
		                        <div class="action-buttons">
		                            <button class="view-details" data-href="../studio/hairmakeup_detail.do?mno=${vo.mvo.mno}">상세보기</button>
		                            <button class="cancel" data-href="${vo.wno}">취소</button>
		                        </div>
	                        </div>
		                </c:forEach>
		            </div>
		        </c:otherwise>
		    </c:choose>
        </div>
        <div id="table6" class="tab_contents">
            <!-- 혼수 관련 내용 추가 -->
        </div>
    </div>
</body>
</html>
