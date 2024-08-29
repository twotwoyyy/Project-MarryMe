<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>기본 레이아웃</title>
    <!-- 외부 CSS 파일 링크 -->
    <link rel="stylesheet" type="text/css" href="styles.css">
   <style type="text/css">
      .h3{
         text-align: center;
      }
      #my_title{
         font-size: 20px;
         font-family: 'SCoreDream', sans-serif;
         font-weight:500;
         margin-bottom: 20px;
      }

   </style>

</head>
<body>
    <div class="mycontainer">
        <section class="mypage_menu">
            <!-- 사이드바 메뉴 영역 -->
            <div id="mypmenu">
            <h1 id="my_title">${title }</h1>
                <h3>개인정보</h3>
                <ul>
                    <li><a href="../mypage/mypage_main.do">정보확인</a></li>
                    <li><a href="../member/join_update.do">회원수정</a></li>
                    <li><a href="../member/member_delete.do">회원탈퇴</a></li>
                    <li><a href="../member/pw_change.do">비밀번호 변경</a></li>
                </ul>
            </div>
            <div id="mypmenu">
                <h3>관리정보</h3>
                <ul>
                    <li><a href="../mypage/mypage_wish.do">나의 위시리스트</a></li>
                    <li><a href="../mypage/mypage_reserve.do">예약 내역</a></li>
                    <li><a href="../mypage/mypage_qna.do">문의 내역</a></li>
                    <li><a href="../mypage/mypage_review.do">리뷰 내역</a></li>
                    <li><a href="../mypage/mypage_buy.do">구매 내역</a></li>
                    <li><a href="../mypage/mypage_cart.do">장바구니 관리</a></li>
                </ul>
            </div>
        </section>
    <jsp:include page="${mypage_jsp }"></jsp:include>
    </div>
</body>
</html>
