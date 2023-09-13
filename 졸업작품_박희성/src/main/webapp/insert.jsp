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
<link rel="stylesheet" href="Css/insert.css">
<script type="text/javascript" src="script/check.js"></script>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String name = "";

try{
	Connection con = Util.getConnection();
	String sql = "select name from sign_in where id = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){
		name=rs.getString(1);
	}
}
catch(Exception e){
	e.printStackTrace();
}

%>
</head>
<body>
	<jsp:include page="Section/header.jsp"></jsp:include>
	
	<form action="notice_insert.jsp" name="frm" method="post" style="display: flex; justify-content: center; align-items: center;">
	<div class="main">
		<div class="insert_area">
			<div class="title">
				<span class="area_title">제목</span>
				<input type="text" name="title">
			</div>
			<div class="contents">
				<span class="area_title">내용</span>
				<input type="text" name="contents">
			</div>
		</div>
		<div class="input_area"><input type="button" onclick="insert_login()" value="글 올리기" class="input"></div>
	</div>
	</form>
</body>
</html>