<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function(){
		iB_Sheet_Make("M1001020_1_Sheet","${M1001020_1_Sheet}","575px");
		iB_Sheet_Make("M1001020_2_Sheet","${M1001020_2_Sheet}","575px");
		iB_Sheet_Make("M1001020_3_Sheet","${M1001020_3_Sheet}","575px");
	
		doAction('M1001020_1_Sheet','search');
	
	});
	
	//1번시트 선택시
	function M1001020_1_Sheet_OnSelectCell(OldRow, OldCol, NewRow, NewCol,isDelete) {
		if (OldRow != NewRow) {
			doAction('M1001020_2_Sheet','search');
			doAction('M1001020_3_Sheet','search');
		}
	}
	
	function M1001020_3_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {
		if (Col == 5){
			var data = {};
			data["inventory_unit_C"] = "";
			set_data(M1001020_3_Sheet,Row,"item_CD",data,"item");
		}
	}
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		$('#orde_CD').val(M1001020_1_Sheet.GetCellValue(M1001020_1_Sheet.GetSelectRow(),"orde_CD"));
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M100/Common_Data.do'/>",queryStr);
			
			break;
		case "input":
			var nRow = window[sheetNm].DataInsert(-1);
			window[sheetNm].SetCellValue(nRow,'befor_CD',$('#orde_CD').val());
			break;
		case "save":
			
			for (var i = 1; i < window[sheetNm].RowCount() + 1 ; i++) {
				if (window[sheetNm].GetCellValue(i,"out_quantity") != 0) {
					alert('이미 사용한 제품이 있습니다.');
					return false;
				}
				
				if (window[sheetNm].GetCellValue(i,"in_quantity") == 0) {
					alert('입고수량이 0 입니다.');
					return false;
				}
				
			}
			
			make_CD_combo(window[sheetNm],"inve_CD","INV");
			
			var param = {url:"<c:url value='/M100/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);
			break;
		case "sandData":
			for (var i = 1; i < window[sheetNm].RowCount() + 1 ; i++) {
				var nRow = M1001020_3_Sheet.DataInsert(-1);
				var item_CD =  window[sheetNm].GetCellValue(i,"item_CD");
				var quantity = window[sheetNm].GetCellValue(i,"quantity");
				
		    	$.ajax({
	  	    		url: "<c:url value='/M100/item_sandData.do'/>",
	  	    	type: "POST",
	  	    	data: {item_CD:item_CD, quantity:quantity},
	  	    	async: false,
	  	    	dataType: "json",
	  	    	success : function( data ) {
	  	    		M1001020_3_Sheet.SetCellValue(nRow,'befor_CD',$('#orde_CD').val());
	  	    		M1001020_3_Sheet.SetCellValue(nRow,'item_CD',data.item_data.item_CD);
	  	    		M1001020_3_Sheet.SetCellValue(nRow,'in_quantity',data.item_data.quantity);
	  	    	},
	  	    	err : function(r) {
	  	    		alert('<spring:message code="fail.common.menu.create" />');
	  	    	}});
		    	
			}
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
				<h4>발주 입고 관리</h4>
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
			<input type="text" hidden="true" id="orde_CD" name="orde_CD">
			<div class="inquiry-box">
				<table class="table" style="font-size: 12px">
					<caption>검색조건</caption>
					<tbody>
						<tr>	
							<th scope="row"><label for="client_cd">거래처 명</label></th>
							<td>
								<select class="form" id="clie_CD" name="clie_CD" title="거래처명 " onchange="doAction('M1001020_1_Sheet','search')">
									<option value="%">전체</option>								
					 				<c:forEach var="item" items="${clie_CD}">
										<option value="${item.some_CD}">${item.some_NM}</option>
									</c:forEach> 
								</select>
							</td>
							<th><label for="complete_FL" onchange="doAction('M1001020_1_Sheet','search')">완료 여부</label></th>
							<td>
									<input type="radio" name="complete_FL" id="complete_FL" value="%" onchange="doAction('M1001020_1_Sheet','search')"/>전체
									<input type="radio" name="complete_FL" id="complete_FL" value="0" checked="checked" onchange="doAction('M1001020_1_Sheet','search')"/>미완료
									<input type="radio" name="complete_FL" id="complete_FL" value="1" onchange="doAction('M1001020_1_Sheet','search')"/>완료
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
							<h6> 발주 Lot 목록</h6>
						</div>
						<div class="btn-y-group">
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M1001020_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M1001020_1_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 입고 예정 목록</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">
								<li><a class="btn-act" href="#" role="button" onclick="doAction('M1001020_2_Sheet', 'sandData'); return false;" title="입고적용">입고적용</a></li></ul>
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M1001020_2_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M1001020_2_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 실제 입고 목록</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">
								<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M1001020_3_Sheet', 'input')" role="button">신규</a></li>
								<li><a title="저장" class="btn-save" href="#" onclick="doAction('M1001020_3_Sheet', 'save'); return false;" role="button">저장</a></li>							
							</ul>
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M1001020_3_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M1001020_3_Sheet"></div>
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