<%@page import="java.io.Console"%>
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
	String pw = request.getParameter("pw");
	String title = request.getParameter("notice_name");
	String writer = request.getParameter("writer");
	if(title == null) title="";
	if(writer == null) writer ="";
	String view_number = request.getParameter("notice_view_number");
	Integer notice_number = 0;
	if(view_number == null || view_number == "null")
		view_number = "000";
	
	String tempPage = request.getParameter("page");
	Integer cPage;
	Integer perForPage = 5;
	if (tempPage == null || tempPage.length() == 0 || tempPage == "0") {
	    cPage = 1;
	}
	try {
	    cPage = Integer.parseInt(tempPage);
	} catch (NumberFormatException e) {
	    cPage = 1;
	}
	Integer printFirst = (cPage - 1)*5 + 1;
	Integer printLast = printFirst + perForPage -1 ;
	Integer totalList = 0;
	Integer totalPage = 0;
	Integer pageList = (cPage-1) / 5 + 1;
	
	try{
		Connection con = Util.getConnection();
		String sql="select a.* , rownum from(select insert_number, writer, title, contents, to_char(insert_time,'mm/dd'),id"
					+" from notice order by insert_time desc) a";
		PreparedStatement pstmt = con.prepareStatement(sql);
		if(title != null && writer != null){
			sql = sql+" WHERE a.title LIKE ? and a.id like ?";
			pstmt = con.prepareStatement(sql);	
			pstmt.setString(1, "%" + title + "%");
			pstmt.setString(2, "%" + writer + "%");
		}
		else if(title != null){
			sql = sql+" WHERE a.title LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + title + "%");
		}
		else if(writer != null){
			sql = sql + " where a.id = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, writer);
			title="";
		}
		else{
			title="";
		}
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
			totalList += 1;
		totalPage = totalList / perForPage;
		if(totalList % perForPage != 0) totalPage++;
		rs = pstmt.executeQuery();
		if(cPage > totalPage){
			cPage = 1;
			printFirst = (cPage - 1)*5 + 1;
			printLast = printFirst + perForPage -1 ;
			pageList = (cPage-1) / 5 + 1;
		}

		if(id == null){
			id = "";
		}
		String user_info = "select name, id"
						+" from sign_in"
						+" where id = ? and password = ?";
		PreparedStatement pstmt2 = con.prepareStatement(user_info);
		pstmt2.setString(1, id);
		pstmt2.setString(2, pw);
		ResultSet rs2 = pstmt2.executeQuery();	
		boolean login_check = false;
		if(rs2.next()){
			login_check = true;
		}
		
		String number = "select * from notice where id = ?";
		PreparedStatement pstmt3 = con.prepareStatement(number);
		pstmt3.setString(1, id);
		ResultSet rs3 = pstmt3.executeQuery();
		String notice_plus = "";
		while(rs3.next()){
			notice_number++;
			if(notice_number > 99)
				notice_plus = "99+";
		}
		
       %>
<div class="main">
	<form name="notice_form" method="post">
	<input type="text" name="id" value="<%=id %>" style="display: none;">
	<input type="text" name="pw" value="<%=pw %>" style="display: none;">
	<input type="text" name="notice_view_number" value="<%=view_number %>" style="display: none;">
    <div class="notice_board">
    	
        <p class="notice_title">게시판</p>
        
    	
        	<ul class="notice">
        		<%
        		while(rs.next()){
        			Integer num = Integer.parseInt(rs.getString(7));
        			if(printFirst <= num && printLast >= num){
        			%>
        			<li class="notice_list" onclick="notice_view(this.value)" value="<%=rs.getInt(1) %>">
        				<span class="notice_no"><%=rs.getString(7) %></span>
        				<span class="notice_slash">|</span>
        				<span class="notice_writer"><%=rs.getString(2) %></span>
        				<span class="notice_slash">|</span>
        				<span class="notice_name"><%=rs.getString(3) %></span>
        				<span class="notice_slash">|</span>
        				<span class="notice_time"><%=rs.getString(5) %></span>
        			</li>
        			<%}
        			else if(num > printLast) break;
        		}
        		%>
        	</ul>
        <div class="notice_page">
    		<input name="page" value="<%=cPage %>" style="display: none;" type="text">
    		<input type="button" value="< 이전" class="page_BN" onclick="page_before()"><div style="margin-left: 10px; margin-right: 10px;">
    		<% Integer num2 = (pageList-1)*5 + 1;
    			while(num2 <= pageList*5 && num2 <= totalPage){%>
    			<input type="button" value="<%=num2 %>" onclick="pageNum(this.value)" class="page_button"
    			<% if(num2 == cPage) {%>
    			style="background: gray; color: white;"
    			<%} %>>
    		<%	num2++;
    			}%>
    		</div>
    		<input type="button" value="다음 >" class="page_BN" onclick="page_next()">
    	</div>
    	
    	<div class="notice_search">
    		<input type="text" value="<%=title %>" placeholder="제목 검색" name="notice_name" class="notice_search_name">
    		<input type="text" value="<%=writer %>" name="writer" style="display: none;">
    		<input type="button" onclick="search()" name="notice_search_button" value="검색" class="notice_search_button">
    		<%
    		if(title != "" || writer != ""){
    		%>
    		<img src="Image/reset_icon.png" onclick="search_reset()">
    		<%} %>
    	</div>
    	
    	<%
        if(id.length() == 0){
        	%>
        		<div style="width: 150px; height: 40px; position: absolute; display: flex; bottom: 10px; right: 20px;">
        			<input type="button" class="notice_insert" onclick="insert_not()" value="글쓰기">
        		</div>
        	<%
        }
        else{
        	%>
        		<div style="width: 150px; height: 40px; position: absolute; display: flex; bottom: 10px; right: 20px;">
    				<input type="button" class="notice_insert" onclick="insert()" value="글쓰기">
    			</div>
    		<%
        }	
        %>
    	</div>
	</form>
    
	
</div>

<jsp:include page="Section/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
function search() {
	let value = notice_form.notice_name.value;
	notice_form.action = "index.jsp";
	if (value.length == 0) {
		alert("검색어를 입력하세요.");
		notice_form.page.value = 1;
		notice_form.submit();
	} else {
		alert("검색 완료");
		notice_form.page.value = 1;
		notice_form.submit();
	}
}
function pageNum(page_num){	
	notice_form.action = "index.jsp";
	notice_form.page.value = page_num;
	document.notice_form.submit();
	return true;
}
function page_before(){
	let num = parseInt(notice_form.page.value);
	if(num == 1) return false;
	notice_form.action = "index.jsp";
	notice_form.page.value = num -1;
	notice_form.submit();
	return true;
}
function page_next(){
	let num = parseInt(notice_form.page.value);
	if(num == <%=totalPage %>) return false;
	notice_form.action = "index.jsp";
	notice_form.page.value = num +1;
	notice_form.submit();
	return true;
}

</script>
</html>
        <%
	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
		%>