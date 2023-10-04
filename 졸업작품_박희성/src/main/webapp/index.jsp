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
	Integer notice_number = 0;
	
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
	Integer pageList = (cPage-1) / 10 + 1;
	
	try{
		Connection con = Util.getConnection();
		String sql="select a.* , rownum from(select * from notice order by insert_time desc) a";
		if(title != null)
			sql = sql+" WHERE a.title LIKE ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		if(title != null)
			pstmt.setString(1, "%" + title + "%");
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
			pageList = (cPage-1) / 10 + 1;
		}

		if(id == null){
			id = "";
		}
		String user_info = "select s.name, s.id"
						+" from sign_in s"
						+" where s.id = ?";
		PreparedStatement pstmt2 = con.prepareStatement(user_info);
		pstmt2.setString(1, id);
		ResultSet rs2 = pstmt2.executeQuery();	
		
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
    <div class="notice_board">
    	<div class="notice_search">
    		<input type="text" value="<%=title %>" placeholder="제목 검색" name="notice_name" class="notice_search_name">
    		<input type="button" onclick="search()" name="notice_search_button" value="검색" class="notice_search_button">
    	</div>
        <p class="notice_title">게시판</p>
        <%
        if(id.length() == 0){
        	%>
        		<input type="button" class="notice_insert" onclick="insert_not()" value="글쓰기">
        	<%
        }
        else{
        	%>
    			<input type="button" class="notice_insert" onclick="insert()" value="글쓰기">
    		<%
        }
        %>
    	

        <div class="notice_titles">
        <span class="notice_no_title">NO.</span>
        <span class="notice_writer_title">글쓴이</span>
        <span class="notice_name_title">제목</span>
        <span class="notice_time_title">시간</span>
        </div>
        	<table class="notice" border="2">
            	<%
            	while(rs.next()){
            		Integer num = Integer.parseInt(rs.getString(7));
            		if(printFirst <= num && printLast >= num){
            		%>
            		<tr>
            			<td class="notice_no"><%=rs.getString(7) %></td>
                		<td class="notice_writer"><%=rs.getString(1) %></td>
                		<td class="notice_name"><%=rs.getString(2) %></td>
                		<td class="notice_time"><%=rs.getString(4) %></td>
            		</tr>
            		<%}
            		else if(num > printLast) break;
            	}
            	%>
        	</table>
        <div class="notice_page">
    		<input name="page" value="<%=cPage %>" style="display: none;" type="text">
    		<input type="button" value="< 이전" class="page_BN" onclick="page_before()"><div style="margin-left: 10px; margin-right: 10px;">
    		<% Integer num2 = (pageList-1)*10 + 1;
    			while(num2 <= pageList*10 && num2 <= totalPage){%>
    			<input type="button" value="<%=num2 %>" onclick="pageNum(this.value)" class="page_button"
    			<% if(num2 == cPage) {%>
    			style="background: gray; color: white;"
    			<%} %>>
    		<%	num2++;
    			}%>
    		</div>
    		<input type="button" value="다음 >" class="page_BN" onclick="page_next()">
    	</div>
    	</div>
	</form>

    
    <div class="side_menu">
        <form name="login_form" method="post" action="login_action.jsp">
            <div class="sign_in">
                <%
                if(id.length() == 0){
                	%>
                	<input type="text" name="id" placeholder="아이디" value="<%=id %>" id="id">
                	<input type="password" name="pw" placeholder="비밀번호" id="pw">
                	<input type="button" class="login" value="로그인" onclick="login()">
                	<p class="join" onclick="go_sign_in()">회원가입</p>
                	<%
                }
                else{
                	if(rs2.next()){
                	%>
                	<div class="user_info">
                		<p>닉네임 : <%=rs2.getString(1) %></p>
                		<p>아이디 : <%=rs2.getString(2) %></p>
                		<%
                		if(notice_number > 99){
                			%>
                			<p>올린 글 수 : <%=notice_plus %></p>
                			<%
                		}
                		else{
                			%>
                			<p>올린 글 수 : <%=notice_number %></p>
                			<%
                		}
                		%>
                	</div>
                	<p class="join" onclick="home()">로그아웃</p>
                	<%
                	}
                }
                %>
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
	notice_form.page.value = num -1;
	notice_form.submit();
	return true;
}
function page_next(){
	let num = parseInt(notice_form.page.value);
	if(num == <%=totalPage %>) return false;
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