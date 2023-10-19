<%@page import="DBPKG.Util"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script src="script/check.js"></script>
<link rel="stylesheet" href="Css/insert.css">
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String insert_number = request.getParameter("view_number");

try{
	Connection con = Util.getConnection();
	String sql = "select notice.title, notice.contents"
				+" from notice, sign_in"
				+" where notice.insert_number = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, insert_number);
	ResultSet rs = pstmt.executeQuery();

%>
</head>
<body>
	<jsp:include page="Section/header.jsp"></jsp:include>

	<form action="notice_update_action.jsp" name="frm" method="post" style="display: flex; justify-content: center; align-items: center;">
	<input type="text" name="id" value="<%=id %>" style="display: none;">
	<input type="text" name="insert_number" value="<%=insert_number %>" style="display: none;">
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
		<div class="input_area"><input type="button" onclick="notice_update_action()" value="글 수정하기" class="input"></div>
	</div>
	</form>

</body>
<%}
catch(Exception e){
	e.printStackTrace();
} %>
</html>