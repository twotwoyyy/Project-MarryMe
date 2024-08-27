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
        <section class="adminpage_menu">
            <!-- 사이드바 메뉴 영역 -->
            <div id="adminpmenu">
            <h1 id="my_title">${title }</h1>
                <h3>회원정보</h3>
                <ul>
                    <li><a href="../adminpage/member_list.do">회원 관리</a></li>
                    <li><a href="../adminpage/notice_list.do">공지사항 관리</a></li>
                    <li><a href="#">리뷰 관리</a></li>
                    <li><a href="../adminpage/adminpage_reserve.do">예약 관리</a></li>
                    <li><a href="../adminpage/reply_list.do">QnA 관리</a></li>
                </ul>
            </div>
            <div id="adminmenu">
                <h3>관리정보</h3>
                <ul>
<!--                     <li><a href="../mypage/mypage_wish.do">나의 위시리스트</a></li> -->
<!--                     <li><a href="../adminpage/adminpage_reserve.do">예약 내역</a></li> -->
<!--                     <li><a href="../adminpage/adminpage_qna.do">문의 내역</a></li> -->
<!--                     <li><a href="#">리뷰 내역</a></li> -->
<!--                     <li><a href="../mypage/mypage_cart.do">장바구니 관리</a></li> -->
                </ul>
            </div>
        </section>
    <jsp:include page="${adminpage_jsp }"></jsp:include>
    </div>
</body>
</html>
