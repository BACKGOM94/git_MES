<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table.stockData tr td {
		border : 1px solid #bcbcbc;
		border-collapse : collapse;
		height : 22px;
		font-size : 10px;
	}
	
	table.stockData tr td.titleRow {
		font-weight : 700;
		background-color : #E6FAFA;
	}
	
	input.inputRow {
		border : none;
		background-color : #ffffff;
		text-align : right;
		width : 90%;
	}
</style>

<script type="text/javascript">
$(document).ready(				
		function(){
			
			//기본 날짜 지정
			$('#start_date').val(get_date('1'));
			$('#end_date').val(get_date('today'));
			
			//IBSheet 생성 영역
			iB_Sheet_Make("M1001010_1_Sheet","${M1001010_1_Sheet}","200px");	
			iB_Sheet_Make("M1001010_2_Sheet","${M1001010_2_Sheet}","330px");	
			
			doAction('M1001010_1_Sheet','search');

	});
	
	//특정 행 클릭시 발생 이벤트
	function M1001010_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			doAction('M1001010_2_Sheet','search');
		}
	}
	
	//행 변경시 이벤트
	function M1001010_1_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {
		if (Col == 3) {
			var data = {};
			data["manager_NM"] = "";
			data["manager_phone_NO"] = "";
			set_data(M1001010_1_Sheet,Row,"clie_CD",data,"clie");
		}
	}
	
	//거래처에 따른 제품 콤보박스 데이터로 가져오기
	function get_item_CD_ComBo (Row){
		var clie_CD = M1001010_1_Sheet.GetCellValue(M1001010_1_Sheet.GetSelectRow(),'clie_CD');
		
	    	$.ajax({
	  	    		url: "<c:url value='/M100/get_item_CD_ComBo.do'/>",
	  	    	type: "POST",
	  	    	data: {clie_CD:clie_CD},
	  	    	async: false,
	  	    	dataType: "json",
	  	    	success : function( data ) {
	  	    		 
	  	    		M1001010_2_Sheet.CellComboItem(Row,'item_CD',{
	  	    			"ComboText": data.combo_data.ComboText,
	  	    			"ComboCode" : data.combo_data.ComboCode
	  	    		});
	  	    		
	  	    	},
	  	    	err : function(r) {
	  	    		alert('<spring:message code="fail.common.menu.create" />');
	  	    	}});
	}
	
	//행 변경시 이벤트
	function M1001010_2_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {	
		
		if(RaiseFlag == 0){
			if (Col == 5 || Col == 7) {
	
				var order_price = M1001010_2_Sheet.GetCellValue(Row,"order_price");
				var quantity = M1001010_2_Sheet.GetCellValue(Row,"quantity");
				var supply_price = 0;
				var tax_price = 0;
				var total_price = 0;

				if (M1001010_2_Sheet.GetCellValue(Row,"tax_FL") == 0) {
					supply_price = order_price * quantity;
					total_price = order_price * quantity;
				}else if (M1001010_2_Sheet.GetCellValue(Row,"tax_FL") == 1) {
					supply_price = (order_price * quantity) * 0.9;
					tax_price = (order_price * quantity) * 0.1;
					total_price = order_price * quantity;	
				}
				
				M1001010_2_Sheet.SetCellValue(Row,'supply_price',supply_price);
				M1001010_2_Sheet.SetCellValue(Row,'tax_price',tax_price);
				M1001010_2_Sheet.SetCellValue(Row,'total_price',total_price);
				
			}
		}
		
		if (Col == 4) {
				var data = {};
				data["order_unit_C"] = "";
				data["order_price"] = "";
				data["standard"] = "";
				data["item_group_C"] = "";
				data["tax_FL"] = "";
				set_data(M1001010_2_Sheet,Row,"item_CD",data,"item");
				M1001010_2_Sheet.SetCellValue(Row,'quantity',0);
		}
	}
	function M1001010_1_Sheet_OnSearchEnd(Code, Msg, StCode, StMsg) {
		for (var i = 1; i < M1001010_1_Sheet.RowCount()+1; i++) {
			if (M1001010_1_Sheet.GetCellValue(i,"complete_FL") == 1) {
				M1001010_1_Sheet.SetRowEditable(i,0);
			}
		}
	}
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		$('#orde_CD').val(M1001010_1_Sheet.GetCellValue(M1001010_1_Sheet.GetSelectRow(),'orde_CD'));
		
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M100/Common_Data.do'/>",queryStr);
			
			break;
		case "input":
			if (sheetNm =='M1001010_2_Sheet'){
				if (M1001010_1_Sheet.FindStatusRow("I").length != 0) {
					alert("생산 지시서부터 만들어주세요.");
					return false;
				 }
			}
			var nRow = window[sheetNm].DataInsert(-1);
			 if (sheetNm =='M1001010_2_Sheet') {
				 
				M1001010_2_Sheet_OnChange(nRow,'4');
				 window[sheetNm].SetCellValue(nRow,'orde_CD',$('#orde_CD').val());
				 get_item_CD_ComBo(nRow);
			 } else if ((sheetNm =='M1001010_1_Sheet')){
				 window[sheetNm].SetCellValue(nRow,'order_DT',get_date('today'));
				 M1001010_1_Sheet_OnChange(nRow,'3');
			 }
			break;
		case "save":
			
			if (sheetNm =='M1001010_1_Sheet') {
				make_CD_combo(window[sheetNm],"orde_CD","ORD");
			}else if (sheetNm =='M1001010_2_Sheet'){
				if (IBSheet_double_Check(window[sheetNm],"item_CD") != 0) {
					alert("제품이 중복됩니다. 확인후 진행해주세요.");
					return false;
				}			
				for (var i = 1; i < window[sheetNm].RowCount()+1; i++) {
					if (window[sheetNm].GetCellValue(i,'quantity') == 0) window[sheetNm].SetCellValue(i,'sStatus','D');
				}
			}
			
			var param = {url:"<c:url value='/M100/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);		
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
				<h4>발주등록</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M1001010_1_Sheet', 'input'); return false;" role="button">신규</a></li>
				    <li><a title="저장" class="btn-save" href="#" onclick="doAction('M1001010_1_Sheet', 'save'); return false;" role="button">저장</a></li>
				    <li><a  title="초기화" class="btn-reset" href="#"  onclick="doAction('M1001010_1_Sheet','reset'); return false;" role="button">초기화</a></li>
				 </ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="orde_CD" name="orde_CD">
			<div class="inquiry-box">
				<table class="table">
					<caption>발주등록</caption>
					<tbody>
						<tr class="line">
							<th class="required"><label for="">발주일자</label></th>
							<td>
								<input type="Date" class="form width40" title="발주일자 시작" id="start_date" name="start_date" onchange="doAction('M1001010_1_Sheet', 'search'); return false;"/>~
								<input type="Date" class="form width40" title="발주일자 종료" id="end_date" name="end_date" onchange="doAction('M1001010_1_Sheet', 'search'); return false;"/>
							</td>
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
				<div class="grid">
				<!-- title -->
					<div class="title">
						<div class="title-area">
							<h6>발주목록 </h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M1001010_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M1001010_1_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
		
				<div class="grid">
					<!-- title -->
					<div class="title">
						<div class="title-area">
							<h6> 품목목록</h6>
						</div>
						<!--  button group -->
						<div class="btn-y-group">
							<ul class="list-inline">													
								<li><a title="신규" class="btn-line-plus" href="#" 	id="input2" 	onclick="doAction('M1001010_2_Sheet', 'input')" role="button">신규</a></li>
								<li><a title="저장" class="btn-save" href="#" 		id="save2"  	onclick="doAction('M1001010_2_Sheet', 'save'); return false;" role="button">저장</a></li>
								<li><a  title="초기화" class="btn-reset" href="#"  onclick="doAction('M1001010_2_Sheet','search');; return false;" role="button">초기화</a></li>								
							</ul>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M1001010_2_Sheet_totalcnt"></span> 건</p>
						</div>
						<div style="float: left; margin-left: 15px;">
						<table class="stockData" style="width: 800px; text-align: center;">
							<tr>
								<td style="width: 7%;" class="titleRow">현재고</td>
								<td style="width: 13%;"><input type="text" name="row_01" class="inputRow" disabled></td>
								<td style="width: 7%;" class="titleRow">출고예정</td>
								<td style="width: 13%;"><input type="text" name="row_02" class="inputRow" disabled></td>
								<td style="width: 7%;" class="titleRow">입고예정</td>
								<td style="width: 13%;"><input type="text" name="row_03" class="inputRow" disabled></td>
								<td style="width: 7%;" class="titleRow">안전재고</td>
								<td style="width: 13%;"><input type="text" name="row_04" class="inputRow" disabled></td>
								<td style="width: 7%;" class="titleRow">가용재고</td>
								<td style="width: 13%;"><input type="text" name="row_05" class="inputRow" disabled></td>
							</tr>
						</table>
						</div>
					</div>
					<div class="clear"></div>
					<div id="M1001010_2_Sheet">
					</div>
				</div>
		
				
			</div>
			<%--하단 컨텐츠(전체) 영역--%>
		</div>
		<%-- page-content --%>
	</div>
	<%-- container --%>
</body>
</html>