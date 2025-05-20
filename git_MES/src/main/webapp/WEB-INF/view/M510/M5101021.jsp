<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	$(document).ready(				
		function(){
			//IBSheet 생성 영역
			iB_Sheet_Make("M5101021_1_Sheet","${M5101021_1_Sheet}","100%");	
			doAction('M5101021_1_Sheet','search');
			//IBSheet 생성 영역
			iB_Sheet_Make("M5101021_1_Sheet","${M5101021_1_Sheet}","100%");	
	});
	
	//데이터 변경시 다른 데이터 변경
	function M5101021_1_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {		
		if(Col == 4) {
			
	  	    	$.ajax({
  	  	    		url: "<c:url value='/M510/get_equi_location.do'/>",
  	  	    	type: "POST",
  	  	    	data: {equi_CD:Value},
  	  	    	async: false,
  	  	    	dataType: "json",
  	  	    	success : function( data ) {
  	  	    	M5101021_1_Sheet.SetCellValue(Row,"equi_location",data.equi_location);
  	  	    	},
  	  	    	err : function(r) {
  	  	    		alert('<spring:message code="fail.common.menu.create" />');
  	  	    	}
  	  	    	});
	  	    	
		}
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M510/Common_Data.do'/>",queryStr);
			break;
		case "save":
			var param = {url:"<c:url value='/M510/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);		
		default:
			break;
		}
	}
</script>
</head>
<body>
	<%-- container --%>
	<div class="popup_container">
		<%-- page-content --%>
		<div class="popup-page-content">
			<%--네비게이션 영역--%>
			<%@ include file="/WEB-INF/view/Common/navigation.jsp"%>
			<%--네비게이션 영역--%>			
	
			<%--페이지 제목 영역--%>
			<div class="page-header">
				<h4>모니터링 등록 </h4>
				<h5>모니터링 화면을 수정합니다.</h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="저장" class="btn-save" href="#" onclick="doAction('M5101021_1_Sheet', 'save'); return false;" role="button">저장</a></li>						
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			</form>
			<%--검색조건 영역--%>
			
			<%--하단 컨텐츠(전체) 영역--%>
			<div class="layout-grid">
				<div class="title">
					<div class="title-area">
						<h6> 프로그램 목록 </h6>
					</div>
					<div class="title-set">
						<p>조회건수 : <span id="M5101021_1_Sheet_totalcnt"></span> 건</p>
					</div>	
				</div>

				<%-- ibsheet div --%>
				<div id="M5101021_1_Sheet"></div>
				<%-- ibsheet div--%>				
			</div>
			<%--하단 컨텐츠(전체) 영역--%>
		</div>
		<%-- page-content --%>
	</div>
	<%-- main_con --%>				
</body>
</html>