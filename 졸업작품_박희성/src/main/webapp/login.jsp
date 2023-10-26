<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="Css/login.css">
<script type="text/javascript" src="script/check.js"></script>
</head>
<%
request.setCharacterEncoding("UTF-8");
String doplication = request.getParameter("doplication");
boolean check = true;
if(doplication == null){
	check = false;
}
%>
<body>

<div class="box">
    <p class="title">로그인</p>
    
    <form method="post" action="login_action.jsp" name="frm">
    	<%if(check){ %>
    	<p>아이디/비밀번호가 틀림</p>
    	<%} %>
        <div class="insert_zone">
            <input type="text" name="id" id="id" placeholder="아이디을 입력해주세요" class="insert_input">
            <input type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요" class="insert_input">
        </div>
        <input type="button" class="button" value="로그인" onclick="login()">
        <span class="sign_in" onclick="go_sign_in()">회원가입</span>
    </form>
    <img alt="" src="Image/house_icon.png" onclick="home()" id="home_img">
</div>

</body>
</html>