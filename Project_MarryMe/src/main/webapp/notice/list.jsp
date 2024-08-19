<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">	
#list{
	padding: 200px 300px 200px 300px; 
}
.close{
	display:grid;
    grid-template-columns:10% 50% 20% 30%;
    text-align:center;
    align-items:center;
    gap:10px;
    font-size:14px;
}
.subject{
	display:flex;
    gap:5px;
    justify-content: start;
    align-items:center;
    cursor: pointer;
}
</style>
</head>
<body>
<div id="list">
	<div id="detail">
		<div id="qna">
			<div class="list_sc">
				<ul class="qna_list">
					<li>
                      <div class="close">
                        <p class="number">번호</p>
                     	<div class="subject">
                          <p style="margin: 0px auto;">제목</p>
                        </div>
                        <p class="writer">작성자</p>
                        <p class="regdate">작성일</p>
                      </div>
                      <div class="close">
                        <c:forEach var="vo" items="${list }">
                         <p>${vo.notice_no }</p>
                         <div>
                           <p>${vo.subject }</p>
                         </div>
                         <p>${vo.name }</p>
                         <p>${vo.dbday }</p>
                        </c:forEach>
                      </div>
                   </li>
			 	 </ul>
				 <ul class="page">
                   <li><a href="">&lt;</a></li>
                   <li class="active"><a href="#">1</a></li>
                   <li><a href="#">2</a></li>
                   <li><a href="#">10</a></li>
                   <li><a href="#">12</a></li>
                   <li><a href="#">5</a></li>
                   <li><a href="#">&gt;</a></li>
    	     	 </ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>