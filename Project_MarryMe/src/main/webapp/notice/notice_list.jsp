<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="custom-styles.css">
<style type="text/css">
/* 페이지 스타일 */
#pagination-container {
    padding-top: 30px;
    display: flex;
    justify-content: center;
    gap: 10px;
}

#pagination-container .pagination-item a {
    display: block;
    width: 24px;
    height: 24px;
    line-height: 24px;
    text-align: center;
    transition: .3s;
}

#pagination-container .pagination-item a:hover {
    background: #303A1F;
    color: #dcdcdc;
}

#pagination-container .pagination-item.active > a {
    background: #303A1F;
    color: #dcdcdc;
}

#notice-table {
    font-family: 'SCoreDream', sans-serif;
	width: 1000px;
	margin: 0 auto;
}

.noticeall{
	padding-top: 30px;
	padding-bottom: 30px;
	margin: 0px auto;
	min-height: 550px;
}

.notice-container {
    font-family: 'SCoreDream', sans-serif;
    width:1300px;
    margin-top: 200px;
    margin: 0 auto;
    background: #EFF3EA;
    padding-bottom: 70px;
}

h2.notice-title {
    font-family: 'SCoreDream', sans-serif;
    margin: 0 auto;
    text-align: center;
    font-weight: 300;
    font-size: 30px;
    padding-top: 20px;
    margin-bottom: 10px;
}

.table-header {
    background-color: rgb(78, 107, 63);
}

.table-header th {
    color: white;
}

.table-container {
    width: 100%;
    border-collapse: collapse;
    
}

.table-container th, .table-container td {
    border: 1px solid #e7e7e7;
    padding: 10px;
    text-align: center;
}

.table-container td {
    background-color: white;
}

.table-actions a {
    border: none;
    color: white;
    padding: 5px 10px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin: 0 5px;
    text-decoration: none;
}

.table-actions .update {
    background-color: #28a745;
}

.table-actions .update:hover {
    background-color: #218838;
}

.table-actions .delete {
    background-color: #dc3545;
}

.table-actions .delete:hover {
    background-color: #c82333;
}

.pagination-controls {
    text-align: center;
    margin-top: 30px;
}

.pagination-controls .pagination-button {
    border: none;
    background-color: #303A1F;
    color: white;
    padding: 5px 10px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin: 0 5px;
    text-decoration: none;
}

.pagination-controls .pagination-button:hover {
    background-color: rgb(101, 122, 65);
}

#Noticebtn{
    border: none;
    background-color: rgb(78, 107, 63);
    color: white;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin: 5px;
    margin-bottom: 20px;
    margin-left: 150px;
}
#Noticebtn:hover{
	background-color: rgb(101, 122, 65);
}

</style>
<script type="text/javascript">
$(function(){
	$('#Noticebtn').click(function(){
		location.href="../notice/notice_insert.do"
	})
})
</script>
</head>
<body>
	<div class="noticeall">
	    <div class="notice-container">
	        <h2 class="notice-title">공지 관리</h2>
	        	<button id="Noticebtn">공지 등록</button>
	        <table id="notice-table" class="table-container">
	            <thead class="table-header">
	                <tr>
	                    <th>번호</th>
	                    <th>제목</th>
	                    <th>작성자</th>
	                    <th>작성일</th>
	                    <th>조회수</th>
	                    <th>관리</th>
	                </tr>
	            </thead>
	            <tbody>
	                <c:set var="count" value="${count }" />
	                <c:forEach var="vo" items="${noticeList }">
	                    <tr>
	                        <td>${count }</td>
	                        <td style="text-align:left;">[${vo.notice_type}]&nbsp;${vo.subject }</td>
	                        <td>관리자</td>
	                        <td>${vo.dbday }</td>
	                        <td>${vo.hit }</td>
	                        <td class="table-actions">
	                            <a href="../notice/notice_update.do?no=${vo.no }" class="update">수정</a>
	                            <a href="../notice/notice_delete.do?no=${vo.no }" class="delete">삭제</a>
	                        </td>
	                    </tr>
	                    <c:set var="count" value="${count-1 }" />
	                </c:forEach>
	                <tr>
	                    <td style="background-color: #EFF3EA;" colspan="6" class="pagination-controls">
	                        <a href="#" class="pagination-button">이전</a> ${curpage } 페이지 / ${totalpage } 페이지
	                        <a href="#" class="pagination-button">다음</a>
	                    </td>
	                </tr>
	            </tbody>
	        </table>
	    </div>
    </div>
</body>
</html>
