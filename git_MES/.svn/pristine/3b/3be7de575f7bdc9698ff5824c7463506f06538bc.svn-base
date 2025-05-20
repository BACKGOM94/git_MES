<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html lang="ko">
<head>
<style type="text/css">
	.sec_cal {
	    margin: 0 auto;
	    font-family: "NotoSansR";
	}
	
	.sec_cal .cal_nav {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    font-weight: 700;
	    font-size: 48px;
	    line-height: 78px;
	}
	
	.sec_cal .cal_nav .year-month {
	    width: 300px;
	    text-align: center;
	    line-height: 1;
	}
	
	.sec_cal .cal_nav .nav {
	    display: flex;
	    border: 1px solid #333333;
	    border-radius: 5px;
	}
	
	.sec_cal .cal_nav .go-prev,
	.sec_cal .cal_nav .go-next {
	    display: block;
	    width: 50px;
	    height: 78px;
	    font-size: 0;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	
	.sec_cal .cal_nav .go-prev::before,
	.sec_cal .cal_nav .go-next::before {
	    content: "";
	    display: block;
	    width: 20px;
	    height: 20px;
	    border: 3px solid #000;
	    border-width: 3px 3px 0 0;
	    transition: border 0.1s;
	}
	
	.sec_cal .cal_nav .go-prev:hover::before,
	.sec_cal .cal_nav .go-next:hover::before {
	    border-color: #ed2a61;
	}
	
	.sec_cal .cal_nav .go-prev::before {
	    transform: rotate(-135deg);
	}
	
	.sec_cal .cal_nav .go-next::before {
	    transform: rotate(45deg);
	}
	
	.sec_cal .cal_wrap {
	    padding-top: 40px;
	    position: relative;
	    margin: 0 auto;
	}
	
	.sec_cal .cal_wrap .days {
	    display: flex;
	    margin-bottom: 20px;
	    padding-bottom: 20px;
	    border-bottom: 1px solid #ddd;
	}
	
	.sec_cal .cal_wrap::after {
	    top: 368px;
	}
	
	.sec_cal .cal_wrap .day {
	    display:flex;
	    align-items: center;
	    justify-content: center;
	    width: calc(100% / 7);
	    text-align: left;
	    color: #999;
	    font-size: 12px;
	    text-align: center;
	    border-radius:5px
	}
	
	.current.today {background: rgb(242 242 242);}
	
	.sec_cal .cal_wrap .dates {
	    display: flex;
	    flex-flow: wrap;
	    height: 290px;
	}
	
	.sec_cal .cal_wrap .day:nth-child(7n -1) {
	    color: #3c6ffa;
	}
	
	.sec_cal .cal_wrap .day:nth-child(7n) {
	    color: #ed2a61;
	}
	
	.sec_cal .cal_wrap .day.disable {
	    color: #ddd;
	}
	
	table, th, td {
  border: 1px solid black;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {

    calendarInit();
});
/*
    달력 렌더링 할 때 필요한 정보 목록 

    현재 월(초기값 : 현재 시간)
    금월 마지막일 날짜와 요일
    전월 마지막일 날짜와 요일
*/

function calendarInit() {

    // 날짜 정보 가져오기
    var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
    var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
    var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
    var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
  
    var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    // 달력에서 표기하는 날짜 객체
  
    
    var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
    var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
    var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일
    
    // kst 기준 현재시간
    // console.log(thisMonth);

    // 캘린더 렌더링
    renderCalender(thisMonth);

    function renderCalender(thisMonth) {

        // 렌더링을 위한 데이터 정리
        currentYear = thisMonth.getFullYear();
        currentMonth = thisMonth.getMonth();
        currentDate = thisMonth.getDate();

        // 이전 달의 마지막 날 날짜와 요일 구하기
        var startDay = new Date(currentYear, currentMonth, 0);
        var prevDate = startDay.getDate();
        var prevDay = startDay.getDay();

        // 이번 달의 마지막날 날짜와 요일 구하기
        var endDay = new Date(currentYear, currentMonth + 1, 0);
        var nextDate = endDay.getDate();
        var nextDay = endDay.getDay();

        // console.log(prevDate, prevDay, nextDate, nextDay);

        // 현재 월 표기
        $('.year-month').text(currentYear + '.' + (currentMonth + 1));

        // 렌더링 html 요소 생성
        calendar = document.querySelector('.dates')
        calendar.innerHTML = '';
        
        // 지난달
        for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
            calendar.innerHTML = calendar.innerHTML + '<div class="day prev disable">' + i + '</div>'
        }
        // 이번달
        for (var i = 1; i <= nextDate; i++) {
        	
        	var _true = '<i class="fa fa-star" style="color: blue;"></i>' ;
        	var _false = '<i class="fa fa-star" style="color: red;"></i>' ;
        	
        	
        	var Data = '<table>' + 
        	'<tr><td>' + i + '일</td><td>Lv1</td><td>Lv3</td><td>avg</td><td>Data</td></tr>' + 
        	'<tr><td>삼원DMP</td><td>' + _true + '</td><td>' + _false + '</td><td>' + _false + '</td><td>20</td></tr>' +
        	'<tr><td>삼원DMP</td><td>' + _true + '</td><td>' + _false + '</td><td>' + _false + '</td><td>20</td></tr>' +
        	'<tr><td>삼원DMP</td><td>' + _true + '</td><td>' + _false + '</td><td>' + _false + '</td><td>20</td></tr>' +
        	'<tr><td>삼원DMP</td><td>' + _true + '</td><td>' + _false + '</td><td>' + _false + '</td><td>20</td></tr>' +
        				'</table>';
        	
			var comp_NM = '';
			var comp_CD = '';
			var cert_Key = '';
			var _date = currentYear + String(currentMonth+1).padStart(2,'0') + String(i).padStart(2,'0');
        	var _data = '<table><tr><td>' + i + '일</td><td>Lv1</td><td>Lv3</td><td>avg</td><td>Data</td></tr>';
        				
        	for (var j = 1; j < 5; j++) {
				switch (j) {
					case 1:
							comp_NM = 'SMT';
							comp_CD = 'COM202408260001';
							cert_Key = '8cfd-8388-2ffd-9b94';
						break;
					case 2:
							comp_NM = '남양정공';
							comp_CD = 'COM202408260002';
							cert_Key = 'f7cb-606f-5238-b382';
						break;
					case 3:
							comp_NM = '다승정밀';
							comp_CD = 'COM202408260003';
							cert_Key = '0161-2dd1-ebc7-ddd5';
						break;
					case 4:
							comp_NM = '삼원DMP';
							comp_CD = 'COM202408260004';
							cert_Key = '3182-e048-f1fe-89fb';
						break;

				default:
					break;
				}							
				
				_data += '<tr><td>' + comp_NM + '</td><td>';
				
				if (kpi_check(1,cert_Key,_date) == 1) _data += _true + '</td><td>';			
				else _data += _false + '</td><td>';
				
				if (kpi_check(3,cert_Key,_date)== 1) _data += _true + '</td><td>';			
				else _data += _false + '</td><td>';
				
    	    	$.ajax({
		  	    	url: "<c:url value='/M990/get_Kpi_data.do'/>",
		  	    	type: "POST",
		  	    	data: {comp_CD : comp_CD, _date:_date},
		  	    	async: false,
		  	    	dataType: "json",
		  	    	success : function( data ) {	
		  	    		_data += data.kpi_data.avg + '</td><td>' + data.kpi_data.count + '</td></tr>';
		  	    	},
		  	    	err : function(r) {
		  	    		alert('<spring:message code="fail.common.menu.create" />');
		  	    	}
	  	    	});
    	    	
			}
        	
        	_data += '</table>';
        	
            calendar.innerHTML = calendar.innerHTML + '<div class="day current">' + _data + '</div>'
        }
        // 다음달
        for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
            calendar.innerHTML = calendar.innerHTML + '<div class="day next disable">' + i + '</div>'
        }

        // 오늘 날짜 표기
        if (today.getMonth() == currentMonth) {
            todayDate = today.getDate();
            var currentMonthDate = document.querySelectorAll('.dates .current');
            currentMonthDate[todayDate -1].classList.add('today');
        }
    }

    // 이전달로 이동
    $('.go-prev').on('click', function() {
        thisMonth = new Date(currentYear, currentMonth - 1, 1);
        renderCalender(thisMonth);
    });

    // 다음달로 이동
    $('.go-next').on('click', function() {
        thisMonth = new Date(currentYear, currentMonth + 1, 1);
        renderCalender(thisMonth); 
    });
    
    function kpi_check(_Lv,_schKpiCertKey,_schOcrDttm) {
		var param = {
				schKpiCertKey : _schKpiCertKey , schOcrDttm : _schOcrDttm
		};
		
		var url = '';
		var value = 0 ;
		if (_Lv == 1) url = 'http://www.ssf-kpi.kr:8080/kpiLv1/kpiLv1List' ; 
		else url = 'http://www.ssf-kpi.kr:8080/kpiLv3/kpiLv3List' ;

        $.ajax({
                url : url, 
                type : "POST",
                data : JSON.stringify(param),
                async: false,
                dataType : "json",
                contentType: "application/json; charset=utf-8",
                success : function(data) {

                    if (data.length > 0) value = 1;                     

                },
                fail : function(data) {
                    console.log("오류가 발생했습니다.");
                }
            });
        
        return value ;
		
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
				<h4>Kpi 관리</h4>
				<h5></h5>
			</div>
			<%--페이지 제목 영역--%>
			
			<%--검색버튼 영역--%>
			<div class="btn-group">				
			</div>
			<%--검색버튼 영역--%>
			
			<%--검색조건 영역--%>
			<form name="searchForm" id="searchForm" method="post">
			<input type="text" hidden="true" id="sheetNm" name="sheetNm">
			<input type="text" hidden="true" id="comp_CD" name="comp_CD">
			<div class="inquiry-box">
				<table class="table">
					<caption>회사등록</caption>
					<tbody>
						<tr class="line">
							<th></th><td></td>
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
				<div class="sec_cal">
				  <div class="cal_nav">
				    <a href="javascript:;" class="nav-btn go-prev">prev</a>
				    <div class="year-month"></div>
				    <a href="javascript:;" class="nav-btn go-next">next</a>
				  </div>
				  <div class="cal_wrap">
				    <div class="days">
				      <div class="day">MON</div>
				      <div class="day">TUE</div>
				      <div class="day">WED</div>
				      <div class="day">THU</div>
				      <div class="day">FRI</div>
				      <div class="day">SAT</div>
				      <div class="day">SUN</div>
				    </div>
				    <div class="dates"></div>
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
