<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Review List</title>
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
		#rmsg:hover{
			background-color: #efefef;
		}
        #count {
            color: #DC143C;
            font-size: 20px;
            font-weight: bold;
        }
        .titbox{
            margin-top : 10px;
        
        }
        th:nth-child(1) { width: 20px; } /* 번호 */
        th:nth-child(2) { width: 80px; } /* 카테고리 */
        th:nth-child(3) { width: 400px; } /* 리뷰 */
        th:nth-child(4) { width: 80px; } /* 날짜 */
        th:nth-child(5) { width: 40px; } /* 평점 */
        th:nth-child(6) { width: 80px; } /* 삭제 버튼 */
        
    </style>
    <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
    <script type="text/javascript">
        $(function() {
            $('.btn-delete').click(function() {
                if (confirm('리뷰를 삭제하시겠습니까?')) {
                    let rno = $(this).attr('data-href');
                    location.href = "../mypage/mypage_review_delete.do?rno="+rno;
                }
            });
        });
    </script>
</head>
<body>
    <div class="myreserve">
        <div class="sixth"> 
            <h1>나의 리뷰 내역</h1>
        </div>
        <p class="titbox">
            내가 쓴 총 <span id="count">${myrSize}</span>개의 리뷰가 있습니다
        </p>
        <p>*리뷰 내용을 누르면 상세 페이지로 이동합니다*</p>

        <table>
            <thead>
                <tr id="rcate">
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>리뷰</th>
                    <th>날짜</th>
                    <th>평점</th>
                    <th></th>
                </tr>
            </thead>
            <tbody class="rList">
                <c:forEach var="review" items="${myrList}">
                    <tr id="myr">
                        <td>${review.num}</td>
                        <td>
                            <c:choose>
                                <c:when test="${review.cate == 1}">웨딩홀</c:when>
                                <c:when test="${review.cate == 2}">드레스</c:when>
                                <c:when test="${review.cate == 3}">예복</c:when>
                                <c:when test="${review.cate == 4}">스튜디오</c:when>
                                <c:when test="${review.cate == 5}">헤어/메이크업</c:when>
                                <c:when test="${review.cate == 6}">혼수</c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </td>
                        <td id="rmsg" style="text-align: left;">
                        	<c:choose>
	                        	<c:when test="${review.cate==1 }"><a href="../hall/detail.do?hno=${review.pno }">${review.msg}</a></c:when>
	                        	<c:when test="${review.cate==2 }"><a href="../dress/dress_detail.do?d_no=${review.pno }">${review.msg}</a></c:when>
	                        	<c:when test="${review.cate==3 }"><a href="../dress/suit_detail.do?su_no=${review.pno }">${review.msg}</a></c:when>
	                        	<c:when test="${review.cate==4 }"><a href="../studio/studio_detail.do?sno=${review.pno }">${review.msg}</a></c:when>
	                        	<c:when test="${review.cate==5 }"><a href="../studio/hairmakeup_detail.do?mno=${review.pno }">${review.msg}</a></c:when>
	                        	<c:when test="${review.cate==6 }"><a href="../goods/detail.do?mgno=${review.pno }">${review.msg}</a></c:when>
                        	</c:choose>
                        	
                        </td>
                        <td class="date-info">${review.dbday}</td>
                        <td>${review.score}</td>
                        <td>
                            <button class="btn-delete" data-href="${review.review_no}">삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
		
        <!-- Pagination -->
        <div class="pagination">
                <a href="../mypage/mypage_review.do?page=${curpage-1}">이전</a>
						${curpage } page / ${totalpage } pages
                <a href="../mypage/mypage_review.do?page=${curpage+1}">다음</a>
        </div>
    </div>
</body>
</html>
