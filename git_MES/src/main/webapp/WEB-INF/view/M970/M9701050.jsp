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
				item_Change();
				return false;
				}
		});
		
		$('#start_date').val(get_date('today'));
		$('#end_date').val(get_date('today'));
		
		//IBSheet 생성 영역
		iB_Sheet_Make("M9701050_1_Sheet","${M9701050_1_Sheet}","100%");	
		iB_Sheet_Make("M9701050_2_Sheet","${M9701050_2_Sheet}","100%");	
		doAction('M9701050_1_Sheet','search');
		doAction('M9701050_2_Sheet','search');
		
	});
	
	function item_Change(){
		doAction('M9701050_1_Sheet','search');
		doAction('M9701050_2_Sheet','search');		
	}
	
	function M9701050_1_Sheet_OnSearchEnd() { 
		var value = 0;
		
		for (var i = 1; i < M9701050_1_Sheet.RowCount() + 1; i++) {
			value += M9701050_1_Sheet.GetCellValue(i,'inventory');
		}		
		$('#total_item_count').val(value);
	}
	
	function M9701050_2_Sheet_OnSearchEnd() { 
		var value = 0;
		
		for (var i = 1; i < M9701050_2_Sheet.RowCount() + 1; i++) {
			value += M9701050_2_Sheet.GetCellValue(i,'out_quantity');
		}
		$('#total_exit_count').val(value);
	}
	
	function doAction(sheetNm, action){
		$('#sheetNm').val(sheetNm);
			switch (action) {			
			
			case "search":				
		 		var queryStr = FormQueryStringEnc(document.searchForm);		
		 		window[sheetNm].DoSearch("<c:url value='/M970/Common_Data.do'/>",queryStr);				
				break;
			case "print":
				window[sheetNm].DoPrint();
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
				<h4>색상별 출고 현황</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post"> 
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<div class="inquiry-box">
				<table class="table">
					<tbody>
						<tr class="line">
							<th class="required"><label for="">검색일자</label></th>
							<td>
								<input type="Date" class="form width40" title="발주일자 시작" id="start_date" name="start_date" onchange="doAction('M9701050_2_Sheet', 'search'); return false;"/>~
								<input type="Date" class="form width40" title="발주일자 종료" id="end_date" name="end_date" onchange="doAction('M9701050_2_Sheet', 'search'); return false;"/>
							</td>
							<th scope="row"><label for="item_CD_97">아이템 명</label></th>
							<td>
								<select class="form" id="item_CD_97" name="item_CD_97" title="아이템 명" onchange="item_Change()">								
										<option value="%">전체</option>
							 		<c:forEach var="item" items="${item_CD_97}">
										<option value="${item.some_CD}">${item.some_NM}</option>
									</c:forEach> 
								</select>
							</td>
							<th scope="row"><label for="exit_clie_NM_97">거래처</label></th>
							<td><input type="text" id="exit_clie_NM_97" name="exit_clie_NM_97" title="거래처" /></td>
							<th scope="row"><label for="total_item_count">총 재고 수량</label></th>
							<td><input type="text" id="total_item_count" name="total_item_count" title="총 재고 수량"  readonly="readonly"/></td>
							<th scope="row"><label for="total_exit_count">총 출고 수량</label></th>
							<td><input type="text" id="total_exit_count" name="total_exit_count" title="총 출고 수량"  readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
			<%--검색조건 영역--%>
		
			<%--하단 컨텐츠(전체) 영역--%>
			<div class="layout-grid">
				<div class="grid-left45">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 재고 관리</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">		
								<li><a title="인쇄" class="btn-print" href="#" onclick="doAction('M9701050_1_Sheet', 'print'); return false;" role="button">인쇄</a></li>					
							</ul>
						</div>	
						<div class="title-set">			
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M9701050_1_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left45">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 출고 관리</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">	
								<li><a title="인쇄" class="btn-print" href="#" onclick="doAction('M9701050_2_Sheet', 'print'); return false;" role="button">인쇄</a></li>						
							</ul>
						</div>	
						<div class="title-set">			
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M9701050_2_Sheet"></div>
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