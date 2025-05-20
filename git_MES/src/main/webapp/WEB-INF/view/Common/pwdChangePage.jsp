<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
	
	<style>
		@import url(https://fonts.googleapis.com/css?family=Roboto:400,100,500,300italic,500italic,700italic,900,300);
	.center {
	 text-align:center;
	  
	}
	.textinput {
	  position: relative;
	  width: 260px;
	
	}
	
	.input {
	  font-family: 'Roboto', sans-serif;
	  border: none;
	  margin: 0;
	  padding: 10px 0;
	  outline: none;
	  border-bottom: solid 1px #212121;
	  font-size: 15px;
	  margin-top: 12px;
	  width: 100%;
	  color: #212121;
	  -webkit-tap-highlight-color: transparent;
	}
	
	.label {
	  font-family: 'Roboto', sans-serif;
	  font-size: 15px;
	  position: absolute;
	  left: 0;
	  top: 22px;
	  transition: 0.2s cubic-bezier(0, 0, 0.3, 1);
	  pointer-events: none;
	  color: #212121;
	  user-select: none;
	}
	
	.line {
	  height: 2px;
	  background-color: #2196F3;
	  position: absolute;
	  transform: translateX(-50%);
	  left: 50%;
	  bottom: 0;
	  width: 0;
	  transition: 0.2s cubic-bezier(0, 0, 0.3, 1);
	}
	
	.input:focus ~ .line, .input:valid ~ .line {
	  width: 100%;
	}
	
	.input:focus ~ .label, .input:valid ~ .label {
	  font-size: 11px;
	  color: #2196F3;
	  top: 0;
	}
	
	
	</style>
	
    <script type="text/javascript">
   
    <%--화면 로드 처리--%>
    $(document).ready(
    	function() {
  			document.getElementById('memb_ID').value = "${memb_ID}"
	    });
    
    	//PW 변경전 확인 
		function pwCheck() {
			var memb_ID = $("#memb_ID").val();
			var pw = $("#pw").val();
			var chpw = $("#chpw").val();
			var chpw2 = $("#chpw2").val();
			 
			 if((chpw != chpw2) || (chpw == "")){
				 
				 alert("변경비밀번호를 확인해주세요.");
				 $("#pw").val("");
				 $("#chpw").val("");
				 $("#chpw2").val("");
				 return;
			 }else {
			    	$.ajax({
		  	    		url: "<c:url value='/Common/action_pwdChange.do'/>",
		  	    	type: "POST",
		  	    	data: {memb_ID:memb_ID,memb_PW:pw,chpw:chpw},
		  	    	async: false,
		  	    	dataType: "json",
		  	    	success : function( data ) {		
		  	    		switch (data.status) {
						case 1:
							alert('비밀번호 변경이 완료되었습니다.');
							window.close();
							break;
						case 2:
							alert('현재 비밀번호가 일치하지 않습니다.');
							 $("#pw").val("");
							 $("#chpw").val("");
							 $("#chpw2").val("");
							break;

						default:
							break;
						}
		  	    	},
		  	    	err : function(r) {
		  	    		alert('<spring:message code="fail.common.menu.create" />');
		  	    	}
		  	    	});
			 }
		}
	</script>

</head>
<body>
	<%-- container --%>
	<div class="popup_container">
		<%-- page-content --%>
		<div class="popup-page-content">
			
			<%--페이지 제목 영역--%>
			<div class="page-header">
				<h4>비밀번호변경 팝업</h4>
				<h5>비밀번호변경 기능을 제공합니다.</h5>
			</div>
			<%--페이지 제목 영역--%>
							
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li>
						<a class="btn-reset" href="#" role="button" onclick="pwCheck(); return false;" title="변경">변경</a>
					</li>
				
					<li>
						<a class="btn-close" href="#" role="button" onclick="window.close(); return false;" title="닫기">닫기</a>
					</li>						
				</ul>
			</div>
			<%--검색버튼 영역--%>
			<div class="center">
				<div class='textinput'>
				  <input type='text' id="memb_ID" class='input' required readonly="readonly">
				  <label class='label'></label>
				  <span class='line'></span>
				</div>
				<br />
				<div class='textinput'>
				  <input type="password" id="pw"  class='input'  required>
				  <label class='label'>현재비밀번호</label>
				  <span class='line'></span>
				</div>
				<div class='textinput'>
				  <input type="password" id="chpw" class='input' required>
				  <label class='label'>변경비밀번호</label>
				  <span class='line'></span>
				</div>
				<div class='textinput'>
				  <input type="password" id="chpw2" class='input'  required>
				  <label class='label'>변경비밀번호확인</label>
				  <span class='line'></span>
				</div>
			</div>
			<%--하단 컨텐츠(전체) 영역--%>
		</div>
		<%-- page-content --%>
	</div>
	<%-- main_con --%>
</body>
</html>