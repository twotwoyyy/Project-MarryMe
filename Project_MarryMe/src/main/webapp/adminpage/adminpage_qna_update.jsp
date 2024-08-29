<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 등록</title>
<style type="text/css">
/* 기존 스타일 재사용 및 새로운 스타일 추가 */
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
    width: calc(100% - 22px); /* 여백과 테두리를 고려한 너비 조정 */
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
    font-size: 14px;
}
/*  	문의 내용 출력란 사이즈 조절하는 코드 */
 .notice-form-input {
   	height: 150px; /* 입력 필드의 높이 */
}
 .notice-form-textarea {
     height: 150px;
 }

/* 바로 위의 주석 코드가 수정된 스타일 */
.notice-form-table td input,
.notice-form-table td textarea {
    margin-top: 10px; /* 요소 위쪽 여백 */
    margin-bottom: 10px; /* 요소 아래쪽 여백 */
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

/* 새로운 스타일 추가 */
/* 기존 스타일 */
.notice-form-readonly {
    background-color: #f9f9f9; /* 읽기 전용 필드 배경색 */
    padding: 10px; /* 내부 여백을 줄여서 크기 조정 */
    border-radius: 5px;
    text-align: center; /* 가로 중앙 정렬 */
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 문의 내용의 readonly 부분만 크기 조정 */
.notice-form-readonly-large {
    height: 150px; /* 높이 맞추기 (textarea와 동일하게) */
    width: calc(100% - 22px); /* 너비 맞추기 (textarea와 동일하게) */
    box-sizing: border-box; /* 테두리와 패딩을 너비에 포함 */
}
</style>
</head>
<body>
    <div id="notice-form-container">
        <div id="notice-form-content">
            <h2 id="notice-form-title">답변 등록</h2>
            <form method="post" action="../adminpage/adminpage_qna_update_ok.do">
                <table class="notice-form-table">
                    <tr id="white">
                        <th width="20%">번호</th>
                        <td width="30%">
                            <div class="notice-form-readonly">${vo.qna_no}</div>
                        </td>
                        <th class="custom-height" width="20%">구분</th> <!-- 수정된 부분 -->
					    <td width="30%">
					        <div class="notice-form-readonly">${vo.cate }</div>
					    </td>
                    </tr>
                    <tr id="white">
                        <th width="20%">아이디</th>
                        <td width="30%">
                            <div class="notice-form-readonly">${vo.id }</div>
                        </td>
                        <th class="custom-height" width="20%">날짜</th> <!-- 수정된 부분 -->
					    <td width="30%">
					        <div class="notice-form-readonly">${vo.dbday }</div>
					    </td>
                    </tr>
                    <tr id="white">
                        <th width="20%">문의 내용</th>
                        <td width="80%" colspan="3">
                            <div class="notice-form-readonly notice-form-readonly-large">${vo.msg }</div>
                        </td>
                    </tr>
                    <tr>
                        <th width="20%">답변 작성</th>
                        <td width="80%" colspan="3">
                            <textarea rows="10" cols="50" name="content" class="notice-form-textarea" required>${Remsg }</textarea>
                            <input type="hidden" name="qno" value="${vo.qna_no}">
                        </td>
                    </tr>
                    <tr id="noBtn">
                        <td colspan="4">
                            <button type="submit" class="notice-form-button">등록</button> 
                            <input type="button" value="취소" class="notice-form-cancel-button" onclick="javascript:history.back()">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</body>
</html>
