<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">

</script>
<style type="text/css">
    h1 {
        text-align: center;
        margin-bottom: 20px;
    }
    .form-container {
        width: 50%;
        margin: auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.2);
    }
    .form-group {
        margin-bottom: 15px;
    }
    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    .form-group input, .form-group select {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .form-group input[readonly] {
        background-color: #f9f9f9;
    }
    .form-group .submit-btn {
        width: 100%;
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .form-group .submit-btn:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
    <section class="mycontent">
        <div class="sixth">
            <h1>${sessionScope.name}&nbsp;${sessionScope.gender}님 마이페이지</h1>
        </div>
        
        <div class="form-container">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" value="${sessionScope.id}" readonly>
            </div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" value="${sessionScope.name}" readonly>
            </div>
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="text" id="phone" name="phone" value="${vo.phone}" readonly>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="text" id="email" name="email" value="${vo.email}" readonly>
            </div>
            <div class="form-group">
                <label for="post">우편번호</label>
                <input type="text" id="post" name="post" value="${vo.post}" readonly>
            </div>
            <div class="form-group">
                <label for="address1">주소</label>
                <input type="text" id="address1" name="address1" value="${vo.address1}" readonly>
            </div>
            <div class="form-group">
                <label for="address2">상세주소</label>
                <input type="text" id="address2" name="address2" value="${vo.address2}" readonly>
            </div>
        </div>
    </section>
</body>
</html>
