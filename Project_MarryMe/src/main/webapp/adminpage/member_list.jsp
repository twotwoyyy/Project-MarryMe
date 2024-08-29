<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <link rel="stylesheet" type="text/css" href="../css/mypage.css">
    <style type="text/css">
        body {
            font-family: 'SCoreDream', sans-serif;
            margin: 0;
            padding: 0;
        }
        .myreserve {
            margin: 0 auto;
            padding: 20px;
            width: 100%;
            max-width: 1200px;
        }
        .section {
            margin-bottom: 40px;
        }
        .section-label {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            border-bottom: 2px solid #DDDDDD;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        .empty {
            text-align: center;
            font-size: 1.2em;
            padding: 20px;
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
            background-color: #8FBC8B;
        }
        .reserveimage img {
            width: 100px;
            height: auto;
        }
        .date-info {
            font-size: 14px;
            color: #666;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a, .pagination span {
            display: inline-block;
            padding: 10px;
            margin: 0 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-decoration: none;
            color: #333;
        }
        .pagination .active {
            background-color: #f4f4f4;
            color: #000;
            font-weight: bold;
        }
        .pagination a:hover {
            background-color: #8FBC8B;
        }
        .btn-delete {
            border: none;
            background-color: #FF5A5A;
            color: white;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }
        .btn-delete:hover {
            background-color: #e14b4b;
        }
        .btn-success {
            border: none;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }
        .btn-custom-success:hover {
		    background-color: #218838; /* 마우스를 올렸을 때 배경색 변화 */
		}
        .btn-primary {
		    border: none; /* 테두리 없음 */
		    background-color: #007bff; /* 파란색 배경색 */
		    color: white; /* 텍스트 색상 */
		    padding: 10px 20px; /* 상하 10px, 좌우 20px 여백 */
		    cursor: pointer; /* 마우스 커서가 포인터로 변함 */
		    border-radius: 5px; /* 모서리 둥글기 */
		    font-size: 14px; /* 글자 크기 */
		}
		.btn-primary:hover {
		    background-color: #0056b3;
		}

        #rmsg:hover {
            background-color: #efefef;
        }
        #count {
            color: #DC143C;
            font-size: 20px;
            font-weight: bold;
        }
        .titbox {
            margin-top: 10px;
        }
        th:nth-child(1) { width: 20px; } /* 번호 */
        th:nth-child(2) { width: 80px; } /* 카테고리 */
        th:nth-child(3) { width: 350px; } /* 문의 내용 */
        th:nth-child(4) { width: 80px; } /* 날짜 */
        th:nth-child(5) { width: 80px; } /* 관리자 답변 */
        th:nth-child(6) { width: 80px; } /* 삭제 버튼 */
        .answer-row {
            display: none;
            background-color: #f9f9f9;
        }
        .answer-row.active {
            display: table-row;
        }
        .answerContent{
        	margin-left: 210px;
        }
        .btn-msg{
        	background-color: #8FBC8B;
        	border: none;
            color: white;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }
        .Redefault{
            border: none;
            background-color: #efefef;
            color: black;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 14px;
        }
    </style>
    <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
    <script type="text/javascript">
    </script>
</head>
<body>
    <div class="myreserve">
        <div class="sixth"> 
            <h1>회원 목록</h1>
        </div>
        <p class="titbox">
            총 <span id="count">${total}</span> 분의 회원이&nbsp;Project MarryMe와 함께하고있습니다.
        </p>
        <table>
            <thead>
                <tr id="rcate">
                    <th>번호</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>성별</th>
                    <th>나이</th>
                    <th>주소</th>
                    <th>주소</th>
                </tr>
            </thead>
            <tbody class="rList">
            <c:set var="i" value="디귿"/>
                <c:forEach var="y" items="이응">
                    <tr id="myr">
                        <td>${aqp}</td>
                        <td> 아이디 </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                    </tr>
				    <!-- 기존 답변 내용 -->
				    
				    <c:set var="aqp" value="${count = count-1 }"/>
				</c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <a href="../adminpage/adminpage_qna.do?page=${curpage-1}">이전</a>
            ${curpage} page / ${totalpage} pages
            <a href="../adminpage/adminpage_qna.do?page=${curpage+1}">다음</a>
        </div>
    </div>
</body>
</html>