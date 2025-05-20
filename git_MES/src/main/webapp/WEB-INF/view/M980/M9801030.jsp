<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<script type="text/javascript">
	<%--화면 로딩시 동작 정의--%>
	$(document).ready(
		function() {
			//IBSheet 생성 영역
			iB_Sheet_Make("M9801030_1_Sheet","${M9801030_1_Sheet}","100%");
			iB_Sheet_Make("M9801030_2_Sheet","${M9801030_2_Sheet}","100%");
			iB_Sheet_Make("M9801030_3_Sheet","${M9801030_3_Sheet}","100%");
			doAction('M9801030_1_Sheet','search');
			doAction('M9801030_3_Sheet','search');
		});
	
	//특정 행 클릭시 발생 이벤트
	function M9801030_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) doAction('M9801030_2_Sheet','search');
	}
	// 데이터값 변경시 발생 이벤트
	function M9801030_2_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {
		if (Col == 5 && RaiseFlag == 0) {
			var check_data;
			for (var i = 1; i < M9801030_2_Sheet.RowCount()+1; i++) {	
				check_data = M9801030_2_Sheet.GetCellValue(i,'work_SQ');
				
		 		if (Row != i ) {
				 	if (Value > OldValue ) {
						if (Value >= check_data && OldValue <= check_data) M9801030_2_Sheet.SetCellValue(i,"work_SQ",check_data -1);
					}else if (Value < OldValue){
						if (OldValue >= check_data && Value <= check_data) M9801030_2_Sheet.SetCellValue(i,"work_SQ",check_data +1);
					}	 
				} 
				
			}
			M9801030_2_Sheet.ColumnSort("5");
		}
	}
	
	function doAction(sheetNm, action){
		$('#sheetNm').val(sheetNm);
		$('#proc_CD').val(M9801030_1_Sheet.GetCellValue(M9801030_1_Sheet.GetSelectRow(),'proc_CD'));
		
		switch (action) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M980/Common_Data.do'/>",queryStr);
			break;
	 	case "input":
			var nRow = window[sheetNm].DataInsert(-1);	
			if (sheetNm == 'M9801030_2_Sheet') {
				window[sheetNm].SetCellValue(nRow,"proc_CD",$('#proc_CD').val());
				window[sheetNm].SetCellValue(nRow,"work_SQ",window[sheetNm].RowCount());
			}
			break;
		case "save":
			
			var check_item;
			var check_item_NM;
			var code_NM;
			var code;
			var count = 1;
			if (sheetNm == 'M9801030_1_Sheet') {
				check_item_NM = 'proc_NM';
				code = 'proc_CD';
				code_NM = 'PRO';
			} else if (sheetNm == 'M9801030_3_Sheet') {
				check_item_NM = 'work_NM';
				code = 'work_CD';
				code_NM = 'WOR';
			}
			
			if (sheetNm != 'M9801030_2_Sheet'){
				for (var i = 1; i < window[sheetNm].RowCount()+1; i++) {							
					check_item = window[sheetNm].GetCellValue(i,check_item_NM);
					
					for (var j = 1; j < window[sheetNm].RowCount()+1; j++) {
						if (i != j && check_item == window[sheetNm].GetCellValue(j,check_item_NM)) {
							alert('중복된 데이터가 있습니다. 확인후 진행해주세요.');
							return false;
						}}}	
				make_CD(window[sheetNm],code,code_NM);	
			}else {
				for (var i = 1; i < window[sheetNm].RowCount()+1; i++) {
					if (window[sheetNm].GetCellValue(i,'sStatus') == 'D') window[sheetNm].SetCellValue(i,'sStatus','');						
					else window[sheetNm].SetCellValue(i,'sStatus','I');
				}
				for (var i = 1; i < window[sheetNm].RowCount()+1; i++) {
					if (window[sheetNm].GetCellValue(i,'sStatus') == 'I') {
						window[sheetNm].SetCellValue(i,'work_SQ',count);
						count ++;
					}	
				}
			}
			
	  		var param = {url:"<c:url value='/M980/Common_Data.do'/>", sheet:sheetNm};
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
				<h4>품목분류관리</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">					
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post"> 
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="proc_CD" name="proc_CD">
			<div class="inquiry-box">
				<table class="table">
					<caption>검색조건</caption>
					<tbody>
						<tr>	
							<th></th><td></td>
							<th></th><td></td>
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
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 공정</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">
								<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9801030_1_Sheet', 'input')" role="button">신규</a></li>
								<li><a title="저장" class="btn-save" href="#" onclick="doAction('M9801030_1_Sheet', 'save'); return false;" role="button">저장</a></li>								
							</ul>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9801030_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M9801030_1_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 공정내용</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">
								<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9801030_2_Sheet', 'input')" role="button">신규</a></li>
								<li><a title="저장" class="btn-save" href="#" onclick="doAction('M9801030_2_Sheet', 'save'); return false;" role="button">저장</a></li>							
							</ul>
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M9801030_2_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M9801030_2_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 작업실</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">
								<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9801030_3_Sheet', 'input')" role="button">신규</a></li>
								<li><a title="저장" class="btn-save" href="#" onclick="doAction('M9801030_3_Sheet', 'save'); return false;" role="button">저장</a></li>							
							</ul>
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M9801030_3_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M9801030_3_Sheet"></div>
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
