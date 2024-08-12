<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/login.css">
<title>Insert title here</title>
</head>
<body>
	<div id="login">
        <div class="tt_box">
            <a href="../main/main.do">
                <img src="../img/logo.png" alt="project marry me">
                <h1>Project Marry Me</h1> 
            </a>
        </div>
        <form method="POST" action="">
            <div class="login_box">
                <div class="input_wrap">
                    <input type="text" id="id" name="id">
                    <label for="id">아이디</label>
                </div>
                <div class="input_wrap">
                    <input type="password" id="pw" name="pw">
                    <label for="pw">비밀번호</label>
                </div>
            </div>
            <p class="error">아이디를 입력해주세요</p>
            <button>로그인</button>
        </form>
        <ul class="login_links">
            <li><a href="#">아이디 찾기</a></li>
            <li><a href="#">비밀번호 찾기</a></li>
            <li><a href="../member/join.do">회원가입</a></li>
        </ul>
        <ul class="sns_btns">
            <li>
                <a href="">카카오톡 로그인
                    <!-- <svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M0.519531 8.61196C0.519531 11.4975 2.37093 14.0321 5.1607 15.4739L4.21824 19.0958C4.18323 19.203 4.20964 19.3196 4.28698 19.3991C4.3427 19.4564 4.41616 19.4854 4.48968 19.4854C4.55233 19.4854 4.61492 19.4648 4.66753 19.4221L8.72156 16.6072C9.30482 16.693 9.90582 16.7384 10.5195 16.7384C16.0423 16.7384 20.5195 13.1004 20.5195 8.61196C20.5195 4.12404 16.0423 0.485352 10.5195 0.485352C4.99677 0.485352 0.519531 4.12404 0.519531 8.61196Z" fill="#4E2828"/>
                    </svg> -->
                </a>
            </li>
            <li>
                <a href="">네이버 로그인
                    <!-- <svg width="25" height="25" viewBox="0 0 25 25" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M15.0619 5.48535V13.0196L9.9945 5.48535H4.51953V20.4187H9.97713V12.8844L15.0446 20.4187H20.5195V5.48535H15.0619Z" fill="white"/>
                    </svg> -->
                </a>
            </li>
            <li>
                <a href="">애플 로그인
                    <!-- <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M19.9042 15.2656C19.6079 15.95 19.2573 16.58 18.851 17.1591C18.2972 17.9487 17.8438 18.4953 17.4944 18.7987C16.9527 19.2969 16.3723 19.552 15.7508 19.5666C15.3046 19.5666 14.7665 19.4396 14.1402 19.182C13.5118 18.9257 12.9343 18.7987 12.4063 18.7987C11.8525 18.7987 11.2586 18.9257 10.6233 19.182C9.98701 19.4396 9.47446 19.5738 9.08257 19.5871C8.48659 19.6125 7.89253 19.3501 7.29957 18.7987C6.92111 18.4687 6.44772 17.9028 5.88064 17.1011C5.27219 16.245 4.77197 15.2523 4.38009 14.1206C3.96039 12.8981 3.75 11.7143 3.75 10.5683C3.75 9.25555 4.03367 8.1233 4.60184 7.17448C5.04838 6.41236 5.64243 5.81117 6.38594 5.36983C7.12944 4.92849 7.9328 4.70359 8.79794 4.6892C9.27132 4.6892 9.8921 4.83563 10.6635 5.1234C11.4328 5.41215 11.9267 5.55858 12.1433 5.55858C12.3052 5.55858 12.8539 5.38736 13.7841 5.04602C14.6637 4.72946 15.4062 4.59839 16.0144 4.65002C17.6624 4.78303 18.9006 5.4327 19.724 6.60316C18.2501 7.49624 17.521 8.7471 17.5355 10.3518C17.5488 11.6017 18.0022 12.6418 18.8933 13.4676C19.2972 13.8509 19.7482 14.1472 20.25 14.3575C20.1412 14.6731 20.0263 14.9754 19.9042 15.2656ZM16.1244 0.391887C16.1244 1.37155 15.7665 2.28626 15.0531 3.1329C14.1922 4.1394 13.1509 4.721 12.0216 4.62923C12.0073 4.5117 11.9989 4.388 11.9989 4.25802C11.9989 3.31754 12.4083 2.31105 13.1354 1.4881C13.4984 1.07143 13.96 0.724971 14.5199 0.448596C15.0785 0.176344 15.6069 0.0257829 16.1038 0C16.1184 0.130966 16.1244 0.26194 16.1244 0.391875V0.391887Z" fill="white"/>
                    </svg> -->
                </a>
            </li>
        </ul>
    </div>
    <jsp:include page="../main/footer.jsp"></jsp:include>
</body>
</html>