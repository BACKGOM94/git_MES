<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.layout-grid .grid-layout {
	    padding-bottom: 0px;
	}
	.grid-right70 {
	    margin-bottom: 0px;
	}
	.grid-left29 {
	    padding-bottom: 0px;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

<%--화면 로딩시 동작 정의--%>
$(document).ready(
	function() {
		
		//검색창에서 엔터시 검색
		$("[name^=searchForm]").keypress(function(){
			if(event.keyCode==13){
				doAction('M9806010_1_Sheet','search');
				return false;
				}
		});
		
		//IBSheet 생성 영역
		iB_Sheet_Make("M9806010_1_Sheet","${M9806010_1_Sheet}","100%");	
		
		doAction('M9806010_1_Sheet','search');
		
		
	});
	
function doAction(sheetNm,sAction){
	$('#sheetNm').val(sheetNm);
	switch (sAction) {
	case "search":
		var queryStr = FormQueryStringEnc(document.searchForm);
		window[sheetNm].DoSearch("<c:url value='/M980/Common_Data.do'/>",queryStr);
		break;
	case "input":
		var nRow = window[sheetNm].DataInsert(-1);
		window[sheetNm].SetCellValue(nRow,"com_cd","${com_cd}");
		break;
	case "save":
		make_CD(window[sheetNm],"equi_CD","EQU");
		var param = {url:"<c:url value='/M980/Common_Data.do'/>", sheet:sheetNm};
		DataSave(param);		
		break;
	case "reset":
		$('#equi_NM').val('');
		var queryStr = FormQueryStringEnc(document.searchForm);
		window[sheetNm].DoSearch("<c:url value='/M980/Common_Data.do'/>",queryStr);
		break;
	default:
		break;
	}
}
	
</script>

</head>
<body>
<%-- container --%>
	<div class="container">
		<%-- page-content --%>
		<div class="page-content">
			<%--네비게이션 영역--%>
			<%@ include file="/WEB-INF/view/Common/navigation.jsp"%>
			<%--네비게이션 영역--%>
		
			<%--페이지 제목 영역--%>				
			<div class="page-header">
				<h4>설비 관리</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9806010_1_Sheet', 'input')" role="button">신규</a></li>
					<li><a title="저장" class="btn-save" href="#" onclick="doAction('M9806010_1_Sheet', 'save'); return false;" role="button">저장</a></li>
					<li><a  title="초기화" class="btn-reset" href="#"  onclick="doAction('M9806010_1_Sheet','reset'); return false;" role="button">초기화</a></li>
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post" >
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<div class="inquiry-box">
				<table class="table">
					<caption>설비 관리</caption>
					<tbody>
						<tr class="line">
							<th scope="row"><label for="equi_NM">설비명</label></th>
							<td><input type="text" id="equi_NM" name="equi_NM" title="설비명"  /></td>
							<th ></th><td></td>
							<th></th><td></td>
							<th></th><td></td>
							<th></th><td></td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
			<%--검색조건 영역--%>
		
			<%--하단 컨텐츠(전체) 영역--%>
			<div class="layout-grid">
				<div class="grid">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 설비 목록</h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9806010_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M9806010_1_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
			</div>
			<%--하단 컨텐츠(전체) 영역--%>
		</div>
		<%-- page-content --%>
	</div>
	<%-- container --%>
</body>
</html>