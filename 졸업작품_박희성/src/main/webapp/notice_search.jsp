<%@page import="java.sql.PreparedStatement"%>
<%@page import="DBPKG.Util"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String title = request.getParameter("");

try{
	Connection con = Util.getConnection();
	String sql = "select * from notice where contents = %?% order by insert_time desc";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, title);
}
catch(Exception e){
	e.printStackTrace();
}

%>