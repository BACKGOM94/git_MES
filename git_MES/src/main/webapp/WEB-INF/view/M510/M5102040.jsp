<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html lang="ko">
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
<script type="text/javascript">

	$(document).ready(				
		function(){

			//IBSheet 생성 영역
			iB_Sheet_Make("M5102040_1_Sheet","${M5102040_1_Sheet}","100%");	
			iB_Sheet_Make("M5102040_2_Sheet","${M5102040_2_Sheet}","100%");	
			
			doAction('M5102040_1_Sheet','search');
	});
	
	//특정 행 클릭시 발생 이벤트
	function M5102040_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			doAction('M5102040_2_Sheet','search');
		}
	}
	
	//M5102040_2_Sheet시트 서치가 끝난후 진행
	function M5102040_2_Sheet_OnSearchEnd(Code, Msg, StCode, StMsg) { 
		var Data_1 = 0;
		var Data_2 = 0;
		
		for (var i = 1; i < M5102040_2_Sheet.RowCount() + 1 ; i++) {
			Data_1 += parseInt(M5102040_2_Sheet.GetCellValue(i,"total_make"));
			Data_2 += parseInt( M5102040_2_Sheet.GetCellValue(i,"total_error"));
		}
		
		var Data_3 = (Data_1 / M5102040_2_Sheet.RowCount()).toFixed(2);
		var Data_4 = (Data_2 / M5102040_2_Sheet.RowCount()).toFixed(2);
		var Data_5 = ((Data_2 / (Data_1 + Data_2))*100).toFixed(2);
		
		$('#Data_1').val(Data_1);
		$('#Data_2').val(Data_2);
		$('#Data_3').val(Data_3);
		$('#Data_4').val(Data_4);
		$('#Data_5').val(Data_5);
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		$('#equi_CD').val(M5102040_1_Sheet.GetCellValue(M5102040_1_Sheet.GetSelectRow(),'equi_CD'));
		
		switch (sAction) {
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
				<h4>불량률 통계</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="equi_CD" name="equi_CD">
			<div class="inquiry-box">
				<table class="table">
					<caption>설비 이력 모니터링</caption>
					<tbody>
						<tr class="line">
							<th></th><td></td>
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
				<!-- title -->
					<div class="title">
						<div class="title-area">
							<h6> 설비 목록</h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M5102040_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M5102040_1_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
				<div class="form-right width70">
					<form id="M5102040_1_SheetForm" name="M5102040_1_SheetForm" method="post">
						<div class="form-wrap" style="height: 34%">
							<!-- title -->
							<div class="title">
								<div class="title-area">
									<h6> 설비 통계 상세</h6>
								</div>
								<!-- buttin group -->
								<div class="btn-y-group">
								</div>
							</div>
							<div class="clear"></div>
							<div class="form-layout">
								<table>
									<caption>
										설비 정보
									</caption>
									<tbody>
										<tr>
											<th><label for="Data_1">총 생산 수량</label></th>
											<td>								
												<input type="text" class="form" title="총 생산 수량" id="Data_1" name="Data_1" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th><label for="Data_2">총 불량 수량</label></th>
											<td>
												<input title="총 불량 수량" type="text" class="form" id="Data_2" name="Data_2" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th><label for="Data_3">평균 생산 수량</label></th>
											<td>
												<input title="평균 생산 수량" type="text" class="form" id="Data_3" name="Data_3" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th><label for="Data_4">평균 불량 수량</label></th>
											<td>
												<input title="평균 불량 수량" type="text" class="form" id="Data_4" name="Data_4" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th><label for="Data_5">총 불량률</label></th>
											<td>
												<input title="총 불량률" type="text" class="form" id="Data_5" name="Data_5" readonly="readonly"/>
											</td>
										</tr>								
									</tbody>
								</table>
							</div>
						</div>
					</form>
				</div>
				<br><br>
				<div class="grid-right70">
					<!-- title -->
							<div class="title">
								<div class="title-area">
									<h6> 일자별 데이터 </h6>
								</div>
								<div class="btn-y-group">
								</div>
								<div class="title-set">
									<p>조회건수 : <span id="M5102040_2_Sheet_totalcnt"></span> 건</p>
								</div>	
							</div>
							<div class="clear" ></div>
					<div id="M5102040_2_Sheet">
					</div>
				</div>
			</div><!-- grid-full-width -->
			
			<%--하단 컨텐츠(전체) 영역--%>
		</div>
		<%-- page-content --%>
	</div>
	<%-- container --%>
</body>
</html>
