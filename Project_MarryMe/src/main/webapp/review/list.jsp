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
.rating .star.active {
    fill: #0b3a1e; /* 선택된 색상 */
}

.rating2 .star2 {
    cursor: pointer;
    fill: #bbbbbb; /* 기본 색상 */
}
.rating2 .star2.active {
    fill: #0b3a1e; /* 선택된 색상 */
}
.Btn{
	color: #303A1F;
	border: 1px solid #303A1F;
}
.Btn:hover{
	background:#303A1F;
    color:#dcdcdc;
    cursor: pointer;
}
.reviewList .start_btn{
	display:flex;
	justify-content:space-between;
}
.reviewList .start_btn div:last-child{
	display:flex;
	gap:5px;
}
#rplupdate .detail_update {
    padding-bottom:20px;
    margin-bottom:20px;
    height:auto;
    opacity:1;
    overflow:hidden;
    visibility:visible;
}
.detail_update > label:first-child{
    font-weight:500;
    margin-bottom:5px;
}
.detail_update textarea{
    width:100%;
    height:100px;
    resize:none;
    font-size:14px;
    line-height:1.5em;
    margin-bottom:5px;
    box-sizing:border-box;
}
.detail_update input[type="file"]{
    font-size:14px;
}
.detail_update input[type="button"]{
	
    height:30px;
    background:#303A1F;
    color:#dcdcdc;
}
.detail_update input[type="button"]:hover{
	
    
    background:#dcdcdc;
    color:#303A1F;
    cursor:pointer;
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
	
	$('.rating .star').on('click', function(){
	    // 클릭된 별의 인덱스를 가져옵니다.
	        let index = $(this).data('index');
	        score=index
	        // 모든 별에 대해 색상을 업데이트합니다.
	        $('.rating .star').each(function() {
	            let starIndex = $(this).data('index');
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
		formData.append("upload", $('#review_photo')[0].files[0]);

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
	// 페이징
	$(document).on('click', '.pageinfo', function() {
        page = $(this).data('page');
   //     console.log(page); //
        replyList(pno, page, cate); // 클릭한 페이지로 갱신
    });
	// 수정쪽 스코어
	 $(document).on('click','.rating2 .star2',function(){ // DOM을 한번 업데이트 하고 실행 on : 클릭 시점의 문서를 읽어들임
		    // 클릭된 별의 인덱스를 가져옵니다.
	     let index = $(this).data('index');
	     score=index
	     // 모든 별에 대해 색상을 업데이트합니다.
	     $('.rating2 .star2').each(function() {
	         let starIndex = $(this).data('index');
	         if (starIndex <= index) {
	             $(this).addClass('active');
	     	}else{
	        		$(this).removeClass('active');
	     	}
			});
	});
	// 수정
	$(document).on('click','.replyUpdate',function(){
		let rno=$(this).data('rno')
		
		page=$('#curpage').data('page')
		let img=$('#rImg'+rno).val()
		let msg=$('#review_content'+rno).val()
		if(msg.trim()==="")
		 {
			 $('#review_content'+rno).focus()
			 return
		 }
		
		
		var formData = new FormData();
		
		formData.append("msg", msg);
		formData.append("rno", rno);
		formData.append("upload", $('#review_photo'+rno)[0].files[0]);
		if(img!==null){
			formData.append("img",img);
		}
		formData.append("score", score);
		
		$.ajax({
			
			url: '../review/update.do',
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
					 
					 cancle(rno)
					 replyList(pno,page,cate)
					 
				 }
				
			},
			error:function(request,status,error)
			{
				 console.log(error)
			}
			
			 
		})

	}) 
	//삭제
	$(document).on('click','.replyDelete',function(){
		let rno=$(this).data('rno');
		
		$.ajax({
			url:"../review/delete.do",
			data:{"rno":rno},
			type:"post",
			success:function(result){
				 
				 if(result==='OK')
				 {
					 replyList(pno,page,cate)
				 }else{
					 alert('잘못된 입력입니다')
				 }
			},
			error:function(request,status,error)
			{
				 console.log(error)
			}

		})
	})
})


function replyUpdateData(rno){
	$('.detail_input').removeClass('active');
	$('.board_top button').prop('disabled', true)
	$('.detail_update').hide()
	$('#m'+rno).show()
}
function cancle(rno){
	$('#m'+rno).hide()
	$('.board_top button').prop('disabled', false)
}

function replyList(pno,page,cate)
{
	 $.ajax({
		 type:'post',
		 url:'../review/review_list.do',
		 data:{"pno":pno,"page":page,"cate":cate},
		 success:function(json)
		 {
			
			 json=JSON.parse(json)
			//console.log(json)
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
         	 html+='<div class="start_btn">'
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
				if(reply.id===reply.sessionId){
					html+='<div>'
					html+='<input type="button" value="수정" class="Btn" onclick="replyUpdateData('+reply.rno+')">'
		            html+='<input type="button" value="삭제" class="Btn replyDelete" data-rno="'+reply.rno+'">'
		            html+='</div>'
				}
		     html+='</div>'
             html+='<div class="content_text">'//내용
                 html+='<pre>'+reply.msg+'</pre>'
             html+='</div>'
            if(reply.img!=="NOIMAGE" || reply.img!=null){
            	html+='<div class="img_box">'//이미지
                html+='<img src="../img/review_img/'+reply.img+'" alt="">'
            	html+='</div>'	
            }else{
            	html+='<div class="img_box">'//이미지
                html+='<img src="../img/no_image.png" alt="">'
               	html+='</div>'	
            }
          //http://localhost/Project_MarryMe/img/review_img/
         html+='</div>'
         html+='<div>'
         html+= '<div class="detail_update" style="display: none" id="m'+reply.rno+'">'
         html+= '<label for="review_content"></label>'
         html+=       '<textarea name="review_content" style="margin-top:5px;" id="review_content'+reply.rno+'">'+reply.msg+'</textarea>'
         html+=         '<label for="review_photo" class="hidden">파일업로드</label>'
         html+=         '<input type="file" id="review_photo'+reply.rno+'">'
		 html+='<div class="rating2">'
	 	 html+=	         '<svg data-index="1" class="star2" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" >'
		 html+= '<path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" />'
	     html+= '</svg>'
	     html+=   '<svg data-index="2" class="star2" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" >'
		 html+=       '<path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" />'
		 html+=   '</svg>'
		 html+=    '<svg data-index="3" class="star2" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" >'
		 html+=         '<path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" />'
		 html+=     '</svg>'
		 html+=     '<svg data-index="4" class="star2" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" >'
		 html+=         '<path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" />'
		 html+=     '</svg>'
		 html+=     '<svg data-index="5" class="star2" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" >'
		 html+=        '<path d="M7.157 6.698l2.165-4.59a.743.743 0 0 1 1.358 0l2.165 4.59 4.84.74c.622.096.87.895.42 1.353l-3.503 3.57.827 5.044c.106.647-.544 1.141-1.1.835l-4.328-2.382-4.329 2.382c-.556.306-1.205-.188-1.099-.835l.826-5.044-3.502-3.57c-.45-.458-.202-1.257.42-1.352l4.84-.74z" />'
		 html+=     '</svg>'
		 html+= 	'</div>'
		 html+=		'<div class="button">'
         html+=         '<input type="button" value="수정완료" class="replyUpdate" data-rno="'+reply.rno+'">'
         html+=         '<input type="button" style="margin-left:5px;" value="취소" onclick="cancle('+reply.rno+')">'
         html+=		'</div>'
       	 html+='<input type="hidden" value="'+reply.img+'" id="rImg'+reply.rno+'">'    
         html+=  '</div>'
         html+='</div>'
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
			$('#reviewPage').html(html2)	
			json.map(function(count){
				let review_count=count.total;
				console.log(review_count)
		   	 	$('.detail_tab a[href="#review"]').text('후기('+review_count+')')		
			})
		}
		,
		error:function(request,status,error)
		{
		   console.log(error)
		}
	 })
}

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
   <ul class="page" id="reviewPage">
   <!-- 페이징 -->
   </ul>
</div>
</body>
</html>