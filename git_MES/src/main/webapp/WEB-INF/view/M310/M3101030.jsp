<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function(){
		iB_Sheet_Make("M3101030_1_Sheet","${M3101030_1_Sheet}","575px");
		iB_Sheet_Make("M3101030_2_Sheet","${M3101030_2_Sheet}","575px");
		iB_Sheet_Make("M3101030_3_Sheet","${M3101030_3_Sheet}","575px");
	
		doAction('M3101030_1_Sheet','search');
	
	});
	
	//1번시트 선택시
	function M3101030_1_Sheet_OnSelectCell(OldRow, OldCol, NewRow, NewCol,isDelete) {
		if (OldRow != NewRow) 	doAction('M3101030_2_Sheet','search');
	}
	//2번시트 선택시
	function M3101030_2_Sheet_OnSelectCell(OldRow, OldCol, NewRow, NewCol,isDelete) {
		if (OldRow != NewRow) 	doAction('M3101030_3_Sheet','search');
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		$('#vehi_DT').val(M3101030_1_Sheet.GetCellValue(M3101030_1_Sheet.GetSelectRow(),"vehi_DT"));
		$('#sale_CD').val(M3101030_2_Sheet.GetCellValue(M3101030_2_Sheet.GetSelectRow(),"sale_CD"));
		$('#vehi_CD').val(M3101030_1_Sheet.GetCellValue(M3101030_1_Sheet.GetSelectRow(),"vehi_CD"));
		
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M310/Common_Data.do'/>",queryStr);	
			break;

		case "save":
			
			window[sheetNm].SetCellValue(window[sheetNm].GetSelectRow(),'sStatus','U');
			
			var param = {url:"<c:url value='/M310/Common_Data.do'/>", sheet:sheetNm};
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
				<h4>배송관리</h4>
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
			<input type="text" hidden="true" id="vehi_DT" name="vehi_DT">
			<input type="text" hidden="true" id="sale_CD" name="sale_CD">
			<input type="text" hidden="true" id="vehi_CD" name="vehi_CD">
			<div class="inquiry-box">
				<table class="table" style="font-size: 12px">
					<caption>검색조건</caption>
					<tbody>
						<tr>	
							<th scope="row"><label for="vehi_CD">차량 명</label></th>
							<td>
								<select class="form" id="vehi_CD" name="vehi_CD" title="차량" onchange="doAction('M3101030_1_Sheet','search')">
									<option value="%">전체</option>								
					 				<c:forEach var="item" items="${vehi_CD}">
										<option value="${item.some_CD}">${item.some_NM}</option>
									</c:forEach> 
								</select>
							</td>
							<th><label for="complete_FL" onchange="doAction('M3101030_1_Sheet','search')">완료 여부</label></th>
							<td>
									<input type="radio" name="complete_FL" id="complete_FL" value="%" onchange="doAction('M3101030_1_Sheet','search')"/>전체
									<input type="radio" name="complete_FL" id="complete_FL" value="0" checked="checked" onchange="doAction('M3101030_1_Sheet','search')"/>미완료
									<input type="radio" name="complete_FL" id="complete_FL" value="1" onchange="doAction('M3101030_1_Sheet','search')"/>완료
							</td>
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
							<h6> 차량 목록</h6>
						</div>
						<div class="btn-y-group">
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M3101030_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M3101030_1_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 거래처 목록</h6>
						</div>
						<div class="btn-y-group">
							<ul class="list-inline">
								<li><a class="btn-act" href="#" role="button" onclick="doAction('M3101030_1_Sheet', 'save'); return false;" title="배송완료">배송완료</a></li></ul>
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M3101030_2_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M3101030_2_Sheet"></div>
					<%-- ibsheet div --%>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 출고 품목 목록</h6>
						</div>
						<div class="btn-y-group">
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M3101030_3_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M3101030_3_Sheet"></div>
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