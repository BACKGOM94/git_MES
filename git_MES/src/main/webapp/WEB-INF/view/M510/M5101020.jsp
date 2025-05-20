<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.donut {
    width: calc(60%);
    padding-bottom: calc(60%);
    margin: 0 auto;
    border-radius: 50%;
    position: relative;
    text-align: center;
    transition: background .3s ease-in-out;
}

 .donut::before {
    color: #fff;
    width: 70%;
    padding: calc(35% - .64vw) 0;
    background: #264057;
    border-radius: 50%;
    position: absolute;
    left: 15%;
    top: 15%;
    display: block;
    content: attr(data-percent)'%';
    transform: skew(-0.03deg);
    margin: auto;
    font-size: 1.1vw;
    font-size: 2vw;
    padding: calc(35% - 1.3vw) 0;
} 

.area {
	text-align: center;
}
</style>

<script type="text/javascript">

	$(document).ready(
			function() {
				//1분주기로 데이터 리로드
				setTimeout(function () {
					location.reload();
					},60000);
			});

	function doAction(sheetNm, action){
		$('#sheetNm').val(sheetNm);
		
		switch (action) {
		case "update":
			window.open("<c:url value='/M510/M5101021.do'/>", "화면수정", "height=600, width=1100, top=200, left=400");
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
				<h4>설비 실적 모니터링</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">
				<ul class="list-inline">
					<li><a title="수정" class="btn-save" href="#" onclick="doAction('M5101021_1_Sheet', 'update'); return false;" role="button">수정</a></li>
				</ul>
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post"> 
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			</form>
			<%--검색조건 영역--%>
		
			<%--하단 컨텐츠(전체) 영역--%>
			<div class="layout-grid">
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> ${view_spot_1.item_NM}</h6>
						</div>
						<div class="btn-y-group">
						</div>
						<div class="title-set">
							<p><b>목표건수</b> : ${view_spot_1.target_CT}건		</p>
							<p><b>측정건수</b> : ${view_spot_1.count}건</p><br>
							<p><b>불량건수</b> : ${view_spot_1.error_count}건		</p>
							<p><b>평균시간</b> : ${view_spot_1.read_TM}초</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					<%-- ibsheet div --%>
					<div class="area">
						<div class="donut" data-percent="${view_spot_1.percentage}"style="background: conic-gradient(#3F8BC9 0% ${view_spot_1.percentage}%, #F2F2F2 ${view_spot_1.percentage}% 100%);"></div>
					</div>
					<%-- ibsheet div --%>
					<br>
					<div class="title">
							<div class="title-area">
							<h6> ${view_spot_4.item_NM}</h6>
						</div>
						<div class="btn-y-group">
						</div>
						<div class="title-set">
							<p><b>목표건수</b> : ${view_spot_4.target_CT}건		</p>
							<p><b>측정건수</b> : ${view_spot_4.count}건</p><br>
							<p><b>불량건수</b> : ${view_spot_4.error_count}건		</p>
							<p><b>평균시간</b> : ${view_spot_4.read_TM}초</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div class="area">
						<div class="donut" data-percent="${view_spot_4.percentage}"style="background: conic-gradient(#3F8BC9 0% ${view_spot_4.percentage}%, #F2F2F2 ${view_spot_4.percentage}% 100%);"></div>
					</div>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> ${view_spot_2.item_NM}</h6>
						</div>
						<div class="btn-y-group">
						</div>
						<div class="title-set">
							<p><b>목표건수</b> : ${view_spot_2.target_CT}건		</p>
							<p><b>측정건수</b> : ${view_spot_2.count}건</p><br>
							<p><b>불량건수</b> : ${view_spot_2.error_count}건		</p>
							<p><b>평균시간</b> : ${view_spot_2.read_TM}초</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div class="area">
						<div class="donut" data-percent="${view_spot_2.percentage}"style="background: conic-gradient(#3F8BC9 0% ${view_spot_2.percentage}%, #F2F2F2 ${view_spot_2.percentage}% 100%);"></div>
					</div>
					<%-- ibsheet div --%>
					<br>
					<div class="title">
						<div class="title-area">
							<h6> ${view_spot_5.item_NM}</h6>
						</div>
						<div class="btn-y-group">
						</div>
						<div class="title-set">
							<p><b>목표건수</b> : ${view_spot_5.target_CT}건		</p>
							<p><b>측정건수</b> : ${view_spot_5.count}건</p><br>
							<p><b>불량건수</b> : ${view_spot_5.error_count}건		</p>
							<p><b>평균시간</b> : ${view_spot_5.read_TM}초</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div class="area">
						<div class="donut" data-percent="${view_spot_5.percentage}"style="background: conic-gradient(#3F8BC9 0% ${view_spot_5.percentage}%, #F2F2F2 ${view_spot_5.percentage}% 100%);"></div>
					</div>
				</div>
				<div class="grid-left5">
					<div class="clear"></div>
				</div>
				<div class="grid-left29">
					<%-- title --%>
					<div class="title">
						<div class="title-area">
							<h6> ${view_spot_3.item_NM}</h6>
						</div>
						<div class="btn-y-group">
						</div>
						<div class="title-set">
							<p><b>목표건수</b> : ${view_spot_3.target_CT}건		</p>
							<p><b>측정건수</b> : ${view_spot_3.count}건</p><br>
							<p><b>불량건수</b> : ${view_spot_3.error_count}건		</p>
							<p><b>평균시간</b> : ${view_spot_3.read_TM}초</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div class="area">
						<div class="donut" data-percent="${view_spot_3.percentage}"style="background: conic-gradient(#3F8BC9 0% ${view_spot_3.percentage}%, #F2F2F2 ${view_spot_3.percentage}% 100%);"></div>
					</div>
					<%-- ibsheet div --%>
					<br>
					<div class="title">
						<div class="title-area">
							<h6> ${view_spot_6.item_NM}</h6>
						</div>
						<div class="btn-y-group">
						</div>
						<div class="title-set">
							<p><b>목표건수</b> : ${view_spot_6.target_CT}건		</p>
							<p><b>측정건수</b> : ${view_spot_6.count}건</p><br>
							<p><b>불량건수</b> : ${view_spot_6.error_count}건		</p>
							<p><b>평균시간</b> : ${view_spot_6.read_TM}초</p>
						</div>
					</div>
					<div class="clear"></div>
					<%-- title --%>
					
					<%-- ibsheet div --%>
					<div class="area">
						<div class="donut" data-percent="${view_spot_6.percentage}"style="background: conic-gradient(#3F8BC9 0% ${view_spot_6.percentage}%, #F2F2F2 ${view_spot_6.percentage}% 100%);"></div>
					</div>
				</div>
				
			</div>
			<%--하단 컨텐츠(전체) 영역--%>
			
			
		</div>
		<%-- page-content --%>
	</div>
	<%-- container --%>
</body>
</html>