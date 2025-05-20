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
					doAction('M9808010_1_Sheet','search');
					return false;
					}
			});
			
			//IBSheet 생성 영역
			iB_Sheet_Make("M9808010_1_Sheet","${M9808010_1_Sheet}","100%");	
			
			doAction('M9808010_1_Sheet','search');
			
			//IBSheet 생성 영역
			iB_Sheet_Make("M9808010_2_Sheet","${M9808010_2_Sheet}","100%");	
			
			//Sheet와 Form 연결 , onChange 함수
			addChangeEvent("M9808010_1_SheetForm",M9808010_1_SheetForm_onchange);
	});
	
	//Sheet와 Form 연결 된 함수 내용
	function M9808010_1_SheetForm_onchange(){
		var row = M9808010_1_Sheet.GetSelectRow();
		if(row == -1) return;	//선택된 row가 없을경우 카피를 수행하지 않는다.		
		var param = {sheet:M9808010_1_Sheet,form:document.M9808010_1_SheetForm,row:M9808010_1_Sheet.GetSelectRow(),formPreFix:""};
		IBS_CopyForm2Sheet(param);
	}
	
	//특정 행 클릭시 발생 이벤트
	function M9808010_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			$('#memb_ID').val(M9808010_1_Sheet.GetCellValue(NewRow,"memb_ID"));
			var param = {sheet:M9808010_1_Sheet,form:document.M9808010_1_SheetForm,formPreFix:"",row:NewRow};
			IBS_CopySheet2Form(param)
			doAction('M9808010_2_Sheet','search');

		}
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M980/Common_Data.do'/>",queryStr);
			break;
		case "input":
			var nRow = window[sheetNm].DataInsert(-1);
			break;
		case "save":
			if (sheetNm =='M9808010_1_Sheet') {
				if (double_Check (window[sheetNm],'memb_ID') > 0 ) {
					alert('<spring:message code="common.isExist.msg" />');
					break;
				} 
		  		var Row = window[sheetNm].FindStatusRow("I").split(";");
		  		for (var i = 0; i < Row.length; i++) {
		  			if (window[sheetNm].GetCellValue(Row[i],"memb_PW") == "" ) {
		  				alert('<spring:message code="fail.common.pwsearch" />');
		  				return false;
					}
		  		}				
			}else if (sheetNm =='M9808010_2_Sheet'){
				
				var count = M9808010_2_Sheet.RowCount()+1 ;

				for (var i = 1; i < count; i++) {	
					if (window[sheetNm].GetCellValue(i,'auth') == 1)  window[sheetNm].SetCellValue(i,'sStatus','I');
					else window[sheetNm].SetCellValue(i,'sStatus','');
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
				<h4>사원등록</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9808010_1_Sheet', 'input'); return false;" role="button">신규</a></li>
				    <li><a title="저장" class="btn-save" href="#" onclick="doAction('M9808010_1_Sheet', 'save'); return false;" role="button">저장</a></li>
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="memb_ID" name="memb_ID">
			<div class="inquiry-box">
				<table class="table">
					<caption>사원등록</caption>
					<tbody>
						<tr class="line">
							<th scope="row"><label for="memb_NM">회원명</label></th>
							<td><input type="text" id="memb_NM" name="memb_NM" title="회원명" /></td>
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
							<h6> 사원등록 목록</h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9808010_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M9808010_1_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
				<div class="form-right width70">
					<form id="M9808010_1_SheetForm" name="M9808010_1_SheetForm" method="post">
						<div class="form-wrap" style="height: 34%">
							<!-- title -->
							<div class="title">
								<div class="title-area">
									<h6> 사원등록 상세</h6>
								</div>
								<!-- buttin group -->
								<div class="btn-y-group">
								</div>
							</div>
							<div class="clear"></div>
							<div class="form-layout">
								<table>
									<caption>
										사원등록
									</caption>
									<tbody>
										<tr>
											<th class="required"><label for="memb_ID">아이디</label></th>
											<td>								
												<input type="text" class="form" title="아이디" id="memb_ID" name="memb_ID" autocomplete="new-password"//>
											</td>
										</tr>
										<tr>
											<th><label for="memb_PW">비밀번호</label></th>
											<td>								
												<input type="password" class="form" title="비밀번호" id="memb_PW" name="memb_PW" autocomplete="new-password"//>
											</td>
										</tr>
										<tr>
											<th class="required"><label for="memb_NM">이름</label></th>
											<td>
												<input title="이름" type="text" class="form" id="memb_NM" name="memb_NM" />
											</td>
										</tr>
										<tr>
											<th><label for="phone_NO">연락처</label></th>
											<td>
												<input title="연락처" type="text" class="form" id="phone_NO" name="phone_NO" />
											</td>
										</tr>
										<tr>
											<th><label for="birthdate_DT">생일</label></th>
											<td>
												<input title="생일" type="Date" class="form" id="birthdate_DT" name="birthdate_DT" />
											</td>
										</tr>
										<tr>
											<th><label for="join_DT">가입 날짜</label></th>
											<td>
												<input title="가입 날짜" type="Date" class="form" id="join_DT" name="join_DT"  readonly="readonly"/>
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
											<th><label for="rank_GB">직급</label></th>
											<td>
												<select class="form" id="rank_GB" name="rank_GB" title="직급">
										 		<c:forEach var="item" items="${rank_GB}">
													<option value="${item.some_CD}">${item.some_NM}</option>
												</c:forEach> 
											</select>
											</td>
										</tr>
										<tr>
											<th><label for="work_type_GB">직무</label></th>
											<td>
												<select class="form" id="work_type_GB" name="work_type_GB" title="직무">
										 		<c:forEach var="item" items="${work_type_GB}">
													<option value="${item.some_CD}">${item.some_NM}</option>
												</c:forEach> 
											</select>
											</td>
										</tr>
										<tr>
											<th><label for="sex_GB">성별</label></th>
											<td>
												<select class="form" id="sex_GB" name="sex_GB" title="성별">
										 		<c:forEach var="item" items="${sex_GB}">
													<option value="${item.some_CD}">${item.some_NM}</option>
												</c:forEach> 
											</select>
											</td>
										</tr>
										<tr>
											<th><label for="memb_status_GB">회원상태</label></th>
											<td>
												<select class="form" id="memb_status_GB" name="memb_status_GB" title="회원상태">
										 		<c:forEach var="item" items="${memb_status_GB}">
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
									<h6> 권한 정보 </h6>
								</div>
								<div class="btn-y-group">
									<ul class="list-inline">
										<li>
											<a title="저장" class="btn-save" href="#" onclick="doAction('M9808010_2_Sheet', 'save'); return false;" role="button">저장</a>
										</li>
									</ul>
								</div>
								<div class="title-set">
									<p>조회건수 : <span id="M9808010_2_Sheet_totalcnt"></span> 건</p>
								</div>	
							</div>
							<div class="clear" ></div>
					<div id="M9808010_2_Sheet">
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
