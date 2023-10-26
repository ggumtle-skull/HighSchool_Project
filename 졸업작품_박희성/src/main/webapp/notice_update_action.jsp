<%@page import="DBPKG.Util"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String pw = request.getParameter("pw");
String view_number = request.getParameter("insert_number");
String title = request.getParameter("title");
String contents = request.getParameter("contents");
System.out.println(id);
try{
	Connection con = Util.getConnection();
	String sql = "update notice"
				+" set contents = ?, title = ?"
				+" where insert_number = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, contents);
	pstmt.setString(2, title);
	pstmt.setInt(3, Integer.parseInt(view_number));
	pstmt.executeUpdate();
	%>
	<jsp:include page="index.jsp">
		<jsp:param value="<%=id %>" name="id"/>
		<jsp:param value="<%=view_number %>" name="notice_view_number"/>
		<jsp:param value="<%=pw %>" name="pw"/>
	</jsp:include>
	<%
}
catch(Exception e){
	e.printStackTrace();
}

%>