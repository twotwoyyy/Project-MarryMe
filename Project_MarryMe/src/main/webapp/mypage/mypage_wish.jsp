
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
<style type="text/css">
.tab_area.tab5 button {
    width: 20%;
}
.tab_area.sub4 button {
    height: 70px;
}
.tab_area button:last-child {
    border-radius: 0 10px 10px 0;
    border-right: 1px solid #e7e7e7;
}
.tab_area button {
    overflow: hidden;
    position: relative;
    display: inline-block;
    height: 66px;
    border: 1px solid #e7e7e7;
    border-left: none;
    border-right: none;
    cursor: pointer;
}
.tab_area.mypage button span {
    font-size: 16px;
}
.tab_area.sub4 button span {
    font-size: 16px;
    line-height: 68px;
}
.tab_area button.on span {
    color: #ffffff;
}

.tab_area button span {
    position: relative;
    display: block;
    color: #00548b;
    font-size: 18px;
    text-align: center;
    line-height: 66px;
    z-index: 20;
}
.tab_area {
    height: 68px;
    font-size: 0;
}
.pc_mt30 {
    margin-top: 30px;
}

.titbox .total_num_txt {
    color: grey; 
}

/* Hidden 클래스 정의 */
.hidden {
    display: none;
}

.tab_area button.on::after {
    background-color: #00548b;
}
.tab_area button.on::after {
    z-index: 10;
}

/* 활성화된 탭의 스타일 */
.on {
    background-color: #00548b; /* 활성화된 탭의 배경색을 파란색으로 설정 */
    color: white; /* 글자색을 흰색으로 설정 */
}

.tab_area button::after {
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    content: '';
}
    
.jjimTitle {
        font-size: 1.2em; 
        font-weight: bold;
}
.jjimBtn {
        width: 25px; 
        height: 25px; 
    }
 .jjimTitle {
    display: inline-block;
    max-width: 100%;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
function toggleTab(tabIndex) {
    // 모든 테이블 숨기기
    document.getElementById('table1').classList.add('hidden');
    document.getElementById('table2').classList.add('hidden');
    document.getElementById('table3').classList.add('hidden');
    document.getElementById('table4').classList.add('hidden');
    document.getElementById('table5').classList.add('hidden');
    document.getElementById('table6').classList.add('hidden');

    // 모든 탭의 활성화 클래스 제거
    var buttons = document.querySelectorAll('.tab_box button');
    buttons.forEach(function(button) {
        button.classList.remove('on');
    });

    // 선택한 탭의 테이블 표시 및 해당 탭 활성화
    if (tabIndex === 0) {
        document.getElementById('table1').classList.remove('hidden');
        buttons[tabIndex].classList.add('on');
    } else if (tabIndex === 1) {
        document.getElementById('table2').classList.remove('hidden');
        buttons[tabIndex].classList.add('on');
    }else if (tabIndex === 2) {
        document.getElementById('table3').classList.remove('hidden');
        buttons[tabIndex].classList.add('on');
    }else if (tabIndex === 3) {
        document.getElementById('table4').classList.remove('hidden');
        buttons[tabIndex].classList.add('on');
    }else if (tabIndex === 4) {
        document.getElementById('table5').classList.remove('hidden');
        buttons[tabIndex].classList.add('on');
    }
    }else if (tabIndex === 5) {
        document.getElementById('table6').classList.remove('hidden');
        buttons[tabIndex].classList.add('on');
    }
}

</script>
<script type="text/javascript">
$(function(){
	$('.jjimBtn').click(function() {
        let jno = $(this).attr("data-jno");            

        $.ajax({
            type: 'post',
            url: '../mypage/mypage_wish_cancel.do',
            data: {'jno': jno},
            success: function(result) {
                if (result === 'ok') {
                    alert("찜 취소가 완료되었습니다");
                    location.reload(); 
                } 
            }
        });
    });
})
</script>
</head>
<body>
  <div class="myJjim">
      <div class="max1200 dp_pc contents_titbox">
                <h4 class="titbox">나의<strong>찜목록</strong></h4>
   	  </div>
   	 <div class="tab_contents_area ">
   	  	<p class="titbox">&nbsp;&nbsp;<span class="total_num_txt offline ta_px0">총 <strong>${totalWish}</strong>개의 찜 내역이 있습니다.</span></p>
   	  </div>
		<div class="pc_mt30 ta_mt40 ta_mx40 tab_area tab5 sub4 mypage">
		    <div class="tab_box">
		        <button onclick="toggleTab(0)" class="h40 on"><span>홀</span></button>
		        <button onclick="toggleTab(1)" class="h40"><span>드레스</span></button>
		        <button onclick="toggleTab(2)" class="h40"><span>예복</span></button>
		        <button onclick="toggleTab(3)" class="h40"><span>스튜디오</span></button>
		        <button onclick="toggleTab(4)" class="h40"><span>헤어/메이크업</span></button>
		        <button onclick="toggleTab(5)" class="h40"><span>혼수</span></button>
		    </div>
		</div>

        <!--  명소 찜 목록 -->
        <div id="table1" class="">
		   <c:choose>
			 <c:when test="${empty hallList}">
			 		<!--TABLE-->
			  <table class="lecture_info_table tablet_type2 mypage" style="width: 100%;">
				    <tbody>
						        <tr>
						            <td colspan="4" class="empty">
						                나의 위시 목록이 없습니다.
						            </td>
						        </tr>
					 </tbody>
				 </table>
			 </c:when>
			<c:otherwise>        
        	<div class="col-sm-4 col-md-12">
				<div class="row">
					<c:forEach var="vo" items="${hallList }">
						<div class="col-md-4">
							<div class="single-blog">
								<div class="content fix">
									<a class="image fix" href="../hall/detail.do?hno=${vo.hvo.hno}"><img
										src="${vo.hvo.image }" width="100%" height="220px" /></a>
									<div class="metammm" style="position: relative">
										<div style="display: inline-block" class="jjimTitle">
											<a href="../hall/detail.do?hno=${vo.hvo.hno}"></a>
											<img src="../busan/jjim.png" class="jjimBtn" data-jno="${vo.hvo.hno }">
											${vo.hvo.name}
										</div>
										<div style="display: inline-block; float: right; margin-top: 22px; cursor: pointer;" onclick="">
											<img src="" style="width: 30px;">
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			</c:otherwise>
			</c:choose>
        </div>
    
        </div>

</body>
</html>