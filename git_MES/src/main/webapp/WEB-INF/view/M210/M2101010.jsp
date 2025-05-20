<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<script type="text/javascript">
	<%--화면 로딩시 동작 정의--%>
	$(document).ready(
		
		function() {
			
			//기본 날짜 지정
			$('#start_date').val(get_date('1'));
			$('#end_date').val(get_date('today'));
			
			//IBSheet 생성 영역
			iB_Sheet_Make("M2101010_1_Sheet","${M2101010_1_Sheet}","100%");
			iB_Sheet_Make("M2101010_2_Sheet","${M2101010_2_Sheet}","100%");
			iB_Sheet_Make("M2101010_3_Sheet","${M2101010_3_Sheet}","100%");
			doAction('M2101010_1_Sheet','search');
		});
	
	//특정 행 클릭시 발생 이벤트
	function M2101010_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			$('#manu_CD').val(M2101010_1_Sheet.GetCellValue(NewRow,"manu_CD"));
			doAction('M2101010_2_Sheet','search');
		}
	}
	
	//특정 행 클릭시 발생 이벤트
	function M2101010_2_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			$('#item_CD').val(M2101010_2_Sheet.GetCellValue(NewRow,"item_CD"));
			doAction('M2101010_3_Sheet','search');
		}
	}
	
	//행 변경시 이벤트
	function M2101010_2_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {

		if (Col == 3) {
			var data = {};
			data["inventory_unit_C"] = "";
			set_data(M2101010_2_Sheet,Row,"item_CD",data,"item");
		}
	}
	
	//제품명명 콤보박스 데이터로 가져오기
	function get_item_CD_ComBo (Row){
	    	$.ajax({
	  	    		url: "<c:url value='/M210/get_item_CD_ComBo.do'/>",
	  	    	type: "POST",
	  	    	data: {},
	  	    	async: false,
	  	    	dataType: "json",
	  	    	success : function( data ) {
	  	    		M2101010_2_Sheet.CellComboItem(Row,'item_CD',{
	  	    			"ComboText": data.combo_data.ComboText,
	  	    			"ComboCode" : data.combo_data.ComboCode
	  	    		});
	  	    	},
	  	    	err : function(r) {
	  	    		alert('<spring:message code="fail.common.menu.create" />');
	  	    	}});
	}
	
	function M2101010_2_Sheet_OnSearchEnd(Code, Msg, StCode, StMsg) {
		for (var i = 1; i < M2101010_2_Sheet.RowCount()+1; i++) {
			if (M2101010_2_Sheet.GetCellValue(i,"complete_FL") == 1) {
				M2101010_2_Sheet.SetRowEditable(i,0);
			}
			get_item_CD_ComBo(i);
		}
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M210/Common_Data.do'/>",queryStr);
			break;
		case "input":
			var nRow = window[sheetNm].DataInsert(-1);
			
			if (sheetNm == 'M2101010_1_Sheet') {
				window[sheetNm].SetCellValue(nRow,'manu_DT',get_date('today'));
				make_CD_combo(window[sheetNm],"manu_CD","MAN");
				doAction('M2101010_1_Sheet','save');
			} else if (sheetNm == 'M2101010_2_Sheet') {
				get_item_CD_ComBo(nRow);
				window[sheetNm].SetCellValue(nRow,'manu_CD',M2101010_1_Sheet.GetCellValue(M2101010_1_Sheet.GetSelectRow(),"manu_CD"));
			}
			
			break;
		case "save":
			var param = {url:"<c:url value='/M210/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);
			break;	
		case "delete":
			window[sheetNm].SetCellValue(window[sheetNm].GetSelectRow(),'sStatus','D');
			doAction('M2101010_1_Sheet','save');
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
			<input type="text" hidden="true" id="manu_CD" name="manu_CD">
			<input type="text" hidden="true" id="item_CD" name="item_CD">
			<div class="inquiry-box">
				<table class="table">
					<caption>검색조건</caption>
					<tbody>
						<tr>	
							<th class="required"><label for="">지시일자</label></th>
							<td>
								<input type="Date" class="form width40" title="지시일자 시작" id="start_date" name="start_date" onchange="doAction('M2101010_1_Sheet', 'search'); return false;"/>~
								<input type="Date" class="form width40" title="지시일자 종료" id="end_date" name="end_date" onchange="doAction('M2101010_1_Sheet', 'search'); return false;"/>
							</td>
							<th><label for="complete_FL" onchange="doAction('M1001020_1_Sheet','search')">완료 여부</label></th>
							<td>
									<input type="radio" name="complete_FL" id="complete_FL" value="%" onchange="doAction('M2101010_1_Sheet','search')"/>전체
									<input type="radio" name="complete_FL" id="complete_FL" value="0" checked="checked" onchange="doAction('M2101010_1_Sheet','search')"/>미완료
									<input type="radio" name="complete_FL" id="complete_FL" value="1" onchange="doAction('M2101010_1_Sheet','search')"/>완료
							</td>
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
							<h6> 생산지시서</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">
								<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M2101010_1_Sheet', 'input')" role="button">신규</a></li>
								<li><a title="삭제" class="btn-delete" href="#" id="delete"  onclick="doAction('M2101010_1_Sheet', 'delete'); return false;" role="button">삭제</a></li>															
							</ul>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M2101010_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M2101010_1_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 생산품목</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">
								<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M2101010_2_Sheet', 'input')" role="button">신규</a></li>
								<li><a title="저장" class="btn-save" href="#" onclick="doAction('M2101010_2_Sheet', 'save'); return false;" role="button">저장</a></li>							
							</ul>
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M2101010_2_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M2101010_2_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 현재상황</h6>
						</div>
						<div class="btn-y-group">
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M2101010_3_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M2101010_3_Sheet"></div>
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
