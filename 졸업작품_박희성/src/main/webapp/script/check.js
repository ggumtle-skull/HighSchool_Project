function home(){
    window.location="index.jsp";
    return false;
}
function go_sign_in(){
	window.location="sign_in.jsp";
	return false;
}
function go_login(){
	window.location="login.jsp";
	return false;
}
function back(){
	window.history.back();
	return false;
}

function reWrite(){
    sign_in.reset();
}

function join(){
    if(sign_in.name.value.length == 0){
        alert("이름을 입력해주세요");
        sign_in.name.focus();
        return false;
    }
    else if(sign_in.id.value.length == 0){
        alert("아이디을 입력해주세요");
        sign_in.id.focus();
        return false;
    }
    else if(sign_in.pw.value.length == 0){
        alert("비밀번호을 입력해주세요");
        sign_in.pw.focus();
        return false;
    }
    else if(sign_in.rpw.value.length == 0 || sign_in.pw.value != sign_in.rpw.value){
        alert("비밀번호가 틀립니다");
        sign_in.rpw.focus();
        return false;
    }
    else{
        document.sign_in.submit();
        //window.location = "index.jsp";
        return true;
    }
}

function go_sign_in(){
    window.location = "sign_in.jsp";
}

function login(){
    if(frm.id.value.length == 0 || frm.pw.value.length == 0){
        alert("아이디/비밀번호를 입력하시오");
        return false;
    }
    else{
        document.frm.submit();
        return true;
    }
}

function insert_login(){
	if(frm.title.value.length ==0){
		alert("제목이 작성되지 않았습니다.");
		frm.title.focus();
		return false;
	}
	else if(frm.contents.value.length ==0){
		alert("내용이 작성되지 않았습니다.");
		frm.contents.focus();
		return false;
	}
	else{
		alert("개시글이 작성되었습니다.");
		document.frm.submit();
		return true;
	}
}
function insert(){
	notice_form.action = "insert.jsp";
	document.notice_form.submit();
	return true;
}
function insert_not(){
	alert("게시글을 입력하려면 로그인을 하세요");
	return false;
}

function notice_view(insert_num){
	notice_form.notice_view_number.value = insert_num;
	notice_form.action = "notice_view.jsp";
	document.notice_form.submit();	
	return true;
}
function notice_update(){
	frm.action = "notice_update.jsp";
	document.frm.submit();
	return true;
}
function notice_update_action(){
	if(frm.title.value.length ==0){
		alert("제목이 작성되지 않았습니다.");
		frm.title.focus();
		return false;
	}
	else if(frm.contents.value.length ==0){
		alert("내용이 작성되지 않았습니다.");
		frm.contents.focus();
		return false;
	}
	else{
		alert("개시글이 수정되었습니다.");
		document.frm.submit();
		return true;
	}
}
function notice_delete(){
	frm.action = "notice_delete.jsp";
	document.frm.submit();
	return true;
}

function search_writer(){
	frm.action = "index.jsp";
	document.frm.submit();
	return true;
}
function search_reset(){
	notice_form.action="index.jsp";
	notice_form.notice_name.value="";
	notice_form.writer.value="";
	notice_form.submit();
	return true;
}