<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				doAction('M9701010_1_Sheet','search');
				return false;
				}
		});

		$('#start_date').val(get_date('today'));
		$('#end_date').val(get_date('today'));
		

		//IBSheet 생성 영역
		iB_Sheet_Make("M9701010_1_Sheet","${M9701010_1_Sheet}","100%");	
		doAction('M9701010_1_Sheet','search');
		
	});
	    
	//조회 종료후 실행함수
	function M9701010_1_Sheet_OnSearchEnd(Code, Msg, StCode, StMsg){ 
		var production = 0;
		var delivery = 0;
		var inventory = 0;
		
		for (var i = 1; i < M9701010_1_Sheet.RowCount() + 1; i++) {
			
			production += M9701010_1_Sheet.GetCellValue(i,"in_quantity");
			delivery += M9701010_1_Sheet.GetCellValue(i,"out_quantity");
			
		}
		
		inventory = production - delivery;
		
		$('#production').val(production);
		$('#delivery').val(delivery);
		$('#inventory').val(inventory);
	}
	
	//행 변경시 이벤트
	function M9701010_1_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {
		
		if(Col == 9) {
			var division = M9701010_1_Sheet.GetCellValue(Row,4);
			var status = M9701010_1_Sheet.GetCellValue(Row,1);
			if (division == 2 && RaiseFlag == 0 && status == 'U' ) {
				alert('출고시에는 공급처를 수정할수 없습니다.\n거래명세서에서 수정해주세요.');
				M9701010_1_Sheet.SetCellValue(Row,Col,OldValue);
			}
		}
		
		if(Col == 12 || Col == 13) {
			var division = M9701010_1_Sheet.GetCellValue(Row,4);
			switch (Col) {
			case 11:
					if (division == 2 && RaiseFlag == 0) {
						alert('출고시에는 입고값을 넣을수 없습니다.');
						M9701010_1_Sheet.SetCellValue(Row,Col,OldValue);
					}
				break;
			case 13:
				if ((division == 1 && RaiseFlag == 0) || (division == 3 && RaiseFlag == 0)) {
					alert('생산 및 반품시에는 출고값을 넣을수 없습니다.');
					M9701010_1_Sheet.SetCellValue(Row,Col,OldValue);
				}				
				break;
			default:
				break;
			}
		}
		if (Col == 10 && RaiseFlag == 0) {
			if (M9701010_1_Sheet.GetComboInfo(Row, Col, 'selectedIndex') == -1) {
				alert('잘못된 데이터 입니다.');
				M9701010_1_Sheet.SetCellValue(Row,Col,OldValue);
				M9701010_1_Sheet.SetSelectCol(Col);	
			} else {
				var data = {};
				data["real_order"] = "";
				set_data(M9701010_1_Sheet,Row,"enter_clie_CD_97",data,"E97");				
			}
		}
		
		if (Col == 11 && RaiseFlag == 0) {
			if (M9701010_1_Sheet.GetComboInfo(Row, Col, 'selectedIndex') == -1) {
				alert('잘못된 데이터 입니다.');
				M9701010_1_Sheet.SetCellValue(Row,Col,OldValue);
				M9701010_1_Sheet.SetSelectCol(Col);	
			}
		}
		
		if (Col == 6 && RaiseFlag == 0) {
			if (M9701010_1_Sheet.GetComboInfo(Row, Col, 'selectedIndex') == -1) {
				alert('잘못된 데이터 입니다.');
				M9701010_1_Sheet.SetCellValue(Row,Col,OldValue);
				M9701010_1_Sheet.SetSelectCol(Col);
			}else {			
				var data = {};
				data["item_CD_97"] = "";
				data["color_CD_97"] = "";
				data["count_97"] = "";
				set_data(M9701010_1_Sheet,Row,"lot_CD_97",data,"L97");
			}
		} 
	}
	
	function doAction(sheetNm, action){
		$('#sheetNm').val(sheetNm);
		if(sheetNm == 'M9701010_1_Sheet' ){
			
			switch (action) {
			case "input":				
				var nRow = window[sheetNm].DataInsert(-1);
				window[sheetNm].SetCellValue(nRow,'regist_DT',get_date('today'));
				window[sheetNm].SetCellValue(nRow,'in_quantity','0');
				window[sheetNm].SetCellValue(nRow,'out_quantity','0');

				M9701010_1_Sheet_OnChange(nRow, 6, window[sheetNm].GetCellValue(nRow,6), '', 0);
				M9701010_1_Sheet_OnChange(nRow, 9, window[sheetNm].GetCellValue(nRow,9), '', 0);
				
				break;
				
			case "save":

		  		make_CD(window[sheetNm],"data_CD_97","D97");
		  		
                var param = {url:"<c:url value='/M970/Common_Data.do'/>", sheet:[sheetNm]};
                DataSave(param);                
				break;
				
			case "search":					
				
				
				$('#color_CD_97').val(document.querySelector("#temp_color_CD_97_list option[value='" + $('#temp_color_CD_97').val() + "']").dataset.value);
				
		 		var queryStr = FormQueryStringEnc(document.searchForm);		
		 		window[sheetNm].DoSearch("<c:url value='/M970/Common_Data.do'/>",queryStr);	
				break;
				
			default:
				break;
			}
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
				<h4>제품 수불</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9701010_1_Sheet', 'input')" role="button">신규</a></li>
					<li><a title="저장" class="btn-save" href="#" onclick="doAction('M9701010_1_Sheet', 'save'); return false;" role="button">저장</a></li>
					<li><a  title="초기화" class="btn-reset" href="#"  onclick="doAction('M9701010_1_Sheet','search'); return false;" role="button">초기화</a></li>
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post"> 
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="color_CD_97" name="color_CD_97">
			<div class="inquiry-box">
				<table class="table">
					<tbody>
						<tr class="line">			
							<th class="required"><label for="">등록일자</label></th>
							<td>
								<input type="Date" class="form width40" title="발주일자 시작" id="start_date" name="start_date" onchange="doAction('M9701010_1_Sheet', 'search'); return false;"/>~
								<input type="Date" class="form width40" title="발주일자 종료" id="end_date" name="end_date" onchange="doAction('M9701010_1_Sheet', 'search'); return false;"/>
							</td>
							<th scope="row"><label for="division">구분자</label></th>
							<td>
								<select class="form" id="division" name="division" title="구분자" onchange="doAction('M9701010_1_Sheet','search')">								
										<option value="%">전체</option>
							 			<option value="1">생산</option>
							 			<option value="2">출고</option>
							 			<option value="3">반품</option>
							 			<option value="4">재고조정</option>
								</select>
							</td>
							<th scope="row"><label for="temp_color_CD_97">색상</label></th>
							<td>
								<input type="text" list="temp_color_CD_97_list" id="temp_color_CD_97" onchange= "doAction('M9701010_1_Sheet','search')">
								<datalist id="temp_color_CD_97_list">																
										<option data-value="%" value="" />
							 		<c:forEach var="item" items="${color_CD_97}">
										<option  data-value="${item.some_CD}" value="${item.some_NM}"/>
									</c:forEach> 
								</datalist>
							</td>
							<th scope="row"><label for="item_CD_97">아이템명</label></th>
							<td>
								<select class="form" id="item_CD_97" name="item_CD_97" title="아이템명" onchange="doAction('M9701010_1_Sheet','search')">								
										<option value="%">전체</option>
							 		<c:forEach var="item" items="${item_CD_97}">
										<option value="${item.some_CD}">${item.some_NM}</option>
									</c:forEach> 
								</select>
							</td>
							<th></th><td></td>
						</tr>
						<tr class="line">			
							<th scope="row"><label for="lot_NM_97">Lot번호</label></th>
							<td><input type="text" id="lot_NM_97" name="lot_NM_97" title="lot번호" /></td>
							<th scope="row"><label for="supply_clie_NM_97">공급처</label></th>
							<td><input type="text" id="supply_clie_NM_97" name="supply_clie_NM_97" title="공급처" /></td>
							<th scope="row"><label for="enter_clie_NM_97">발주처</label></th>
							<td><input type="text" id="enter_clie_NM_97" name="enter_clie_NM_97" title="발주처" /></td>
							<th scope="row"><label for="exit_clie_NM_97">출고처</label></th>
							<td><input type="text" id="exit_clie_NM_97" name="exit_clie_NM_97" title="출고처" /></td>
							<th></th><td></td>
						</tr>						
						<tr class="line">			
							<th scope="row"><label for="production">입고 수량</label></th>
							<td><input type="text" id="production" name="production" title="입고 수량"  readonly="readonly"/></td>
							<th scope="row"><label for="delivery">출고 수량</label></th>
							<td><input type="text" id="delivery" name="delivery" title="출고 수량" readonly="readonly"/></td>
							<th scope="row"><label for="inventory">재고 수량</label></th>
							<td><input type="text" id="inventory" name="inventory" title="재고 수량" readonly="readonly"/></td>
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
							<h6> 제품 수불</h6>
						</div>
						<div class="title-set">
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M9701010_1_Sheet"></div>
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