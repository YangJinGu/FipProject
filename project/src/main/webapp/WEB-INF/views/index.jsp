<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Fip</title>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> 
</head>
<script type="text/javascript">
	$(document).ready(function(){
		$("#btn-login").on("click", function(){
			fn_loginCheck();
		});
		
		$("#btn-reg").on("click", function(){
			location.href="/user/regForm";
		})
	});
	
	
	
//로그인 체크 함수	
function fn_loginCheck(){
	
	if($.trim($("#userId").val()).length <= 0) {
		alert("아이디는 필수입력사항 입니다.");
		$("#userId").focus();
		return;
	}
	
	if($.trim($("#userPwd").val()).length <= 0) {
		alert("비밀번호는 필수입력사항 입니다.");
		$("#userPwd").focus();
		return;
	}
	
	$.ajax({
		type: "POST",
		url: "/user/login",
		data:{
			userId:$("#userId").val(),
			userPwd:$("#userPwd").val()
		},
		datatype:"JSON",
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0) {
				alert("로그인성공");
				location.href = "/board/list";
			}else if(response.code == -1) {
				alert("비밀번호가 일치하지 않습니다.");
				$("#userPwd").val("");
				$("#userPwd").focus();
			}else if(response.code == 400) {
				alert("로그인 시도중 오류가 발생했습니다.");
				$("#userId").val("");
				$("#userPwd").val("");
				$("#userId").focus();
			}else if(response.code == 404) {
				alert("회원이 존재하지 않습니다.");
				$("#userId").val("");
				$("#userPwd").val("");
				$("#userId").focus();
			}else if(response.code == 500) {
				alert("이미 로그인 되어있습니다. 로그아웃합니다");
				loaction.href = "/index";
			}else {
				alert("알수 없는 오류가 발생했습니다.");
			}
		},
		error:function(xhr, status, error){
			icia.common.error(error);
		}
	});
};	
	
	
</script>
<body>
	<form class="form-signin">
		<label for="userId">아이디</label>
		<input type="text" id="userId" name="userId" placeholder="아이디">
		<label for="userPwd">비밀번호</label>
		<input type="text" id="userPwd" name="userPwd" placeholder="비밀번호">
		<button type="button" id="btn-login">로그인</button>
		<button type="button" id="btn-reg">회원가입</button>
	</form>
</body>
</html>