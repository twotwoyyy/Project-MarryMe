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

</script>
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
<style type="text/css">
#join{
   padding-top: 20px;
}
</style>
</head>
<body>
   <div id="join" class="mycontent">
        <div class="tt_box">
            <h2>비밀번호 변경</h2>
        </div>
        <section class="join_wrap">
            <p><span>*</span> 필수입력사항</p>
            <form method="POST" action="../member/pw_change_ok.do">
                <div class="center">
                    <div class="input_wrap">
                        <label for="pw">기존 비밀번호<span>*</span></label>
                        <input type="password" name="oldpw" placeholder="비밀번호를 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <label for="pw_check">새 비밀번호<span>*</span></label>
                        <input type="password" name="newpw" placeholder="비밀번호를 입력해주세요" required>
                    </div>
                    <div class="form_btns">
                        <button class="join_btn">변경</button>
                        <button onclick="javascript:history.back()">취소</button>
                    </div>
                </div>
            </form>
        </section>
    </div>
</body>
</html>