<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%-- 공통스크립트, 스타일시트 정의 --%>
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/gom/com/login.css' />" />

	<style>
		body {background-color: #bfc2c7;}
	</style>	
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	<%--화면 로드 처리--%>
	$(document).ready(
		function() {
			
			if ("${login_status}" == "N") {
				alert('<spring:message code="fail.common.login"/>');
			}
			
			$("#memb_cd").focus();
		} 
	);
	
	//ID,PW 공백 확인
	function actionLogin() {
		if ($("#memb_cd").val() == "") {
			alert('<spring:message code="fail.common.idsearch"/>');
			$("#memb_cd").focus();
			return false;
		}else if ($("#memb_pw").val() == "") {
			alert('<spring:message code="fail.common.pwsearch"/>');
			$("#memb_pw").focus();
			return false;
	    } else $("#loginForm").attr({action:"<c:url value='/Common/actionLogin.do'/>", method:'post'}).submit();
	}

</script>
</head>
<body id="page">
	<div class="login-page">
		<div class="logo"><img src="<c:url value='/images/gom/login/login-logo.png'/>">
		</div>
		<div class="form">
			<%-- 아이디 패스워드 입력 --%>
			<form class="login-form" id="loginForm" name="loginForm">
				<div>
					<i class="fa fa-user fa-2x input-icon"></i>
					<input type="text" id="memb_ID" name="memb_ID" placeholder="User ID" style="background: #ffffff;" value="" maxlength="20">
				</div>
				<div>
					<i class="fa fa-lock fa-2x input-icon"></i>
					<input type="password" id="memb_PW" name="memb_PW" placeholder="Password"  autocomplete="off" style="background: #ffffff;" value="">
				</div>

				<%-- 로그인 버튼 --%>
				<a href="#" target="_blank" onclick="javascript:actionLogin(); return false;"><button>login</button></a>

				<div class="margin-15"></div>

				<%-- 체크박스구간 --%>
				<div class="f-check">
					<input type="checkbox" name="keep" value="true">
					<span class="check">아이디 저장</span>
				</div>
			</form>
		</div>
	</div>
</body>
</html>