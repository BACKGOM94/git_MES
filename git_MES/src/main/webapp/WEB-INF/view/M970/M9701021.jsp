<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	$(document).ready(				
		function(){
			//IBSheet 생성 영역
			iB_Sheet_Make("M9701021_1_Sheet","${M9701021_1_Sheet}","100%");	
			
			$('#regist_DT').val(get_date('today'));
			
	});
	
	function base_data_Change(target){
		
		switch (target) {
		case 'temp_enter_clie_CD_97':
				try {
					$('#enter_clie_CD_97').val(document.querySelector("#temp_enter_clie_CD_97_list option[value='" + $('#temp_enter_clie_CD_97').val() + "']").dataset.value);
				} catch (e) {		
					alert('잘못된 데이터가 입력되었습니다.');
					$('#temp_enter_clie_CD_97').focus();
					$('#temp_enter_clie_CD_97').val('');
				}						
			break;
		case 'temp_exit_clie_CD_97':
				try {
					$('#exit_clie_CD_97').val(document.querySelector("#temp_exit_clie_CD_97_list option[value='" + $('#temp_exit_clie_CD_97').val() + "']").dataset.value);
				} catch (e) {		
					alert('잘못된 데이터가 입력되었습니다.');
					$('#temp_exit_clie_CD_97').focus();
					$('#temp_exit_clie_CD_97').val('');
				}	
			break;
		case 'temp_supply_clie_CD_97':
				try {
					$('#supply_clie_CD').val(document.querySelector("#temp_supply_clie_CD_97_list option[value='" + $('#temp_supply_clie_CD_97').val() + "']").dataset.value);
				} catch (e) {		
					alert('잘못된 데이터가 입력되었습니다.');
					$('#temp_supply_clie_CD_97').focus();
					$('#temp_supply_clie_CD_97').val('');
				}	
			break;

		default:
			break;
		}		
	
	}
	
	//데이터 변경시 다른 데이터 변경
	function M9701021_1_Sheet_OnChange(Row, Col, Value, OldValue, RaiseFlag) {		

		if (Col == 9 || Col == 8) {
			var price = M9701021_1_Sheet.GetCellValue(Row,"price");
			var  out_quantity = M9701021_1_Sheet.GetCellValue(Row,"out_quantity");
			
			M9701021_1_Sheet.SetCellValue(Row,'total_price',price * out_quantity);			
		}		
		
		
 		if (Col == 4 && RaiseFlag == 0) {
			if (M9701021_1_Sheet.GetComboInfo(Row, Col, 'selectedIndex') == -1) {
				alert('잘못된 데이터 입니다.');
				M9701021_1_Sheet.SetCellValue(Row,Col,OldValue);
				M9701021_1_Sheet.SetSelectCol(Col);	
			}else{
								
				var supply_clie_CD = $('#supply_clie_CD').val();

	  	    	$.ajax({
  	  	    		url: "<c:url value='/M970/Lot_Change.do'/>",
  	  	    	type: "POST",
  	  	    	data: {lot_CD_97:Value,supply_clie_CD:supply_clie_CD},
  	  	    	async: false,
  	  	    	dataType: "json",
  	  	    	success : function( data ) {
	  	  	    	M9701021_1_Sheet.SetCellValue(Row,'color_CD_97',data.info.color_CD_97);
		  	  	    M9701021_1_Sheet.SetCellValue(Row,'item_CD_97',data.info.item_CD_97);
			  	  	M9701021_1_Sheet.SetCellValue(Row,'count_97',data.info.count_97);
			  	  	M9701021_1_Sheet.SetCellValue(Row,'price',data.info.price);
			  	  	
  	  	    	},
  	  	    	err : function(r) {
  	  	    		alert('<spring:message code="fail.common.menu.create" />');
  	  	    	}
  	  	    	});
			}
		} 
	}

	function doAction(sheetNm,sAction){
		$('#sheetNm').val(sheetNm);
		switch (sAction) {
		case "input":

			if ($('#temp_enter_clie_CD_97').val() == '') {
				alert('발주처를 입력해 주세요');
				$('#temp_enter_clie_CD_97').focus();
				return false;
			}
			if ($('#temp_exit_clie_CD_97').val() == '') {
				alert('출고처를 입력해 주세요');
				$('#temp_exit_clie_CD_97').focus();
				return false;
			}
			if ($('#temp_supply_clie_CD_97').val() == '') {
				alert('공급처를 입력해 주세요');
				$('#temp_supply_clie_CD_97').focus();
				return false;
			}
			
			if($('#box_CT').val() == '') $('#box_CT').val(0);
			
			$('#temp_enter_clie_CD_97').prop("disabled",true);
			$('#temp_exit_clie_CD_97').prop("disabled",true);
			$('#temp_supply_clie_CD_97').prop("disabled",true);
			
			var nRow = window[sheetNm].DataInsert(-1);			
			window[sheetNm].SetCellValue(nRow,'lot_CD_97','');
			break;
		case "save":
					
			if (window[sheetNm].RowCount() == 0) {
				alert('제품이 등록되지 않았습니다.');
				return false;	
			}else{
				for (var i = 1; i < M9701021_1_Sheet.RowCount() + 1; i++) {
					if (M9701021_1_Sheet.GetComboInfo(i, 4, 'selectedIndex') == -1) {
						alert('Lot 번호를 선택하지 않았습니다.');
						return false;
					}
					
					if (M9701021_1_Sheet.GetCellValue(i, 9) == 0) {
						alert('출고수량 0 이 존재합니다.');
						return false;
					}
					
				}		
			}
			
			$('#temp_enter_clie_CD_97').prop("disabled",false);
			$('#temp_exit_clie_CD_97').prop("disabled",false);
			$('#temp_supply_clie_CD_97').prop("disabled",false);

			make_CD(window[sheetNm],"exit_CD_97","X97");

			var exit_CD_97 = window[sheetNm].GetCellValue(1,"exit_CD_97");			

			for (var i = 1; i < window[sheetNm].RowCount() + 1; i++) {
				window[sheetNm].SetCellValue(i,'enter_clie_CD_97',$('#temp_enter_clie_CD_97').val());
				window[sheetNm].SetCellValue(i,'exit_clie_CD_97',$('#temp_exit_clie_CD_97').val());
				window[sheetNm].SetCellValue(i,'supply_clie_CD_97',$('#temp_supply_clie_CD_97').val());
				window[sheetNm].SetCellValue(i,'box_CT',$('#box_CT').val());				
				window[sheetNm].SetCellValue(i,'exit_CD_97',exit_CD_97);
				window[sheetNm].SetCellValue(i,'regist_DT',$('#regist_DT').val());
			}

			
			var param = {url:"<c:url value='/M970/Common_Data.do'/>", sheet:sheetNm};
			DataSave(param);	
			opener.location.reload();
			window.close();
		default:
			break;
		}
	}
</script>
</head>
<body>
	<%-- container --%>
	<div class="popup_container">
		<%-- page-content --%>
		<div class="popup-page-content">
			<%--네비게이션 영역--%>
			<%@ include file="/WEB-INF/view/Common/navigation.jsp"%>
			<%--네비게이션 영역--%>			
	
			<%--페이지 제목 영역--%>
			<div class="page-header">
				<h4>거래명세서 등록 </h4>
				<h5>거래명세서를 등록 합니다.</h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="저장" class="btn-save" href="#" onclick="doAction('M9701021_1_Sheet', 'save'); return false;" role="button">저장</a></li>						
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="enter_clie_CD_97" name="enter_clie_CD_97">
			<input type="text" hidden="true" id="exit_clie_CD_97" name="exit_clie_CD_97">
			<input type="text" hidden="true" id="supply_clie_CD" name="supply_clie_CD">
			<div class="inquiry-box">
				<table class="table">
					<caption>거래명세서 등록</caption>
					<tbody>
						<tr class="line">
							<th scope="row"><label for="temp_enter_clie_CD_97">발주처</label></th>
							<td>
								<input type="text" list="temp_enter_clie_CD_97_list" id="temp_enter_clie_CD_97"  onchange="base_data_Change('temp_enter_clie_CD_97')">
								<datalist id="temp_enter_clie_CD_97_list">																
							 		<c:forEach var="item" items="${enter_clie_CD_97}">
										<option  data-value="${item.some_CD}" value="${item.some_NM}"/>
									</c:forEach> 
								</datalist>
							</td>
							<th scope="row"><label for="temp_exit_clie_CD_97">출고처</label></th>
							<td>
								<input type="text" list="temp_exit_clie_CD_97_list" id="temp_exit_clie_CD_97"   onchange="base_data_Change('temp_exit_clie_CD_97')">
								<datalist id="temp_exit_clie_CD_97_list">																
							 		<c:forEach var="item" items="${exit_clie_CD_97}">
										<option  data-value="${item.some_CD}" value="${item.some_NM}"/>
									</c:forEach> 
								</datalist>
							</td>
							<th scope="row"><label for="temp_supply_clie_CD_97">공급처</label></th>
							<td>
								<input type="text" list="temp_supply_clie_CD_97_list" id="temp_supply_clie_CD_97"  onchange="base_data_Change('temp_supply_clie_CD_97')" >
								<datalist id="temp_supply_clie_CD_97_list">																
							 		<c:forEach var="item" items="${supply_clie_CD_97}">
										<option  data-value="${item.some_CD}" value="${item.some_NM}"/>
									</c:forEach> 
								</datalist>
							</td>
							<th scope="row"><label for="box_CT">C/T</label></th>
							<td><input type="text" id="box_CT" name="box_CT" title="C/T" /></td>
						</tr>
						<tr class="line">
							<th class="required"><label for="">등록일자</label></th>
							<td>
								<input type="Date" class="form width60" title="등록 일자" id="regist_DT" name="regist_DT"/>							
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
			<%--검색조건 영역--%>	
			
			<%--하단 컨텐츠(전체) 영역--%>
			<div class="layout-grid">
				<div class="title">
					<div class="title-area">
						<h6> 제품 목록 </h6>
					</div>
					<div class="btn-group">
						<ul class="list-inline">
							<li><a title="신규" class="btn-line-plus" href="#" onclick="doAction('M9701021_1_Sheet', 'input')" role="button">신규</a></li>						
						</ul>
					</div>
					<div class="title-set">
						<p>조회건수 : <span id="M9701021_1_Sheet_totalcnt"></span> 건</p>
					</div>	
				</div>

				<%-- ibsheet div --%>
				<div id="M9701021_1_Sheet"></div>
				<%-- ibsheet div--%>				
			</div>
			<%--하단 컨텐츠(전체) 영역--%>
		</div>
		<%-- page-content --%>
	</div>
	<%-- main_con --%>				
</body>
</html>