<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
<%-- 즐겨찾기, 메뉴 이동 --%>
function fn_leftTabMove(cls)
{
	if(cls == "01") {
		$("#viewAllMenu").css("display", "");
		$("#viewBookMark").css("display", "none");
	} else {
		$("#viewAllMenu").css("display", "none");
		$("#viewBookMark").css("display", "");
	}
}

    <%-- 좌측메뉴 숨김 --%>
	function fn_disappearLeftMenu(cls)
	{
		if(cls == "01") {
			$("#leftMenuGroup").css("display", "none");
			$("#leftMenuGroupDis").css("display", "");
			$("#leftMenuGroupDis").css({"min-width": "32px"});
			$(".box-both-right").css({"margin": "0 0 0 32px"});
			
			var tmpWidth = $("#myTabDiv").parent().width();
			myTab.SetWidth(tmpWidth);
		} else {
			$("#leftMenuGroup").css("display", "");
			$("#leftMenuGroupDis").css("display", "none");
			$("#leftMenuGroupDis").css({"min-width": "250px"});
			$(".box-both-right").css({"margin": "0 0 0 250px"});
			
			var tmpWidth = $("#myTabDiv").parent().width();
			myTab.SetWidth(tmpWidth);
		}
		
		var posY = $(".list-unstyled").offset().top;
		var h = $(window).height()-(posY+10);
		$(".list-unstyled").css({'overflow':'auto'});
		$(".list-unstyled").css({'height':''+h+'px'});	
	}

    <%-- 좌측 메뉴 스크롤 높이 계산 후 적용 --%>
	$(window).resize(function(){
		var tc = document.getElementsByClassName("list-unstyled");
		if(tc.length > 0) {
			$(".list-unstyled").each(function(index, item){
				var posY = $(".list-unstyled").offset().top;
				var h = $(window).height()-(posY+10);
				$(".list-unstyled").css({'height':''+h+'px'});
				$(".list-unstyled").css({'overflow':'auto'});	
			});
		}
		
		//창크기 변동에 따른 IBTab 너비 변경
		var tmpWidth = $("#myTabDiv").parent().width();
		if(typeof(myTab) != 'undefined') {
			myTab.SetWidth(tmpWidth);	
		}
	}).resize();
	
<%-- 좌측메뉴 호출 --%>
function fn_moveDetailMenu(menu_NM,menu_CD)
{
	
	fn_leftTabMove("01");
	fn_disappearLeftMenu("02");
	
	$.ajax({
			url: "<c:url value='/Common/get_Left_menu.do'/>",
		type: "POST",
		data: {menu_CD:menu_CD},
		dataType: "json",
		success : function( data ) {
			var appendData = "";
			$.each(data.Left_menu_List, function(idx, data){

				if(data.menu_LV == "3") { 
					appendData +=
						  '<li class="active-select" id ="gs_' + data.menu_CD + '">'
						+	'<a href="#" onclick="javascript:insertTab(\''
						+   menu_NM
						+	'\', \''	
						+   menu_CD
						+	'\', \''		
						+	data.pgmURL
						+	'\', \''
						+	data.menu_CD
						+	'\', \''
						+	data.menu_NM
						+	'\', \''
						+	data.upp_menu_NM
						+	'\', \''
						+	data.upp_menu_CD
						+	'\', \'\'); return false;">'
						+	'<i class="fa fa-file-o" aria-hidden="true"></i>'
						+	data.menu_NM
						+	'</a>'
						+'</li>';
				} else if(data.menu_LV == "2") {
					if(idx > 1) {
						appendData += 
							 '</div>'
							+ '<li id="gm_' + data.menu_CD + '" style="font-weight:bold;">'
							+   '<a href="#">'
							+	'<span class="caret"></span>'
							+	'<i class="fa fa-folder-o" aria-hidden="true"></i>'							
							+	data.menu_NM
							+  '</a>'
							+'</li>'
							+'<div id="gm_' + data.menu_CD + '_slave" style="display:none;">';	
					} else {
						appendData += 
							 '<li id="gm_' + data.menu_CD + '" style="font-weight:bold;">'
							+   '<a href="#">'
							+	'<span class="caret"></span>'
							+	'<i class="fa fa-folder-o" aria-hidden="true"></i>'							
							+	data.menu_NM
							+  '</a>'
							+'</li>'
							+'<div id="gm_' + data.menu_CD + '_slave" style="display:block;">';	
					}
				}
				
			});
			
			$("#allMenuList").html(appendData);
			
			$("#gsMenuNm").html(menu_NM);
			$("#gsMenuNm2").html(menu_NM);
			
			<%-- 아코디언 --%>
			$('[id^=gm_]').click(function() {
				$('[id='+ $(this).attr("id") + '_slave]').not($(this).next('[id='+ $(this).attr("id") + '_slave]').slideToggle("fast")).hide();
			});
			
		},
		err : function(r) {
			alert('<spring:message code="fail.common.menu.create" />');
		}
		});

}

	<%-- 새창으로 이벤트 --%>
	function fn_pwdChange()
	{	
		var height = 400;
		var width = 700;
		var top = (screen.height-height) / 4;
		var left = (screen.width-width) / 4;
		var style = "height=" + height + ", width=" + width + ", top=" + top + ", left=" + left + ", location=no, resizable=no, menubar=no, toolbar=no, scrollbars=false";
		var id = "MBSAc000";
		var url = "<c:url value='/Common/pwdChange.do'/>";
		window.open(url, id, style);
	}

	<%-- 모든탭 닫기 이벤트 --%>
	function fn_closeTabAll()
    {
		if(confirm('<spring:message code="common.close.tab.all.msg" />')){
			myTab.RemoveAll();	
			insertTab("Home", "0", "/Common/main_Tab_create.do", "0", "Home", "Home", "0");
		}
    }
	
</script>
<div id="skipNav" class="invisible" style="display:none">
    <dl>
        <dt>콘텐츠 바로가기</dt>
        <dd><a href="#content">컨텐츠 바로가기</a></dd>
        <dd><a href="#topnavi">메인메뉴 바로가기</a></dd>
        <dd><a href="#leftmenu">좌메뉴 바로가기</a></dd>
    </dl>
</div>

<%-- 상단정보 설정 --%>
<div class="header">
	<div class="logo-img">
		<a href="<c:url value='/Common/actionMainPage.do'/>"><img src="<c:url value='/images/gom/main/logo_Giant_Factory.png'/>" class="logo-size" alt="경영정보시스템 홈"></a>		
	</div>
	<div class="notice">
	</div>
	<div class="icon-right">
		<ul class="list-inline">
			<li>
				<a href="<c:url value='/Common/actionMainPage.do'/>"><i class="fa fa-repeat" aria-hidden="true" title="새로고침"></i><span>새로고침</span></a>
			</li>
			<li>
				<a href="#" onclick="javascript:fn_closeTabAll(); return false;"><i class="fa fa-window-close" aria-hidden="true" title="전체 탭 닫기"></i><span>모든창닫기</span></a>
			</li>
			<li>
				<a href="<c:url value='/manual/GIT_Manual.hwp'/>"><i class="fa fa-question-circle" aria-hidden="true" title="메뉴얼"></i><span>매뉴얼</span></a>
			</li>
			<li>
				<a href="#" onclick="javascript:fn_pwdChange(); return false;"><i class="fa fa-pencil"></i><span>비밀번호 변경</span></a>
			</li>
			<li class="logout">
				<a href="<c:url value='/Common/actionLogout.do'/>"><i class="fa fa-sign-out" aria-hidden="true" title="로그아웃"></i><span>로그아웃</span></a>
			</li>
		</ul>
	</div>
</div>

<%-- 좌측메뉴 안보이게 설정 --%>
<div class="box-both-left" id="leftMenuGroupDis" role="navigation" style="min-height:92%; width:32px">
	<div class="box-both-left-nav navbar-collapse" style="width:32px">
		<div class="left-top" style="width:32px">
			<a href="#" onclick="javascript:fn_disappearLeftMenu('02'); return false;" title="좌측메뉴를 보입니다.">
				<div class="left-top-arrow pull-right">
					<i class="fa fa-chevron-right" aria-hidden="true"></i>
				</div>
			</a>
		</div>
	</div>
</div>

<%-- 좌측메뉴 설정 --%>
<div class="box-both-left" id="leftMenuGroup" role="navigation" style="min-height:92%;">
	<div class="box-both-left-nav navbar-collapse">
		<div class="left-top">
			<a href="#" onclick="javascript:fn_disappearLeftMenu('01'); return false;" title="좌측메뉴를 숨깁니다.">
				<div class="left-top-arrow pull-right">
					<i class="fa fa-chevron-left" aria-hidden="true"></i>
				</div>
			</a>
		</div>
		<div class="log-box">
			<p><span class="log-con">[회사 : <c:out value="${userInfo.comp_ko_NM}"/>]</span></p>
			<p><span class="log-con">[ <c:out value="${userInfo.memb_rating}"/></span> |
				<span class="log-name"><i class="fa fa-user" aria-hidden="true"></i> <c:out value="${userInfo.memb_NM}"/>  ]</span> 
			</p>
		</div>
		<div>
			<label for="menuSearch" style="margin-left:20px;">메뉴검색 : </label>
			<input type="text" id="mnuNm" name="mnuNm" style="width:100px">
			<span class="btn-search" onclick="javascript:fn_searchMenuList();">검색</span>
		</div>
		<%-- 좌측메뉴 탭 설정 --%>
		<div class="left-tabs" id="viewAllMenu">
			<ul class="tabs-list tabs-nav">
				<li class="active">
					<a href="#"><div id="gsMenuNm">전체</div></a>
				</li>
				<li>
					<a href="#" onclick="javascript:fn_leftTabMove('02'); return false;">즐겨찾기</a>
				</li>
			</ul>
			
			<%-- 좌측메뉴 탭 설정 --%>
			<div class="tabs-content">
				<div class="cont-list">
					<ul class="list-unstyled" id="allMenuList" style="overflow:auto;">
					</ul>
				</div>
			</div>
		</div>
		<div class="left-tabs" id="viewBookMark">
			<ul class="tabs-list tabs-nav">
				<li>
					<a href="#" onclick="javascript:fn_leftTabMove('01'); return false;"><div id="gsMenuNm2">전체</div></a>
				</li>
				<li class="active">
					<a href="#">즐겨찾기</a>
				</li>
			</ul>
			
			<%-- 즐겨찾기 메뉴 탭 설정 --%>
			<div class="tabs-content">
				<div class="cont-list">
					<ul class="list-unstyled" id="bookMarkList" style="overflow:auto;">
					</ul>
				</div>
			</div>
		</div>		
		<%-- 좌측메뉴 탭 설정 --%>
	</div>
</div>
<%-- 좌측메뉴 설정 --%>