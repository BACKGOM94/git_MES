<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<script type="text/javascript">
$(document).ready(
	
	function() {
		
		//검색창에서 엔터시 검색
		$("[name^=searchForm]").keypress(function(){
			if(event.keyCode==13){
				doAction('M9801010_1_Sheet','search');
				return false;
				}
		});
		
		//IBSheet 생성 영역
		iB_Sheet_Make("M9801010_1_Sheet","${M9801010_1_Sheet}","100%");
		doAction('M9801010_1_Sheet','search');
		//Sheet와 Form 연결 , onChange 함수
		addChangeEvent("M9801010_1_SheetForm",M9801010_1_SheetForm_onchange);
	});
		
//Sheet와 Form 연결 된 함수 내용
function M9801010_1_SheetForm_onchange(){
	var row = M9801010_1_Sheet.GetSelectRow();
	if(row == -1) return;	//선택된 row가 없을경우 카피를 수행하지 않는다.		
	var param = {sheet:M9801010_1_Sheet,form:document.M9801010_1_SheetForm,row:M9801010_1_Sheet.GetSelectRow(),formPreFix:""};
	IBS_CopyForm2Sheet(param);
}

//특정 행 클릭시 발생 이벤트
function M9801010_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
	if (OldRow != NewRow) {
		var param = {sheet:M9801010_1_Sheet,form:document.M9801010_1_SheetForm,formPreFix:"",row:NewRow};
		IBS_CopySheet2Form(param);
	}
}

function doAction(sheetNm, action){
	$('#sheetNm').val(sheetNm);

	switch (action) {
	case "search":
		var queryStr = FormQueryStringEnc(document.searchForm);
		window[sheetNm].DoSearch("<c:url value='/M980/Common_Data.do'/>",queryStr);
		break;
 	case "input":
		var nRow = window[sheetNm].DataInsert(-1);
		window[sheetNm].SetCellValue(nRow,'item_CD','');
		$('#inventory_item_CD').val(0);
		break;
	case "save":
		make_CD_combo(window[sheetNm],"item_CD","ITE");	

  		var Row = window[sheetNm].FindStatusRow("I|U").split(";");
  		
  		for (var i = 0; i < Row.length; i++) {
  			if ($('#inventory_item_CD').val() == 0) window[sheetNm].SetCellValue(Row[i],'inventory_item_CD',window[sheetNm].GetCellValue(Row[i],"item_CD"));	
  			if ($('#exchange_value').val() == '')  window[sheetNm].SetCellValue(Row[i],'exchange_value','1');
  			if ($('#price').val() == '')  window[sheetNm].SetCellValue(Row[i],'price','0');
  		}  
  		var param = {url:"<c:url value='/M980/Common_Data.do'/>", sheet:sheetNm};
		DataSave(param);	
		location.reload();
		break; 
	default:
		break;
	}
}

</script>
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
				<h4>품목</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9801010_1_Sheet', 'input'); return false;" role="button">신규</a></li>
				    <li><a title="저장" class="btn-save" href="#" onclick="doAction('M9801010_1_Sheet', 'save'); return false;" role="button">저장</a></li>
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<div class="inquiry-box">
				<input type="text" hidden="true" id="sheetNm" name="sheetNm">
				<table class="table">
					<caption>품목</caption>
					<tbody>
						<tr class="line">
							<th scope="row"><label for="item_NM">품목명</label></th>
							<td><input type="text" id="item_NM" name="item_NM" title="품목명" /></td>
							<th scope="row"><label for="item_group_C">품목군별</label></th>
							<td>
								<select class="form" id="item_group_C" name="item_group_C" title="품목군별" onchange="doAction('M9801010_1_Sheet','search')">								
										<option value="%">전체</option>
							 		<c:forEach var="item" items="${item_group_C}">
										<option value="${item.some_CD}">${item.some_NM}</option>
									</c:forEach> 
								</select>
							</td>
							<th></th><td></td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
			<%--검색조건 영역--%>
			
			<%--하단 컨텐츠(전체) 영역--%>
			<div class="layout-grid">
				<div class="grid-left45">
				<!-- title -->
					<div class="title">
						<div class="title-area">
							<h6> 품목 목록</h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9801010_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M9801010_1_Sheet">
						<!-- 데이터 -->
					</div>
					<div style="text-align: center;" id=pagination-div>
					
					</div>
				</div>
				
				
				<div class="form-right width55">
					<form id="M9801010_1_SheetForm" name="M9801010_1_SheetForm" method="post">
						<div class="form-wrap">
							<!-- title -->
							<div class="title">
								<div class="title-area">
									<h6> 품목 상세</h6>
								</div>
								<!-- buttin group -->
								<div class="btn-y-group">
								</div>
							</div>
							<div class="clear"></div>
							<div class="form-layout">
								<table>
									<caption>
										품목등록
									</caption>
									<tbody>
									<tr>
										<th class="required"><label for="item_NM">품목명</label></th>
										<td colspan='5'>
											<input type="text" class="form" title="품목명" id="item_NM" name="item_NM" />
										</td>
									</tr>
									<tr>
										<th><label for="order_unit_C">주문단위</label></th>
										<td>
											<select class="form" id="order_unit_C" name="order_unit_C" title="주문단위">
										 		<c:forEach var="item" items="${item_unit_C}">
													<option value="${item.some_CD}">${item.some_NM}</option>
												</c:forEach> 
											</select>
										</td>
										<th><label for="exchange_value">환산계수</label></th>
										<td>
											<input type="text" class="form" title="환산계수" id="exchange_value" name="exchange_value" />
										</td>
										<th><label for="inventory_unit_C">재고단위</label></th>
										<td>
											<select class="form" title="재고단위" id="inventory_unit_C" name="inventory_unit_C" >
									 			<c:forEach var="item" items="${item_unit_C}">
													<option value="${item.some_CD}">${item.some_NM}</option>
												</c:forEach> 
											</select>
										</td>										
									</tr>
									
									<tr>
										<th><label for="standard">규격</label></th>
										<td>
											<input type="text" class="form" title="규격" id="standard" name="standard" />
										</td>
										<th><label for="tax_FL">과세여부</label></th>
										<td>
											<select class="form" id="tax_FL" name="tax_FL" title="과세여부">
												<option value="1">과세</option>
												<option value="0">면세</option>
											</select>
										</td>
										<th><label for="inventory_item_CD">재고품목</label></th>
										<td>
											<select class="form" id="inventory_item_CD" name="inventory_item_CD" title="재고품목">
												<option value="0">자체사용</option>
								 				<c:forEach var="item" items="${item_CD}">
													<option value="${item.some_CD}">${item.some_NM}</option>
												</c:forEach> 
											</select>
										</td>
									</tr>
									<tr>
										<th><label for="use_order">발주여부</label></th>
										<td>
											<select class="form" id="use_order" name="use_order" title="발주여부">
												<option value="1">사용</option>
												<option value="0">미사용</option>
											</select>
										</td>
										<th><label for="use_production">생산여부</label></th>
										<td>
											<select class="form" id="use_production" name="use_production" title="생산여부">
												<option value="1">사용</option>
												<option value="0">미사용</option>
											</select>
										</td>
										<th><label for="use_sale">판매여부</label></th>
										<td>
											<select class="form" id="use_sale" name="use_sale" title="판매여부">
												<option value="1">사용</option>
												<option value="0">미사용</option>
											</select>
										</td>
									</tr>
									<tr>
										<th><label for="item_group_C">품목군</label></th>
										<td>
											<select class="form" id="item_group_C" name="item_group_C" title="품목군">
												<c:forEach var="item" items="${item_group_C}">
													<option value="${item.some_CD}">${item.some_NM}</option>
												</c:forEach>
											</select>
										</td>
										<th><label for="proc_CD">공정</label></th>
										<td>
											<select class="form" id="proc_CD" name="proc_CD" title="공정">
												<c:forEach var="item" items="${proc_CD}">
													<option value="${item.some_CD}">${item.some_NM}</option>
												</c:forEach>
											</select>
										</td>
										<th><label for="price">표준단가</label></th>
										<td>
											<input type="text" class="form" title="표준단가" id="price" name="price" />
										</td>
									</tr>
									<tr>
										<th><label for="memo">비고</label></th>
										<td colspan="5">
											<textarea title="비고" type="text" class="form" id="memo" name="memo" row="5" ></textarea>
										</td>
									</tr>
									</tbody>
								</table>
							</div>		
						</div>
					</form>
				</div>
				<br><br>
				<%-- 탭 영역 --%>
			</div>
			<%--하단 컨텐츠(전체) 영역--%>
		</div>
		<%-- page-content --%>
	</div>
	<%-- container --%>
</body>
</html>
