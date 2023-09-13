<%@page import="java.sql.PreparedStatement"%>
<%@page import="DBPKG.Util"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String name = request.getParameter("name");
String title = request.getParameter("title");
String contents = request.getParameter("contents");

LocalTime now = LocalTime.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH시 mm분");
String formatnow = now.format(formatter);
try{
	Connection con = Util.getConnection();
	String sql = "insert into notice values(?,?,?,?,systimestamp)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, name);
	pstmt.setString(2, title);
	pstmt.setString(3, contents);
	pstmt.setString(4, formatnow);
	
	pstmt.executeUpdate();
	%>
	<jsp:forward page="index.jsp"></jsp:forward>
	<%
}
catch(Exception e){
	e.printStackTrace();
}

%>