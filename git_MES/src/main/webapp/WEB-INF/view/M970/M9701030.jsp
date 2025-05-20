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
			
			//검색창에서 엔터시 검색
			$("[name^=searchForm]").keypress(function(){
				if(event.keyCode==13){
					doAction('M9701030_1_Sheet','search');
					doAction('M9701030_3_Sheet','search');
					return false;
					}
			});
			
			//기본 날짜 지정
			$('#start_date1').val(get_date('1'));
			$('#end_date1').val(get_date('today'));
			$('#start_date2').val(get_date('1'));
			$('#end_date2').val(get_date('today'));

			//IBSheet 생성 영역
			iB_Sheet_Make("M9701030_1_Sheet","${M9701030_1_Sheet}","200px");	
			iB_Sheet_Make("M9701030_2_Sheet","${M9701030_2_Sheet}","330px");	
			iB_Sheet_Make("M9701030_3_Sheet","${M9701030_3_Sheet}","200px");	
			iB_Sheet_Make("M9701030_4_Sheet","${M9701030_4_Sheet}","330px");	
			
			doAction('M9701030_1_Sheet','search');
			doAction('M9701030_3_Sheet','search');

	});
	
	//특정 행 클릭시 발생 이벤트
	function M9701030_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			doAction('M9701030_2_Sheet','search');
		}
	}
	
	//특정 행 클릭시 발생 이벤트
	function M9701030_3_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			doAction('M9701030_4_Sheet','search');
		}
	}
	
	function M9701030_1_Sheet_OnSearchEnd() { 
		var value = 0;
		
		for (var i = 1; i < M9701030_1_Sheet.RowCount() + 1; i++) {
			value += M9701030_1_Sheet.GetCellValue(i,'total_price');
		}
		
		$('#total_price1').val(value);
	}
	
	function M9701030_3_Sheet_OnSearchEnd() { 
		var value = 0;
		
		for (var i = 1; i < M9701030_3_Sheet.RowCount() + 1; i++) {
			value += M9701030_3_Sheet.GetCellValue(i,'total_price');
		}
		
		$('#total_price2').val(value);
	}
	
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		
		if (sheetNm == 'M9701030_2_Sheet') {
			$('#supply_clie_CD_97').val(M9701030_1_Sheet.GetCellValue(M9701030_1_Sheet.GetSelectRow(),'supply_clie_CD_97'));	
		}else if (sheetNm == 'M9701030_4_Sheet') {
			$('#supply_clie_CD_97').val(M9701030_3_Sheet.GetCellValue(M9701030_3_Sheet.GetSelectRow(),'supply_clie_CD_97'));	
		}
		
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M970/Common_Data.do'/>",queryStr);
			break;
		case "save":
			var param = {url:"<c:url value='/M970/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);		
			break;
		case "print":
           
			var list = M9701030_1_Sheet.GetComboInfo(M9701030_1_Sheet.GetSelectRow(), 0,'text').split('|');
			
			var supply_clie_NM_97 = list[M9701030_1_Sheet.GetComboInfo(M9701030_1_Sheet.GetSelectRow(), 0,'selectedIndex')];
			
			var jrf_NM = "97_bill_1.jrf"
			
			var UB_data = "comp_CD#${comp_CD}#";
			UB_data += "start_date1#"+$('#start_date1').val() + "#";
			UB_data += "end_date1#"+$('#end_date1').val() + "#";
			UB_data += "start_date2#"+$('#start_date2').val() + "#";
			UB_data += "end_date2#"+$('#end_date2').val() + "#";
			UB_data += "supply_clie_CD_97#" + $('#supply_clie_CD_97').val() + "#";
			UB_data += "supply_clie_NM_97#" + supply_clie_NM_97 + "#";
			
			UB_print(jrf_NM,UB_data);
						
			break;
		case "print2":
            
			var list = M9701030_1_Sheet.GetComboInfo(M9701030_1_Sheet.GetSelectRow(), 0,'text').split('|');
			
			var enter_clie_NM_97 = list[M9701030_1_Sheet.GetComboInfo(M9701030_1_Sheet.GetSelectRow(), 0,'selectedIndex')];
			var supply_clie_NM_97 = list[M9701030_1_Sheet.GetComboInfo(M9701030_1_Sheet.GetSelectRow(), 0,'selectedIndex')];
			
			var jrf_NM = "97_bill_2.jrf"
			
			var UB_data = "comp_CD#${comp_CD}#";
			UB_data += "start_date1#"+$('#start_date1').val() + "#";
			UB_data += "end_date1#"+$('#end_date1').val() + "#";
			UB_data += "start_date2#"+$('#start_date2').val() + "#";
			UB_data += "end_date2#"+$('#end_date2').val() + "#";
			UB_data += "supply_clie_CD_97#" + $('#supply_clie_CD_97').val() + "#";
			UB_data += "supply_clie_NM_97#" + supply_clie_NM_97 + "#";
			UB_print(jrf_NM,UB_data);
						
			break;
			
		case "print3":
            
			var jrf_NM = "97_bill_3.jrf"
				
				var UB_data = "comp_CD#${comp_CD}#";
				UB_data += "start_date1#"+$('#start_date1').val() + "#";
				UB_data += "end_date1#"+$('#end_date1').val() + "#";
				UB_data += "start_date2#"+$('#start_date2').val() + "#";
				UB_data += "end_date2#"+$('#end_date2').val() + "#";
				UB_data += "supply_clie_CD_97#" + $('#supply_clie_CD_97').val() + "#";
				UB_data += "supply_clie_NM_97#" + supply_clie_NM_97 + "#";

				UB_print(jrf_NM,UB_data);
						
			break;
			
		case "print4":
            
			var jrf_NM = "97_bill_4.jrf"
				
				var UB_data = "comp_CD#${comp_CD}#";
				UB_data += "start_date1#"+$('#start_date1').val() + "#";
				UB_data += "end_date1#"+$('#end_date1').val() + "#";
				UB_data += "start_date2#"+$('#start_date2').val() + "#";
				UB_data += "end_date2#"+$('#end_date2').val() + "#";
				UB_data += "supply_clie_CD_97#" + $('#supply_clie_CD_97').val() + "#";
				UB_data += "supply_clie_NM_97#" + supply_clie_NM_97 + "#";

				UB_print(jrf_NM,UB_data);
						
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
				<h4>청구서</h4>
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
			<input type="text" hidden="true" id="supply_clie_CD_97" name="supply_clie_CD_97">
			<div class="inquiry-box">
				<table class="table">
					<caption>청구서</caption>
					<tbody>
						<tr class="line">
							<th class="required"><label for="">등록 일자</label></th>
							<td>
								<input type="Date" class="form width40" title="등록일자 시작" id="start_date1" name="start_date1" onchange="doAction('M9701030_1_Sheet', 'search'); return false;"/>~
								<input type="Date" class="form width40" title="등록일자 종료" id="end_date1" name="end_date1" onchange="doAction('M9701030_1_Sheet', 'search'); return false;"/>
							</td>
							<th scope="row"><label for="total_price1">총 금액</label></th>
							<td><input type="text" id="total_price1" name="total_price1" title="총 금액"  readonly="readonly"/></td>
							<th scope="row"><label for="supply_clie_NM_971">공급처</label></th>
							<td><input type="text" id="supply_clie_NM_971" name="supply_clie_NM_971" title="공급처" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="check_DT">검색 일자</label></th>
							<td>
								<input type="Date" class="form width40" title="등록일자 시작" id="start_date2" name="start_date2" onchange="doAction('M9701030_3_Sheet', 'search'); return false;"/>~
								<input type="Date" class="form width40" title="등록일자 종료" id="end_date2" name="end_date2" onchange="doAction('M9701030_3_Sheet', 'search'); return false;"/>
							</td>
							<th scope="row"><label for="total_price2">총 금액</label></th>
							<td><input type="text" id="total_price2" name="total_price2" title="총 금액"  readonly="readonly"/></td>
							<th scope="row"><label for="supply_clie_NM_972">공급처</label></th>
							<td><input type="text" id="supply_clie_NM_972" name="supply_clie_NM_972" title="공급처" /></td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
			<%--검색조건 영역--%>	
			
			<%--하단 컨텐츠(전체) 영역--%>
			<div class="layout-grid">
				<div class="grid-left45">
				<!-- title -->
					<div class="title">
						<div class="title-area">
							<h6>청구서목록</h6>
						</div>
						<div class="btn-group">
							<ul class="list-inline">
								<li><a title="인쇄" class="btn-print" href="#" onclick="doAction('M9701030_1_Sheet', 'print'); return false;" role="button">인쇄</a></li>
								<li><a title="인쇄2" class="btn-print" href="#" onclick="doAction('M9701030_1_Sheet', 'print2'); return false;" role="button">인쇄2</a></li>
								<li><a title="인쇄3" class="btn-print" href="#" onclick="doAction('M9701030_1_Sheet', 'print4'); return false;" role="button">인쇄3</a></li>
							 </ul>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9701030_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M9701030_1_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
				<div class="grid-right45">
				<!-- title -->
					<div class="title">
						<div class="title-area">
							<h6>청구서목록</h6>
						</div>
						<div class="btn-group">
							<ul class="list-inline">
								<li><a title="인쇄" class="btn-print" href="#" onclick="doAction('M9701030_1_Sheet', 'print3'); return false;" role="button">인쇄</a></li>								
							 </ul>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9701030_3_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M9701030_3_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
				<div class="grid-left45">
					<!-- title -->
					<div class="title">
						<div class="title-area">
							<h6> 판매내역</h6>
						</div>
						<!--  button group -->
						<div class="btn-y-group">
							<ul class="list-inline">																					
								<li><a title="저장" class="btn-save" href="#" 	id="save2"  	onclick="doAction('M9701030_2_Sheet', 'save'); return false;" role="button">저장</a></li>														
							</ul>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9701030_2_Sheet_totalcnt"></span> 건</p>
						</div>
						<div style="float: left; margin-left: 15px;">
						</div>
					</div>
					<div class="clear"></div>
					<div id="M9701030_2_Sheet">
					</div>
				</div>
				<div class="grid-right45">
					<!-- title -->
					<div class="title">
						<div class="title-area">
							<h6> 판매내역</h6>
						</div>
						<!--  button group -->
						<div class="btn-y-group">
							<ul class="list-inline">																
							</ul>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9701030_4_Sheet_totalcnt"></span> 건</p>
						</div>
						<div style="float: left; margin-left: 15px;">
						</div>
					</div>
					<div class="clear"></div>
					<div id="M9701030_4_Sheet">
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