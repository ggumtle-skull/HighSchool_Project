<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INDEX</title>
<link rel="stylesheet" href="Css/index.css">
<script src="script/check.js"></script>
</head>
<body>
<jsp:include page="Section/header.jsp"></jsp:include>

<div class="main">
    <div class="notice_board">
    	<div class="notice_search">
    		<input type="text" placeholder="제목 검색" name="notice_name" class="notice_search_name">
    		<input type="button" onclick="search()" name="notice_search_button" value="검색" class="notice_search_button">
    	</div>
        <p class="notice_title">게시판</p>
        <input type="button" class="notice_insert" onclick="insert()" value="글쓰기">
    	
<%
	try{
		Connection con = Util.getConnection();
		String sql = "select * from notice";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
	
%>
        <form action="" name="notice_form" method="post">
        	<table class="notice" border="1">
            	<tr>
                	<td class="notice_writer_title">글쓴이</td>
                	<td class="notice_name_title">제목</td>
                	<td class="notice_time_title">시간</td>
            	</tr>
            	<%
            	while(rs.next()){
            		%>
            		<tr>
                		<td class="notice_writer"><%=rs.getString(1) %></td>
                		<td class="notice_name"><%=rs.getString(2) %></td>
                		<td class="notice_time"><%=rs.getString(3) %></td>
            		</tr>
            		<%
            	}
            	%>
        	</table>
        </form>
        <%
	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
		%>
    </div>
    
    <div class="side_menu">
        <form name="login_form" method="post" action="login_action.jsp">
            <div class="sign_in">
                <input type="text" name="id" placeholder="아이디" id="id">
                <input type="password" name="pw" placeholder="비밀번호" id="pw">
                <input type="button" class="login" value="로그인" onclick="login()">
                <p class="join" onclick="go_sign_in()">회원가입</p>
            </div>
        </form>
    </div>
</div>


</body>
</html>