<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

<%--화면 로딩시 동작 정의--%>
$(document).ready(
		
	function() {
		
		//IBSheet 생성 영역
		iB_Sheet_Make("M9809010_1_Sheet","${M9809010_1_Sheet}","100%");	
		doAction('M9809010_1_Sheet','search');
		
	});
	    
	function doAction(sheetNm, action){
		$('#sheetNm').val(sheetNm);
		if(sheetNm == 'M9809010_1_Sheet' ){
			
			switch (action) {
			case "input":				
				var nRow = window[sheetNm].DataInsert(-1);
				window[sheetNm].SetCellValue(nRow,"category_CD",$('#category_CD').val());
				window[sheetNm].SetCellValue(nRow,"comp_CD","${comp_CD}");				
				break;
				
			case "save":
				var Row = window[sheetNm].FindStatusRow("I").split(";");
				
		  		for (var i = 0; i < Row.length; i++) {
		  	  	    	$.ajax({
		  	  	    		url: "<c:url value='/M980/make_category_CD.do'/>",
		  	  	    	type: "POST",
		  	  	    	data: {category_CD:$('#category_CD').val()},
		  	  	    	async: false,
		  	  	    	dataType: "json",
		  	  	    	success : function( data ) {	
		  	  	    		window[sheetNm].SetCellValue(Row[i],"sub_category_CD",parseInt(data.CD)+i);
		  	  	    	},
		  	  	    	err : function(r) {
		  	  	    		alert('<spring:message code="fail.common.menu.create" />');
		  	  	    	}
		  	  	    	});		
					
				}
		  		
		  		
                var param = {url:"<c:url value='/M980/Common_Data.do'/>", sheet:[sheetNm]};
                DataSave(param);                
				break;
				
			case "search":				
		 		var queryStr = FormQueryStringEnc(document.searchForm);		
		 		window[sheetNm].DoSearch("<c:url value='/M980/Common_Data.do'/>",queryStr);				
				break;
				
			default:
				break;
			}
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
				<h4>코드 관리</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9809010_1_Sheet', 'input')" role="button">신규</a></li>
					<li><a title="저장" class="btn-save" href="#" onclick="doAction('M9809010_1_Sheet', 'save'); return false;" role="button">저장</a></li>
					<li><a  title="초기화" class="btn-reset" href="#"  onclick="doAction('M9809010_1_Sheet','search'); return false;" role="button">초기화</a></li>
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post"> 
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<div class="inquiry-box">
				<table class="table">
					<tbody>
						<tr class="line">			
							<th scope="row"><label for="category_CD">대분류</label></th>
							<td>
								<select class="form" id="category_CD" name="category_CD" title="대분류명" onchange="doAction('M9809010_1_Sheet','search')">								
									<c:forEach var="item" items="${category_Data}">
										<option value="${item.some_CD}">${item.some_NM}</option>
									</c:forEach>
								</select>
							</td>
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
				<div class="grid">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> 소분류명칭</h6>
						</div>
						<div class="title-set">			
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div id="M9809010_1_Sheet"></div>
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