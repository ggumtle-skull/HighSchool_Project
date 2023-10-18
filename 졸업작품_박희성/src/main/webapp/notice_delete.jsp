<%@page import="DBPKG.Util"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String view_number = request.getParameter("view_number");

try{
	Connection con = Util.getConnection();
	String sql="delete from notice where insert_number = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, view_number);
	pstmt.execute();
	%>
	<jsp:include page="index.jsp">
		<jsp:param value="<%=id %>" name="id"/>
	</jsp:include>
	<%
}
catch(Exception e){
	e.printStackTrace();
}
%>