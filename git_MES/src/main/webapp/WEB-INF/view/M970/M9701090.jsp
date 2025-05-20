<%@ page contentType="text/html; charset=UTF-8"%>
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
		
		//IBSheet 생성 영역
		iB_Sheet_Make("M9701090_1_Sheet","${M9701090_1_Sheet}","100%");			
		
		//기본 날짜 지정
		$('#start_date').val(get_date('1'));
		$('#end_date').val(get_date('today'));
		
		doAction('M9701090_1_Sheet','search');
		
	});

	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M970/Common_Data.do'/>",queryStr);
			break;
		case "print":
			M9701090_1_Sheet.DoPrint();
			break;
		default:
			break;
		}
	}

	function year_Change(){
		doAction('M9701090_1_Sheet','search');
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
				<h4>색상별 현황</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="인쇄" class="btn-print" href="#" onclick="doAction('M9701090_1_Sheet', 'print'); return false;" role="button">인쇄</a></li>					
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post" >
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<div class="inquiry-box">
				<table class="table">
					<caption>제품 관리</caption>
					<tbody>
						<tr class="line">
							<th class="required"><label for="">등록일자</label></th>
							<td>
								<input type="Date" class="form width40" title="등록일자 시작" id="start_date" name="start_date" onchange="doAction('M9701090_1_Sheet', 'search'); return false;"/>~
								<input type="Date" class="form width40" title="등록일자 종료" id="end_date" name="end_date" onchange="doAction('M9701090_1_Sheet', 'search'); return false;"/>
							</td>
							<th scope="row"><label for="item_CD_97">아이템명</label></th>
							<td>
								<select class="form" id="item_CD_97" name="item_CD_97" title="아이템명" onchange="doAction('M9701090_1_Sheet','search')">								
										<option value="%">전체</option>
							 		<c:forEach var="item" items="${item_CD_97}">
										<option value="${item.some_CD}">${item.some_NM}</option>
									</c:forEach> 
								</select>
							</td>
							<th scope="row"><label for="supply_clie_CD_97">공급처 명</label></th>
							<td>
								<select class="form" id="supply_clie_CD_97" name="supply_clie_CD_97" title="공급처명" onchange="doAction('M9701090_1_Sheet','search')">								
										<option value="%">전체</option>
							 		<c:forEach var="item" items="${supply_clie_CD_97}">
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
							<h6> 색상 목록</h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9701090_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M9701090_1_Sheet"></div>
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