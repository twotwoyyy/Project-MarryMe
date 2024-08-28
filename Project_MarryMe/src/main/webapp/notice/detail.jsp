<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 상세보기</title>
<style type="text/css">

/* 공지 상세 영역 스타일 */
#notice-container {
    max-width: 1200px;
    width: 100%;
    margin: 20px auto;
    padding-top: 100px;
    font-family: 'SCoreDream', sans-serif;
    
}

#notice-content {
    background: #EFF3EA;
    padding: 30px;
    border-radius: 8px;
}

#notice-title {
    font-size: 24px;
    margin-bottom: 20px;
    color: #333;
    border-bottom: 2px solid rgb(78, 107, 63);
    padding-bottom: 10px;
}

.notice-table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 8px;
    overflow: hidden;
}

.notice-table th, .notice-table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.notice-table th {
    background-color: rgb(78, 107, 63);
    color: white;
    font-weight: bold;
}

.notice-table td {
    color: #333;
}

.notice-content {
    white-space: pre-wrap;
    background-color: #fff;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    overflow: auto;
    min-height: 300px;
}

.notice-link {
    border: none;
    background-color: rgb(78, 107, 63);
    color: white;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin-left: 360px;
    margin-bottom: 5px;
    border: none;
}

.notice-link:hover {
	background-color: rgb(101, 122, 65);

}
</style>
</head>
<body>
	<div id="notice-container">
		<div id="notice-content">
			<h2 id="notice-title" style="text-align: center;">[${vo.notice_type } 공지]&nbsp;${vo.subject }</h2>
			<table class="notice-table">
				<tr>
					<th width="20%">번호</th>
					<td width="30%">${vo.no}</td>
					<th width="20%">작성일</th>
					<td width="30%">${vo.dbday }</td>
				</tr>
				<tr>
					<th width="20%">공지 종류</th>
					<td width="30%">${vo.notice_type }</td>
					<th width="20%">조회수</th>
					<td width="30%">${vo.hit }</td>
				</tr>
				<tr>
					<td colspan="4" valign="top">
						<pre class="notice-content">${vo.content }</pre>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: right; padding-top: 10px;">
						<a class="notice-link" href="../notice/list.do">목록</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
