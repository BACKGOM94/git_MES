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
		
		//IBSheet 생성 영역
		iB_Sheet_Make("M2101030_1_Sheet","${M2101030_1_Sheet}","100%");	
		
		doAction('M2101030_1_Sheet','search');
		
		
	});

	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M210/Common_Data.do'/>",queryStr);
			break;
		case "save":
			
			for (var i = 1; i < window[sheetNm].RowCount() + 1; i++) {
				if (window[sheetNm].GetCellValue(i,"chk") == 1) {
					window[sheetNm].SetCellValue(i,'sStatus','U');
				}
			}
			
			var param = {url:"<c:url value='/M210/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);
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
				<h4>작업지시서 관리</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">				
					<li><a title="저장" class="btn-save" href="#" onclick="doAction('M2101030_1_Sheet', 'save'); return false;" role="button">완료</a></li>
					<li><a  title="초기화" class="btn-reset" href="#"  onclick="doAction('M2101030_1_Sheet','search'); return false;" role="button">초기화</a></li>
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
							<th scope="row"><label for="work_CD">작업실</label></th>
							<td>
								<select class="form" id="work_CD" name="work_CD" title="작업실별" onchange="doAction('M2101030_1_Sheet','search')">								
							 		<c:forEach var="item" items="${work_CD}">
										<option value="${item.some_CD}">${item.some_NM}</option>
									</c:forEach> 
								</select>
							</td>
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
							<p>조회건수 : <span id="M2101030_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M2101030_1_Sheet"></div>
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