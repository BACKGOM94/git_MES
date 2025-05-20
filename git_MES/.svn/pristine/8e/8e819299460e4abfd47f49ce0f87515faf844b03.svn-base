<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<%--IBTab 스크립트--%>
<script type="text/javascript" src="<c:url value='/IBSheet7/ibmditab/ibmditab.js'/>"></script>
<script type="text/javascript" src="<c:url value='/IBSheet7/ibmditab/ibmditabinfo.js'/>"></script>
<script type="text/javascript" src="<c:url value='/IBSheet7/ibmditab/ibmditabscroll.js'/>"></script>	

<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	<%-- 기본 실행 --%>
	$(document).ready(
		function(){
		<%-- 페이지 초기화 --%>
		pageload();
		<%-- 즐겨찾기, 메뉴 이동 --%>
		fn_leftTabMove("02");
		<%-- 좌측메뉴 숨김 --%>
		fn_disappearLeftMenu("02");
		});
		
	<%-- 로딩 중 화면막기 --%>
	function gfn_blockScreen() {
		$("#loadingDiv").addClass("overlay");
	}
	
	<%-- 로딩 중 화면막기 해제 --%>
	function gfn_blockScreenCancle() {
		$("#loadingDiv").removeClass("overlay");
	}
	
	<%-- 화면로딩 중 표시 --%>
	function gfn_loadingScreen() {
		$("#loadingOverlay").addClass("loading-overlay");
	}
	
	<%-- 화면로딩 중 해제 --%>
	function gfn_loadingScreenCancle() {
		$("#loadingOverlay").removeClass("loading-overlay");
	}
	
	<%-- 페이지 초기화 --%>
	function pageload() {
		createIBMDITab2("myTabDiv","myTab","100%", "100%", "MyDesign");
	}
	
	<%-- 탭 생성 완료 이벤트 --%>
	function myTab_OnloadTab2Finish()
	{
		<%-- 탭 초기화 함수(버튼 스타일 , 아이콘사용 유무, 닫기버튼 유무) --%>
		myTab.Init(1, false, true);
		
		<%-- 최대 갖을수 있는 탭의 수 --%>
		myTab.SetMaxCount(20);
		
		<%-- 탭버튼의 너비 설정(0:지정개수/화면너비 , 1: 지정너비 , 2:헤더타이틀 글자수에 따른 너비) --%>
		myTab.SetTabItemLayout(2);
		
		<%-- 높이 설정 --%>
		$(window).resize(function(){
			var h = $(window).height();
			myTab.SetHeight(h-104);
		});
		
		<%-- 텝간 간격 --%>
		myTab.SetTabOffset(3, 0);
		
		<%-- 상단 메뉴를 보이기 위한 탭 z-index 수정 --%>
		myTab.SetMaxZIndex(1);
		
		<%-- 초기화 후 Home 화면 출력 --%>
		insertTab("Home", "0", "/Common/main_Tab_create.do", "0", "Home", "Home", "0");
		
	}
	
	<%-- 선택된 메뉴의 화면 추가 --%>
	function insertTab(topMenuNm, topMenuNo, chkURL, mnuId, menuNm, upp_menu_NM, upperMenuId, smsCtfYn)
	{
		
		if(myTab.GetCount() < 20) {
			gfn_loadingScreen();	
		}
			gv_sUpperMenuId = upperMenuId;
			gv_sMnuId = mnuId;
			
			<%-- 이미 추가된 페이지인 경우 새로 추가하지 말고 해당 탭으로 focus 이동한다. --%>
			
	
			var cnt  = myTab.GetCount();
			for(var i=0;i<cnt;i++)
			{
				var id = myTab.GetTabID(i);
				if(id==mnuId){
					gfn_loadingScreenCancle();
					 myTab.SetSelectedIndex(i);
					 return;
				}
			}
			var targetUrl = "?topMenuNm="+encodeURIComponent(topMenuNm)+"&topMenuNo="+encodeURIComponent(topMenuNo)+"&menuNm="+encodeURIComponent(menuNm)+"&upp_menu_NM="+encodeURIComponent(upp_menu_NM);
	
			myTab.InsertItem2(mnuId, menuNm, "${pageContext.request.contextPath}" + chkURL + targetUrl, "", true);
	
			<%-- 텝 높이 설정 --%>
			var height = $(window).height();
				myTab.SetHeight(height-142); //2016.04.19 헤더 영역의 기본 높이가 142이다
		
	}

</script>
</head>
<body>
	<div id="loadingDiv" > </div>
	<div id="loadingOverlay"> </div>
	<div class="wrapper">
	    <%--탑 및 좌측 메뉴 영역--%>
	    <%@ include file="/WEB-INF/view/Common/inc/main_Left.jsp" %>	
	    <%--탑 및 좌측 메뉴 영역--%>
	    
		<div class="box-both-right" style="min-height: 100%;">
		
		    <%--탑 및 좌측 메뉴 영역--%>
		    <%@ include file="/WEB-INF/view/Common/inc/main_Top.jsp" %>	
		    <%--탑 및 좌측 메뉴 영역--%>
		    
		    <div class="page-content2">
				<div id="myTabDiv" class="cont"></div>
			</div>
		</div>		
	</div>
</body>
</html>