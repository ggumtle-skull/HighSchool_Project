<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DBPKG.Util"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="Css/section.css">
<script src="script/check.js"></script>
</head>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String pw = request.getParameter("pw");

try{
	Connection con = Util.getConnection();
	String sql = "select * from sign_in where id = ? and password = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, pw);
	
	ResultSet rs = pstmt.executeQuery();
	
	boolean login_check = false;
	if(rs.next()){
		login_check = true;
	}
%>
<body>
    <header>
        <div class="header_title"><span><a href="index.jsp">Nororotice</a></span></div>
        <div class="logo">
            <a href="index.jsp">
                <img src="Image/logo-removebg.png">
            </a>
        </div>
        <div class="login_space">
        	<%
        		if(login_check){
        			pstmt = con.prepareStatement(sql);
        			pstmt.setString(1, id);
        			pstmt.setString(2, pw);
        			rs = pstmt.executeQuery();
        			if(rs.next()){
        			%>
        			<div class="login_success">
        				<p id="name"><%=rs.getString(1) %>님</p>
        				<input id="sign_out" type="button" value="로그아웃" onclick="home()">
        				<p id="id"><%=rs.getString(2) %></p>
        			</div>
        			<%}
        		}
        		else{
        			%>
        			<input type="button" name="login" id="login" onclick="go_login()" value="로그인">
        			<%
        		}
        	%>
        </div>
    </header>
</body>
<%
}
catch(Exception e){
	e.printStackTrace();
}
%>
</html>