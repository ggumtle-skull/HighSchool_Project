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
<%
request.setCharacterEncoding("UTF-8");
String id_duplication = request.getParameter("id_duplication");
boolean duplication = true;
if(id_duplication == null){
	duplication = false;
}
%>
<body>
<div class="box">
    <p class="title">회원가입</p>
    <p class="warning">졸업작품 체험이 끝나면 데이터베이스를 지울 것이며 혹시모르니 평소에 쓰지 않는 아이디와 비밀번호를 사용해주세요</p>
    <%
            if(duplication){
            	%>
            	<p id="duplication">아이디 중복</p>
            	<%
            }
    %>
    <form method="post" action="sign_in_action.jsp" name="sign_in">
        <div class="insert_zone">
            <input type="text" name="name" id="name" placeholder="이름을 입력해주세요" class="insert_input">
            <input type="text" name="id" id="id" placeholder="아이디를 입력해주세요" class="insert_input">
            <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요" class="insert_input">
            <input type="password" name="rpw" id="rpw" placeholder="비밀번호 재입력" class="insert_input">
            
        </div>
        <div class="button_zone">
        	<input type="button" class="button" id="joins" value="가입하기" onclick="join()">
        </div>
    </form>
    <img alt="" src="Image/house_icon.png" onclick="home()" id="home_img">
    <p class="login" onclick="go_login()">로그인</p>
</div>
</body>
</html>