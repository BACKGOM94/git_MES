<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%!
	String nullToStr(String s1, String s2) {
		return ((s1 == null)?s2:s1);
	}
%>
<%
	request.setCharacterEncoding("UTF-8");

	String jrf = nullToStr(request.getParameter("jrf"), "report2.jrf");  // 리포트 파일	
//	String arg = nullToStr(request.getParameter("arg"), "ARG.1#아규먼트1#T.1#11#ARG.2#아규먼트2#T.2#22#ARG.3#아규먼트3#T.3#22#");  // 파라미타 명#파라미타값#
	String arg = nullToStr(request.getParameter("arg"), "ARG#ASD#T#ASD#");  // 파라미타 명#파라미타값#
	String resId = nullToStr(request.getParameter("resId"), "UBIHTML");
	String count = nullToStr(request.getParameter("count"), "1");
	
	System.out.println("UBIREPORT ::: jrf	= " + jrf);
	System.out.println("UBIREPORT ::: arg	= " + arg);
	System.out.println("UBIREPORT ::: resId	= " + resId);
	System.out.println("UBIREPORT ::: count	= " + count);
%>

<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>UbiReport4 HTMLViewer</title>

<script src='./js/ubihtml.js'></script>
<script src='./js/msg.js'></script>
<script src='./js/ubinonax.js'></script>
<script language='javascript'>
/*-----------------------------------------------------------------------------------
htmlViewer.setUserSaveList('Image,Pdf,Docx,Xls,Pptx,Hml,Cell');
htmlViewer.setUserPrintList('Ubi,Html,Pdf');
htmlViewer.setVisibleToolbar('INFO', false);
htmlViewer.HmlExtension='hwp';
htmlViewer.printHTML();		// HTML PrintSet
htmlViewer.printPDF();		// PDF PrintSet
htmlViewer.export('PDF');	// PDF/EXCEL/EXCEL_NO/HWP/PPTX/HML/DOCX/CELL/IMAGE
htmlViewer.print();		// Direct Print(WS VIEWER)
htmlViewer.printSet();		// PrintSet(WS VIEWER)
//htmlViewer.events.printEnd = UbiPrintEnd;
//htmlViewer.events.exportEnd = UbiExportEnd;
-----------------------------------------------------------------------------------*/
	/* URL 정보 */
	var app = 'git_MES';
	var appUrl = self.location.protocol + '//' + self.location.host + (app==''?'':('/' + app));

	/* Viewer Object */
	var htmlViewer = null;

	/* Viewer Param */
	var pKey = '<%= session.getId() %>';
	var pServerUrl = appUrl + '/UbiServer';
	var pResUrl = appUrl + '/ubi4/js/';
	var pDivId = 'UbiHTMLViewer';
	var pScale = 'WholePage';	//WholePage/PageWidth/60~300

	/* Modify for your environment */
	var pJrf = '<%= jrf %>';
	var pArg = '<%= arg %>';
	var pResId = '<%= resId %>';
	var count = '<%= count %>';	

	/* Report Preview */
	function UbiLoadReport() {

		UbiResize();
		htmlViewer = new UbiViewer( {

			key : pKey,
			ubiserverurl : pServerUrl,
			resource : pResUrl,
			resid : pResId,
			divid : pDivId,
			scale : pScale,
			jrffile : pJrf,
			arg : pArg,
			useplugin :'true',
			ismultireport :'true',
			multicount :count
		});				
				
		htmlViewer.showReport(UbiPreviewEnd);	
		htmlViewer.events.printEnd = UbiPrintEnd;
		htmlViewer.events.exportEnd = UbiExportEnd;		
	}

	/* Preview Callback */
	function UbiPreviewEnd() {
		htmlViewer.setVisibleToolbar("PRINT_UBI", true);		
		htmlViewer.printPDF();		// PDF PrintSet
//		htmlViewer.setVisibleToolbar('SAVE_PPTX',false); 
//		htmlViewer.setVisibleToolbar('SAVE_HWP',false);
//		htmlViewer.setVisibleToolbar('SAVE_RTF',false);
//		htmlViewer.setVisibleToolbar('SAVE_CELL',false);
//		htmlViewer.setVisibleToolbar('SAVE_HML',false);
//		htmlViewer.setVisibleToolbar('SAVE_DOCX',false);
//		htmlViewer.setVisibleToolbar('SAVE_EXCEL',false);
		//htmlViewer.print();  프린터로 바로 출력
		
/*
		// 전용뷰어 사용 기준 페이지 : 50페이지 이상이면 전용뷰어 인쇄만 활성화 됩니다.
		var basePageNum = 50;
	
		try {
			if( basePageNum <= htmlViewer.totalPage ) {

				htmlViewer.setEnableToolbar("PRINT_PDF", false);
				htmlViewer.setEnableToolbar("PRINT_HTML", false);
				htmlViewer.setEnableToolbar("PRINT_UBI", true);
				htmlViewer.setPluginprogress(true);
			}
			else {

				htmlViewer.setEnableToolbar("PRINT_PDF", true);
				htmlViewer.setEnableToolbar("PRINT_HTML", true);
				htmlViewer.setEnableToolbar("PRINT_UBI", false);
				htmlViewer.setPluginprogress(false);
			}
		}
		catch (e) {}
		*/
	}

	/* Print Callback */
	function UbiPrintEnd(flag) {
		var corpCds = opener.corpCds;
		var gtordNos = opener.gtordNos;
		var corpCdArray1 = opener.corpCdArray1;
		var corpCdArray2 = opener.corpCdArray2;
		var outPrcsNoArray1 = opener.outPrcsNoArray1;
		var outPrcsNoArray2 = opener.outPrcsNoArray2;
		var menu = opener.menuNo;	
	
	}
	
	/* Export Callback */
	function UbiExportEnd(flag, msg) {
		
	}

	/* Viewer Object Resize */
	function UbiResize() {

		/* Size Gap */
		var gap = 6;
		var w = ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - gap;
		var h = ((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - gap;
		document.getElementById(pDivId).style.width = w + 'px';
		document.getElementById(pDivId).style.height = h + 'px';
	}	 
	
//-->
</script>
</head>
<body style='margin:1px' onload='UbiLoadReport()' onresize='UbiResize()'>
<div id='UbiHTMLViewer' style='border:1px solid #767676; border-bottom-width:2px;'></div>
	<!-- <div id='UbiHTMLViewer' style='display :none; border-bottom-width:2px;'> </div> -->
</body>
</html>