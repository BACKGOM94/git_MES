<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--공통 스크립트 함수--%>
<script type="text/javascript">

	var topMenuNm = "${pageContext.request.getParameter('topMenuNm')}";
	var upp_menu_NM = "${pageContext.request.getParameter('upp_menu_NM')}";
	var menuNm = "${pageContext.request.getParameter('menuNm')}";
	
	var appendNaviData = "";

    //화면 로드 처리
    $(document).ready(
		function() {
			if(topMenuNm != "") {
				appendNaviData += "<span><i class='fa fa-home' aria-hidden='true'></i>"
								+ " \> " 
								+ decodeURIComponent(topMenuNm)
								+ " \> "
								+ decodeURIComponent(upp_menu_NM)
								+ " \> "
								+ decodeURIComponent(menuNm);
				
				$(".breadcrumbs").html(appendNaviData);
			}
			
			if($.isFunction(parent.gfn_loadingScreenCancle)) {
				parent.gfn_loadingScreenCancle();
			}
			
		}
	);
 
    //form에 onchange 함수 기능을 추가
    function addChangeEvent(form,function_name) {
    		$("#" + form + " input, #" + form + " select, #" + form + " textarea").change(function () {
    			function_name();
    		});
    	}
    
  	//IBSheet 만들어주는 함수
    function iB_Sheet_Make(iBSheet_NM,col_Data_String,height) {

		createIBSheet2(document.getElementById(iBSheet_NM),iBSheet_NM, "100%", height, "smLazyLoad"); 
		
    	var col_Data_Json =JSON.parse(col_Data_String.replaceAll("'",'"'));

    	var initSheet = {};
    	
    	initSheet.Cfg = {
    			SearchMode:smLazyLoad,
    			Page:30,
    			ToolTip:1,
    			MergeSheet:msHeaderOnly		
    			};
    	
    	initSheet.HeaderMode = {Sort:1, ColMove:1, ColResize:1, HeaderCheck:1};
    	initSheet.Cols = col_Data_Json;
		
    	IBS_InitSheet( window[iBSheet_NM] , initSheet);
    	window[iBSheet_NM].FitColWidth();
    	window[iBSheet_NM].cols = initSheet.Cols;
    	window[iBSheet_NM].SetRowBackColorI("#f5f5f5");
    	window[iBSheet_NM].SetRowBackColorU("#f5f5f5");
    	
    	window[iBSheet_NM].SetEditable(1);
    }
  	
  	//IBSheet Data를 저장하기위한 함수
  	function DataSave(param){
  	   if(typeof parent.gfn_blockScreen == 'function') {
  		   	parent.gfn_blockScreen();
  		   }
  	   //저장 옵션 생성
  	  var opt = {};
  	  opt["Param"] = "sheetNm="+param.sheet;
  	  opt["Mode"] = 2;
  	  opt["Delim"]= " ‡ ";
  	   
  	  //시트 저장
  	  window[param.sheet].DoSave(param.url,opt);
  	  //location.reload();
 // 	  doAction(param.sheet,'search');
  	   if(typeof parent.gfn_blockScreenCancle == 'function') {
  		   	parent.gfn_blockScreenCancle();
  		   }
  	}
  	
  	//콤보박스 고유코드 생성
  	function make_CD_combo(IBSheet,col_CD,unionKey) {
  		var Row = IBSheet.FindStatusRow("I").split(";");
		 var value_CD;
		 var value_NM;
		 
  		for (var i = 0; i < Row.length; i++) {
  			
  			switch (col_CD) {
  			case "comp_CD": value_NM = IBSheet.GetCellValue(Row[i],"comp_ko_NM");
  				break;
  			case "item_CD" : value_NM = IBSheet.GetCellValue(Row[i],"item_NM");
				break;
  			case "clie_CD" : value_NM = IBSheet.GetCellValue(Row[i],"clie_NM");
				break;	
  			case "vehi_CD" : value_NM = IBSheet.GetCellValue(Row[i],"vehi_NO");
				break;	
			
  			default:
  				break;
  			}
  			 
  			if (i == 0) {
  	  	    	$.ajax({
  	  	    		url: "<c:url value='/Common/make_CD.do'/>",
  	  	    	type: "POST",
  	  	    	data: {unionKey:unionKey},
  	  	    	async: false,
  	  	    	dataType: "json",
  	  	    	success : function( data ) {	
  	  	    	value_CD = data.CD;	  	  	 
  	  	    	
	  	  	    IBSheet.CellComboItem(Row[i],col_CD,{
		  	  	    "ComboCode": value_CD,
		  	      	"ComboText": value_NM
	  	  	    });
  	  	    	
  	  	    	IBSheet.SetCellValue(Row[i],col_CD,value_CD);
  	  	    	},
  	  	    	err : function(r) {
  	  	    		alert('<spring:message code="fail.common.menu.create" />');
  	  	    	}
  	  	    	});		
			}else {
				value_CD = value_CD.substr(0,11) + String(parseInt(value_CD.substr(11,4))+1).padStart(4,'0');
	  	  	    IBSheet.CellComboItem(Row[i],col_CD,{
		  	  	    "ComboCode": value_CD,
		  	      	"ComboText": value_NM
	  	  	    });
				IBSheet.SetCellValue(Row[i],col_CD,value_CD);
			}
		}
	}
  	
  //고유코드 생성
  	function make_CD(IBSheet,col_CD,unionKey) {
  		var Row = IBSheet.FindStatusRow("I").split(";");
		 var value_CD;
		 
  		for (var i = 0; i < Row.length; i++) {
  			if (i == 0) {
  	  	    	$.ajax({
  	  	    		url: "<c:url value='/Common/make_CD.do'/>",
  	  	    	type: "POST",
  	  	    	data: {unionKey:unionKey},
  	  	    	async: false,
  	  	    	dataType: "json",
  	  	    	success : function( data ) {	
  	  	    	value_CD = data.CD;	  	  	 

  	  	    	IBSheet.SetCellValue(Row[i],col_CD,value_CD);
  	  	    	},
  	  	    	err : function(r) {
  	  	    		alert('<spring:message code="fail.common.menu.create" />');
  	  	    	}
  	  	    	});
			}else {
				value_CD = value_CD.substr(0,11) + String(parseInt(value_CD.substr(11,4))+1).padStart(4,'0');

				IBSheet.SetCellValue(Row[i],col_CD,value_CD);
			}
		}
	}
  	
  	//데이터 중복확인
  	function double_Check (IBSheet,col_NM) {
  		var Row = IBSheet.FindStatusRow("I").split(";");
  		var value;
  		var return_Data = 0;
  		for (var i = 0; i < Row.length; i++) {
			value = IBSheet.GetCellValue(Row[i],col_NM);
	    	$.ajax({
	  	    		url: "<c:url value='/Common/double_Check.do'/>",
	  	    	type: "POST",
	  	    	data: {value:value,col_NM:col_NM},
	  	    	async: false,
	  	    	dataType: "json",
	  	    	success : function( data ) {	
	  	    		return_Data = return_Data + data.count;
	  	    	},
	  	    	err : function(r) {
	  	    		alert('<spring:message code="fail.common.menu.create" />');
	  	    	}
	  	    	});
  		}
  		return return_Data;
  	}
  	
  	//IBSheet에서 데이터 중복확인
  	function IBSheet_double_Check (IBSheet,col_NM) {
  		var return_Data = 0;
  		
  		for (var i = 1; i < IBSheet.RowCount()+1; i++) {
			for (var j = 1; j < IBSheet.RowCount()+1; j++) {
				if (i != j && IBSheet.GetCellValue(i,col_NM) == IBSheet.GetCellValue(j,col_NM)) {
					return_Data = return_Data + 1 ;
				}
			}
  		}
  		return return_Data;
  	}
  	
  	//데이터 변경시 다른데이터의 콤보박스 자동 변경
  	function set_data_combo(IBSheet,Row,key_col,change_col,unique_Key){
  		var key_data = IBSheet.GetCellValue(Row,key_col);
    	$.ajax({
    		url: "<c:url value='/Common/set_data_combo.do'/>",
    	type: "POST",
    	data: {unique_Key:unique_Key,key_data:key_data},
    	async: false,
    	dataType: "json",
    	success : function( data ) {
    		
    		var ComboCode = "";
    		var ComboText = "";

    		for (var i = 0; i < data.info.length; i++) {
    			ComboCode += data.info[i].some_CD;
    			ComboText += data.info[i].some_NM;
    			
    			if (i != data.info.length - 1) {
    				ComboCode += '|';
    				ComboText += '|';
				}
			}
    		
    		if (data.info.length != 0) {
    			IBSheet.CellComboItem(Row,change_col,{
    	  	  	    "ComboCode": ComboCode,
    	  	      	"ComboText": ComboText
      	  	    });	
			}
    		
    	},
    	err : function(r) {
    		alert('<spring:message code="fail.common.menu.create" />');
    	}
    	});
    	
  	}
  	
  	//데이터 변경시 다른 데이터 자동 변경
  	function set_data (IBSheet,Row,key_col,value_col,Master_NM){
  		var key_data = IBSheet.GetCellValue(Row,key_col);
    	$.ajax({
	    		url: "<c:url value='/Common/set_data.do'/>",
	    	type: "POST",
	    	data: {Master_NM:Master_NM},
	    	async: false,
	    	dataType: "json",
	    	success : function( data ) {
	    		for (var i = 0; i < data.info.length; i++) {
					if (data.info[i][key_col] == key_data) {
						for (let key in value_col){
							IBSheet.SetCellValue(Row,key,data.info[i][key]);
		    			}
										
					}
				}
	    	},
	    	err : function(r) {
	    		alert('<spring:message code="fail.common.menu.create" />');
	    	}
	    	});

  	}
  	
    //날짜 가져오기
    function get_date(set_date) {
    	var today = new Date();         
    	var year = today.getFullYear();
        var month = ('0' + (today.getMonth() + 1)).slice(-2);
        var day = ('0' + today.getDate()).slice(-2);
        
        var value = '';
        
        switch (set_date) {
		case 'today':
			value = year + "-" + month + "-" + day;
			break;
		case '1':
			value = year + "-" + month + "-01"
			break;
		case 'year':
			value = year
			break;
			
		default:
			break;
		}
        
        return value;
    }
    
    function UB_print(jrf_NM,UB_data) {
    	var $form = $("<form></form>");
    	
    	var arrPath = window.location.pathname.split("/");
    	var vhostName = window.location.hostname;
    	var rpath = "";

    	if(vhostName.indexOf("localhost") > -1 || vhostName.indexOf("127.") > -1){
    		rpath = "/" + arrPath[1];
    	}
    	
    	var url = rpath + "/ubi4/ubihtml.jsp";
    	var wid = "1280";
    	var hit = "800";	
    	
    	window.open("", "reportPopup", "width=" + wid + ", height=" + hit + ", top=150,left=150, scrollbars=yes,resizable=yes");

    	$form.attr("action", url);
    	$form.attr("method", "post");
    	$form.attr("target", "reportPopup");
    	$form.appendTo('body');

    	var sys = $("<input type='hidden' value='UBIHTML' name='resId' id='resId'>");
    	var rf = $("<input type='hidden' value='" + jrf_NM + "' name='jrf' id='jrf'>");
    	var arglist = $("<input type='hidden' value='" + UB_data + "' name='arg' id='arg'>");

    	$form.append(sys).append(rf).append(arglist);
    	$form.submit();
    	
    }
</script>
<style>
	form {
	    height: min-content;
	}
	table {
	    font-size: small;
	}
</style>
<%-- 로컬네비게이션 --%>
<ul class="breadcrumbs"></ul>
<%-- 로컬네비게이션 --%>