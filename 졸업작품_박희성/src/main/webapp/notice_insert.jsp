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
	String sql = "insert into notice values(?,?,?,?,?,systimestamp,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	String sql2 = "select name from sign_in where id = ?";
	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	pstmt2.setString(1, id);
	ResultSet rs = pstmt2.executeQuery();
	
	String insert_number = "select insert_number from notice order by insert_number";
	PreparedStatement pstmt3 = con.prepareStatement(insert_number);
	ResultSet rs2 = pstmt3.executeQuery();
	int num=0;
	while(rs2.next()){
		num = rs2.getInt(1);
	}
	num++;
	
	
	pstmt.setInt(1, num);
	if(rs.next()){
		pstmt.setString(2, rs.getString(1));
	}
	else{
		pstmt.setString(2, "nameless");
	}
	pstmt.setString(3, title);
	pstmt.setString(4, contents);
	pstmt.setString(5, formatnow);
	pstmt.setString(6, id);
	
	pstmt.executeUpdate();
	%>
	<jsp:forward page="index.jsp"></jsp:forward>
	<%
}
catch(Exception e){
	e.printStackTrace();
	%>
	<jsp:forward page="index.jsp"></jsp:forward>
	<%
}

%>