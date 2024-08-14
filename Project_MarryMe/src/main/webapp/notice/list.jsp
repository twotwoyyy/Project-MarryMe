<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="list">
<section class="list_sc" >
	<div class="row1">
    <table class="table">
     <tr>
      <td>
       <a href="../databoard/insert.do" class="btn btn-sm btn-primary">새글</a>
      </td>
     </tr>
    </table>
    <table class="table">
     <tr>
      <th width=10% class="text-center">번호</th>
      <th width=55% class="text-center">제목</th>
      <th width=10% class="text-center">이름</th>
      <th width=15% class="text-center">작성일</th>
      <th width=10% class="text-center">조회수</th>
     </tr>
     <c:set var="count" value="${count }"/>
     <c:forEach var="vo" items="${list }">
       <tr>
	      <td width=10% class="text-center">${count }</td>
	      <td width=55%>
	      <a href="../databoard/detail.do?no=${vo.notice_no }">${vo.subject }</a>
	      &nbsp;
	      <c:if test="${today==vo.dbday }">
	        <sup><img src="../databoard/new.gif"></sup>
	      </c:if>
	      </td>
	      <td width=10% class="text-center">${vo.name }</td>
	      <td width=15% class="text-center">${vo.dbday }</td>
	      <td width=10% class="text-center">${vo.hit }</td>
	     </tr>
	     <c:set var="count" value="${count-1 }"/>
     </c:forEach>
    </table>
    <table class="table">
     <tr>
      <td class="text-left inline">
      <form method="post" action="../databoard/find.do">
       <input type="checkbox" value="N" name="fs">이름
       <input type="checkbox" value="S" name="fs">제목
       <input type="checkbox" value="C" name="fs">내용
       <!-- Search:<select name="fs>
       			
       			</select>
        -->
       <input type=text name=ss size=15 class="input-sm">
       <input type=submit value="검색" class="btn btn-sm btn-success">
       </form>
      </td>
      <td class="text-right">
       <a href="#" class="btn btn-sm btn-success">이전</a>
       ${curpage } page / ${totalpage } pages
       <a href="#" class="btn btn-sm btn-info">다음</a>
      </td>
     </tr>
    </table>
   </div>
 </section>
 </div>
</body>
</html>