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
					doAction('M9805010_1_Sheet','search');
					return false;
					}
			});
			
			//IBSheet 생성 영역
			iB_Sheet_Make("M9805010_1_Sheet","${M9805010_1_Sheet}","100%");	
			iB_Sheet_Make("M9805010_2_Sheet","${M9805010_2_Sheet}","100%");	
			
			//Sheet와 Form 연결 , onChange 함수
			addChangeEvent("M9805010_1_SheetForm",M9805010_1_SheetForm_onchange);
			
			doAction('M9805010_1_Sheet','search');
	});
	
	//Sheet와 Form 연결 된 함수 내용
	function M9805010_1_SheetForm_onchange(){
		var row = M9805010_1_Sheet.GetSelectRow();
		if(row == -1) return;	//선택된 row가 없을경우 카피를 수행하지 않는다.		
		var param = {sheet:M9805010_1_Sheet,form:document.M9805010_1_SheetForm,row:M9805010_1_Sheet.GetSelectRow(),formPreFix:""};
		IBS_CopyForm2Sheet(param);
	}
	
	//특정 행 클릭시 발생 이벤트
	function M9805010_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			var param = {sheet:M9805010_1_Sheet,form:document.M9805010_1_SheetForm,formPreFix:"",row:NewRow};
			IBS_CopySheet2Form(param)
			doAction('M9805010_2_Sheet','search');
		}
	}
	
	//행 변경시 이벤트
	function M9805010_2_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {

		if (Col == 3) {		
			var data = {};
			data["price"] = "";
			set_data (M9805010_2_Sheet,Row,"item_CD",data,"item")
		}
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		$('#clie_CD').val(M9805010_1_Sheet.GetCellValue(M9805010_1_Sheet.GetSelectRow(),'clie_CD'));
		
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M980/Common_Data.do'/>",queryStr);
			break;
		case "input":
			var nRow = window[sheetNm].DataInsert(-1);
			if (sheetNm == "M9805010_1_Sheet") {
				window[sheetNm].SetCellValue(nRow,'clie_CD','');
				$('#enter_FL').val(0);
				$('#exit_FL').val(0);				
			}else if (sheetNm == "M9805010_2_Sheet"){
				window[sheetNm].SetCellValue(nRow,'clie_CD',M9805010_1_Sheet.GetCellValue(M9805010_1_Sheet.GetSelectRow(),'clie_CD'));
			}
			break;
		case "save":
		  		var Row = window[sheetNm].FindStatusRow("I").split(";");
		  		if (sheetNm == "M9805010_1_Sheet") {
			  		for (var i = 0; i < Row.length; i++) {		  					  			
			  			if (window[sheetNm].GetCellValue(Row[i],"memb_PW") == "" ) {
			  				alert('<spring:message code="fail.common.pwsearch" />');
			  				return false;
						}							  		
			  		}
			  		if (sheetNm == "M9805010_1_Sheet") make_CD_combo(window[sheetNm],"clie_CD","CLI");
		  		}else if (sheetNm == "M9805010_2_Sheet") {
					if (IBSheet_double_Check(window[sheetNm],'item_CD') > 0 ) {
						alert('<spring:message code="common.isExist.msg" />');
						return false;
					}
		  		}
				
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
				<h4>거래처 등록</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9805010_1_Sheet', 'input'); return false;" role="button">신규</a></li>
				    <li><a title="저장" class="btn-save" href="#" onclick="doAction('M9805010_1_Sheet', 'save'); return false;" role="button">저장</a></li>
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="clie_CD" name="clie_CD">
			<div class="inquiry-box">
				<table class="table">
					<caption>거래처등록</caption>
					<tbody>
						<tr class="line">
							<th scope="row"><label for="clie_NM">거래처명</label></th>
							<td><input type="text" id="clie_NM" name="clie_NM" title="거래처명" /></td>
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
							<h6> 거래처등록 목록</h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9805010_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M9805010_1_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
				<div class="form-right width70">
					<form id="M9805010_1_SheetForm" name="M9805010_1_SheetForm" method="post">
						<div class="form-wrap" style="height: 34%">
							<!-- title -->
							<div class="title">
								<div class="title-area">
									<h6> 거래처등록 상세</h6>
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
											<th class="required"><label for="clie_NM">거래처 명</label></th>
											<td>								
												<input type="text" class="form" title="거래처 명" id="clie_NM" name="clie_NM"/>
											</td>
										</tr>
										<tr>
											<th><label for="manager_NM">담당자 이름</label></th>
											<td>
												<input title="담당자 이름" type="text" class="form" id="manager_NM" name="manager_NM" />
											</td>
										</tr>
										<tr>
											<th><label for="manager_phone_NO">담당자 연락처</label></th>
											<td>
												<input title="담당자 연락처" type="text" class="form" id="manager_phone_NO" name="manager_phone_NO" />
											</td>
										</tr>
										<tr>
											<th><label for="address">주소</label></th>
											<td>
												<input title="우편번호" type="text" class="form width20" id="address" name="address" />
												<span class="btn-popup-iq" id="ZipPopHs"></span>
												<input title="주소" type="text" class="form width75" id="hshopAdr" name="hshopAdr"	/>
											</td>
										</tr>
										<tr>
											<th><label for="address_detail">주소상세</label></th>
											<td>
												<input title="주소상세" type="text" class="form" id="address_detail" name="address_detail" />
											</td>
										</tr>
										<tr>
											<th><label for="email">이메일</label></th>
											<td>
												<input title="이메일" type="text" class="form" id="email" name="email" />
											</td>
										</tr>
										<tr>
											<th><label for="enter_FL">입고 여부</label></th>
											<td>
												<select class="form" id="enter_FL" name="enter_FL" title="입고 여부">
													<option value="0">사용 안함</option>
													<option value="1">사용</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><label for="exit_FL">출고 여부</label></th>
											<td>
												<select class="form" id="exit_FL" name="exit_FL" title="출고 여부">
													<option value="0">사용 안함</option>
													<option value="1">사용</option>
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
									<h6> 거래처별 사용제품 정보 </h6>
								</div>
								<div class="btn-y-group">
									<ul class="list-inline">
										<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9805010_2_Sheet', 'input'); return false;" role="button">신규</a></li>
									    <li><a title="저장" class="btn-save" href="#" onclick="doAction('M9805010_2_Sheet', 'save'); return false;" role="button">저장</a></li>
									</ul>
								</div>
								<div class="title-set">
									<p>조회건수 : <span id="M9805010_2_Sheet_totalcnt"></span> 건</p>
								</div>	
							</div>
							<div class="clear" ></div>
					<div id="M9805010_2_Sheet">
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
