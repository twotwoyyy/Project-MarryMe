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
        .reservedetail .stline.past{
        	position:relative;
        }
        .reservedetail .stline.past::after{
        	content:'이미 지난 예약입니다';
        	width:100%;
        	height:100%;
        	display:flex;
        	justify-content:center;
        	align-items:center;
        	font-size:20px;
        	font-weight:500;
        	color:#dcdcdc;
        	background:rgba(0,0,0,.5);
        	position:absolute;
        	top:0; bottom:0; left:0; right:0;
      		z-index:1
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
        .rebtn {
            display: flex;
            gap: 10px;
            margin-left: 20px;
        }
        .rebtn button {
            width: 100px;
            height: 50px;
            border: 1px solid #e7e7e7;
            border-radius: 5px;
            text-align: center;
            line-height: 50px;
            font-size: 16px;
            background-color: #f4f4f4;
        }

        .rebtn .cancel {
            background-color:  #419DD9;
            color: white;
            cursor: pointer;
            position:relative;
            z-index:2;
        }
        

        .rebtn .status-button {
        	background-color: ##8FBC8B;
        	color:black;
        }
        
        .rebtn .status-button.approved {
		    background-color: #8FBC8B;
		    color: white;
		}
		.rebtn .approve {
		    background-color: #419DD9 !important; /* 적절한 색상을 여기서 설정 */
		    color: white;
		    cursor: pointer;
		    position: relative;
		    z-index: 2;
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
        
/*         예약 삭제 버튼 */
        .rebtn .delete {
		    background-color: #DC143C;
		    color: white;
		    cursor: pointer;
		    position: relative;
		    z-index: 2;
		}
        
    </style>
    <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
    <script type="text/javascript">
    $(function() {
    	$(function() {
    	    // 예약 승인 버튼 클릭 처리
    	    $(document).on('click', '.approve', function() {
    	        let $this = $(this);  // 클릭된 요소를 참조하는 변수 저장
    	        let isApproved = $this.parents('.stline').find('.status-button').hasClass('approved');
    	        
    	        if (isApproved) {
    	            alert('이미 예약 승인 상태입니다.');
    	        } else {
    	            let resno = $this.attr('data-href');
    	            $.ajax({
    	                url: "../adminpage/adminpage_reserve_ok.do?resno=" + resno,
    	                type: "POST",
    	                success: function(response) {
    	                    // 예약 승인 성공 시 해당 항목의 상태만 업데이트
    	                    const statusButton = $this.parents('.stline').find('.status-button');
    	                    statusButton.text('예약 완료');
    	                    statusButton.addClass('approved');
    	                    $this.prop('disabled', true); // 승인 버튼 비활성화
    	                    alert('예약이 승인되었습니다.');
    	                },
    	                error: function(xhr, status, error) {
    	                    alert('예약 승인 중 오류가 발생했습니다.');
    	                }
    	            });
    	        }
    	    });
    	});


        // 예약 삭제 버튼 클릭 처리
        $(document).on('click', '.delete', function() {
            if (!confirm('정말로 예약을 삭제하시겠습니까?')) {
                return; // 사용자가 삭제를 취소한 경우 아무 작업도 하지 않음
            }

            let resno = $(this).attr('data-href');
            $.ajax({
                url: "../adminpage/reserve_delete.do",
                type: "POST",
                data: { resno: resno },
                success: function(response) {
                    // 삭제 시 페이지를 새로 고쳐 갱신된 목록을 로드합니다.
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert('예약 삭제 중 오류가 발생했습니다.');
                }
            });
        });

        // 예약 상태에 따라 버튼 텍스트를 업데이트합니다
        $('.status-button').each(function() {
            const confirmStatus = $(this).data('confirm');
            if (confirmStatus === 'y') {
                $(this).text('예약 완료');
                $(this).addClass('approved');
            } else {
                $(this).text('예약 대기');
            }
        });

        // 지난 예약 처리
        let today = new Date(),
            year = today.getFullYear(),
            month = ('0' + (today.getMonth() + 1)).slice(-2),
            day = ('0' + today.getDate()).slice(-2);
        let rdate = $('.stline .ws_info .tel .rdate')
        rdate.each(function() {
            let target = $(this).text();
            let temp = target.split('-');
            let ryear = temp[0],
                rmonth = temp[1],
                rday = temp[2];
            let isPast = false;
            
            if (year > ryear) {
                isPast = true;
            } else if (year == ryear) {
                if (month > rmonth) {
                    isPast = true;
                } else if (month == rmonth) {
                    if (day > rday) {
                        isPast = true;
                    }
                }
            }

            if (isPast) {
                $(this).parents('.stline').addClass("past");
            } else {
                // 지난 예약이 아닌 경우 예약 삭제 버튼을 예약 승인 버튼으로 변경
                const deleteBtn = $(this).parents('.stline').find('.delete');
                deleteBtn.text('예약 승인');
                deleteBtn.removeClass('delete').addClass('approve');
            }
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
                            <div class="stline">
                                <a class="reserveimage" href="../hall/detail.do?hno=${vo.hvo.hno}">
                                    <img src="${vo.hvo.image}" alt="${vo.hvo.name}">
                                </a>
                                <div class="ws_info">
                                    <div class="reservename">
                                        <img src="../mypage/jjim.png" class="reserveBtn">
                                        <span>${vo.hvo.name}</span>
                                    </div>
                                    <div class="tel">
	                                    <div class="date-info">☎ ${vo.hvo.addr}</div>
                                        <div class="date-info" style="color:red">예약일: <span class="rdate">${vo.rdate}</span></div>
                                        <div class="date-info" style="color:green">예약시간: ${vo.rtime }</div>
                                        <div class="date-info">등록일: ${vo.dbday}</div>
	                                </div>
	                            </div>
                                <div class="rebtn">
		                            <c:choose>
		                                <c:when test="${vo.confirm eq 'y'}">
		                                    <button class="status-button approved" data-confirm="${vo.confirm}" data-href="${vo.resno}">예약 완료</button>
		                                </c:when>
		                                <c:otherwise>
		                                    <button class="status-button" data-confirm="${vo.confirm}" data-href="${vo.resno}">예약 대기</button>
		                                </c:otherwise>
		                            </c:choose>
		                            <button class="delete" data-href="${vo.resno}">예약 삭제</button>
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
                                        <div class="date-info" style="color:red">예약일: <span class="rdate">${vo.rdate}</span></div>
                                        <div class="date-info" style="color:green">예약시간: ${vo.rtime }</div>
                                        <div class="date-info">등록일: ${vo.dbday}</div>
	                                    <div class="date-info">${vo.dvo.d_price}</div>
                                    </div>
                                </div>
                                <div class="rebtn">
		                            <c:choose>
		                                <c:when test="${vo.confirm eq 'y'}">
		                                    <button class="status-button approved" data-confirm="${vo.confirm}" data-href="${vo.resno}">예약 완료</button>
		                                </c:when>
		                                <c:otherwise>
		                                    <button class="status-button" data-confirm="${vo.confirm}" data-href="${vo.resno}">예약 대기</button>
		                                </c:otherwise>
		                            </c:choose>
		                            <button class="delete" data-href="${vo.resno}">예약 삭제</button>
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
                                        <div class="date-info" style="color:red">예약일: <span class="rdate">${vo.rdate}</span></div>
                                        <div class="date-info" style="color:green">예약시간: ${vo.rtime }</div>
                                        <div class="date-info">등록일: ${vo.dbday}</div>
	                                    <div class="date-info">${vo.suvo.su_price}</div>
                                    </div>
                                </div>
                                <div class="rebtn">
		                            <c:choose>
		                                <c:when test="${vo.confirm eq 'y'}">
		                                    <button class="status-button approved" data-confirm="${vo.confirm}" data-href="${vo.resno}">예약 완료</button>
		                                </c:when>
		                                <c:otherwise>
		                                    <button class="status-button" data-confirm="${vo.confirm}" data-href="${vo.resno}">예약 대기</button>
		                                </c:otherwise>
		                            </c:choose>
		                            <button class="delete" data-href="${vo.resno}">예약 삭제</button>
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
                                        <div class="date-info" style="color:red">예약일: <span class="rdate">${vo.rdate}</span></div>
                                        <div class="date-info" style="color:green">예약시간: ${vo.rtime }</div>
                                        <div class="date-info">등록일: ${vo.dbday}</div>
                                    </div>
                                </div>
                                <div class="rebtn">
		                            <c:choose>
		                                <c:when test="${vo.confirm eq 'y'}">
		                                    <button class="status-button approved" data-confirm="${vo.confirm}" data-href="${vo.resno}">예약 완료</button>
		                                </c:when>
		                                <c:otherwise>
		                                    <button class="status-button" data-confirm="${vo.confirm}" data-href="${vo.resno}">예약 대기</button>
		                                </c:otherwise>
		                            </c:choose>
		                            <button class="delete" data-href="${vo.resno}">예약 삭제</button>
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
                                    	<div class="date-info">☎ ${vo.mvo.address}</div>
                                        <div class="date-info" style="color:red">예약일: <span class="rdate">${vo.rdate}</span></div>
                                        <div class="date-info" style="color:green">예약시간: ${vo.rtime }</div>
                                        <div class="date-info">등록일: ${vo.dbday}</div>
                                    </div>
                                </div>
                                <div class="rebtn">
		                            <c:choose>
		                                <c:when test="${vo.confirm eq 'y'}">
		                                    <button class="status-button approved" data-confirm="${vo.confirm}" data-href="${vo.resno}">예약 완료</button>
		                                </c:when>
		                                <c:otherwise>
		                                    <button class="status-button" data-confirm="${vo.confirm}" data-href="${vo.resno}">예약 대기</button>
		                                </c:otherwise>
		                            </c:choose>
		                            <button class="delete" data-href="${vo.resno}">예약 삭제</button>
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
