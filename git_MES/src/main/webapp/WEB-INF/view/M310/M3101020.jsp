<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function(){
		iB_Sheet_Make("M3101020_1_Sheet","${M3101020_1_Sheet}","575px");
		iB_Sheet_Make("M3101020_2_Sheet","${M3101020_2_Sheet}","575px");
		iB_Sheet_Make("M3101020_3_Sheet","${M3101020_3_Sheet}","575px");
	
		doAction('M3101020_1_Sheet','search');
	
	});
	
	//1번시트 선택시
	function M3101020_1_Sheet_OnSelectCell(OldRow, OldCol, NewRow, NewCol,isDelete) {
		if (OldRow != NewRow) {
			doAction('M3101020_2_Sheet','search');
			doAction('M3101020_3_Sheet','search');
		}
	}
	
	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		$('#vehi_DT').val(M3101020_1_Sheet.GetCellValue(M3101020_1_Sheet.GetSelectRow(),"vehi_DT"));
		$('#disp_CD').val(M3101020_1_Sheet.GetCellValue(M3101020_1_Sheet.GetSelectRow(),"disp_CD"));
		$('#vehi_CD').val(M3101020_1_Sheet.GetCellValue(M3101020_1_Sheet.GetSelectRow(),"vehi_CD"));
		
		switch (sAction) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M310/Common_Data.do'/>",queryStr);	
			break;

		case "save":
			var param = {url:"<c:url value='/M310/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);
			break;
		
		case "sandData":
			if (M3101020_1_Sheet.GetCellValue(M3101020_1_Sheet.GetSelectRow(),"set_item_FL") == 1) {
				alert('적재가 완료된 차량입니다 . ');
				return false;
			}
			for (var i = 1; i < M3101020_3_Sheet.RowCount()+1; i++) {
				M3101020_3_Sheet.SetCellValue(i,'use_quantity','0');
			}
			for (var i = 1; i < M3101020_2_Sheet.RowCount()+1; i++) {
				if (M3101020_2_Sheet.GetCellValue(i,"Level") == 0) {
					var s_item_CD = M3101020_2_Sheet.GetCellValue(i,"item_CD");
					var s_quantity = M3101020_2_Sheet.GetCellValue(i,"quantity");
					
					for (var j = 1; j < M3101020_3_Sheet.RowCount()+1; j++) {
						if (M3101020_3_Sheet.GetCellValue(j,"Level") == 1) {
							if (s_item_CD == M3101020_3_Sheet.GetCellValue(j,"item_CD")) {
								if (M3101020_3_Sheet.GetCellValue(j,"quantity") < s_quantity) {
									s_quantity = s_quantity - M3101020_3_Sheet.GetCellValue(j,"quantity");
									M3101020_3_Sheet.SetCellValue(j,'use_quantity',M3101020_3_Sheet.GetCellValue(j,"quantity"));
								}else{
									M3101020_3_Sheet.SetCellValue(j,'use_quantity',s_quantity);
									s_quantity = 0 ;
								}
								M3101020_3_Sheet.SetCellValue(j,'disp_CD',$('#disp_CD').val());
							}
						}
					}
					
					if (s_quantity != 0 ) {
						alert('제품이 부족합니다.');
						return false;
					}
				}
			}
			
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
				<h4>수주 출고 관리</h4>
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
			<input type="text" hidden="true" id="disp_CD" name="disp_CD">
			<input type="text" hidden="true" id="vehi_CD" name="vehi_CD">
			<div class="inquiry-box">
				<table class="table" style="font-size: 12px">
					<caption>검색조건</caption>
					<tbody>
						<tr>	
							<th scope="row"><label for="vehi_CD">차량 명</label></th>
							<td>
								<select class="form" id="vehi_CD" name="vehi_CD" title="차량" onchange="doAction('M3101020_1_Sheet','search')">
									<option value="%">전체</option>								
					 				<c:forEach var="item" items="${vehi_CD}">
										<option value="${item.some_CD}">${item.some_NM}</option>
									</c:forEach> 
								</select>
							</td>
							<th><label for="set_item_FL" onchange="doAction('M3101020_1_Sheet','search')">완료 여부</label></th>
							<td>
									<input type="radio" name="set_item_FL" id="set_item_FL" value="%" onchange="doAction('M3101020_1_Sheet','search')"/>전체
									<input type="radio" name="set_item_FL" id="set_item_FL" value="0" checked="checked" onchange="doAction('M3101020_1_Sheet','search')"/>미완료
									<input type="radio" name="set_item_FL" id="set_item_FL" value="1" onchange="doAction('M3101020_1_Sheet','search')"/>완료
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
							<p>조회건수 : <span id="M3101020_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M3101020_1_Sheet"></div>
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
								<li><a class="btn-act" href="#" role="button" onclick="doAction('M3101020_2_Sheet', 'sandData'); return false;" title="자동적재">자동적재</a></li></ul>
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M3101020_2_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M3101020_2_Sheet"></div>
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
							<ul class="list-inline">
								<li><a title="저장" class="btn-save" href="#" onclick="doAction('M3101020_3_Sheet', 'save'); return false;" role="button">저장</a></li>
							</ul>
						</div>						
						<div class="title-set">
							<p>조회건수 : <span id="M3101020_3_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M3101020_3_Sheet"></div>
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