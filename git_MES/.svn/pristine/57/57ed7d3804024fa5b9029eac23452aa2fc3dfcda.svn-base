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
			iB_Sheet_Make("M2101020_1_Sheet","${M2101020_1_Sheet}","100%");
			iB_Sheet_Make("M2101020_2_Sheet","${M2101020_2_Sheet}","100%");
			iB_Sheet_Make("M2101020_3_Sheet","${M2101020_3_Sheet}","100%");
			doAction('M2101020_1_Sheet','search');
			
		});
	
	//특정 행 클릭시 발생 이벤트
	function M2101020_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			$('#manu_CD').val(M2101020_1_Sheet.GetCellValue(NewRow,"manu_CD"));
			doAction('M2101020_2_Sheet','search');
			doAction('M2101020_3_Sheet','search');
		}
	}
	
	//행 변경시 이벤트
	function M2101020_2_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {

		if (Col == 3) {
			var data = {};
			data["inventory_unit_C"] = "";
			set_data(M2101020_2_Sheet,Row,"item_CD",data,"item");
		}
	}
	
	//search 완료후 이벤트
	function M2101020_3_Sheet_OnSearchEnd(Code, Msg, StCode, StMsg) {
		for (var i = 1; i < M2101020_3_Sheet.RowCount()+1; i++) {
			if (M2101020_3_Sheet.GetCellValue(i,"Level") != 1) {
				M2101020_3_Sheet.SetRowEditable(i,0);
			}
		}
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M210/Common_Data.do'/>",queryStr);
			break;
		case "save":
			
			if (M2101020_1_Sheet.GetCellValue(M2101020_1_Sheet.GetSelectRow(),"complete_FL") == 1) {
				alert('재료투입이 완료된 생산지시서입니다 . ');
				return false;
			}
			
			
			var param = {url:"<c:url value='/M210/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);
			if (sheetNm == 'M2101020_3_Sheet') {
				for (var i = 1; i < M2101020_2_Sheet.RowCount() + 1; i++) {
					M2101020_2_Sheet.SetCellValue(i,'sStatus','I');
				}
				doAction('M2101020_2_Sheet', 'save');
			}
			break;	
		case "sandData":
			
			if (M2101020_1_Sheet.GetCellValue(M2101020_1_Sheet.GetSelectRow(),"complete_FL") == 1) {
				alert('재료투입이 완료된 생산지시서입니다 . ');
				return false;
			}
			
			var i = 1;
			while (i < M2101020_2_Sheet.RowCount() + 1) {

				var item_CD = M2101020_2_Sheet.GetCellValue(i,"item_CD");
				var quantity = M2101020_2_Sheet.GetCellValue(i,"quantity");
		    	$.ajax({
	  	    		url: "<c:url value='/M210/make_BOM_Data2.do'/>",
	  	    	type: "POST",
	  	    	data: {item_CD:item_CD,quantity:quantity},
	  	    	async: false,
	  	    	dataType: "json",
	  	    	success : function( data ) {
	  	    		for (var j = 0; j < data.list.length; j++) {
	  	    			
	  	    			var s_item_CD = data.list[j].item_sub_CD ;
	  	    			var s_real_need_count = data.list[j].real_need_count * quantity ;
	  	    			
	  	    			for (var k = 1; k < M2101020_3_Sheet.RowCount() + 1 ; k++) {	  	    				
							if (M2101020_3_Sheet.GetCellValue(k,"Level") == 1) {
		  	    				if (M2101020_3_Sheet.GetCellValue(k,"item_CD") == s_item_CD ) {
		  	    					
		  	    					var s_quantity = M2101020_3_Sheet.GetCellValue(k,"quantity");
		  	    					var s_use_quantity = M2101020_3_Sheet.GetCellValue(k,"use_quantity");		  	    			
		  	    					
									if (s_quantity < s_real_need_count + s_use_quantity) {

										M2101020_3_Sheet.SetCellValue(k,'use_quantity',s_quantity);
										s_real_need_count = s_real_need_count - s_quantity - s_use_quantity;
									}else{
										M2101020_3_Sheet.SetCellValue(k,'use_quantity', s_real_need_count + s_use_quantity);
										s_real_need_count = 0;
									}	
								}	
							}
						}
	  	    			
	  	    			if (s_real_need_count != 0 ) {
	  	    				if (data.list[j].down_YN !=0) {
	  	    					var nRow = M2101020_2_Sheet.DataInsert(-1);
	  	    					M2101020_2_Sheet.SetCellValue(nRow,'manu_CD',$('#manu_CD').val());
	  	    					M2101020_2_Sheet.SetCellValue(nRow,'item_CD',s_item_CD);
	  	    					M2101020_2_Sheet.SetCellValue(nRow,'quantity',s_real_need_count);
							}else {
								alert('재료가 부족합니다.');
								return false;
							}
						}
	  	    			
					}
	  	    	},
	  	    	err : function(r) {
	  	    		alert('<spring:message code="fail.common.menu.create" />');
	  	    	}});
		    	i ++;
			}
			
 			var Row = M2101020_3_Sheet.FindStatusRow("U").split(";");			
			for (var i = 0; i < Row.length; i++) {
				M2101020_3_Sheet.SetCellValue(Row[i],'manu_CD',$('#manu_CD').val());
			}		 
			
			doAction('M2101020_2_Sheet','search');
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
			<div class="inquiry-box">
				<table class="table">
					<caption>검색조건</caption>
					<tbody>
						<tr>	
							<th class="required"><label for="">지시일자</label></th>
							<td>
								<input type="Date" class="form width40" title="지시일자 시작" id="start_date" name="start_date" onchange="doAction('M2101020_1_Sheet', 'search'); return false;"/>~
								<input type="Date" class="form width40" title="지시일자 종료" id="end_date" name="end_date" onchange="doAction('M2101020_1_Sheet', 'search'); return false;"/>
							</td>
							<th><label for="complete_FL" onchange="doAction('M1001020_1_Sheet','search')">완료 여부</label></th>
							<td>
									<input type="radio" name="complete_FL" id="complete_FL" value="%" onchange="doAction('M2101020_1_Sheet','search')"/>전체
									<input type="radio" name="complete_FL" id="complete_FL" value="0" checked="checked" onchange="doAction('M2101020_1_Sheet','search')"/>미완료
									<input type="radio" name="complete_FL" id="complete_FL" value="1" onchange="doAction('M2101020_1_Sheet','search')"/>완료
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
							</ul>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M2101020_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M2101020_1_Sheet"></div>
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
								<li><a class="btn-act" href="#" role="button" onclick="doAction('M2101020_3_Sheet', 'sandData'); return false;" title="자동적용">자동적용</a></li>
							</ul>
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M2101020_2_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M2101020_2_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 현재 제품상황</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">
								<li><a title="저장" class="btn-save" href="#" onclick="doAction('M2101020_3_Sheet', 'save'); return false;" role="button">저장</a></li>
							</ul>
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M2101020_3_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M2101020_3_Sheet"></div>
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
