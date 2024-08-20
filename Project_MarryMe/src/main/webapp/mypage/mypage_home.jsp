<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
<style type="text/css">
	h1{
	text-align: center;
	}
</style>
</head>
<body>
	<section class="mycontent">
	<div class="sixth">
		<h1>${sessionScope.name}&nbsp;${sessionScope.gender}님 마이페이지</h1>
	</div>
	</section>
	
</body>
</html>