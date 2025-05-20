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
					doAction('M9709020_1_Sheet','search');
					return false;
					}
			});
			
			//IBSheet 생성 영역
			iB_Sheet_Make("M9709020_1_Sheet","${M9709020_1_Sheet}","100%");	
			iB_Sheet_Make("M9709020_2_Sheet","${M9709020_2_Sheet}","100%");	
			
			//Sheet와 Form 연결 , onChange 함수
			addChangeEvent("M9709020_1_SheetForm",M9709020_1_SheetForm_onchange);
			
			doAction('M9709020_1_Sheet','search');
	});
	
	//Sheet와 Form 연결 된 함수 내용
	function M9709020_1_SheetForm_onchange(){
		var row = M9709020_1_Sheet.GetSelectRow();
		if(row == -1) return;	//선택된 row가 없을경우 카피를 수행하지 않는다.		
		var param = {sheet:M9709020_1_Sheet,form:document.M9709020_1_SheetForm,row:M9709020_1_Sheet.GetSelectRow(),formPreFix:""};
		IBS_CopyForm2Sheet(param);
	}
	
	//특정 행 클릭시 발생 이벤트
	function M9709020_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			var param = {sheet:M9709020_1_Sheet,form:document.M9709020_1_SheetForm,formPreFix:"",row:NewRow};
			IBS_CopySheet2Form(param);
			doAction('M9709020_2_Sheet','search');
		}
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		$('#client_CD_97').val(M9709020_1_Sheet.GetCellValue(M9709020_1_Sheet.GetSelectRow(),"client_CD_97"));
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M970/Common_Data.do'/>",queryStr);
			break;
			
		case "input":
			var nRow = window[sheetNm].DataInsert(-1);
			if (sheetNm == "M9709020_1_Sheet") {
				$('#enter_FL_97').val(0);
				$('#exit_FL_97').val(0);
				$('#supply_FL_97').val(0);
				window[sheetNm].SetCellValue(nRow,'enter_FL_97','0');
				window[sheetNm].SetCellValue(nRow,'exit_FL_97','0');
				window[sheetNm].SetCellValue(nRow,'supply_FL_97','0');
			}else if (sheetNm == "M9709020_2_Sheet") {
				window[sheetNm].SetCellValue(nRow,'client_CD_97',$('#client_CD_97').val());
			}
			break;
			
		case "save":
		  		
			if (sheetNm == "M9709020_1_Sheet") make_CD(window[sheetNm],"client_CD_97","E97");

			var param = {url:"<c:url value='/M970/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);		
			
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
				<h4>거래처 관리</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9709020_1_Sheet', 'input'); return false;" role="button">신규</a></li>
				    <li><a title="저장" class="btn-save" href="#" onclick="doAction('M9709020_1_Sheet', 'save'); return false;" role="button">저장</a></li>
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="client_CD_97" name="client_CD_97">
			<div class="inquiry-box">
				<table class="table">
					<caption>거래처관리</caption>
					<tbody>
						<tr class="line">
							<th scope="row"><label for="client_NM_97">거래처명</label></th>
							<td><input type="text" id="client_NM_97" name="client_NM_97" title="거래처명" /></td>
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
							<h6> 거래처 목록</h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9709020_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M9709020_1_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
				<div class="form-right width70">
					<form id="M9709020_1_SheetForm" name="M9709020_1_SheetForm" method="post">
						<div class="form-wrap" style="height: 34%">
							<!-- title -->
							<div class="title">
								<div class="title-area">
									<h6> 거래처 상세정보</h6>
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
											<th class="required"><label for="client_NM_97">거래처 명</label></th>
											<td>								
												<input type="text" class="form" title="거래처 명" id="client_NM_97" name="client_NM_97"/>
											</td>
										</tr>
										<tr>
											<th><label for="contact_97">연락처</label></th>
											<td>
												<input title="연락처" type="text" class="form" id="contact_97" name="contact_97" />
											</td>
										</tr>
										<tr>
											<th><label for="phone_NO_97">전화번호</label></th>
											<td>
												<input title="전화번호" type="text" class="form" id="phone_NO_97" name="phone_NO_97" />
											</td>
										</tr>
										<tr>
											<th><label for="address">주소</label></th>
											<td>
												<input title="주소" type="text" class="form" id="address" name="address" />
											</td>
										</tr>
										<tr>
											<th><label for="account_NO">계좌번호</label></th>
											<td>
												<input title="계좌번호" type="text" class="form" id="account_NO" name="account_NO" />
											</td>
										</tr>
										<tr>
											<th><label for="real_order">원발주처</label></th>
											<td>
												<input title="원발주처" type="text" class="form" id="real_order" name="real_order" />
											</td>
										</tr>
										<tr>
											<th><label for="enter_FL_97">발주 여부</label></th>
											<td>
												<select class="form" id="enter_FL_97" name="enter_FL_97" title="발주 여부">
													<option value="0">사용 안함</option>
													<option value="1">사용</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><label for="exit_FL_97">출고 여부</label></th>
											<td>
												<select class="form" id="exit_FL_97" name="exit_FL_97" title="출고 여부">
													<option value="0">사용 안함</option>
													<option value="1">사용</option>
												</select>
											</td>
										</tr>	
										<tr>
											<th><label for="supply_FL_97">공급 여부</label></th>
											<td>
												<select class="form" id="supply_FL_97" name="supply_FL_97" title="공급 여부">
													<option value="0">사용 안함</option>
													<option value="1">사용</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><label for="memo">비고</label></th>
											<td>
												<input title="비고" type="text" class="form" id="memo" name="memo" />
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
									<h6> 거래처별 제품 단가 정보 </h6>
								</div>
								<div class="btn-y-group">
									<ul class="list-inline">
										<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9709020_2_Sheet', 'input'); return false;" role="button">신규</a></li>
									    <li><a title="저장" class="btn-save" href="#" onclick="doAction('M9709020_2_Sheet', 'save'); return false;" role="button">저장</a></li>
									</ul>
								</div>
								<div class="title-set">
									<p>조회건수 : <span id="M9709020_2_Sheet_totalcnt"></span> 건</p>
								</div>	
							</div>
							<div class="clear" ></div>
					<div id="M9709020_2_Sheet">
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
