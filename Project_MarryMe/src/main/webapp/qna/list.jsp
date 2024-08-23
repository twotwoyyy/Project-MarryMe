<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	let pno=$('#postNo').val()
	console.log('pno:'+pno)
	let cate=$('#rCate').val()
	console.log('cate:'+cate)
	let page=1
	qnaList(pno,page,cate)
	
	
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
   			data:{"qno":qno,"pwd":pwd,},
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
       <button>문의 작성</button>
   </div>
   <div class="detail_input">
       <label for="qna_content">문의를 작성해주세요</label>
       <textarea name="qna_content" id="qna_content"></textarea>
       <div>
           <div class="qna_pwbox">
               <label for="qna_pw">비밀번호</label>
               <input type="password" id="qna_pw">
           </div>
           <input type="button" value="작성완료">
       </div>
   </div>
   <ul class="qna_list">
       
   </ul>
   <ul class="page" id="qnaPage">
   
   </ul>    
</div>
</body>
</html>