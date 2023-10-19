<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="Css/sign_in.css">
<script src="script/check.js"></script>
<title>회원가입</title>
</head>
<body>
<div class="box">
    <p class="title">회원가입</p>
    <p class="warning">졸업작품 체험이 끝나면 데이터베이스를 지울 것이며 혹시모르니 평소에 쓰지 않는 아이디와 비밀번호를 사용해주세요</p>
    
    <form method="post" action="sign_in_action.jsp" name="sign_in">
        <div class="insert_zone">
            <p class="insert_tag">이름</p>
            <input type="text" name="name" placeholder="이름을 입력해주세요" class="insert_input">
            <p class="insert_tag">아이디</p>
            <input type="text" name="id" placeholder="아이디를 입력해주세요" class="insert_input">
            <p class="insert_tag">비밀번호</p>
            <input type="password" name="pw" placeholder="비밀번호를 입력해주세요" class="insert_input">
            <p class="insert_tag">비밀번호 재확인</p>
            <input type="password" name="rpw" placeholder="비밀번호를 입력해주세요" class="insert_input">
        </div>
        <div class="button_zone">
        	<input type="button" class="button" id="homes" value="돌아가기" onclick="home()">
        	<input type="button" class="button" id="reWrites" value="다시쓰기" onclick="reWrite()">
        	<input type="button" class="button" id="joins" value="가입하기" onclick="join()">
        </div>
    </form>
    
</div>

</body>
</html>