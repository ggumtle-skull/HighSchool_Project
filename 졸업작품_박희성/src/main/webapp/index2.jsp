<%@page import="org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation"%>
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
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String title = request.getParameter("notice_name");
	//Integer notice_number = Integer.parseInt(request.getParameter("nono"));
%>
<div class="main">
	<form name="notice_form" action="index2.jsp" method="post">
	<input type="text" name="id" value="<%=id %>" style="display: none;">
    <div class="notice_board">
    	<div class="notice_search">
    		<input type="text" placeholder="제목 검색" name="notice_name" class="notice_search_name">
    		<input type="button" onclick="search()" name="notice_search_button" value="검색" class="notice_search_button">
    	</div>
        <p class="notice_title">게시판</p>
    	

        <div class="notice_titles">
        <span class="notice_no_title">NO.</span>
        <span class="notice_writer_title">글쓴이</span>
        <span class="notice_name_title">제목</span>
        <span class="notice_time_title">시간</span>
        </div>
        	<table class="notice" border="2">
            	<%
            	try{
            		Connection con = Util.getConnection();
            		String sql="select a.* , rownum from(select * from notice order by insert_time desc) a WHERE a.title LIKE ?";
            		PreparedStatement pstmt = con.prepareStatement(sql);
            		pstmt.setString(1, "%" + title + "%");
            		ResultSet rs = pstmt.executeQuery();
            	
            	while(rs.next()){
            		%>
            		<tr>
            			<td class="notice_no"><%=rs.getString(7) %></td>
                		<td class="notice_writer"><%=rs.getString(1) %></td>
                		<td class="notice_name"><%=rs.getString(2) %></td>
                		<td class="notice_time"><%=rs.getString(4) %></td>
            		</tr>
            		<%
            	}
            	%>
        	</table>
    	</div>
        </form>

    
    <div class="side_menu">
        <form name="login_form" method="post" action="login_action.jsp">
            <div class="sign_in">
            </div>
        </form>
    </div>
    
	<div class="notice_post">
		
	</div>
</div>


</body>
<script type="text/javascript">
	function search() {
		let value = notice_form.notice_name.value;
		if (value.length == 0) {
			alert("검색어를 입력하세요.");
		} else {
			alert("검색 완료");
			notice_form.submit();
		}
	}
</script>
</html>
        <%
	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
		%>