<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	<%--화면 로딩시 동작 정의--%>
	$(document).ready(
		function() {
			
			//검색창에서 엔터시 검색
			$("[name^=searchForm]").keypress(function(){
				if(event.keyCode==13){
					doAction('M9801020_1_Sheet','search');
					return false;
					}
			});
			
			//IBSheet 생성 영역
			iB_Sheet_Make("M9801020_1_Sheet","${M9801020_1_Sheet}","100%");
			iB_Sheet_Make("M9801020_2_Sheet","${M9801020_2_Sheet}","100%");
			doAction('M9801020_1_Sheet','search');
		});
	
	//특정 행 클릭시 발생 이벤트
	function M9801020_1_Sheet_OnSelectCell(OldRow,OldCol,NewRow,NewCol,isDelete) {
		if (OldRow != NewRow) {
			doAction('M9801020_2_Sheet','search');
		}
	}
	
	function doAction(sheetNm, action){
		$('#sheetNm').val(sheetNm);
		$('#item_CD').val(M9801020_1_Sheet.GetCellValue(M9801020_1_Sheet.GetSelectRow(),'item_CD'));
		switch (action) {
		case "search":
			var queryStr = FormQueryStringEnc(document.searchForm);
			window[sheetNm].DoSearch("<c:url value='/M980/Common_Data.do'/>",queryStr);			
			break;
	 	case "input":
	 		window[sheetNm].SetSelectRow(1);
			var nRow = window[sheetNm].DataInsert(-1);	
			window[sheetNm].SetCellValue(nRow,"item_CD",$('#item_CD').val());
			window[sheetNm].SetCellValue(nRow,"Level",1);
			window[sheetNm].SetCellValue(nRow,"loss_rate",0);
			break;
		case "save":
			var check_item;
			for (var i = 1; i < window[sheetNm].RowCount()+1; i++) {
				if (window[sheetNm].GetCellValue(i,'Level') == 1) window[sheetNm].SetCellValue(i,"sStatus","I");
				if (window[sheetNm].GetCellValue(i,'Level') < 2) {
				
					check_item = window[sheetNm].GetCellValue(i,'item_sub_CD');
					for (var j = 1; j < window[sheetNm].RowCount()+1; j++) {
						if (window[sheetNm].GetCellValue(j,'Level') == 1) {
							if (i != j && check_item == window[sheetNm].GetCellValue(j,'item_sub_CD')) {
								alert('중복된 데이터가 있습니다. 확인후 진행해주세요.');
								return false;						
							}	
						}
					}
				}
				
			}
			
	  		var param = {url:"<c:url value='/M980/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);		
			break; 
			
		case "delete":
			if (window[sheetNm].GetCellValue(window[sheetNm].GetSelectRow(),'Level') != 1) {
				alert("첫번째 하위 요소만 삭제할수 있습니다.");
				break;
			}
			var new_data = {};
			new_data["comp_CD"] = "${comp_CD}";
			new_data["item_CD"] = window[sheetNm].GetCellValue(window[sheetNm].GetSelectRow(),'item_CD');
			new_data["item_sub_CD"] = window[sheetNm].GetCellValue(window[sheetNm].GetSelectRow(),'item_sub_CD');
	    	$.ajax({
	    	    url: '<c:url value="/M980/M9801020_2_delete.do"/>' ,
	    	    type: "POST",
	    	    data: new_data,
	    	    async: false,
	    	    dataType: "json",
	    	    success : function(value) {
	    	    },
	    	    err : function(r) {
	    	        alert('<spring:message code="fail.request.msg"/>');
	    	    }
			}, "html"); 
	    	
	    	doAction('M9801020_2_Sheet','search');
	    	
	    	break;
	    	
			break;
		default:
			break;
		}
	}
	
	function M9801020_2_Sheet_OnSearchEnd() { 

		for (var i = 1; i < M9801020_2_Sheet.RowCount()+1; i++) {	
			if (M9801020_2_Sheet.GetCellValue(i,'Level') != '1') {
				M9801020_2_Sheet.SetRowEditable(i,0);		
			}

			if (M9801020_2_Sheet.GetCellValue(i,'Level') > 1) {
				for (var j = 1; j < M9801020_2_Sheet.RowCount()+1; j++) {
	
					if (M9801020_2_Sheet.GetCellValue(i,'item_CD') == M9801020_2_Sheet.GetCellValue(j,'item_sub_CD')) {

						var real_need_count = M9801020_2_Sheet.GetCellValue(j,'real_need_count');
						M9801020_2_Sheet.SetCellValue(i,"need_count",M9801020_2_Sheet.GetCellValue(i,'need_count') * real_need_count);
						M9801020_2_Sheet.SetCellValue(i,"real_need_count",M9801020_2_Sheet.GetCellValue(i,'real_need_count'));
						M9801020_2_Sheet.SetCellValue(i,"sStatus","");
					}}}
	
			
		}
				
	}
	
	function M9801020_2_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {

		if (Col == 2 || Col == 4) {
			var need_count = M9801020_2_Sheet.GetCellValue(Row,'need_count');
			var loss_rate = M9801020_2_Sheet.GetCellValue(Row,'loss_rate');
			var real_need_count = need_count + (need_count * (loss_rate/100));
			M9801020_2_Sheet.SetCellValue(Row,"real_need_count",real_need_count);		
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
				<h4>BOM 등록</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post"> 
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="item_CD" name="item_CD">
			<div class="inquiry-box">
				<table class="table">
					<caption>검색조건</caption>
					<tbody>
						<tr>			
							<th scope="row"><label for="item_NM">제품명</label></th>
							<td><input type="text" id="item_NM" name="item_NM" title="제품명" /></td>
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
							<h6> 품목 목록</h6>
						</div>
						<div class="title-set">
							<p>조회건수 : <span id="M9801020_1_Sheet_totalcnt"></span> 건</p>
						</div>
					</div>
					<div class="clear"></div>
					<div class="grid-layout" id="M9801020_1_Sheet">
						<!-- 데이터 -->
					</div>
				</div>
				<div class="grid-right70">
					<!-- title -->
					<div class="title">
						<div class="title-area">
							<h6>BOM</h6>
						</div>
						<!--  button group -->
						<div class="btn-y-group">
							<ul class="list-inline">
								<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9801020_2_Sheet', 'input')" role="button">신규</a></li>								
								<li><a title="삭제" class="btn-delete" href="#" id="delete"  onclick="doAction('M9801020_2_Sheet', 'delete'); return false;" role="button">삭제</a></li>
								<li><a title="저장" class="btn-save" href="#" onclick="doAction('M9801020_2_Sheet', 'save'); return false;" role="button">저장</a></li>
							</ul>
						</div>
						<div class="title-set">
							
						</div>	
					</div>
					<div class="clear"></div>
					<div id="M9801020_2_Sheet">
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