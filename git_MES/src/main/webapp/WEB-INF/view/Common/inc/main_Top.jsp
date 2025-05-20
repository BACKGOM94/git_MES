<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">

<%-- 상단 메뉴 호출 --%>
function fn_topMenuLoad()
{
	$.ajax({
			url: "<c:url value='/Common/get_Top_menu.do'/>",
		type: "POST",
		data: {},
		dataType: "json",
		success : function( data ) {
			var appendData = "<ul>";
			$.each(data.Top_menu_List, function(idx, data){
					appendData +=
						'<li>'
						+ '<a href="#" onclick="javascript:fn_moveDetailMenu(\''+data.menu_NM+'\','+data.menu_CD+'); return false;">'
						+ data.menu_NM
						+ '</a>'
						+ '</li>';				
			});
			appendData += "</ul>";
			$(".clearfix").append(appendData);
		},
		err : function(r) {
			alert('<spring:message code="fail.common.menu.create" />');
		}
		});	
}

<%--화면 로드 처리--%>
$(document).ready(
		function() {
		fn_topMenuLoad();
		}
	);

</script>
    
<%-- 탑메뉴 설정 --%>
<div class="main-nav">
	<nav>
		<ul class="clearfix">
		</ul>
	</nav>
</div>
<%-- 탑메뉴 설정 --%>