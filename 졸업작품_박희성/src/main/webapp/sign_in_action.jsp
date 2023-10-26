<%@page import="DBPKG.Util"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

request.setCharacterEncoding("UTF-8");
String name = request.getParameter("name");
String id = request.getParameter("id");
String pw = request.getParameter("pw");

try{
	Connection con = Util.getConnection();
	String sql = "select * from sign_in where id = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	
	ResultSet rs = pstmt.executeQuery();
	
	if(rs.next()){
		%>
		<jsp:forward page="sign_in.jsp">
			<jsp:param value="true" name="id_duplication"/>
		</jsp:forward>
		<%
	}
	else{
		String sql2 = "insert into sign_in values(?,?,?)";
		PreparedStatement pstmt2 = con.prepareStatement(sql2);
		pstmt2.setString(1, name);
		pstmt2.setString(2, id);
		pstmt2.setString(3, pw);
		
		pstmt2.executeUpdate();
		%>
		<jsp:forward page="index.jsp"></jsp:forward>
		<%
	}
}
catch(Exception e){
	e.printStackTrace();
}
%>