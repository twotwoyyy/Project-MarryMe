<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="apple-touch-icon" sizes="57x57" href="../img/favicon.ico/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="../img/favicon.ico/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="../img/favicon.ico/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="../img/favicon.ico/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="../img/favicon.ico/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="../img/favicon.ico/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="../img/favicon.ico/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="../img/favicon.ico/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="../img/favicon.ico/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="./img/favicon.ico/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="../img/favicon.ico/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="../img/favicon.ico/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="../img/favicon.ico/favicon-16x16.png">
<link rel="manifest" href="../img/favicon.ico/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script defer src="../js/main.js"></script>
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/member_find.css">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){
	$('#member_find form').submit(function(e){
		$('input[name="phone"]').each(function(){
			if(isNaN($(this).val())){
				e.preventDefault()
				alert('휴대폰번호는 숫자만 입력해주세요')
				$(this).val("");
				$(this).focus();
			}			
		})
	})
})
</script>
</head>
<body>
	<div id="member_find">
        <div class="tt_box">
            <a href="../main/main.do">
                <img src="../img/logo.png" alt="project marry me">
                <h1>Project Marry Me</h1> 
            </a>
        </div>
        <div id="find_container">
        	<ul class="tab">
        		<li data-tab="find_id" ${type.equals("id")?"class=active":""}>아이디 찾기</li>
        		<li data-tab="find_pw" ${type.equals("pw")?"class=active":""}>비밀번호 찾기</li>
        	</ul>
        	<div class="form_wrapper">
	        	<div class='find_box ${type.equals("id")?"active":""}'  id="find_id">
	        		<form method="POST" action="../member/member_id_find.do" class="acco">
		        		<p>이메일로 찾기</p>
	        			<div>
	        				<label for="id_email_name">이름</label>
	        				<input type="text" name="name" id="id_email_name"required  placeholder="이름을 입력해 주세요">
	        			</div>
	        			<div>
	        				<label for="id_email_email">이메일</label>
	        				<input type="email" name="email" id="id_email_email" required placeholder="이메일을 입력해 주세요">
	        			</div>
	        			<button>찾기</button>
	        		</form>
	        		<form method="POST" action="../member/member_id_find.do" class="acco">
	        			<p>휴대폰 번호로 찾기</p>
	        			<div>
	        				<label for="id_phone_name">이름</label>
	        				<input type="text" name="name" id="id_phone_name" required placeholder="이름을 입력해 주세요">
	        			</div>
	        			<div>
	        				<label for="id_phone_phone">휴대폰번호</label>
	        				<input type="text" name="phone" id="id_phone_phone" required placeholder="휴대폰번호를 숫자만 입력해 주세요">
	        			</div>
	        			<button>찾기</button>
	        		</form>
	        	</div>
	        	<div class='find_box ${type.equals("pw")?"active":""}' id="find_pw">
	        		<form method="POST" action="../member/member_pw_find.do" class="acco">
		        		<p>이메일로 찾기</p>
		        		<div>
	        				<label for="pw_email_id">아이디</label>
	        				<input type="text" name="id" id="pw_email_id" required placeholder="아이디를 입력해 주세요">
	        			</div>
	        			<div>
	        				<label for="pw_email_name">이름</label>
	        				<input type="text" name="name" id="pw_email_name" required placeholder="이름을 입력해 주세요">
	        			</div>
	        			<div>
	        				<label for="pw_email_email">이메일</label>
	        				<input type="email" name="email" id="pw_email_email"required  placeholder="이메일을 입력해 주세요">
	        			</div>
	        			<button>찾기</button>
	        		</form>
	        		<form method="POST" action="../member/member_pw_find.do" class="acco">
	        			<p>휴대폰 번호로 찾기</p>
	        			<div>
	        				<label for="pw_phone_name">아이디</label>
	        				<input type="text" name="id" id="pw_phone_name" required placeholder="아이디를 입력해 주세요">
	        			</div>
	        			<div>
	        				<label for="pw_phone_name">이름</label>
	        				<input type="text" name="name" id="pw_phone_name" required placeholder="이름을 입력해 주세요">
	        			</div>
	        			<div>
	        				<label for="pw_phone_phone">휴대폰번호</label>
	        				<input type="text" name="phone" id="pw_phone_phone" required placeholder="휴대폰번호를 숫자만 입력해 주세요">
	        			</div>
	        			<button>찾기</button>
	        		</form>
	        	</div>        	
        	</div>
        </div>
    </div>
    <jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>