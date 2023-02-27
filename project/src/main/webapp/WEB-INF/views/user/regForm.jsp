<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script type="text/javascript">
  		//모든 공백 체크 정규식
		var emptCheck = /\s/g;
		//영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
		var idPwCheck = /^[a-zA-Z0-9]{4,20}$/;
		
		var id = hansol;
		
    	$(document).ready(function(){
    		//회원가입 버튼 눌렀을 때 ============
    		$("#btnUserReg").on("click", function(){
    			
    			//아이디 입력, 공백, 형식 체크
    			if($.trim($("#userId").val()).length <= 0) {
    				alert("아이디를 입력해주세요.");
    				$("#userId").focus();
    				return;
    			}
    			
    			if(emptCheck.test($("#userId").val())) {
    				alert("아이디는 공백을 포함할 수 없습니다.");
    				$("#userId").val("");
    				$("#userId").focus();
    				return;
    			}
    			
    			if(!idPwCheck.test($("#userId").val())) {
    				alert("아이디 형식이 맞지않습니다.");
    				$("#userId").focus();
    				return;
    			}
    			
    			//비밀번호 입력, 공백, 형식, 2차확인 체크
    			if($.trim($("#userPwd1").val()).length <= 0) {
    				alert("비밀번호를 입력해주세요.");
    				$("#userPwd1").focus();
    				return;
    			}
    			
    			if(emptCheck.test($("#userPwd1").val())) {
    				alert("비밀번호는 공백을 포함할 수 없습니다.");
    				$("#userPwd1").val("");
    				return;
    			}
    			
    			if(!idPwCheck.test($("#userPwd1").val())) {
    				alert("비밀번호 형식이 맞지 않습니다.");
    				$("#userPwd1").val("");
    				$("#userPwd1").focus();
    				return;
    			}
    			
    			if($("#userPwd1").val() != $("#userPwd2").val()) {
    				alert("비밀번호가 일치하지않습니다.");
    				$("#userPwd2").val("");
    				$("#userPwd2").focus();
    				return;
    			}
    			
    			//닉네임 입력, 공백, 형식체크
    			if($.trim($("#userNickname").val()).length <= 0) {
    				alert("닉네임을 입력해주세요.");
    				$("#userNickname").focus();
    				return;
    			}
    			
    			if(emptCheck.test($("#userNickname").val())) {
    				alert("닉네임은 공백을 사용할 수 없습니다.");
    				$("#userNickname").focus();
    				return;
    			}
    			
    			if($("#userNickname").val().length < 3) {
    				alert("닉네임을 3자 이상 입력해주세요.");
    				$("#userNickname").focus();
    				return;
    			}
    			
    			if($("#userNickname").val().length > 20) {
    				alert("닉네임은 20자를 초과할수없습니다.");
    				$("#userNickname").focus();
    				return;
    			}
    			
    			//이메일 공백, 형식 체크
    			if($.trim($("#userEmail").val()).length <= 0) {
    				alert("이메일을 입력해주세요");
    				$("#userEmail").focus();
    				return;
    			}
    			
    			if(!fn_validateEmail($("#userEmail").val())) {
    				alert("올바른 이메일을 입력해주세요.");
    				$("#userEmail").focus();
    				return;
    			}
    			
    			//이름 입력, 공백 체크
    			if($.trim($("#userName").val()).length <= 0) {
    				alert("이름을 입력해주세요.");
    				$("#userName").focus();
    				return;
    			}
    			
    			if(emptCheck.test($("#userName").val())) {
    				alert("이름은 공백을 사용할 수 없습니다.");
    				$("#userName").focus();
    				return;
    			}
    			
    			//전화번호 입력, 공백 체크
    			if($.trim($("#userPhoneNo").val()).length <= 0) {
    				alert("전화번호를 입력해주세요.");
    				$("#userPhoneNo").focus();
    				return;
    			}
    			
    			if(emptCheck.test($("#userPhoneNo").val())) {
    				alert("전화번호를 정확히 입력해주세요.");
    				$("#userPhoneNo").focus();
    				return;
    			}
    			
    			if($.trim($("#userAddress").val()).length <= 0) {
    				alert("주소를 입력해주세요.");
    				$("#userAddress").focus();
    				return;
    			}
    		
    			fn_regProc();
    			
    		});//회원가입버튼 처리끝
    		
    		//아이디 중복체크 버튼 눌렀을 떄 ==============
    		$("#btnIdDuplicationCheck").on("click", function(){
        		
    			if($.trim($("#userId").val()).length <= 0) {
    				alert("아이디를 입력해주세요.");
    				$("#userId").focus();
    				return;
    			}
    			
    			if(emptCheck.test($("#userId").val())){
    				alert("아이디는 공백을 포함할 수 없습니다.");
    				$("#userId").focus();
    				return;
    			}
    			
    			if(!idPwCheck.test($("#userId").val())){
    				alert("아이디는 4~12자리 영문 대소문자, 숫자로만 가능합니다.");
    				$("#userId").focus();
    				return;
    			}
    			
    			//아이디 중복가입 체크
    			fn_idCheck();
    		});
    		
    		//취소 버튼 눌렀을 때 메인화면으로 돌아감 ===================
    		$("#btnCancel").on("click", function(){
    			location.href="/index";
    		});
    	});
    	 

//아이디 중복가입 체크    	
function fn_idCheck(){
	
	$.ajax({
		type: "POST",
		url:"/user/idCheck",
		data:{
			userId:$("#userId").val()
		},
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0) {
				alert("사용가능한 아이디 입니다.");
			}else if(response.code == -1) {
				alert("중복된 아이디입니다.");
			}else if(response.code == 400) {
				alert("요청이 실패 했습니다.");
			}else {
				alert("요청중 알수없는 오류가 발생했습니다.");
			}
		},
		error:function(xhr, status, error){
			icia.common.error(error);
		}
	});
	
};   


//이메일 형식 체크
function fn_validateEmail(value)
{
	var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	
	return emailReg.test(value);
}

//회원가입    	
function fn_regProc(){
	$.ajax({
		type: "POST",
		url: "/user/regProc",
		data:{
			userId:$("#userId").val(),
			userPwd1:$("#userPwd1").val(),
			userName:$("#userName").val(),
			userEmail:$("#userEmail").val(),
			userNickname:$("#userNickname").val(),
			userPhoneNo:$("#userPhoneNo").val(),
			userAddress:$("#userAddress").val()
		},
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0) {
				alert("회원가입이 완료되었습니다.");
				location.href = "/index";
			}else if(response.code == -1) {
				alert("오류가 발생했습니다.");
			}else if(response.code == 400) {
				alert("잘못된 파라미터값입니다.");
			}else if(response.code == -2){
				alert("중복된 아이디입니다.");
			}else {
				alert("알수없는 오류가 발생했습니다.");
			}
			
		},
		error:function(xhr, status, error){
			icia.common.error(error);
		}
	});
};    	
    </script>
</head>
<body>
    아이디<input type="text" id="userId" name="userId" placeholder="4~12자리의 영문대소문자,숫자로 입력해주세요"> <button type="button" id="btnIdDuplicationCheck">중복확인</button><br />
    비밀번호<input type="password" id="userPwd1" name="userPwd1"> <br />
    비밀번호 확인<input type="password" id="userPwd2" name="userPwd2"> <br />
    이름<input type="text" id="userName" name="userName"> <br />
    이메일<input type="text" id="userEmail" name="userEmail"> <br />
    닉네임<input type="text" id="userNickname" name="userNickname"> <br />
    전화번호<input type="text" id="userPhoneNo" name="userPhoneNo"> <br />
    주소<input type="text" id="userAddress" name="userAddress"> <br />
    <button type="button" id="btnUserReg" name="btnUserReg">회원가입</button>
    <button type="button" id="btnCancel" name="btnCancel">취소</button>
</body>
</html>