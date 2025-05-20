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
			iB_Sheet_Make("M5102050_1_Sheet","${M5102050_1_Sheet}","100%");
			iB_Sheet_Make("M5102050_2_Sheet","${M5102050_2_Sheet}","100%");
			iB_Sheet_Make("M5102050_3_Sheet","${M5102050_3_Sheet}","100%");
			search();
		});

	function search(){
		doAction('M5102050_1_Sheet','search');
		doAction('M5102050_2_Sheet','search');
		doAction('M5102050_3_Sheet','search');
	}
	function doAction(sheetNm, action){
		$('#sheetNm').val(sheetNm);
		
		switch (action) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M510/Common_Data.do'/>",queryStr);
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
				<h4>KPI 전송 이력 조회</h4>
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
			<div class="inquiry-box">
				<table class="table">
					<caption>검색조건</caption>
					<tbody>
						<tr class="line">
							<th class="required"><label for="">검색일자</label></th>
							<td>
								<input type="Date" class="form width40" title="검색일자 시작" id="start_date" name="start_date" onchange="search(); return false;"/>~
								<input type="Date" class="form width40" title="검색일자 종료" id="end_date" name="end_date" onchange="search(); return false;"/>
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
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> Lv1</h6>
						</div>
						<div class="btn-y-group">
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M5102050_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M5102050_1_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> Lv2</h6>
						</div>
						<div class="btn-y-group">
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M5102050_2_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M5102050_2_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> Lv3</h6>
						</div>
						<div class="btn-y-group">
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M5102050_3_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M5102050_3_Sheet"></div>
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
