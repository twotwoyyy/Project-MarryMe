<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
<div class="wrapper row3">
  <main class="container clear">
   <h2 class="sectiontitle">상세보기</h2>
   <table class="table">
    <tr>
     <td width="30%" class="text-center" rowspan="5">
       <img src="${vo.dress_image }" style="width: 100%">
     </td>
     <td colspan="2">
       <h4 id="h3">${vo.dress_subject }</h4>
     </td>
    </tr>
   </table>
  </main>
</div>
</body>
</html>