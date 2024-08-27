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
	 <div id="list" class="goods">
	   <c:if test="${curpage==1}">
        <section class="list_banner">
            <h2>Marriage articles</h2>
        </section> 
       </c:if>
        <section class="list_sc">
            <ul class="cate_list">
                <li data-list="studio" ${cno==1?'class="active"':"" }><a href="../goods/list.do?cno=1">종합</a></li>
                <li data-list="studio" ${cno==3?'class="active"':"" }><a href="../goods/list.do?cno=3">가구</a></li>
                <li data-list="hair" ${cno==4?'class="active"':"" }><a href="../goods/list.do?cno=4">가전</a></li>
                <li data-list="hair" ${cno==5?'class="active"':"" }><a href="../goods/list.do?cno=5">청첩장</a></li>
            </ul>
            <ul class="brand_list container studio active">
            <c:set var="delay" value="0"></c:set>
              <c:forEach var="vo" items="${list }">
                <li data-aos="fade-up" data-aos-duration="1000" data-aos-delay="${delay }">
                    <a href="../goods/detail_before.do?cate=6&pno=${vo.mgno }">
                        <div class="img_wrap">
                            <img src="${vo.poster }" alt="">
                        </div>
                        <div class="text_box">
                            <p class="brand_name" >${vo.title }</p>
                            <p class="brand_sub">${vo.price }</p>
                        </div>
                    </a>
                </li>
              	<c:set var="delay" value="${(delay + 300) % 1200}"/>
              </c:forEach>          
            </ul>
            <ul class="page">
              <c:if test="${startpage>1 }">
                <li><a href="../goods/list.do?page=${startpage-1 }&cno=${cno}">&lt;</a></li>
              </c:if>
                <c:forEach var="i" begin="${startpage }" end="${endpage }">
             
                	<li ${i==curpage?"class=active":""}><a href="../goods/list.do?page=${i }&cno=${cno}" >${ i}</a></li>
            
                </c:forEach>
              <c:if test="${endpage<totalpage }">
                <li><a href="../goods/list.do?page=${endpage+1 }&cno=${cno}">&gt;</a></li>
              </c:if>
            </ul>
        </section>
        <section class="latest container">
            <h3>최근 본 목록</h3>
	            <div class="latest_slide">
				<c:forEach var="cvo" items="${cookieList}">
				    <div class="slides">
				        <a href="../goods/detail.do?pno=${cvo.mgno}">
				            <div class="img_wrap">
				                <img src="${cvo.poster }" alt="">
				            </div>
				            <div class="text_box">
				                <p class="brand_name">${cvo.title }</p>
				                <p class="brand_sub">${cvo.price }</p>
				            </div>
				        </a>
				    </div>
				</c:forEach>
	            </div>
        </section>
    </div>
</body>
</html>