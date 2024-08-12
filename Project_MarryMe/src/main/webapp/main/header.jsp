<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <header id="header">
        <div class="container">
            <div class="left">
                <h1><a href="../main/main.do">project marry me</a></h1>
                <nav>
                    <ul class="menu">
                        <li>
                            <a href="../hall/list.do">웨딩홀</a>
                        </li>
                        <li>
                            <a href="../dress/list.do">드레스 / 예복</a>
                            <ul class="sub_menu">
                                <li><a href="../dress/list.do">드레스</a></li>
                                <li><a href="../dress/list.do">예복</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="../studio/list.do">스튜디오 / 헤어메이크업</a>
                            <ul class="sub_menu">
                                <li><a href="../studio/list.do">스튜디오</a></li>
                                <li><a href="../studio/list.do">헤어메이크업</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="../goods/list.do">혼수</a>
                        </li>
                        <li>
                            <a href="#">커뮤니티</a>
                            <ul class="sub_menu">
                                <li><a href="#">공지사항</a></li>
                                <li><a href="#">후기게시판</a></li>
                                <li><a href="#">문의게시판</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="right">
                <ul class="right_menu">
                    <li>
                        <form method="GET" action="#">
                            <label for="search" class="hidden">검색</label>
                            <input type="search" id="search" name="search">
                            <input type="submit" value="검색">
                        </form>
                    </li>
                    <li><a href="../member/login.do">로그인</a></li>
                    <li><a href="../member/join.do">회원가입</a></li>
                    <!--
                    <li><a href="#">장바구니</a></li>
                    <li><a href="#">마이페이지</a></li>
                    <li><a href="#">관리자페이지</a></li>
                    -->
                </ul>
            </div>
        </div>
    </header>
</body>
</html>