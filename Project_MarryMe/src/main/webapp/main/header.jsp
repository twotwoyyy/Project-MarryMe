<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$('.search_btn').click(function(e){
		if($('#header #search').val().trim()===""){
			e.preventDefault();
			alert('검색어를 입력해주세요')
			$('#header #search').focus()
		}
	})
})
</script>
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
                            <a href="../dress/dress_list.do">드레스 / 예복</a>
                            <ul class="sub_menu">
                                <li><a href="../dress/dress_list.do">드레스</a></li>
                                <li><a href="../dress/suit_list.do">예복</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="../studio/studio_list.do">스튜디오 / 헤어메이크업</a>
                            <ul class="sub_menu">
                                <li><a href="../studio/studio_list.do">스튜디오</a></li>
                                <li><a href="../studio/hairmakeup_list.do">헤어메이크업</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="../goods/list.do">혼수</a>
                        </li>
                        <li>
                            <a href="../notice/list.do">공지사항</a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="right">
                <ul class="right_menu">
                    <li>
                        <form method="GET" action="../main/find.do">
                            <label for="search" class="hidden">검색</label>
                            <input type="search" id="search" name="search">
                            <input type="submit" value="검색" class="search_btn">
                        </form>
                    </li>
                    <c:if test="${sessionScope.id==null}">
                    	<li><a href="../member/login.do">로그인</a></li>
                    	<li><a href="../member/join.do">회원가입</a></li>
                    </c:if>
                    <c:if test="${sessionScope.id!=null}">
                    	<li class="name"><span>${sessionScope.name}</span>${sessionScope.gender}님</li>
                    	<li><a href="../member/logout.do">로그아웃</a></li>
                    	<li><a href="../mypage/mypage_cart.do">장바구니</a></li>
                    	<c:if test="${sessionScope.admin=='n'}">
	                    	<li><a href="../mypage/mypage_main.do">마이페이지</a></li>
	                    </c:if>
	                    <c:if test="${sessionScope.admin=='y'}">
	                    	<li><a href="../adminpage/adminpage_main.do">관리자페이지</a></li>
	                    </c:if>
                    </c:if>
                </ul>
            </div>
        </div>
    </header>
</body>
</html>