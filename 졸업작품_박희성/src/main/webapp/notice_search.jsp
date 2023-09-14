<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DBPKG.Util"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String title = request.getParameter("notice_name");
String id = request.getParameter("id");
String search = "";

try{
	Connection con = Util.getConnection();
	String sql = "select * from notice where contents like ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, "%"+title+"%");
	search = "1";
	ResultSet rs = pstmt.executeQuery();
	System.out.print(rs);
	%>
	<jsp:forward page="index.jsp">
		<jsp:param value="<%=title %>" name="title"/>
		<jsp:param value="<%=search %>" name="search"/>
		<jsp:param value="<%=id %>" name="id"/>
	</jsp:forward>
	<%
}
catch(Exception e){
	e.printStackTrace();
}

%>