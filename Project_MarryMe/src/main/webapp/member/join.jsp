<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="../css/join.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	let id;
	$('.id_check_btn').click(function(){
		id=$('#id_input').val();
		if(id.trim()===""){
			$('#id_input').focus();
			return;
		}
		$.ajax({
			type:'POST',
			url:'../member/idcheck_ok.do',
			data:{"id":id},
			success:function(result){
				let count=Number(result.trim());
				if(count===0){
					$('#idcheck_box .confirm_id').css({'display':'inline'});
					$('#idcheck_box .is_id').text(id+'는(은) 사용가능한 아이디입니다');
					$('#idcheck_box .is_id').css({'color':'#303030'})
				}else{
					$('#idcheck_box .confirm_id').css({'display':'none'});
					$('#idcheck_box .is_id').text(id+'는(은) 이미 사용중인 아이디입니다');
					$('#idcheck_box .is_id').css({'color':'#e02f2f'})
				}
			},
			error:function(request, status, error){
				console.log(error);
			}
		})
	})
	$('#idcheck_box .confirm_id').click(function(){
		$('.join_wrap #id').val(id);
		$('#idcheck_box').removeClass('active');
		$('body').removeClass('active');
	})
	$('.post_search').click(function(){
	  	new daum.Postcode({
	        oncomplete: function(data) {
	            $('input#post').val(data.zonecode);
	            $('input#address1').val(data.address);
	        }
	    }).open();		
	})
	$('#join #join_form').submit(function(e){
		if($('#id').val()==""){
			e.preventDefault()
			alert("아이디 중복체크 버튼을 눌러 아이디 입력을 해주세요")
		}
		if($('#pw').val() != $('#pw_check').val()){
			e.preventDefault()
			alert('비밀번호를 확인해주세요')
		}
		if(isNaN($('#phone').val())){
			e.preventDefault()
			alert('휴대폰번호는 숫자만 입력해주세요')
			$('#phone').focus();
		}
		if($('#post').val()==""){
			e.preventDefault()
			alert("우편번호 검색 버튼을 눌러 주소입력을 해주세요")
		}
	})
	if($('#wedding_date').val()==""){
		let today=new Date().toLocaleDateString('ko-KR',{
			year:'numeric',
			month:'2-digit',
			day:'2-digit'
		}).replace(/\./g, '').replace(/\s/g, '-');
		$('#wedding_date').val(today);
	}
})
</script>
</head>
<body>
	<div id="join">
        <div class="tt_box">
            <h2>회원가입</h2>
        </div>
        <section class="join_wrap">
            <p><span>*</span> 필수입력사항</p>
            <form method="POST" action="../member/join_ok.do" id="join_form">
                <div class="center">
                    <div class="hasBtn">
                        <div class="input_wrap">
                            <label for="id">아이디<span>*</span></label>
                            <input type="text" id="id" name="id" placeholder="아이디 중복체크 버튼을 눌러주세요" required readonly>
                        </div>
                        <input type="button" class="idCheck" value="아이디 중복체크">
                    </div>
                    <div class="input_wrap">
                        <label for="pw">비밀번호<span>*</span></label>
                        <input type="password" id="pw" name="pw" placeholder="비밀번호를 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <label for="pw_check">비밀번호확인<span>*</span></label>
                        <input type="password" id="pw_check" placeholder="비밀번호를 한번 더 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <label for="name">이름<span>*</span></label>
                        <input type="text" id="name" name="name" placeholder="이름을 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <label for="phone">휴대폰<span>*</span></label>
                        <input type="tel" id="phone" name="phone" placeholder="숫자만 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <label for="id">이메일</label>
                        <div>
                            <input type="text" id="email" name="email" placeholder="ex&#41; marryme" required>@
                            <select name="email_domain">
                                <option value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="kakao.com">kakao.com</option>
                                <option value="daum.net">daum.net</option>
                                <option value="hotmail.com">hotmail.com</option>
                                <option value="yahoo.co.kr">yahoo.co.kr</option>
                            </select>
                        </div>
                    </div>
                    <div class="hasBtn">
                        <div class="input_wrap">
                            <label for="post">우편번호<span>*</span></label>
                            <input type="text" id="post" name="post" placeholder="검색버튼을 눌러주세요" required readonly>
                        </div>
                        <input type="button" class="post_search" value="우편번호 검색">
                    </div>
                    <div class="input_wrap">
                        <label for="address1">기본주소<span>*</span></label>
                        <input type="text" id="address1" name="address1" readonly>
                    </div>
                    <div class="input_wrap">
                        <label for="address2">상세주소</label>
                        <input type="text" id="address2" name="address2">
                    </div>
                    <div class="input_wrap">
                        <p class="label">성별</p>
                        <div class="radios">
                            <div class="radio_btn">
                                <label for="man">신랑</label>
                                <input type="radio" id="man" name="gender" value="신랑">
                            </div>
                            <div class="radio_btn">
                                <label for="woman">신부</label>
                                <input type="radio" id="woman" name="gender" value="신부">
                            </div>
                            <div class="radio_btn">
                                <label for="not">선택안함</label>
                                <input type="radio" id="not" name="gender" value="선택안함" checked>
                            </div>
                        </div>
                    </div>
                    <div class="input_wrap">
                        <label for="wedding_date">결혼예정일</label>
                        <input type="text" id="wedding_date" name="wedding_date">
                    </div>
                    <div class="form_btns">
                        <button class="join_btn">회원가입</button>
                        <button onclick="javascript:history.back()">취소</button>
                    </div>
                </div>
            </form>
        </section>
    </div>
    <aside id="idcheck_box">
    	<h3>아이디 중복체크</h3>
    	<div class="form">
   			<label for="id_input">ID</label>
   			<input type="text" name="id_input" id="id_input">
   			<button class="id_check_btn">중복확인</button>
   		</div>
    	<p class="is_id"></p>
    	<button class="confirm_id">확인</button>
    	<button class="close">X</button>
    </aside>
</body>
</html>