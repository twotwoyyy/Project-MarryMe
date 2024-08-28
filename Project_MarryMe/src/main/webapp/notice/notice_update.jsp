<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 등록</title>
<style type="text/css">
/* 공지 등록 영역 스타일 */
#notice-form-container {
    max-width: 1200px;
    width: 100%;
    margin: 20px auto;
    padding-top: 20px;
}

#notice-form-content {
    background: #EFF3EA;
    padding: 30px;
    border-radius: 8px;
}

#notice-form-title {
    font-size: 24px;
    margin-bottom: 20px;
    color: #333;
    border-bottom: 2px solid rgb(78, 107, 63);
    padding-bottom: 10px;
    text-align: center;
}

.notice-form-table {
    width: 100%;
    border-collapse: collapse;
}

.notice-form-table th, .notice-form-table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;

}

.notice-form-table th {
    background-color: rgb(78, 107, 63);
    color: white;
    font-weight: bold;
}

.notice-form-table td {
    color: #333;
}

.notice-form-input, .notice-form-textarea, .notice-form-select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
    font-size: 14px;
}

.notice-form-textarea {
    resize: vertical; /* 세로 방향으로만 크기 조절 가능 */
}

.notice-form-button, .notice-form-cancel-button {
    border: none;
    background-color: rgb(78, 107, 63);
    color: white;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin: 5px;
    
    
}

.notice-form-button:hover, .notice-form-cancel-button:hover {
    background-color: rgb(101, 122, 65);
}

.notice-form-cancel-button {
    background-color: #ccc;
    color: #333;
}

.notice-form-cancel-button:hover {
    background-color: #aaa;
}

#white input,select{
    background-color: white;
}

#noBtn td {
    text-align: center; /* 가운데 정렬 */
}
.notice-form-table th {
    text-align: center; /* 가운데 정렬 */
    vertical-align: middle; /* 세로 가운데 정렬 */
}
</style>
</head>
<body>
	<div id="notice-form-container">
		<div id="notice-form-content">
			<h2 id="notice-form-title">공지 수정</h2>
			<form method="post" action="../notice/notice_update_ok.do">
				<table class="notice-form-table">
					<tr id="white">
						<th width="20%">구분</th>
						<td width="80%">
							<select name="type" class="notice-form-select">
								<option value="1" ${vo.type==1?"selected":"" }>전체</option>
								<option value="2" ${vo.type==2?"selected":"" }>웨딩홀</option>
								<option value="3" ${vo.type==3?"selected":"" }>드레스/예복</option>
								<option value="4" ${vo.type==4?"selected":"" }>스튜디오/헤메</option>
								<option value="5" ${vo.type==5?"selected":"" }>혼수</option>
							</select>
						</td>
					</tr>
					<tr id=white>
						<th width="20%">제목</th>
						<td width="80%">
							<input type="text" name="subject" class="notice-form-input" size="50" required value="${vo.subject }">
							<input type="hidden" name="no" value="${vo.no }">
						</td>
					</tr>
					<tr>
						<th width="20%">내용</th>
						<td width="80%">
							<textarea rows="10" cols="50" name="content" class="notice-form-textarea" required>${vo.content }</textarea>
						</td>
					</tr>
					<tr id="noBtn">
						<td colspan="2">
							<button type="submit" class="notice-form-button">수정</button> 
							<input type="button" value="취소" class="notice-form-cancel-button" onclick="javascript:history.back()">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>
