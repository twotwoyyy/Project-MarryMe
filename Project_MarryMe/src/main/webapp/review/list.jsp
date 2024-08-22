<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#curpage{
	background-color: #303A1F;
	color: #dcdcdc
}
.pageinfo:hover{
	
	cursor: pointer;
	background-color: #303A1F;
	color: #dcdcdc
}
.pageinfo{
	margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
	display:block;
    width:24px;
    height:24px;
    line-height:24px;
    text-align:center;
    transition:.3s;
}
.rating {
    display: flex;
}

.rating .star {
    cursor: pointer;
    fill: #bbbbbb; /* 기본 색상 */
}

.star.active {
    fill: #0b3a1e; /* 선택된 색상 */
}
</style>
<script type="text/javascript">
$(function(){
	let pno=$('#postNo').val()
	console.log('pno:'+pno)
	let cate=$('#rCate').val()
	console.log('cate:'+cate)
	let page=1
	replyList(pno,page,cate)
	//paging(pno,page,cate)
	let score=0;
	
	$('.star').on('click', function(){
	    // 클릭된 별의 인덱스를 가져옵니다.
	        var index = $(this).data('index');
	        score=index
	        // 모든 별에 대해 색상을 업데이트합니다.
	        $('.star').each(function() {
	            var starIndex = $(this).data('index');
	            if (starIndex <= index) {
	                $(this).addClass('active');
	        	}else{
	           		$(this).removeClass('active');
	        	}
	   		});
	});
	
	  $('#reviewBtn').on('click',function(){
		 let msg=$('#review_content').val()
		 if(msg.trim()==="")
		 {
			 $('#review_content').focus()
			 return
		 }
		
		
		var formData = new FormData();
		
		formData.append("msg", msg);
		formData.append("pno", pno);
		formData.append("cate", cate);
		formData.append("upload", $('input[type="file"]')[0].files[0]);

		formData.append("score", score);
		
		$.ajax({
			
			url: '../review/insert.do',
			enctype: 'multipart/form-data',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			success : function(result){
				
				 let res = JSON.parse(result);
				 console.log(res)
				 if(res.result==='OK')
				 {
					 
					 $('.detail_input').removeClass('active');
					 page=1
					 replyList(pno,page,cate)
					 
				 }
				
			},
			error:function(request,status,error)
			{
				 console.log(error)
			}
			
			 
		}) //$.ajax
		
	}) 
	
	$(document).on('click', '.pageinfo', function() {
        let page = $(this).data('page');
   //     console.log(page); //
        replyList(pno, page, cate); // 클릭한 페이지로 갱신
    });
	
	
})

function replyList(pno,page,cate)
{
	 $.ajax({
		 type:'post',
		 url:'../review/review_list.do',
		 data:{"pno":pno,"page":page,"cate":cate},
		 success:function(json)
		 {
			
			 json=JSON.parse(json)
			// console.log(json)
			 let html=''
			 
			 if(json.length === 0){
				 html+='<li><h3>작성된 리뷰가 없습니다</h3></li>'
			 }
			 
			 json.map(function(reply){
				html+='<li class="reviewList">'
				 html+='<div class="top">'
                     html+='<div class="profile">'
                 html+='<img src="../img/profile_img.png" alt="">'
                 html+='<p class="name">'+reply.name+'</p>'//이름
             html+='</div>'
             html+='<p>'+reply.dbday+'</p>'//날짜
         html+='</div>'
         html+='<div class="content">'
             html+='<div class="star">'//별점
             		for(let i=0;i<reply.score;i++){
                 		html+='<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star active">'
                     	html+='<defs>'
                        html+='<path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>'
                   		html+='</defs>'
                   		html+='<use xlink:href="#star-full"></use>'
                 		html+='</svg>'
						}
					for(let i=0;i<(5-reply.score);i++){
             			html+='<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20" height="20" viewBox="0 0 20 20" class="crema_product_reviews_score_star_wrapper__star">'
                 		html+='<defs>'
                 	    html+='<path id="star-full" d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z"></path>'
               			html+='</defs>'
               			html+='<use xlink:href="#star-full"></use>'
             			html+='</svg>'
					}
             html+='</div>'
             html+='<div class="content_text">'//내용
                 html+='<pre>'+reply.msg+'</pre>'
             html+='</div>'
            if(reply.img!==null){
            	html+='<div class="img_box">'//이미지
                html+='<img src="http://localhost/Project_MarryMe/img/review_img/'+reply.img+'" alt="">'
            	html+='</div>'	
            }
         html+='</div>'
         html+= '<div class="detail_input" style="display: none" id="m'+reply.rno+'">'
         html+= '<label for="review_content">후기를 작성해주세요</label>'
         html+=       '<textarea name="review_content" id="review_content">'+reply.msg+'</textarea>'
         html+=         '<label for="review_photo" class="hidden">파일업로드</label>'
         html+=         '<input type="file" id="review_photo">'
         html+=         '<input type="button" value="작성완료" id="reviewBtn">'
         html+=        '<input type="hidden" value="'+reply.pno+'" id="postNo">'
         html+=     '<input type="hidden" value="'+reply.id+'" id="rId">'
         html+=     '<input type="hidden" value="'+reply.cate+'" id="rCate">'
         html+=  '</div>'
         html+='</li>'
		 })
	//	 console.log(html)
		 $('.review_list').html(html)
		 
		 let html2=''
		 
		 json.map(function(page){
			if(page.startpage>1){
				html2+='<li><input type="button" class="pageinfo" value="&lt;" data-page="'+(page.startpage-1)+'"></li>'
			}
          	for(i=page.startpage;i<=page.endpage;i++){
			  	if(page.curpage===i){
          		  html2+='<li><input type="button" value='+i+' class="pageinfo" id="curpage" data-page='+i+'></li>'
				}
				else{
				  html2+='<li><input type="button" value='+i+' class="pageinfo" data-page='+i+'></li>'
				}
        	}
          	if(page.endpage<page.totalpage){
   	        	html2+='<li><input type="button" class="pageinfo" value="&gt;" data-page="'+(page.endpage+1)+'"></li>'
          	}
		})
	//	console.log(html2)
		$('ul.page:first').html(html2)	
		},
		error:function(request,status,error)
		{
		   console.log(error)
		}
	 })
}
document.addEventListener('DOMContentLoaded', function () {
    // 파일 입력 요소들을 가져옵니다.
    const fileInputs = Array.from(document.querySelectorAll('input[type="file"]'));
    
    fileInputs.forEach((input, index) => {
        input.addEventListener('change', function () {
            // 파일이 선택되면 다음 파일 입력 요소를 표시합니다.
             if (input.files.length > 0) {
                  // 다음 파일 입력 필드와 레이블을 표시합니다.
                  if (index < fileInputs.length - 1) {
                      fileInputs[index + 1].classList.remove('hidden');
                      
                  }
             }
             // 만약 선택을 해제한다면
             if (input.files.length === 0) {
                 // 다음 파일 입력 필드와 레이블을 표시합니다.
                 if (index < fileInputs.length - 1) {
                     fileInputs[index + 1].classList.add('hidden');
                     
                 }
            }
        });
    });
});  
</script>
</head>
<body>
<div id="review">
   <div class="board_top">
   	 <h3>후기</h3>
   	 <c:if test="${sessionScope.id!=null }">
  	 	<button>후기 작성</button>
  	 </c:if>
   </div>
   <div class="detail_input">
     <label for="review_content">리뷰를 작성해주세요</label>
     <textarea name="review_content" id="review_content"></textarea>
     <label for="review_photo" class="hidden" >파일업로드</label>
     <input type="file" id="review_photo" name="upload">
      <div class="rating">
    <svg data-index="1" class="star" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
        <path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" />
    </svg>
    <svg data-index="2" class="star" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
        <path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" />
    </svg>
    <svg data-index="3" class="star" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
        <path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" />
    </svg>
    <svg data-index="4" class="star" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
        <path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" />
    </svg>
    <svg data-index="5" class="star" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">
        <path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" />
    </svg>
	</div>
     <input type="button" value="작성완료" id="reviewBtn">
   </div>
   <ul class="review_list">
   <!-- 리뷰출력 -->
   </ul>
   <ul class="page">
   <!-- 페이징 -->
   </ul>
</div>
</body>
</html>