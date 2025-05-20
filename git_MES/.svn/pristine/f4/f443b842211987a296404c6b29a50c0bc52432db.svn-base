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
					doAction('M9701020_1_Sheet','search');
					return false;
					}
			});
			
			//기본 날짜 지정
			$('#start_date').val(get_date('1'));
			$('#end_date').val(get_date('today'));
			
			//IBSheet 생성 영역
			iB_Sheet_Make("M9701020_1_Sheet","${M9701020_1_Sheet}","200px");	
			iB_Sheet_Make("M9701020_2_Sheet","${M9701020_2_Sheet}","330px");	
			
			doAction('M9701020_1_Sheet','search');

	});
	
	//특정 행 클릭시 발생 이벤트
	function M9701020_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			doAction('M9701020_2_Sheet','search');
		}
	}

	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		$('#exit_CD_97').val(M9701020_1_Sheet.GetCellValue(M9701020_1_Sheet.GetSelectRow(),'exit_CD_97'));
		$('#order_NO').val(M9701020_1_Sheet.GetCellValue(M9701020_1_Sheet.GetSelectRow(),'order_NO'));
		
		switch (sAction) {
		case "input":
			window.open("<c:url value='/M970/M9701021.do'/>", "거래명세서 등록", "height=600, width=1100, top=200, left=400");
			break;
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M970/Common_Data.do'/>",queryStr);
			break;
		case "save":			
			var param = {url:"<c:url value='/M970/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);								
			break;
		case "print":
            
			var jrf_NM = "97_tansaction_statement.jrf"
			var UB_data = "exit_CD_97#" + $('#exit_CD_97').val() + "#";
			UB_data += "order_NO#" + $('#order_NO').val() + "#";
			UB_data += "comp_CD#${comp_CD}#";
			
			UB_print(jrf_NM,UB_data);
						
			break;
			
		case "print2":
            
			const enter_clie_NM_97 = prompt("발주처를 입력해 주세요.");
			const exit_clie_NM_97 = prompt("출고처를 입력해 주세요.");
			const supply_clie_NM_97 = prompt("공급처를 입력해 주세요.");
			const contact_97 = prompt("공급처의 연락처를 입력해 주세요.");
			const phone_NO_97 = prompt("공급처의 전화번호를 입력해 주세요.");
			
			var jrf_NM = "97_tansaction_statement2.jrf"
			var UB_data = "exit_CD_97#" + $('#exit_CD_97').val() + "#";
			UB_data += "enter_clie_NM_97#"+ enter_clie_NM_97 + "#";
			UB_data += "exit_clie_NM_97#"+ exit_clie_NM_97 + "#";
			UB_data += "supply_clie_NM_97#" + supply_clie_NM_97 + "#";
			UB_data += "contact_97#" + contact_97 + "#";
			UB_data += "phone_NO_97#" + phone_NO_97 + "#";
			UB_data += "comp_CD#${comp_CD}#";
			
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
				<h4>거래명세서</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9701020_1_Sheet', 'input'); return false;" role="button">신규</a></li>			
				    <li><a title="저장" class="btn-save" href="#" onclick="doAction('M9701020_1_Sheet', 'save'); return false;" role="button">저장</a></li>
				    <li><a title="인쇄" class="btn-print" href="#" onclick="doAction('M9701020_1_Sheet', 'print'); return false;" role="button">인쇄</a></li>
				    <li><a title="인쇄2" class="btn-print" href="#" onclick="doAction('M9701020_1_Sheet', 'print2'); return false;" role="button">인쇄2</a></li>				   
				 </ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="exit_CD_97" name="exit_CD_97">
			<input type="text" hidden="true" id="order_NO" name="order_NO">
			<div class="inquiry-box">
				<table class="table">
					<caption>거래명세서</caption>
					<tbody>
						<tr class="line">
							<th class="required"><label for="">등록 일자</label></th>
							<td>
								<input type="Date" class="form width40" title="등록일자 시작" id="start_date" name="start_date" onchange="doAction('M9701020_1_Sheet', 'search'); return false;"/>~
								<input type="Date" class="form width40" title="등록일자 종료" id="end_date" name="end_date" onchange="doAction('M9701020_1_Sheet', 'search'); return false;"/>
							</td>
							<th scope="row"><label for="enter_clie_NM_97">발주처</label></th>
							<td><input type="text" id="enter_clie_NM_97" name="enter_clie_NM_97" title="발주처" /></td>
							<th scope="row"><label for="exit_clie_NM_97">출고처</label></th>
							<td><input type="text" id="exit_clie_NM_97" name="exit_clie_NM_97" title="출고처" /></td>
							<th scope="row"><label for="supply_clie_NM_97">공급처</label></th>
							<td><input type="text" id="supply_clie_NM_97" name="supply_clie_NM_97" title="공급처" /></td>
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
							<h6>거래명세서목록 </h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9701020_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M9701020_1_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
		
				<div class="grid">
					<!-- title -->
					<div class="title">
						<div class="title-area">
							<h6> Lot목록</h6>
						</div>
						<!--  button group -->
						<div class="btn-y-group">
							<ul class="list-inline">																					
								<li><a title="저장" class="btn-save" href="#" 		id="save2"  	onclick="doAction('M9701020_2_Sheet', 'save'); return false;" role="button">저장</a></li>
								<li><a  title="초기화" class="btn-reset" href="#"  onclick="doAction('M9701020_2_Sheet','search'); return false;" role="button">초기화</a></li>								
							</ul>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9701020_2_Sheet_totalcnt"></span> 건</p>
						</div>
						<div style="float: left; margin-left: 15px;">
						</div>
					</div>
					<div class="clear"></div>
					<div id="M9701020_2_Sheet">
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