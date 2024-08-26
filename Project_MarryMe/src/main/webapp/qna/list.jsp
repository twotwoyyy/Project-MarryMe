<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.pageinfoQna:hover{
	
	cursor: pointer;
	background-color: #303A1F;
	color: #dcdcdc
}
.pageinfoQna{
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
</style>
<script type="text/javascript">
$(function(){
	let pno=$('#postNo').val()
	console.log('pno:'+pno)
	let cate=$('#rCate').val()
	console.log('cate:'+cate)
	let page=1
	qnaList(pno,page,cate)
	
	$('#qnaBtn').on('click',function(){
		let msg=$('#qna_content').val()
		if(msg.trim()==="")
		{
			 $('#qna_content').focus()
			 return
		}
		let pwd=$('#qna_pw').val()
		if(pwd.trim()==="")
		{
			 $('#qna_pw').focus()
			 return
		}
		$.ajax({
			type:'post',
   			url:'../qna/userInsert.do',
   			data:{"msg":msg,"pwd":pwd,"pno":pno,"cate":cate,"tab":0},
   			success:function(result){
   				if(result==="OK"){
   					$('#qna_detail').removeClass('active');
   					qnaList(pno,page,cate)
   				}
   				else{
   					alert('잘못된 입력입니다')
   				}
   			}
		})
			
	})
	
    $(document).on('click','.bimil',function(){
    	let qno=$(this).data('qno');
    	console.log('qno:'+qno)
        let pwbox=$('#write_pw'+qno);
    	if($('#qnaOpen'+qno).hasClass('active')){
    		$('#qnaOpen'+qno).removeClass('active')
    	}else{
	        if(pwbox.hasClass('active')){
	            pwbox.removeClass('active');    
	        }else{
	            $('#qna .qna_list .write_pw').removeClass('active');
	            pwbox.addClass('active');
	        }
    	}
    })
    $(document).on('click','.pwd',function(){
    	let qno=$(this).data('qno');
    	let pwd=$('#review_pw2'+qno).val()
    	$.ajax({
    		type:'post',
   			url:'../qna/password.do',
   			data:{"qno":qno,"pwd":pwd},
   			success:function(result){
   				if(result==="OK"){
   					$('#write_pw'+qno).removeClass('active');
   					$('#qnaOpen'+qno).addClass('active');
   				}
   				else{
   					alert('비밀번호가 틀렸어요~')
   				}
   			}
    	})
    })
    $(document).on('click', '.pageinfoQna', function() {
        page = $(this).data('page');
   //     console.log(page); //
        qnaList(pno, page, cate); // 클릭한 페이지로 갱신
    });
    
})
function qnaList(pno,page,cate)
{
	 $.ajax({
		 type:'post',
		 url:'../qna/list.do',
		 data:{"pno":pno,"page":page,"cate":cate},
		 success:function(json)
		 {
			
			 json=JSON.parse(json)
			 console.log(json)
			 let html=''
			 
			 if(json.length === 0){
				 html+='<li><h3>작성된 문의가 없습니다</h3></li>'
			 }
			 
			 json.map(function(qna){
					 html+='<li>'
				        html+='<div class="close">'
		                     html+='<p class="number">'+qna.qno+'</p>'
		                     html+='<div class="subject">'
		                     	if(qna.tab===1){
		                     	 html+='<span class="reply">RE</span>'
		                     	}
		                         html+='<img src="../img/qna_lock.gif" alt="">'
		                         html+='<p class="bimil" data-qno="'+qna.qno+'">비밀글입니다</p>'
		                     html+='</div>'
		                     if(qna.id===qna.sessionId){
		                    	html+='<div>'
		                    	html+='<input type="button" value="수정" class="Btn" onclick="replyUpdateData('+qna.qno+')">'
		     		            html+='<input type="button" value="삭제" class="Btn replyDelete" data-rno="'+qna.qno+'">'
		     		            html+='</div>'
		                     }
		                     html+='<p class="writer">'+qna.name+'</p>'
		                     html+='<p class="regdate">'+qna.dbday+'<br>'+qna.dayDetail+'</p>'
		                 html+='</div>'
		                 html+='<div class="write_pw" id="write_pw'+qna.qno+'">'
		                         html+='<label for="review_pw2"></label>'
		                         html+='<input type="password" id="review_pw2'+qna.qno+'" name="review_pw" class="review_pw_input">'
		                         html+='<button class="pwd" id="pwd'+qna.qno+'"data-qno="'+qna.qno+'">확인</button>'
		                 html+='</div>'
		                 html+='<div class="open" id="qnaOpen'+qna.qno+'">'
		                     html+='<pre>'+qna.msg+'</pre>'
		                 html+='</div>'
		             html+='</li>'
			 })
		 		$('.qna_list').html(html)
		 
			 let html2=''
			 
			 json.map(function(page){
				if(page.startpage>1){
					html2+='<li><input type="button" class="pageinfoQna" value="&lt;" data-page="'+(page.startpage-1)+'"></li>'
				}
	          	for(i=page.startpage;i<=page.endpage;i++){
				  	if(page.curpage===i){
	          		  html2+='<li><input type="button" value='+i+' class="pageinfoQna" id="curpage" data-page='+i+'></li>'
					}
					else{
					  html2+='<li><input type="button" value='+i+' class="pageinfoQna" data-page='+i+'></li>'
					}
	        	}
	          	if(page.endpage<page.totalpage){
	   	        	html2+='<li><input type="button" class="pageinfoQna" value="&gt;" data-page="'+(page.endpage+1)+'"></li>'
	          	}
			})
		//	console.log(html2)
			$('#qnaPage').html(html2)	
		},
		error:function(request,status,error)
		{
		   console.log(error)
		}
	 })
}
</script>
</head>
<body>
<div id="qna">
  <div class="board_top">
       <h3>문의</h3>
       <c:if test="${sessionScope.id!=null }">
         <c:if test="${sessionScope.admin=='n' }">
	   	    <button>문의 작성</button>
   	     </c:if>
   	   </c:if>
   </div>
   <div class="detail_input" id="qna_detail">
       <label for="qna_content">문의를 작성해주세요</label>
       <textarea name="qna_content" id="qna_content"></textarea>
       <div>
           <div class="qna_pwbox">
               <label for="qna_pw">비밀번호</label>
               <input type="password" id="qna_pw">
           </div>
           <input type="button" value="작성완료" id="qnaBtn">
       </div>
   </div>
   <ul class="qna_list">
       
   </ul>
   <ul class="page" id="qnaPage">
   
   </ul>    
</div>
</body>
</html>