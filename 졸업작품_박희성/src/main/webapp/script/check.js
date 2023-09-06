function home(){
    window.location="index.jsp";
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
        alert("가입이 완료되었습니다");
        window.location = "index.jsp";
        return false;
    }
}

function go_sign_in(){
    window.location = "sign_in.jsp";
}