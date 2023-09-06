<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INDEX</title>
<link rel="stylesheet" href="Css/index.css">
<script src="script/check.js"></script>
</head>
<body>
<jsp:include page="Section/header.jsp"></jsp:include>

<div class="main">
    <div class="notice_board">
        <p class="notice_title">게시판</p>
    
        <table class="notice" border="1">
            <tr>
                <td class="notice_writer">글쓴이</td>
                <td class="notice_name">제목</td>
                <td class="notice_time">시간</td>
            </tr>
        </table>
    </div>
    
    <div class="side_menu">
        <div class="sign_in">
            <input type="text" name="id" placeholder="아이디" id="id">
            <input type="password" name="pw" placeholder="비밀번호" id="pw">
            <input type="button" class="login" value="로그인">
            <p class="join" onclick="go_sign_in()">회원가입</p>
        </div>
    </div>
</div>


</body>
</html>