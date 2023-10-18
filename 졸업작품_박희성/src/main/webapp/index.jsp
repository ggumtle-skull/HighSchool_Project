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
	String title = request.getParameter("notice_name");
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
		String user_info = "select s.name, s.id, count(*)"
						+" from sign_in s"
						+" where s.id = ?"
						+" group by s.name, s.id";
		PreparedStatement pstmt2 = con.prepareStatement(user_info);
		pstmt2.setString(1, id);
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
	<input type="text" name="notice_view_number" value="<%=view_number %>" style="display: none;">
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
        	<ul class="notice">
        		<%
        		while(rs.next()){
        			Integer num = Integer.parseInt(rs.getString(8));
        			if(printFirst <= num && printLast >= num){
        			%>
        			<li class="notice_list" onclick="notice_view(this.value)" value="<%=rs.getInt(1) %>">
        				<span class="notice_no"><%=rs.getString(8) %></span>
        				<span class="notice_writer"><%=rs.getString(2) %></span>
        				<span class="notice_name"><%=rs.getString(3) %></span>
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
                if(!login_check){
                	%>
                	<input type="text" name="id" placeholder="아이디" value="<%=id %>" id="id">
                	<input type="password" name="pw" placeholder="비밀번호" id="pw">
                	<input type="button" class="login" value="로그인" onclick="login()">
                	<p class="join" onclick="go_sign_in()">회원가입</p>
                	<%
                }
                else{
                	pstmt2 = con.prepareStatement(user_info);
            		pstmt2.setString(1, id);
            		rs2 = pstmt2.executeQuery();	
                	if(rs2.next()){
                	%>
                	<input type="text" value="<%=id %>" name="id" style="display:none;">
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
    
	<%
	
	if(!view_number.equals("000")){
		String notice_view = "select writer,id,title,contents,write_date,to_char(insert_time,'yyyy/mm/dd') from notice where insert_number = ?";
		PreparedStatement pstmt_view = con.prepareStatement(notice_view);
		pstmt_view.setString(1, view_number);
		ResultSet rs_view = pstmt_view.executeQuery();
		
		String notice_view_check = "select count(*) from notice, sign_in where ? = notice.id and notice.insert_number = ?";
		PreparedStatement check_pstmt = con.prepareStatement(notice_view_check);
		check_pstmt.setString(1, id);
		check_pstmt.setString(2, view_number);
		ResultSet view_check = check_pstmt.executeQuery();
		Integer check = 0;
		if(view_check.next()){
			check = view_check.getInt(1);
			if(check == null) check=0;
		}
		%>
		<form action="" name="notice_view_frm" method="post">
			<input type="text" value="<%=view_number %>" name="view_number" style="display: none;">
			<input type="text" name="id" value="<%=id %>" style="display: none;">
			<div class="notice_post">
			<%
				if(rs_view.next()){
					%>
					<p><%=rs_view.getString(1) %></p>
					<p><%=rs_view.getString(2) %></p>
					<p><%=rs_view.getString(3) %></p>
					<p><%=rs_view.getString(4) %></p>
					<p><%=rs_view.getString(5) %></p>
					<p><%=rs_view.getString(6) %></p>
					<%
				}
				if(check != 0){
					%>
					<input type="button" value="수정" onclick="notice_update()">
					<input type="button" value="삭제" onclick="notice_delete()">
					<%
				}
			%>
			</div>
		</form>
		<%
	}
	%>
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