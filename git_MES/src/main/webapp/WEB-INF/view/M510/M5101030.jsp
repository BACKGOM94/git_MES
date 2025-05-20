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
			iB_Sheet_Make("M5101030_1_Sheet","${M5101030_1_Sheet}","100%");	
			iB_Sheet_Make("M5101030_2_Sheet","${M5101030_2_Sheet}","100%");	
			
			doAction('M5101030_1_Sheet','search');
	});
	
	//특정 행 클릭시 발생 이벤트
	function M5101030_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			var param = {sheet:M5101030_1_Sheet,form:document.M5101030_1_SheetForm,formPreFix:"",row:NewRow};
			IBS_CopySheet2Form(param)
			doAction('M5101030_2_Sheet','search');
		}
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		$('#equi_CD').val(M5101030_1_Sheet.GetCellValue(M5101030_1_Sheet.GetSelectRow(),'equi_CD'));
		
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
				<h4>설비 이력 모니터링</h4>
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
							<p>조회건수 : <span id="M5101030_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M5101030_1_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
				<div class="form-right width70">
					<form id="M5101030_1_SheetForm" name="M5101030_1_SheetForm" method="post">
						<div class="form-wrap" style="height: 34%">
							<!-- title -->
							<div class="title">
								<div class="title-area">
									<h6> 설비 이력 상세</h6>
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
											<th><label for="equi_NM">설비 명</label></th>
											<td>								
												<input type="text" class="form" title="설비 명" id="equi_NM" name="equi_NM" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th><label for="equi_location">설비 위치</label></th>
											<td>
												<input title="설비 위치" type="text" class="form" id="equi_location" name="equi_location" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th><label for="equi_standard">설비 규격</label></th>
											<td>
												<input title="설비 규격" type="text" class="form" id="equi_standard" name="equi_standard" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th><label for="total_make">총 생산수량</label></th>
											<td>
												<input title="총 생산수량" type="text" class="form" id="total_make" name="total_make" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th><label for="total_error">총 불량수량</label></th>
											<td>
												<input title="총 불량수량" type="text" class="form" id="total_error" name="total_error" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th><label for="error_percent">불량 비율</label></th>
											<td>
												<input title="불량 비율" type="text" class="form" id="error_percent" name="error_percent" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th><label for="memo">비고</label></th>
											<td>
												<textarea title="비고" class="form" id="memo" name="memo" readonly="readonly"></textarea>
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
									<h6> 날짜별 데이터 정보 </h6>
								</div>
								<div class="btn-y-group">
								</div>
								<div class="title-set">
									<p>조회건수 : <span id="M5101030_2_Sheet_totalcnt"></span> 건</p>
								</div>	
							</div>
							<div class="clear" ></div>
					<div id="M5101030_2_Sheet">
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
