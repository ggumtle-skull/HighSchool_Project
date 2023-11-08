<%@page import="DBPKG.Util"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="Css/notice_view.css" rel="stylesheet">
<script type="text/javascript" src="script/check.js"></script>
</head>
<%
request.setCharacterEncoding("UTF-8");

String id=request.getParameter("id");
String pw=request.getParameter("pw");
String notice_view_number = request.getParameter("notice_view_number");
String title = request.getParameter("notice_name");


try{
	Connection con = Util.getConnection();

%>
<body>
<jsp:include page="Section/header.jsp"></jsp:include>
<form action="" method="post" name="frm" style="display: flex; justify-content: center; align-items: center;">
<%
		String notice_view = "select writer, id, title, contents, write_date, to_char(insert_time,'yyyymmdd'), to_char(insert_time, 'hh24mi') from notice where insert_number = ?";
		PreparedStatement pstmt_view = con.prepareStatement(notice_view);
		pstmt_view.setString(1, notice_view_number);
		ResultSet rs_view = pstmt_view.executeQuery();
		
		String notice_view_check = "select count(*) from notice, sign_in where ? = notice.id and notice.insert_number = ?";
		PreparedStatement check_pstmt = con.prepareStatement(notice_view_check);
		check_pstmt.setString(1, id);
		check_pstmt.setString(2, notice_view_number);
		ResultSet view_check = check_pstmt.executeQuery();
		Integer check = 0;
		if(view_check.next()){
			check = view_check.getInt(1);
			if(check == null){
				check = 0;
			}
		}
		if(rs_view.next()){	
			String notice_view_date = rs_view.getString(6);
			notice_view_date = notice_view_date.substring(0, 4) + "년 " + notice_view_date.substring(4,6) + "월 " + notice_view_date.substring(6,8) + "일";
			String notice_view_time = rs_view.getString(7);
			notice_view_time = notice_view_time.substring(0,2) + ":" + notice_view_time.substring(2,4);
		%>
			<input type="text" value="<%=notice_view_number %>" name="view_number" style="display: none;">
			<input type="text" name="id" value="<%=id %>" style="display: none;">
			<input type="text" name="pw" value="<%=pw %>" style="display: none;">
			<input type="text" name="writer" value="<%=rs_view.getString(2) %>" style="display: none;">
			<input type="text" name="notice_name" value="<%=title %>" style="display: none;">
			<ul class="notice_post">
				<li class="notice_view_title">
					<span class="notice_view_tag">제목</span>
					<span style="padding:0 20px;"><%=rs_view.getString(3) %></span>
				</li>
				<li class="notice_view_sub">
						<span class="notice_view_tag">글쓴이</span>
						<span style="margin-left: 20px; cursor: pointer;" onclick="search_writer()"><%=rs_view.getString(1) %></span>
					
					<a href="#" style="float: right; margin-right: 10px;">
						<span><%=notice_view_date %></span>
						<span><%=notice_view_time %></span>
					</a>
				</li>
				<li class="notice_view_contents">
					<span class="notice_view_tag" style="height: 367px; line-height: 367px; margin-right: 20px;">내용</span>
					<textarea rows="" cols="" readonly="readonly"><%=rs_view.getString(4) %></textarea>
				</li>
				<%
					if(check != 0 || id.equals("system")){
				%>
					<li class="notice_view_button">
						<input type="button" value="삭제" onclick="notice_delete()" class="notice_delete">
						<input type="button" value="수정" onclick="notice_update()" class="notice_update">
					</li>
				<%
					}
				%>
				<li class="go_home">
					<img src="Image/house_icon.png" onclick="back()">
				</li>
			</ul>
		<%
		}
}
catch(Exception e){
	e.printStackTrace();
}
	%>
</form>
<jsp:include page="Section/footer.jsp"></jsp:include>
</body>
</html>