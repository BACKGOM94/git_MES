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
				doAction('M9709010_1_Sheet','search');
				return false;
				}
		});
		
		//IBSheet 생성 영역
		iB_Sheet_Make("M9709010_1_Sheet","${M9709010_1_Sheet}","100%");	
		doAction('M9709010_1_Sheet','search');
		
	});
	
	function M9709010_1_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) { 

		if (Col == 7 || Col == 8) {
			if (M9709010_1_Sheet.GetCellValue(Row,1) == "U") {
				alert('수정시엔 사용할수 없는 기능입니다 \n제품수불 페이지에 생산을 등록해 주세요.');
				M9709010_1_Sheet.SetCellValue(Row,Col,OldValue);
				M9709010_1_Sheet.SetSelectCol(Col);
			}
		}
		
		if (Col == 7 && RaiseFlag == 0) {
			if (M9709010_1_Sheet.GetComboInfo(Row, Col, 'selectedIndex') == -1) {
				alert('잘못된 데이터 입니다.');
				M9709010_1_Sheet.SetCellValue(Row,Col,OldValue);
				M9709010_1_Sheet.SetSelectCol(Col);	
			}
		}
		
		if (Col == 5) {
			var data = {};
			set_data_combo(M9709010_1_Sheet,Row,'item_CD_97','color_CD_97','set_item_get_color_97');
		}		
	}

	function doAction(sheetNm, action){
		$('#sheetNm').val(sheetNm);
		if(sheetNm == 'M9709010_1_Sheet' ){
			
			switch (action) {
			case "input":				
				var nRow = window[sheetNm].DataInsert(-1);		
				M9709010_1_Sheet_OnChange(nRow, 5, '', '', 0);
				window[sheetNm].SetCellValue(nRow,'enter_clie_CD_97','');
				break;
				
			case "save":
				var Row = window[sheetNm].FindStatusRow("U|I").split(";");
				
		  		for (var i = 0; i < Row.length; i++) {
		  	  	    for (var j = 1; j < window[sheetNm].RowCount() + 1; j++) {
						if (Row[i] ==  j) {
							continue;
						}else {
							var edit_value = window[sheetNm].GetCellValue(Row[i],"lot_NM_97");
							var value = window[sheetNm].GetCellValue(j,"lot_NM_97");
							
							if (edit_value == value) {
								alert(edit_value + " 는 이미 존재합니다.");
								return false;
							}
							
						}
					}
				}
		  		
		  		Row = window[sheetNm].FindStatusRow("I").split(";");
		  		
		  		make_CD(window[sheetNm],"lot_CD_97","L97");
		  		
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
				<h4>Lot 관리</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9709010_1_Sheet', 'input')" role="button">신규</a></li>
					<li><a title="저장" class="btn-save" href="#" onclick="doAction('M9709010_1_Sheet', 'save'); return false;" role="button">저장</a></li>				
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
							<th scope="row"><label for="lot_NM_97">Lot번호</label></th>
							<td><input type="text" id="lot_NM_97" name="lot_NM_97" title="lot번호" /></td>
							<th scope="row"><label for="temp_color_CD_97">색상</label></th>
							<td>
								<input type="text" list="temp_color_CD_97_list" id="temp_color_CD_97" onchange= "doAction('M9709010_1_Sheet','search')">
								<datalist id="temp_color_CD_97_list">																
										<option data-value="%" value="" />
							 		<c:forEach var="item" items="${color_CD_97}">
										<option  data-value="${item.some_CD}" value="${item.some_NM}"/>
									</c:forEach> 
								</datalist>
							</td>
							<th scope="row"><label for="item_CD_97">아이템명</label></th>
							<td>
								<select class="form" id="item_CD_97" name="item_CD_97" title="아이템명" onchange="doAction('M9709010_1_Sheet','search')">								
										<option value="%">전체</option>
							 		<c:forEach var="item" items="${item_CD_97}">
										<option value="${item.some_CD}">${item.some_NM}</option>
									</c:forEach> 
								</select>
							</td>
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
							<h6> Lot 관리</h6>
						</div>
						<div class="title-set">
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M9709010_1_Sheet"></div>
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