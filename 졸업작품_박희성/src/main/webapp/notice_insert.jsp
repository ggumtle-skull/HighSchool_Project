<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DBPKG.Util"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String title = request.getParameter("title");
String contents = request.getParameter("contents");
String id = request.getParameter("id");

LocalTime now = LocalTime.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH시 mm분");
String formatnow = now.format(formatter);
try{
	Connection con = Util.getConnection();
	String sql = "insert into notice values(?,?,?,?,systimestamp,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	String sql2 = "select name from sign_in where id = ?";
	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	pstmt2.setString(1, id);
	ResultSet rs = pstmt2.executeQuery();
	
	
	if(rs.next()){
		pstmt.setString(1, rs.getString(1));
	}
	else{
		pstmt.setString(1, "nameless");
	}
	pstmt.setString(2, title);
	pstmt.setString(3, contents);
	pstmt.setString(4, formatnow);
	pstmt.setString(5, id);
	
	pstmt.executeUpdate();
	%>
	<jsp:forward page="index.jsp"></jsp:forward>
	<%
}
catch(Exception e){
	e.printStackTrace();
}

%>