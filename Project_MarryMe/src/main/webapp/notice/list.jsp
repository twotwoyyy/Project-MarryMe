<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">



#detail .page{
    padding-top:30px;
    display:flex;
    justify-content:center;
    gap:10px;
}
#detail .page > li a{
    display:block;
    width:24px;
    height:24px;
    line-height:24px;
    text-align:center;
    transition:.3s;
}
#detail .page > li a:hover{
    background:#303A1F;
    color:#dcdcdc;
}
#detail .page > li.active > a{
    background:#303A1F;
    color:#dcdcdc;
}
#notice{
	font-family: 'SCoreDream', sans-serif;
	max-width: 1200px;
	width: 100%;
	margin: 0px auto;
}
.allNotice {
	font-family: 'SCoreDream', sans-serif;
	padding-top:100px;
	margin: 0px auto;
	background:#EFF3EA;
	min-height: 610px;
}
h1{
	font-family: 'SCoreDream', sans-serif;
	margin: 0px auto;
	text-align: center;
	font-weight: 300;
	font-size: 30px;
	margin-top: 20px;
}
.titbox {
	margin-bottom: 20px;
	font-size: 20px;
	text-align: center;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	border: 1px solid #e7e7e7;
	padding: 10px;
	text-align: center;
}

#rcate {
	background-color:rgb(78, 107, 63);
}
#rcate th{
	color:white;
}

td{
	background-color: white;
}
.reserveimage img {
	width: 100px;
	height: auto;
}

.titbox {
	margin-top: 10px;
}

th:nth-child(1) {
	width: 20px;
} /* 번호 */
th:nth-child(2) {
	width: 80px;
} /* 카테고리 */
th:nth-child(3) {
	width: 350px;
} /* 문의 내용 */
th:nth-child(4) {
	width: 80px;
} /* 날짜 */
th:nth-child(5) {
	width: 80px;
} /* 관리자 답변 */

#noticeBtn{
    border: none;
    background-color: #303A1F;
    color: white;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin-left: 360px;
    margin-bottom: 5px;
}
#noticeBtn:hover{
	background-color: rgb(101, 122, 65);
}
</style>
<script type="text/javascript">
	$(function(){
		$('#noticeBtn').click(function(){
			location.href="../notice/insert.do"
		})
	})
</script>
</head>
<body>
	<div class="allNotice">
		<div>
			<h1>공지사항</h1>
		</div>
		<div>
			<button id="noticeBtn">새 글</button>
		</div>
		<table id="notice">
			<thead>
				<tr id="rcate">
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody class="rList">
				<c:set var="count" value="${count }" />
				<c:forEach var="vo" items="${noticeList}">
					<tr id="myr">
						<td width="10%">${count}</td>
						<td width="50%" style="text-align: left;">
							<a href="../notice/detail.do?no=${vo.no}">[${vo.notice_type}]&nbsp;${vo.subject }</a>
						</td>
						<td width="10%">${vo.name }</td>
						<td width="15%">${vo.dbday }</td>
						<td width="10%">${vo.hit }</td>
					</tr>
					<c:set var="count" value="${count-1 }" />
				</c:forEach>
			</tbody>
		</table>
		<div id="detail">
			<ul class="page">
			    <!-- 이전 페이지 링크 -->
			        <c:if test="${startpage>1}">
			            <li><a href="../notice/list.do?page=${startpage-1}">&lt;</a></li>
			        </c:if>
			    <c:forEach var="i" begin="${startpage}" end="${endpage}">
			        <li class="${i == curpage ? 'active' : ''}">
			            <a href="../notice/list.do?page=${i}">${i}</a>
			        </li>
			    </c:forEach>
			    <!-- 다음 페이지 링크 -->
		        <c:if test="${endpage < totalpage}">
		            <li><a href="../notice/list.do?page=${endpage + 1}">&gt;</a></li>
		        </c:if>
			</ul>
		</div>
	</div>
</body>
</html>