<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My qna List</title>
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
    <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
    <script type="text/javascript">
    $(function() {
        $('.btn-msg').click(function() {
            var $row = $(this).closest('tr');
            var $answerRow = $row.next('.answer-row');

            if ($answerRow.hasClass('active')) {
                $answerRow.removeClass('active');
            } else {
                $('.answer-row').removeClass('active'); // 모든 답변 행 숨기기
                $answerRow.addClass('active'); // 선택된 답변 행 보이기
            }
        });

        $('.btn-delete').click(function() {
            if (confirm('문의 글을 삭제하시겠습니까?')) {
                let qna_groupid = $(this).attr('data-delete');
                $.ajax({
                	type:'POST',
                	url:'../mypage/mypage_qna_delete.do',
                	data:{"qna_groupid":qna_groupid},
                	success:function(result){
                		alert("문의가 삭제되었습니다")
                		location.href="../mypage/mypage_qna.do";
                	},
                	error:function(request, status, error){
                		console.log(error)
                	}
                })
            }
        });
    });
    </script>
</head>
<body>
    <div class="myreserve">
        <div class="sixth"> 
            <h1>나의 문의 내역</h1>
        </div>
        <p class="titbox">
            내가 쓴 총 <span id="count">${myqSize}</span>개의 문의가 있습니다
        </p>
        <p>*문의 내용을 누르면 해당 상세 페이지로 이동합니다*</p>

        <table>
            <thead>
                <tr id="rcate">
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>문의 내용</th>
                    <th>날짜</th>
                    <th>관리자 답변</th>
                    <th></th>
                </tr>
            </thead>
            <tbody class="rList">
                <c:forEach var="qna" items="${myqList}">
                    <tr id="myr">
                        <td>${qna.num}</td>
                        <td>
                            <c:choose>
                                <c:when test="${qna.cate == 1}">웨딩홀</c:when>
                                <c:when test="${qna.cate == 2}">드레스</c:when>
                                <c:when test="${qna.cate == 3}">예복</c:when>
                                <c:when test="${qna.cate == 4}">스튜디오</c:when>
                                <c:when test="${qna.cate == 5}">헤어/메이크업</c:when>
                                <c:when test="${qna.cate == 6}">혼수</c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </td>
                        <td id="rmsg" style="text-align: left;">
                            <c:choose>
                                <c:when test="${qna.cate==1 }"><a href="../hall/detail.do?hno=${qna.pno }">${qna.msg}</a></c:when>
                                <c:when test="${qna.cate==2 }"><a href="../dress/dress_detail.do?d_no=${qna.pno }">${qna.msg}</a></c:when>
                                <c:when test="${qna.cate==3 }"><a href="../dress/suit_detail.do?su_no=${qna.pno }">${qna.msg}</a></c:when>
                                <c:when test="${qna.cate==4 }"><a href="../studio/studio_detail.do?sno=${qna.pno }">${qna.msg}</a></c:when>
                                <c:when test="${qna.cate==5 }"><a href="../studio/hairmakeup_detail.do?mno=${qna.pno }">${qna.msg}</a></c:when>
                                <c:when test="${qna.cate==6 }"><a href="../goods/detail.do?pno=${qna.pno }&cate=6">${qna.msg}</a></c:when>
                            </c:choose>
                        </td>
                        <td class="date-info">${qna.dbday}</td>
                        <td>
                            <c:choose>
                                <c:when test="${qna.groupCount == 2}">
                                    <button class="btn-msg" data-qna_no="${qna.qna_no}" data-group_id="${qna.group_id}">답변 보기</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="Redefault">답변 대기</button>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button class="btn-delete" data-delete="${qna.group_id}">삭제</button>
                        </td>
                    </tr>
                  <c:forEach var="reply" items="${reList}">
                        <c:if test="${reply.group_id == qna.group_id}">
                            <tr class="answer-row">
                                <td colspan="6">
                                    <div class="answerContent" style="text-align: left;">➡️[관리자] ${reply.msg}</div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <a href="../mypage/mypage_qna.do?page=${curpage-1}">이전</a>
            ${curpage} page / ${totalpage} pages
            <a href="../mypage/mypage_qna.do?page=${curpage+1}">다음</a>
        </div>
    </div>
</body>
</html>