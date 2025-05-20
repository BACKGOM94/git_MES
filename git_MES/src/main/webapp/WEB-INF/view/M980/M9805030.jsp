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

			//검색창에서 엔터시 검색
			$("[name^=searchForm]").keypress(function(){
				if(event.keyCode==13){
					doAction('M9805030_1_Sheet','search');
					return false;
					}
			});
			
			//IBSheet 생성 영역
			iB_Sheet_Make("M9805030_1_Sheet","${M9805030_1_Sheet}","100%");	
			iB_Sheet_Make("M9805030_2_Sheet","${M9805030_2_Sheet}","100%");	
			
			//Sheet와 Form 연결 , onChange 함수
			addChangeEvent("M9805030_1_SheetForm",M9805030_1_SheetForm_onchange);
			
			doAction('M9805030_1_Sheet','search');
	});
	
	//Sheet와 Form 연결 된 함수 내용
	function M9805030_1_SheetForm_onchange(){
		var row = M9805030_1_Sheet.GetSelectRow();
		if(row == -1) return;	//선택된 row가 없을경우 카피를 수행하지 않는다.		
		var param = {sheet:M9805030_1_Sheet,form:document.M9805030_1_SheetForm,row:M9805030_1_Sheet.GetSelectRow(),formPreFix:""};
		IBS_CopyForm2Sheet(param);
	}
	
	//특정 행 클릭시 발생 이벤트
	function M9805030_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			var param = {sheet:M9805030_1_Sheet,form:document.M9805030_1_SheetForm,formPreFix:"",row:NewRow};
			IBS_CopySheet2Form(param)
			doAction('M9805030_2_Sheet','search');
		}
	}
	
	//행 변경시 이벤트
	function M9805030_2_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {
		if (Col == 2) {		
			var data = {};
			data["manager_NM"] = "";
			data["manager_phone_NO"] = "";
			set_data (M9805030_2_Sheet,Row,"clie_CD",data,"clie")
		}
		
		if (Col == 3 && RaiseFlag == 0) {
			var check_data;
			for (var i = 1; i < M9805030_2_Sheet.RowCount()+1; i++) {	
				check_data = M9805030_2_Sheet.GetCellValue(i,'race_seq');
				
		 		if (Row != i ) {
				 	if (Value > OldValue ) {
						if (Value >= check_data && OldValue <= check_data) M9805030_2_Sheet.SetCellValue(i,"race_seq",check_data -1);
					}else if (Value < OldValue){
						if (OldValue >= check_data && Value <= check_data) M9805030_2_Sheet.SetCellValue(i,"race_seq",check_data +1);
					}	 
				} 
				
			}
			M9805030_2_Sheet.ColumnSort("3");
		}
		
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		$('#vehi_CD').val(M9805030_1_Sheet.GetCellValue(M9805030_1_Sheet.GetSelectRow(),'vehi_CD'));
		
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M980/Common_Data.do'/>",queryStr);
			break;
		case "input":
			var nRow = window[sheetNm].DataInsert(-1);
			if (sheetNm == "M9805030_1_Sheet") window[sheetNm].SetCellValue(nRow,'vehi_kind_C','');
			else if (sheetNm == "M9805030_2_Sheet") window[sheetNm].SetCellValue(nRow,'vehi_CD',$('#vehi_CD').val());
			break;
		case "save":
			if (sheetNm == "M9805030_1_Sheet") make_CD_combo(window[sheetNm],"vehi_CD","VEH");
			var param = {url:"<c:url value='/M980/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);		

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
				<h4>차량 등록</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9805030_1_Sheet', 'input'); return false;" role="button">신규</a></li>
				    <li><a title="저장" class="btn-save" href="#" onclick="doAction('M9805030_1_Sheet', 'save'); return false;" role="button">저장</a></li>
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="vehi_CD" name="vehi_CD">
			<div class="inquiry-box">
				<table class="table">
					<caption>차량 등록</caption>
					<tbody>
						<tr class="line">
							<th scope="row"><label for="vehi_NO">차량번호</label></th>
							<td><input type="text" id="vehi_NO" name="vehi_NO" title="차량번호" /></td>
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
							<h6> 차량등록 목록</h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9805030_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M9805030_1_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
				<div class="form-right width70">
					<form id="M9805030_1_SheetForm" name="M9805030_1_SheetForm" method="post">
						<div class="form-wrap" style="height: 34%">
							<!-- title -->
							<div class="title">
								<div class="title-area">
									<h6> 차량등록 상세</h6>
								</div>
								<!-- buttin group -->
								<div class="btn-y-group">
								</div>
							</div>
							<div class="clear"></div>
							<div class="form-layout">
								<table>
									<caption>
										거래처등록
									</caption>
									<tbody>
										<tr>
											<th class="required"><label for="vehi_NO">차량 번호</label></th>
											<td>								
												<input type="text" class="form" title="차량 번호" id="vehi_NO" name="vehi_NO"/>
											</td>
										</tr>
										<tr>
											<th><label for="vehi_kind_C">차량 종류</label></th>
											<td>
												<select class="form" id="vehi_kind_C" name="vehi_kind_C" title="차량 종류">
										 		<c:forEach var="item" items="${vehi_kind}">
													<option value="${item.some_CD}">${item.some_NM}</option>
												</c:forEach> 
											</select>
											</td>
										</tr>
										<tr>
											<th><label for="memo">비고</label></th>
											<td>
												<textarea title="비고" class="form" id="memo" name="memo" ></textarea>
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
									<h6> 차량별 배송 정보 </h6>
								</div>
								<div class="btn-y-group">
									<ul class="list-inline">
										<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9805030_2_Sheet', 'input'); return false;" role="button">신규</a></li>
									    <li><a title="저장" class="btn-save" href="#" onclick="doAction('M9805030_2_Sheet', 'save'); return false;" role="button">저장</a></li>
									</ul>
								</div>
								<div class="title-set">
									<p>조회건수 : <span id="M9805030_2_Sheet_totalcnt"></span> 건</p>
								</div>	
							</div>
							<div class="clear" ></div>
					<div id="M9805030_2_Sheet">
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
