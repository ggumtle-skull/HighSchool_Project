<%@page import="DBPKG.Util"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
	if(rs.next()){
		%>
		<jsp:forward page="index.jsp"></jsp:forward>
		<%
	}
	else{
		%>
		<jsp:forward page="sign_in.jsp"></jsp:forward>
		<%	
	}
	
}
catch(Exception e){
	e.printStackTrace();
}

%>