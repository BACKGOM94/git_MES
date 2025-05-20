var gJson = {Data: [[]]};

/*
 * IBSheet를 생성(호출 위치에서 동적 생성)
 */
function createIBSheet(sheetid, width, height, gdTp, locale) {

	eventOverRide(sheetid);
	
    var div_str = "";

    if (!locale) locale = "";

    Grids.Locale = locale;
    Grids.Config = __ibsheet_cfg;
    Grids.Msg = __ibsheet_msg;
    

    
    if(!gdTp) {
	    div_str += '<div class="clear mb5">';
	    div_str += '    <div class="fl">';
	    div_str += '        <select id="recordCountPerPage"  name="recordCountPerPage" class="select" title="조회갯수" onchange="javascript:fn_changePageLength(); return false;">';
	    div_str += '            <option value="10" >10개씩 보기</option>';	    
	    div_str += '            <option value="20" >20개씩 보기</option>';
	    div_str += '            <option value="50" >50개씩 보기</option>';
	    div_str += '            <option value="100" >100개씩 보기</option>';
	    div_str += '        </select>';
	    div_str += '    </div>';
	    //div_str += '        <%--전체 건수는 span 에 totalcnt 라는 id 를 사용하면 자동 생성--%>';
	    div_str += '	<p class="fr">조회건수 : <span id="'+sheetid+'_totalcnt"></span> 건</p>';
	    //div_str += '	<span class="btn_help2"><a title="조회된 표의 제목행을 클릭하여 좌, 우로 이동하여 원하는 순서에 놓을 수 있습니다. 또한 각 제목 셀의 우측 선을 클릭하여 셀의 길이를 늘이거나 줄일 수 있습니다." href="#">도움말</a></span>';
	    div_str += '</div>';
    }
	
    div_str += "<div id='DIV_" + sheetid + "' style='width:" + width + ";height:" + height + ";'>";
	div_str += "<script> IBSheet('<ibsheet Sync=\"1\" Data_Sync=\"0\"> </ibsheet>',\"DIV_" + sheetid + "\", \"" + sheetid + "\"); </script>"
	div_str += "</div><div id='page_"+sheetid+"' class='sheet_page'></div>\n";

    //<![CDATA[

    document.write(div_str);
    methodOverRide(sheetid);
    window[sheetid].SetEditable(0);
    //]]>
    //window[sheetid].SetCountInfoElement(document.getElementById("totalcnt"));
//    window[sheetid+"_OnSmartResize"]=fucntion(w,h){
//    resizeWork(sheetid);
//    	
//	}
    
}

function setPageCount(cnt){
	switch(cnt){
	case 10:
		document.getElementById("recordCountPerPage").value = cnt;
		break;
	case 15:
		document.getElementById("recordCountPerPage").value = cnt;
		break;
	case 20:
		document.getElementById("recordCountPerPage").value = cnt;
		break;		
	case 50:
		document.getElementById("recordCountPerPage").value = cnt;
		break;		
	case 100:
		document.getElementById("recordCountPerPage").value = cnt;
		break;
	default:
		document.getElementById("recordCountPerPage").value = 20;
		break;
	}
	
}

/*
function calcSheetHeight(sheetid,v){
    var headerrows = window[sheetid].HeaderRows();
    var datarows = v;
    //     일반적인 해더헹 높이  + 데이터행 높이 + 기타 영역 높이)
    return (headerrows*26) + (datarows*22)+20;
}

$("#recordCountPerPage").bind("change",function(){
	//화면에 시트 id를 알아내야 함.
	var sheetid = sheetobj.id;
	
	var h = calcSheetHeight(sheetid);
	
	window[sheetid].SetSheetHeight(h);

});
*/
function eventOverRide(id){
	try {
		   	//OnSearchEnd 이벤트가 사용중인지 확인
		    var dummy2 = null;

		    if(typeof(window[id+"_OnSearchEnd"])!="undefined") {   

		    	if(typeof window[id+"_OnSearchEnd"] == "function"){

		    		dummy2 = window[id+"_OnSearchEnd"];

		    	} 

		    }

		    window[id+"_OnSearchEnd"] = function(code,msg,StCode,StMsg){
		    	//오류 발생시
		    	if(code<0){
		    		if(msg!=""){
		    			alert(msg);
		    		}
		    		//session이 끊어진 경우로 가정함.
	            	if(code+""=="-300"){
	            		//top.location.href = "/gom/";
	            		top.location.href = gv_getContextRootPath;
	            	}
		    	}
		    	
		    	

			    if( window[id].GetCurrentPage()==1&&(window[id].SearchMode==4 || window[id].SearchMode==1)){
	
			    	makePageIndex(id,1);  //페이지 인덱스를 생성함
	
			    }
			    if(dummy2){
	
			    	dummy2(code,msg,StCode,StMsg);  //화면에 정의한 SearchEnd이벤트가 있으면 이것도 수행함.
	
			    }

		    };
		    
		    
		    var dummySaveEnd=null;
	        //OnSaveEnd 를 dummyResize 담는다.
	        if(typeof(window[id+"_OnSaveEnd"])!="undefined"){ 
	            if(typeof window[id+"_OnSaveEnd"] == "function"){
	                dummySaveEnd = window[id+"_OnSaveEnd"];
	            }
	        }
	        //SaveEnd 오버라이드
	        window[id+"_OnSaveEnd"] = function(code,msg,StCode,stMsg){
	        	if(code<0){
	            	if(msg!=""){
	            		alert(msg);
	            	}
	            	//session이 끊어진 경우로 가정함.
	            	if(code+""=="-300"){
	            		//top.location.href = "//gom/";
	            		top.location.href = gv_getContextRootPath;
	            	}
	            }   
	            if(dummySaveEnd){
	                //기존에 정의한 OnSaveEnd구문을 동작시킨다.
	                dummySaveEnd(code,msg,StCode,stMsg); 
	            }
	        }

		  /*  
		try{
			//OnSelectMenu 이벤트가 사용중인지 확인
			var onselectmenuDummy = null;
			if(typeof(window[id+"_OnSelectMenu"])!="undefined"){   
				if(typeof window[id+"_OnSelectMenu"] == "function"){
					onselectmenuDummy = window[id+"_OnSelectMenu"];
				} 
			}

			window[id+"_OnSelectMenu"] = function(Text,Code,Col){
				
				if(Text=="엑셀 다운로드"){
					window[id].Down2Excel();
				}else if(Text=="업로드"){
					window[id].LoadExcel();
				}else if(Text=="신규행 추가"){
					window[id].DataInsert();
				}		
			

				if(onselectmenuDummy){
					onselectmenuDummy(Text,Code,Col);  //화면에 정의한 SelectMenu이벤트가 있으면 이것도 수행함.
				}
			}  
		}catch(e){
		} 
		    */
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		   var dummy = null;
		   if(typeof(window[id+"_OnLoad"])!="undefined"){   
			  if(typeof window[id+"_OnLoad"] == "function"){
			     dummy = window[id+"_OnLoad"];
			  } 
		   }
		
		   window[id+"_OnLoad"] = function(){
			   window[id].SetCountInfoElement(document.getElementById(id+"_totalcnt"));
			   //SetConfig override   SearchMode가 4 인 경우,SizeMode를 sizeNoVScroll로 한다.
			   var oldSetConfig = window[id].SetConfig;
			   window[id].SetConfig = function(cfg){
				   if((cfg.SearchMode==4 || cfg.SearchMode==1 )&& typeof(cfg.SizeMode)=="undefined" ){
					   cfg.SizeMode = sizeNoVScroll;
				   }
				   oldSetConfig.apply(window[id], [cfg]);
				   
				   //마우스 우측 버튼 클릭시 메뉴
				   //window[id].SetActionMenu("엑셀 다운로드|업로드|신규행 추가");
				   
			   };
			   //행의 상태값을 얻는 메서드 정의
				window[id].GetRowStatus = function(row){
					var col = this.StatusCol;
					return this.GetCellValue(row,col);
				}
			   
			   if(dummy){
		          dummy();
		       }
		   };		    

	   } catch(e) {

	   }
	   
	   
	   
	   
	   try{
			var dummyValidation =null;
			//OnValidation 를 dummyValidation 담는다.
			if(typeof(window[id+"_OnValidation"])!="undefined"){  
				if(typeof window[id+"_OnValidation"] == "function"){
					dummyValidation  = window[id+"_OnValidation"];
				}
			}
			//Validation 오버라이드
			window[id+"_OnValidation"] = function(row,col,v){
				if(window[id].GetRowStatus(row)!="D"){
					if(dummyValidation){
						dummyValidation (row,col,v);
					}
				}  
			} 
		}catch(e){
		}           
}



/*
 * IBSheet를 생성 (특정 div 하위로 넣는 경우에 사용)
 */
function createIBSheet2(obj, sheetid, width, height, gdTp, locale) {

	eventOverRide(sheetid);
	
    var div_str = "";

    if (!locale) locale = "";

    Grids.Locale = locale;
    Grids.Config = __ibsheet_cfg;
    Grids.Msg = __ibsheet_msg;
	
    // width, height 적용
    obj.style.width = width;
    obj.style.height = height;	

    

    IBSheet('<ibsheet Sync=\"1\" Data_Sync=\"0\"> </ibsheet>', obj.id, sheetid);

    if(!gdTp) {
	    div_str += '<div class="clear mb5">';
	    div_str += '    <div class="fl">';
	    div_str += '        <select id="recordCountPerPage"  name="recordCountPerPage" class="select" title="조회갯수" onchange="javascript:fn_changePageLength(); return false;">';
	    div_str += '            <option value="10" >10개씩 보기</option>';	    
	    div_str += '            <option value="20" >20개씩 보기</option>';
	    div_str += '            <option value="50" >50개씩 보기</option>';
	    div_str += '            <option value="100" >100개씩 보기</option>';
	    div_str += '        </select>';
	    div_str += '    </div>';
	    //div_str += '        <%--전체 건수는 span 에 totalcnt 라는 id 를 사용하면 자동 생성--%>';
	    div_str += '	<p class="fr">조회건수 : <span id="'+sheetid+'_totalcnt"></span> 건</p>';
	    //div_str += '	<span class="btn_help2"><a title="조회된 표의 제목행을 클릭하여 좌, 우로 이동하여 원하는 순서에 놓을 수 있습니다. 또한 각 제목 셀의 우측 선을 클릭하여 셀의 길이를 늘이거나 줄일 수 있습니다." href="#">도움말</a></span>';
	    div_str += '</div>';
    } else {
    	//div_str += '	<p class="fr">조회건수 : <span id="'+sheetid+'_totalcnt"></span> 건</p>';
    }
    //100% 높이인 경우 높이를 재계산 함.
    if(height=="100%"){
    	sheetResizeWork(obj,sheetid);
    }
    
    //$("#"+obj.id).after(div_str);
    methodOverRide(sheetid);
    window[sheetid].SetEditable(0);
}

function methodOverRide(id){
	//VaildationFail 메서드를 오버라이드 함
	window[id].ValidateFailOrg = window[id].ValidateFail;

	//재정의 한다.
	window[id].ValidateFail = function(bo){
		//ValidateFail이 true인 경우 대기 이미지 제거
		
		if(bo){
			try{
				parent.gfn_blockScreenCancle();
			}catch(e){}
		}
		this.ValidationFailOrg(bo);
	}
}


var tempWindowHeight = 0;

function sheetResizeWork(divObj,id){

	//페이지 오픈시 시트 높이 설정
   var posY = $("#"+divObj.id).offset().top;
   window[id].OFFSETTOP = posY+50;
   var h = $(window).height()-(posY+10);
   window[id].SetSheetHeight(  h ,1);
          
   //페이지 리사이즈시 시트 높이 설정
   $(window).resize(id,function(){
         var th = $(parent.window).height();
         if(th!=tempWindowHeight){
                    var h = $(window).height()-window[id].OFFSETTOP;
                    window[id].SetSheetHeight(h,1);   
         }
         tempWindowHeight = th;
   });
}

/* MergeSheet 속성에 설정 값 */
var msNone            = 0, // 머지 없음
    msAll             = 1, // 전부 머지 가능
    msPrevColumnMerge = 2, // 앞 컬럼이 머지 된 경우 해당 행 안에서 머지 가능
    msFixedMerge      = 3, // 단위데이터행 구조에서의 고정 셀 병합 기능
    msBaseColumnMerge = 4, // 기준 컬럼 머지 영역 범위 내에서의 머지 기능
    msHeaderOnly      = 5; // 해더만 머지

/* BasicImeMode 속성 설정 값 */
var imeAuto = 0; // 마지막 상태를 그대로 사용
var imeHan  = 1; // 기본 상태를 한글 입력 상태로 함
var imeEng  = 2; // 기본 상태를 영문 입력 상태로 함

/* SizeMode 속성 설정 값 */
var sizeAuto         = 0; // 설정한 높이, 너비 그대로 사용
var sizeNoVScroll    = 1; // 높이를 스크롤 없이 자동 설정
var sizeNoHScroll    = 2; // 너비를 스크롤 없이 자동 설정
var sizeNoBothScroll = 3; // 높이, 너비 모두 스크롤 없이 자동 설정

/* SearchMode 속성 설정 값 */
var smGeneral      = 0; // 일반 조회
var smClientPaging = 1; // 클라이언트 페이징 조회
var smLazyLoad     = 2; // Lazy Load 조회
var smServerPaging = 3; // 실시간 서버 페이징 조회

/* SumPosition 속성 설정 값 */
var posTop    = 0; // 상단 고정 위치
var posBottom = 1; // 하단 고정 위치

/* VScrollMode 속성 설정 값 */
var vsAuto   = 0; // 자동 생성
var vsFixed = 1; // 고정 생성

/*
    FormQueryString 관련 함수 정의
*/
/* FormQueryString과 FormQueryStringEnc함수에서 필수입력 체크시 메시지로 사용한다.-3.4.0.50 */
var IBS_MSG_REQUIRED = "은(는) 필수입력 항목입니다.";

/**
 * 에러메시지를 표시한다. IBS_ShowErrMsg 대신 이 함수를 사용해야 한다.
 * @param   : sMsg      - 메시지
 * @return  : 없음
 * @version : 3.4.0.50
 * @sample
 *  IBS_ShowErrMsg("에러가 발생했습니다.");
 */
function IBS_ShowErrMsg(sMsg) {
    return alert("[IBSheetInfo.js]\n" + sMsg);
}

function IBS_getName(obj) {
    if (obj.name != "") {
        return obj.name;
    } else if (obj.id != "") {
        return obj.id;
    } else {
        return "";
    }
}

function IBS_RequiredChk(obj) {
    return (obj.getAttribute("required") != null);
}

/**
 * Form오브젝트 안에 있는 컨트롤을 QueryString으로 구성한다. 이때, 한글은 인코딩하지 않는다.
 * @param   : form          - 필수,html의 Form 오브젝트 Name
 * @param   : checkRequired - 선택,필수입력 체크 여부(true,false)
 * @return  : String        - Form오브젝트 안에 Control을 QueryString으로 구성한 문자열
 *            undefined     - checkRequired인자가 true이고, 필수입력에 걸린경우 return 값
 * @version : 1.0.0.0,
 *            3.4.0.50(checkRequired 인자 추가)
 * @sample1
 *  var sCondParam=FormQueryString(document.frmSearch); //결과:"txtname=이경희&rdoYn=1&sltMoney=원화";
 * @sample2
 *  <input type="text" name="txtName" required="이름">        //필수 입력 항목이면 required="이름" 를 설정한다.
 *  var sCondParam = FormQueryString(document.mainForm, true);//필수입력까지 체크하며, 필수입력에 걸리면 리턴값은 null
 *  if (sCondParam==null) return;
 */
function FormQueryString(form, checkRequired) {
    if (typeof form != "object" || form.tagName != "FORM") {
        IBS_ShowErrMsg("FormQueryString 함수의 인자는 FORM 태그가 아닙니다.");
        return "";
    }

    if (checkRequired == null) checkRequired = false;

    var name = new Array(form.elements.length);
    var value = new Array(form.elements.length);
    var j = 0;
    var plain_text = "";

    //사용가능한 컨트롤을 배열로 생성한다.
    len = form.elements.length;
    for (i = 0; i < len; i++) {
        var prev_j = j;
        switch (form.elements[i].type) {
            case undefined:
            case "button":
            case "reset":
            case "submit":
                break;
            case "radio":
            case "checkbox":
                if (form.elements[i].checked == true) {
                    name[j] = IBS_getName(form.elements[i]);
                    value[j] = form.elements[i].value;
                    j++;
                }
                break;
            case "select-one":
                name[j] = IBS_getName(form.elements[i]);
                var ind = form.elements[i].selectedIndex;
                if (ind >= 0) {

                    value[j] = form.elements[i].options[ind].value;

                } else {
                    value[j] = "";
                }
                j++;
                break;
            case "select-multiple":
                name[j] = IBS_getName(form.elements[i]);
                var llen = form.elements[i].length;
                var increased = 0;
                for (k = 0; k < llen; k++) {
                    if (form.elements[i].options[k].selected) {
                        name[j] = IBS_getName(form.elements[i]);
                        value[j] = form.elements[i].options[k].value;

                        j++;
                        increased++;
                    }
                }
                if (increased > 0) {
                    j--;
                } else {
                    value[j] = "";
                }
                j++;
                break;
            default:
                name[j] = IBS_getName(form.elements[i]);
                value[j] = form.elements[i].value;
                j++;
        }

        if (checkRequired) {
            //html 컨트롤 태그에 required속성을 설정하면 필수입력을 확인할 수 있다.
            //<input type="text" name="txtName" required="이름">

            if (IBS_RequiredChk(form.elements[i]) && prev_j != j && value[prev_j] == "") {

                if (form.elements[i].getAttribute("required") == null ||
                    form.elements[i].getAttribute("required") == ""
                ) {
                    alert('"' + IBS_getName(form.elements[i]) + '"' + IBS_MSG_REQUIRED);
                } else {

                    alert('"' + form.elements[i].getAttribute("required") + '"' + IBS_MSG_REQUIRED);
                }
                //컨트롤이 숨겨져 있을수도 있으므로 에러 감싼다.
                try {
                    form.elements[i].focus();
                } catch (ee) {;
                }

                return;
            }
        }
    }
    //QueryString을 조합한다.
    for (i = 0; i < j; i++) {
        if (name[i] != '') plain_text += name[i] + "=" + value[i] + "&";
    }

    //마지막에 &를 없애기 위함
    if (plain_text != "") plain_text = plain_text.substr(0, plain_text.length - 1);

    return plain_text;
}

/**
 * Form오브젝트 안에 있는 컨트롤을 QueryString으로 구성한다. 이때, 한글은 인코딩한다.
 * @param   : form          - 필수,html의 Form 오브젝트 Name
 * @param   : Sheet         - 필수,IBheet의 Object id
 * @param   : checkRequired - 선택,필수입력 체크 여부(true,false)
 * @return  : String        - Form오브젝트 안에 Control을 QueryString으로 구성한 문자열
 *            undefined     - checkRequired인자가 true이고, 필수입력에 걸린경우 return 값
 * @version : 1.0.0.0,
 *            3.4.0.50(checkRequired 인자 추가)
 * @sample1
 *  var sCondParam=FormQueryStringEnc(document.frmSearch, mySheet1);
 *  원본:"txtname=이경희&rdoYn=1&sltMoney=원화";
 *  결과:"txtname=%C0%CC%B0%E6%C8%F1&rdoYn=1&sltMoney=%BF%F8%C8%AD";                //UTF16인 경우
 *  결과:"txtname=%EC%9D%B4%EA%B2%BD%ED%9D%AC&rdoYn=1&sltMoney=%EC%9B%90%ED%99%94"; //UTF8인 경우
 * @sample2
 *  <input type="text" name="txtName" required="이름">                    //필수 입력 항목이면 required="이름" 를 설정한다.
 *  var sCondParam = FormQueryStringEnc(document.mainForm, mySheet, true);//필수입력까지 체크하며, 필수입력에 걸리면 리턴값은 null
 *  if (sCondParam==null) return;
 */
function FormQueryStringEnc(form, checkRequired) {
	
    if (typeof form != "object" || form.tagName != "FORM") {
        IBS_ShowErrMsg("FormQueryStringEnc 함수의 form 인자는 FORM 태그가 아닙니다.");
        return "";
    }

    if (checkRequired == null) checkRequired = false;

    var name = new Array(form.elements.length);
    var value = new Array(form.elements.length);
    var j = 0;
    var plain_text = "";

    //사용가능한 컨트롤을 배열로 생성한다.
    len = form.elements.length;
    for (i = 0; i < len; i++) {
        var prev_j = j;
        switch (form.elements[i].type) {
            case "button":
            case "reset":
            case "submit":
                break;
            case "radio":
            case "checkbox":
                if (form.elements[i].checked == true) {
                    name[j] = IBS_getName(form.elements[i]);
                    value[j] = form.elements[i].value;
                    j++;
                }
                break;
            case "select-one":
                name[j] = IBS_getName(form.elements[i]);
                var ind = form.elements[i].selectedIndex;
                if (ind >= 0) {

                    value[j] = form.elements[i].options[ind].value;

                } else {
                    value[j] = "";
                }
                j++;
                break;
            case "select-multiple":
                name[j] = IBS_getName(form.elements[i]);
                var llen = form.elements[i].length;
                var increased = 0;
                for (k = 0; k < llen; k++) {
                    if (form.elements[i].options[k].selected) {
                        name[j] = IBS_getName(form.elements[i]);

                        value[j] = form.elements[i].options[k].value;

                        j++;
                        increased++;
                    }
                }
                if (increased > 0) {
                    j--;
                } else {
                    value[j] = "";
                }
                j++;
                break;
            default:

                name[j] = IBS_getName(form.elements[i]);
                value[j] = form.elements[i].value;
                j++;
        }

        if (checkRequired) {
            //html 컨트롤 태그에 required속성을 설정하면 필수입력을 확인할 수 있다.
            //<input type="text" name="txtName" required="이름">
            if (IBS_RequiredChk(form.elements[i]) && prev_j != j && value[prev_j] == "") {
                if (form.elements[i].getAttribute("required") == "") {
                    alert('"' + IBS_getName(form.elements[i]) + '"' + IBS_MSG_REQUIRED);
                } else {
                    alert('"' + form.elements[i].getAttribute("required") + '"' + IBS_MSG_REQUIRED);
                }
                //컨트롤이 숨겨져 있을수도 있으므로 에러 감싼다.
                try {
                    form.elements[i].focus();
                } catch (ee) {;
                }

                return;
            }
        }
    }

    //QueryString을 조합한다.
    for (i = 0; i < j; i++) {
        if (name[i] != '') plain_text += encodeURIComponent(name[i]) + "=" + encodeURIComponent(value[i]) + "&";
    }

    //마지막에 &를 없애기 위함
    if (plain_text != "") plain_text = plain_text.substr(0, plain_text.length - 1);

    return plain_text;
}

/*------------------------------------------------------------------------------
 * titile : IBSheet의 조회,저장시 사용되는 함수
 * paramList : 
 * param1 : s_SAVENAME 객체를 담고 있는 form 객체
 * param2 : 조회해야 할 시트 객체
 * param3.. : 여러개 시트를 한번에 조회하는 경우 시트의 개수만큼 붙인다.
-------------------------------------------------------------------------------*/
function IBS_SaveName() {
    var param = arguments;
    if (param.length < 2) {
        IBS_ShowErrMsg("최하 두개의 인자가 필요합니다.");
        return;
    }

    if (param.length == 2) {
        param[0].s_SAVENAME.value = IBS_ConcatSaveName(param[1]);
    } else {
        param[0].s_SAVENAME.value = "";
        for (var i = 1; i < param.length; i++) {
            param[0].s_SAVENAME.value += IBS_ConcatSaveName(param[i]) + "@@";
        }
        var tempStr = param[0].s_SAVENAME.value;
        param[0].s_SAVENAME.value = tempStr.substring(0, tempStr.length - 2);
    }
}

function IBS_ConcatSaveName(sheet) {
    var lr  = sheet.GetDataRows(),
        lc  = sheet.LastCol(),
        res = [],
        r   = 0,
        c   = 0,
        cn  = "",
        sn  = "";

    for (r = 0; r < lr; r++) {
        for (c = 0; c <= lc; c++) {
            cn = sheet.GetColName(c);
            sn = sheet.ColSaveName(r, c);

            if (cn !== sn) {
                res.push(sn);
            }
        }
    }
    
    return res.join("|");
}

/*------------------------------------------------------------------------------
 * method : GetSaveJson
 * desc : 지정한 상태에 대한 데이터를 json 형태로 반환한다.
 * param list
 * param1 : IBSheet Object
 * param2 : 상태 (I|U|D)
 * param3 : SkipCol list 
-------------------------------------------------------------------------------*/
function GetSaveJson2(sheet, status, skipcols) {
    if (sheet == null) {
        alert("GetSaveJson2 함수의 첫번째 인자는 ibsheet 객체여야 합니다.");
        return;
    }

    var skipcolsArr = null;
    if (skipcols != null) {
        skipcolsArr = skipcols.split("|");
    }

    var rtnJson = {};
    if (status == null) {
        var temp = GetJsonStatus(sheet, "I", skipcolsArr);
        if (temp) rtnJson["INSERT"] = temp;
        temp = GetJsonStatus(sheet, "D", skipcolsArr);
        if (temp) rtnJson["DELETE"] = temp;
        temp = GetJsonStatus(sheet, "U", skipcolsArr);
        if (temp) rtnJson["UPDATE"] = temp;
    } else {
        switch (status) {
            case "I":
                rtnJson["INSERT"] = GetJsonStatus(sheet, "I", skipcolsArr);
                break;
            case "U":
                rtnJson["UPDATE"] = GetJsonStatus(sheet, "U", skipcolsArr);
                break;
            case "D":
                rtnJson["DELETE"] = GetJsonStatus(sheet, "D", skipcolsArr);
                break;
        }
        GetJsonStatus(sheet, status)
    }
    return rtnJson;
}

function GetJsonStatus(sheet, status, skipcolsArr) {
    var rtnJson = new Array();
    //지정한 상태 값을 갖는 행을 뽑는다.
    var rows = sheet.FindStatusRow(status);

    if (rows == "") return null;

    var rowArr = rows.split(";");

    for (var i = 0; i < rowArr.length; i++) {
        var temp = sheet.GetRowJson(rowArr[i]);
        if (skipcolsArr != null) {
            for (var c = 0; c < skipcolsArr.length; c++) {
                delete temp[skipcolsArr[c]];
            }
        }
        rtnJson.push(temp);
    }
    return rtnJson;
}

/**
    IBSheet 초기화 작업을 일괄 처리 한다.
    @method     IBS_InitSheet
    @public
    @param      {object}    sheet               대상 시트 객체
    @param      {object}    info                초기화 정보
    @param      {object}    info.Cols           컬럼 초기화 정보 객체
    @param      {object}    [info.Cfg]          시트 초기화 정보 객체
    @param      {object}    [info.Headers]      헤더 초기화 정보 객체
    @param      {object}    [info.HeaderMode]   헤더 모드 정보 객체
*/
function IBS_InitSheet(sheet, info) {
    var cInfo         = {},
        colsHeader    = [],
        useColsHeader = 0,
        max           = 0,
        cnt           = 0,
        dataRows      = 1;

    function appendHeaderText(last, col, header) {
        var unitHeader = header.split("|"),
            i          = 0,
            len        = 0;

        useColsHeader = 1;
        len = unitHeader.length;

        if (cnt < len) {
            cnt = len;
        }

        for (i = 0; i < len; i++) {
            if (typeof colsHeader[last + i] === "undefined") {
                colsHeader[last + i] = [];
            }

            colsHeader[last + i][col] = unitHeader[i];
        }
    };

    // 필수 입력 요소 체크
    if (!sheet || !info || !info.Cols) {
        alert("시트 초기화 정보가 올바르지 않습니다.");
        return;
    }

    cInfo = CloneArray(info);

    // DataRows 설정
    if (cInfo.Cols[0] && typeof cInfo.Cols[0].length !== "undefined") {
        dataRows = cInfo.Cols.length;
    }

    // Cfg 기본값 설정
    if (!cInfo.Cfg) {
        cInfo.Cfg = {};
    }

    // Headers 기본값 설정
    if (!cInfo.Headers) {
        cInfo.Headers = [{
            Text: "",
            Align: "Center"
        }];
    }

    // HeaderMode 기본값 설정 및 Align 처리
    if (!cInfo.HeaderMode) {
        cInfo.HeaderMode = {};
    } else {
        if (cInfo.HeaderMode.Align) {
            var header = cInfo.Headers;
            for (var i = 0, len = header.length; i < len; i++) {
                header[i].Align = cInfo.HeaderMode.Align;
            }
        }
    }

    for (var i = 0, len = cInfo.Cols.length; i < len; i++) {
        var col = cInfo.Cols[i];

        if (typeof col.Header === "undefined") {
            for (var j = 0, len2 = col.length; j < len2; j++) {
                var col2 = col[j];

                if (i > 0) {
                    max = cnt;
                }

                if (typeof col2.Header !== "undefined") {
                    appendHeaderText(max, j, col2.Header);
                    delete col2.Header;
                }
            }
        } else {
            appendHeaderText(0, i, col.Header);
            delete col.Header;
        }
    }

    if (useColsHeader) {
        cInfo.Headers = [];
        for (var i = 0, len = colsHeader.length; i < len; i++) {
            var header = {};

            if (typeof colsHeader[i] === "undefined") {
                header.Text = "";
            } else {
                header.Text = colsHeader[i].join("|");
            }

            header.Align = cInfo.HeaderMode.Align || "Center";
            cInfo.Headers.push(header);
        }
    }
    
    //ibleaders shkim 20161219  필터 사용시 체크 관련 공통으로 설정
    cInfo.Cfg["HeaderCheckMode"] = 1;
    
    sheet.SetConfig(cInfo.Cfg);
    sheet.InitHeaders(cInfo.Headers, cInfo.HeaderMode);
    sheet.InitColumns(cInfo.Cols, dataRows);
    
    if(sheet.id == "mySheet6"){
    	sheet.SetCountInfoElement(document.getElementById("totalcnt"));	
    }else if(sheet.id =="mySheet7"){
    	sheet.SetCountInfoElement(document.getElementById("totalcnt1"));
    }
    
    sheet.SetFindDialog(1,"",2,1,0,1);
}

/*------------------------------------------------------------------------------
* method : IBS_CopyJson2Form
* desc : json 데이터를 이름을 기준으로 폼객체에 넣는다.
* param list
* param1 : json 객체
* param2 : 대상 폼 name

json 자료 구조 :
{"폼객체명":{"객체명":"값","객체명2":"값2"}}
ex){"aFrm":{"sa_no":"12345","sa_name":"손이창","grade":"a3","married":"NO","enter_date":"2012-12-31"}}
-------------------------------------------------------------------------------*/
function IBS_CopyJson2Form(jsonobj, frmName) {
    var json,
        obj,
        stype,
        idx,
        max;

    if (typeof frmName == "object") {
        frmName = frmName.name;
    }

    json = jsonobj[frmName];

    for (j in json) {
        obj = null;

        try {
            obj = document[frmName][j];
            if (obj == null || typeof obj == "undefined") {
                obj = document.getElementById(j);
            }
            if (obj == null || typeof obj == "undefined") {
                continue;
            }
        } catch (e) {
            //alert(e.message);
        }

        stype = (obj.type);

        if (typeof stype == "undefined" && obj.length > 0) {
            stype = obj[0].type;
        }

        switch (stype) {
            case undefined:
            case "button":
            case "reset":
            case "submit":
                break;
            case "select-one":
                obj.value = json[j];
                break;
            case "radio":
                obj.checked = json[j];
                break;
            case "checkbox":
                obj.checked = json[j];
                break;
            default:
                obj.value = json[j];
                break;
        } //end of switch
    }
}

/*------------------------------------------------------------------------------
method : IBS_CopyForm2Sheet()
desc  : Form객체에 있는 내용을 시트에 복사
param list
param : json 유형

param 내부 설정값
sheet : 값을 입력 받을 ibsheet 객체 (필수)
form : copy할 폼객체 (필수)
row : ibsheet 객체의 행 (default : 현재 선택된 행)
sheetPreFiex : 맵핑할 시트의 SavaName 앞에 PreFix 문자 (default : "")
formPreFiex : 맵핑할 폼객체의 이름 혹은 id 앞에  PreFix 문자 (default : "")
useOnChange : 시트값 변경시 OnChange 이벤트 사용 유무 (default : false)
-------------------------------------------------------------------------------*/
function IBS_CopyForm2Sheet(param) {
    var sheetobj,
        formobj,
        row,
        sheetPreFix,
        frmPreFix,
        uoc,
        col,
        max,
        colSaveName,
        baseSaveName,
        frmchild,
        sType,
        sValue;

    if ((!param.sheet) || (!param.sheet.IBSheetVersion)) {
        IBS_ShowErrMsg("IBS_CopyForm2Sheet 함수의 sheet 인자가 없거나 ibsheet객체가 아닙니다.");
        return false;
    }
    if (param.form == null || typeof param.form != "object" || param.form.tagName != "FORM") {
        IBS_ShowErrMsg("IBS_CopyForm2Sheet 함수의 form 인자가 없거나 FORM 객체가 아닙니다.");
        return false;
    }

    sheetobj = param.sheet;
    formobj = param.form;
    row = param.row == null ? sheetobj.GetSelectRow() : param.row;
    sheetPreFix = param.sheetPreFix == null ? "" : param.sheetPreFix;
    frmPreFix = param.formPreFix == null ? "" : param.formPreFix;
    uoc = param.useOnChange == null ? 0 : param.useOnChange;
    if (row < 0) {
        alert("선택된 행이 존재하지 않습니다.");
        return;
    }

    //Sheet의 컬럼개수만큼 찾아서 HTML의 Form 각 Control에 값을 설정한다.
    //컬럼개수만큼 루프 실행
    for (col = 0, max = sheetobj.LastCol(); col <= max; col++) {
        //컬럼의 별명을 문자열로 가져온다.
        colSaveName = sheetobj.ColSaveName(col)
        if (colSaveName == "") {
            continue;
        }
        //PreFix가 붙지 않은 형태의 SaveName을 가져온다.
        baseSaveName = colSaveName.substring(sheetPreFix.length);

        frmchild = null;
        try {
            //폼에 있는 해당 이름의 컨트롤을 가져온다.예)"frm_CardNo"
            frmchild = formobj[frmPreFix + baseSaveName];
        } catch (e) {
            alert(e);
        }

        //폼에 해당하는 이름의 컨트롤이 없는 경우는 계속 진행한다.
        if (frmchild == null) continue;

        sType = frmchild.type;
        sValue = "";

        //radio의 경우 frmchild가 배열형태가 되므로, frmchild.type으로는 타입을 알수 없다.
        if (typeof sType == "undefined" && frmchild.length > 0) {
            sType = frmchild[0].type;
        }

        //타입별로 값을 설정한다.
        switch (sType) {
            case undefined:
            case "button":
            case "reset":
            case "submit":
                break;
            case "radio":
                for (idx = 0; idx < frmchild.length; idx++) {
                    if (frmchild[idx].checked) {
                        sValue = frmchild[idx].value;
                        break;
                    }
                }
                break;
            case "checkbox":
                sValue = (frmchild.checked) ? 1 : 0;
                break;
            default:
            	if(frmchild.className.indexOf("ib-maskedit")>0){
            		//ibmaskedit
            		sValue = window[frmchild.id].GetValue(undefined,true);
            	}else{
            		sValue = frmchild.value;	
            	}
            	
        } //end of switch

        sheetobj.SetCellValue(row, sheetPreFix + baseSaveName, sValue, uoc);
    } //end of for(col)

    //정상적인 처리완료
    return true;
}

/*----------------------------------------------------------------------------
method : IBS_CopySheet2Form()
desc : 시트의 한 행을 폼객체에 복사

param list
param : json 유형

param 내부 설정값
sheet : 값을 입력 받을 ibsheet 객체 (필수)
form : copy할 폼객체 (필수)
row : ibsheet 객체의 행 (default : 현재 선택된 행)
sheetPreFiex : 맵핑할 시트의 SavaName 앞에 PreFix 문자 (default : "")
formPreFiex : 맵핑할 폼객체의 이름 혹은 id 앞에  PreFix 문자 (default : "")
-----------------------------------------------------------------------------*/
function IBS_CopySheet2Form(param) {
    var sheetobj,
        formobj,
        row,
        sheetPreFix,
        frmPreFix,
        col,
        max,
        colSaveName,
        baseSaveName,
        sheetvalue,
        frmchild,
        sType,
        sValue;

    if ((!param.sheet) || (!param.sheet.IBSheetVersion)) {
        IBS_ShowErrMsg("IBS_CopyForm2Sheet 함수의 sheet 인자가 없거나 ibsheet객체가 아닙니다.");
        return false;
    }

    if (param.form == null || typeof param.form != "object" || param.form.tagName != "FORM") {
        IBS_ShowErrMsg("IBS_CopyForm2Sheet 함수의 form 인자가 없거나 FORM 객체가 아닙니다.");
        return false;
    }
    sheetobj = param.sheet;
    formobj = param.form;
    row = param.row == null ? sheetobj.GetSelectRow() : param.row;
    sheetPreFix = param.sheetPreFix == null ? "" : param.sheetPreFix;
    frmPreFix = param.formPreFix == null ? "" : param.formPreFix;

    if (row < 0) {
        alert("선택된 행이 존재하지 않습니다.");
        return;
    }

    //Sheet의 컬럼개수만큼 찾아서 HTML의 Form 각 Control에 값을 설정한다.
    //컬럼개수만큼 루프 실행
    for (col = 0, max = sheetobj.LastCol(); col <= max; col++) {
        //컬럼의 별명을 문자열로 가져온다.
        colSaveName = sheetobj.ColSaveName(col)
        if (colSaveName == "") {
            continue;
        }
        //PreFix가 붙지 않은 형태의 SaveName을 가져온다.
        baseSaveName = colSaveName.substring(sheetPreFix.length);

        sheetvalue = sheetobj.GetCellText(row, sheetPreFix + baseSaveName);

        frmchild = null;
        try {
            //폼에 있는 해당 이름의 컨트롤을 가져온다.예)"frm_CardNo"
            frmchild = formobj[frmPreFix + baseSaveName];
        } catch (e) {

        }

        //폼에 해당하는 이름의 컨트롤이 없는 경우는 계속 진행한다.
        if (frmchild == null) {
            continue;
        }

        sType = frmchild.type;
        sValue = "";
        //radio의 경우 frmchild가 배열형태가 되므로, frmchild.type으로는 타입을 알수 없다.
        if (typeof sType == "undefined" && frmchild.length > 0) {
            sType = frmchild[0].type;
        }

        //타입별로 값을 설정한다.
        switch (sType) {
            case undefined:
            case "button":
            case "reset":
            case "submit":
                break;
            case "select-one":
                frmchild.value = sheetobj.GetCellValue(row, sheetPreFix + baseSaveName);
                break;
            case "radio":
                for (idx = 0, radiomax = frmchild.length; idx < radiomax; idx++) {
                    if (frmchild[idx].value == sheetvalue) {
                        frmchild[idx].checked = true;
                        break;
                    }
                }
                break;
            case "checkbox":
                frmchild.checked = (sheetobj.GetCellValue(row, sheetPreFix + baseSaveName) == 1);
                break;
            default:
            	if(frmchild.className.indexOf("ib-maskedit")>0){
            		//ibmaskedit
            		window[frmchild.id].SetValue(sheetvalue);
            	}else{
            		frmchild.value = sheetvalue;
            	}
                
                break;
        } //end of switch
    } //end of for(col)

    //정상적인 처리완료
    return true;
}


/*----------------------------------------------------------------------------
method : IBS_CopySheet2FormValue()
desc : 시트의 한 행을 폼객체에 복사(복사시 Sheet의 Text가 아닌 Value값으로 넘긴다.)

param list
param : json 유형

param 내부 설정값
sheet : 값을 입력 받을 ibsheet 객체 (필수)
form : copy할 폼객체 (필수)
row : ibsheet 객체의 행 (default : 현재 선택된 행)
sheetPreFiex : 맵핑할 시트의 SavaName 앞에 PreFix 문자 (default : "")
formPreFiex : 맵핑할 폼객체의 이름 혹은 id 앞에  PreFix 문자 (default : "")
-----------------------------------------------------------------------------*/
function IBS_CopySheet2FormValue(param) {
    var sheetobj,
        formobj,
        row,
        sheetPreFix,
        frmPreFix,
        col,
        max,
        colSaveName,
        baseSaveName,
        sheetvalue,
        frmchild,
        sType,
        sValue;

    if ((!param.sheet) || (!param.sheet.IBSheetVersion)) {
        IBS_ShowErrMsg("IBS_CopyForm2Sheet 함수의 sheet 인자가 없거나 ibsheet객체가 아닙니다.");
        return false;
    }

    if (param.form == null || typeof param.form != "object" || param.form.tagName != "FORM") {
        IBS_ShowErrMsg("IBS_CopyForm2Sheet 함수의 form 인자가 없거나 FORM 객체가 아닙니다.");
        return false;
    }
    sheetobj = param.sheet;
    formobj = param.form;
    row = param.row == null ? sheetobj.GetSelectRow() : param.row;
    sheetPreFix = param.sheetPreFix == null ? "" : param.sheetPreFix;
    frmPreFix = param.formPreFix == null ? "" : param.formPreFix;

    if (row < 0) {
        alert("선택된 행이 존재하지 않습니다.");
        return;
    }

    //Sheet의 컬럼개수만큼 찾아서 HTML의 Form 각 Control에 값을 설정한다.
    //컬럼개수만큼 루프 실행
    for (col = 0, max = sheetobj.LastCol(); col <= max; col++) {
        //컬럼의 별명을 문자열로 가져온다.
        colSaveName = sheetobj.ColSaveName(col)
        if (colSaveName == "") {
            continue;
        }
        //PreFix가 붙지 않은 형태의 SaveName을 가져온다.
        baseSaveName = colSaveName.substring(sheetPreFix.length);

        //sheetvalue = sheetobj.GetCellText(row, sheetPreFix + baseSaveName);
        sheetvalue = sheetobj.GetCellValue(row, sheetPreFix + baseSaveName);

        frmchild = null;
        try {
            //폼에 있는 해당 이름의 컨트롤을 가져온다.예)"frm_CardNo"
            frmchild = formobj[frmPreFix + baseSaveName];
        } catch (e) {

        }

        //폼에 해당하는 이름의 컨트롤이 없는 경우는 계속 진행한다.
        if (frmchild == null) {
            continue;
        }

        sType = frmchild.type;
        sValue = "";
        //radio의 경우 frmchild가 배열형태가 되므로, frmchild.type으로는 타입을 알수 없다.
        if (typeof sType == "undefined" && frmchild.length > 0) {
            sType = frmchild[0].type;
        }

        //타입별로 값을 설정한다.
        switch (sType) {
            case undefined:
            case "button":
            case "reset":
            case "submit":
                break;
            case "select-one":
                frmchild.value = sheetobj.GetCellValue(row, sheetPreFix + baseSaveName);
                break;
            case "radio":
                for (idx = 0, radiomax = frmchild.length; idx < radiomax; idx++) {
                    if (frmchild[idx].value == sheetvalue) {
                        frmchild[idx].checked = true;
                        break;
                    }
                }
                break;
            case "checkbox":
                frmchild.checked = (sheetobj.GetCellValue(row, sheetPreFix + baseSaveName) == 1);
                break;
            default:
            	if(frmchild.className.indexOf("ib-maskedit")>0){
            		//ibmaskedit
            		window[frmchild.id].SetValue(sheetvalue);
            	}else{
            		frmchild.value = sheetvalue;
            	}
                
                break;
        } //end of switch
    } //end of for(col)

    //정상적인 처리완료
    return true;
}


function fGetXY(aTag){
  var oTmp = aTag;
  var pt = new Point(0,0);
  do {
  	pt.x += oTmp.offsetLeft;
  	pt.y += oTmp.offsetTop;
  	oTmp = oTmp.offsetParent;
  } while(oTmp.tagName!="BODY");
  return pt;
}
function Point(iX, iY){
	this.x = iX;
	this.y = iY;
}


var __ibsheet_cfg = {
    "Cfg" : {
//        "Down2Excel_Url" : path+gv_getContextRootPath+"cmm/ibsheet/Down2Excel.do",
        "LoadExcel_Url" : "../jsp/LoadExcel.jsp",
        "DirectLoadExcel_Url" : "../jsp/DirectLoadExcel.jsp",
        "Down2Text_Url" : "../jsp/Down2Text.jsp",
        "LoadText_Url" : "../jsp/LoadText.jsp",
        "Down2Pdf_Url" : "../jsp/Down2Pdf.jsp",
        "AutoClearHeaderCheck" : "1",
        "CalWeekNumber" : "0",
        "CheckActionKey" : "Space|Enter",
        "ClipPasteMode" : "1",
        "ComboOpenMode" : "1",
        "NextPageCall" : "80",
        "ReverseSortOrder" : "1",
        "SelectCellEventMode" : "1",
        "UseCache" : "1",
        "UseJsonTreeLevel" : "1",
        "UseJsonAttribute" : "1",
        "WaitTimeOut" : "300",
        "FilterInputPopup" : "1",
        "SumZeroValue" : "0",
        "DataRowHeight" : "25",
		"HeaderRowHeight" : "30",
		"EditableColorDiff":"0",
		"DragPopup":"1",
		"AutoFitColWidth" : "Init|Search|Hidden|Resize",
		"MaxSort":"1",
		"UseHeaderSortCancel":"1",
		"UseHeaderActionMenu":"1",
		"FilterCaseSensitive":"0",
		"ThemeVersion":"2"
    }
};
var __ibsheet_msg = {
	    "Lang" : {
	        "Alert" : {
	            "SYS_CanReloadStart" : "",
	            "SYS_CanReloadChanges" : "모든 변경사항을 서버에 반영합니다.",
	            "SYS_CanCancelChanges" : "모든 변경사항을 취소합니다.",
	            "SYS_And" : "and",
	            "SYS_CanReloadSelect" : "모든 선택을 지웁니다.",
	            "SYS_CanReloadEnd" : "! 계속 하시겠습니까?",
	            /*"SYS_ErrTimeout" : "데이터를 다운로드 할 수 없습니다. 시간이 초과되었습니다.",
	            "SYS_AskTimeout" : "서버 시간초과로 데이터를 다운로드 할 수 없습니다. 재요청을 하시겠습니까?",
	            "SYS_UploadTimeout" : "데이터를 업로드 할 수 없습니다. 시간이 초과되었습니다.",
	            "SYS_AskUploadTimeout" : "서버 시간초과로 데이터를 업로드 할 수 없습니다. 재전송을 하시겠습니까?",*/
	            "SYS_ErrHide" : "컬럼을 숨김 처리 할 수 없습니다!",
	            "SYS_ErrHideExt" : "고정컬럼의 너비가 너무 큽니다!",
	            "SYS_ErrPrintOpen" : "인쇄 다이얼로그를 열 수 없습니다.",
	            "SYS_ErrPrint" : "문서 인쇄를 실패 하였습니다.",
	            "SYS_ErrCheck" : "서버 동기화에 실패하였습니다. 업데이트를 임시적으로 제한하시겠습니까?",
	            "SYS_NotFound" : "더 이상 찾을 항목이 없습니다.",
	            "SYS_SearchStart" : "검색 결과가 없습니다. 처음부터 다시 찾으시겠습니까?",
	            "SYS_SearchError" : "검색어 입력이 잘못되었습니다 !",
	            "SYS_ErrAdd" : "여기에 새로운 행을 추가 할 수 없습니다.",
	            "SYS_Invalid" : "잘못된 값",
	            "SYS_DelRow" : "%d' 행을 삭제 하시겠습니까 ?",
	            "SYS_DelSelected" : "%d 개의 선택된 행을 삭제 하시겠습니까 ?",
	            "SYS_StyleErr" : "IBSheet CSS 스타일을 로드 할 수 없습니다 !",
	            "SYS_ExportDownload" : "다운로드",
	            "SYS_FoundResults" : "%d 개를 찾았습니다.",
	            "SYS_PrintPrepared" : "출력할 준비가 되었습니다.",
	            "SYS_InitColsError" : "이미 컬럼초기화가 되어있습니다. 컬럼초기화를 취소합니다.",
	            "SYS_FrozenColsError" : "고정컬럼의 크기가 전체 컬럼 수 보다 같거나 큽니다.",
	            "SYS_NoWordColumn" : "선택된 컬럼에서 데이터를 찾지 못했습니다.",
	            "SYS_NoWordAll" : "시트 전체에서 데이터를 찾지 못했습니다.",
	            "SYS_InitDataRowsError" : "DataRows 설정이 잘못되었습니다.",
	            "SYS_InvalidExcelFileExtension" : "허용되지 않는 파일 형식입니다. 진행을 취소합니다.",
	            "SYS_InvalidTextFileExtension" : "허용되지 않는 파일 형식입니다. 진행을 취소합니다.",
	            "SYS_ExceedClipCopyRange" : "클립보드에 복사할 수 있는 데이터 범위를 초과하였습니다.",
	            "SYS_InvalidComboList" : "콤보목록 설정이 올바르지 않습니다.( %s )",
	            "SYS_LoadExcelError" : "엑셀 파일을 읽는 도중 예외가 발생하였습니다",
	            "SYS_PivotPopupInvalidCols" : "피벗 테이블 컬럼 레이블 설정이 잘못 되었습니다.",
	            "SYS_PivotPopupInvalidRows" : "피벗 테이블 행 레이블 설정이 잘못 되었습니다.",
	            "SYS_PivotPopupInvalidValues" : "피벗 테이블 값 레이블 설정이 잘못 되었습니다.",
	            "SYS_PivotPopupInvalidData" : "피벗 테이블 설정 대상 시트에 데이터가 없습니다.",
	            "SYS_ExceedFileSize" : "최대 파일 크기를 초과 하였습니다. [최대 크기 : %d]",
	            "SYS_InvalidSetGroupColMax" : "모든 컬럼을 그룹 기준 컬럼으로 설정 할 수 없습니다.",
	            "SYS_InvalidColHiddenMax" : "모든 컬럼을 숨김 컬럼으로 설정 할 수 없습니다.",
	            "SYS_InvalidColumnMove" : " 모든 컬럼을 고정컬럼 영역으로 이동 할 수 없습니다."
	        },
	        "Text" : {
	            "SYS_InvalidChildNodeInsert" : "부모 상태가 삭제이므로 자식레벨로 입력할 수 없습니다.",
	            "SYS_InvalidChildNodeCopy" : "부모 상태가 삭제이므로 자식레벨은 복사할 수 없습니다.",
	            "SYS_ParentDelNotDelete" : "부모행이 삭제상태여서 삭제 취소 할 수 없습니다.",
	            "SYS_NotDelParent" : "자식 행이 있으면 삭제가 불가능합니다.",
	            "SYS_NoUpRow" : "수정 상태의 행이 없습니다."        ,
	            "SYS_NoInsRow" : "입력 상태의 행이 없습니다.",
	            "SYS_NoDelRow" : "삭제 상태의 행이 없습니다.",
	            "SYS_NoCopyArgument" : "복사할 행이 없습니다.",
	            "SYS_NoMoveArgument" : "이동할 행이 없습니다.",
	            "SYS_NoSumRow" : "합계행이 없습니다.",
	            "SYS_DelSelected" : "선택한 행을 지웁니다.",
	            "SYS_NoArgument" : "인자가 없습니다.",
	            "SYS_IncorrectArg" : "인자값이 잘못되었습니다.",
	            "SYS_IncorrectRow" : "삭제할 행이 데이터 범위가 아닙니다.",
	            "SYS_ConfirmDelete" : "삭제하시겠습니까?",
	            "SYS_NoDeleteData" : "삭제할 행이 선택되지 않았습니다.",
	            "SYS_ExtentErr" : "그리드 공간이 부족합니다.",
	            "SYS_Sort" : "소팅처리중..",
	            "SYS_SelectAll" : "전체 선택중..",
	            "SYS_DoFilter" : "필터링중..",
	            "SYS_UpdateGrid" : "업데이트중..",
	            "SYS_CollapseAll" : "접기 처리중..",
	            "SYS_ExpandAll" : "펼침 처리중..",
	            "SYS_Render" : "표시하는중..",
	            "SYS_Page" : "",
	            "SYS_NoPages" : "",
	            "SYS_UpdateCfg" : "설정처리중..",
	            "SYS_StartErr" : "<b style='color:#ff6600;'>그리드 표시중 오류가 발생하였습니다.</b>",
	            "SYS_Calculate" : "계산중..",
	            "SYS_UpdateValues" : "값 업데이트중..",
	            "SYS_UpdateTree" : "트리 업데이트중..",
	            "SYS_PageErr" : "데이타 영역을 다운로드할 수 없습니다.",
	            "SYS_Layout" : "",
	            "SYS_Load" : "잠시만 기다려주십시오..",
	            "SYS_ColumnsCaption" : "선택 컬럼 표시",
	            "SYS_ColUpdate" : "컬럼 업데이트중..",
	            "SYS_Picture" : "이미지",
	            "SYS_DefaultsDate" : "일자 선택 ...",
	            "SYS_DefaultsButton" : "선택 ...",
	            "SYS_GroupCustom" : "헤더 타이틀을 이곳에 끌어놓으십시오.",
	            "SYS_Group" : "그룹핑중..",
	            "SYS_DefaultsFilterOff" : "전체",
	            "SYS_Items" : "아이템 %d - %d",
	            "SYS_Print" : "<h2><center>인쇄를 준비하는 동안 잠시 기다려 주십시오.</center></h2>",
	            "SYS_SearchMethodList" : "",
	            "SYS_Contains" : "",
	            "SYS_Starts" : "",
	            "SYS_Ends" : "",
	            "SYS_And" : "and",
	            "SYS_Or" : "or",
	            "SYS_Not" : "",
	            "SYS_SearchSearch" : "조회",
	            "SYS_SearchFilter" : "필터",
	            "SYS_SearchSelect" : "선택",
	            "SYS_SearchMark" : "마킹",
	            "SYS_SearchFind" : "찾기",
	            "SYS_SearchClear" : "초기화",
	            "SYS_SearchHelp" : "도움말",
	            "SYS_Search" : "조회중 ...",
	            "SYS_Printed" : "Please switch to window containing the report to print it",
	            "SYS_DoUndo" : "실행취소 처리중..",
	            "SYS_DoRedo" : "다시실행 처리중..",
	            "SYS_LoadStyles" : "스타일을 로딩중입니다 ...",
	            "SYS_SetStyle" : "스타일 업데이트중..",
	            "SYS_LoadPage" : "로딩하는중",
	            "SYS_RenderPage" : "표시하는중",
	            "SYS_ColWidth" : "컬럼폭을 조정하고 있습니다. '%d'",
	            "SYS_ColMove" : "컬럼을 이동중입니다. '%d'",
	            "SYS_Password" : "***",
	            "SYS_DefaultsNone" : "모두 지우기",
	            "SYS_RadioFilterOff" : "",
	            "SYS_DragObjectMove" : "이동 행 <b style='color:green;'>%d</b>",
	            "SYS_DragObjectCopy" : "복사 행 <b style='color:green;'>%d</b>",
	            "SYS_DragObjectMoreMove" : "<b style='color:blue;'>%d</b> 개 행 이동",
	            "SYS_DragObjectMoreCopy" : "<b style='color:blue;'>%d</b> 개 행 복사",
	            "SYS_ExportFinished" : "<center><b>파일이 생성되었습니다.</b><br/><br/>버튼을 클릭하십시오<br/></center><br/>",
	            "SYS_RenderProgressCaption" : "페이지 표시",
	            "SYS_RenderProgressText" : "%d 페이지 중 %d 페이지가 완료되었습니다.",
	            "SYS_RenderProgressCancel" : "",
	            "SYS_PrintProgressCaption" : "파일 생성",
	            "SYS_PrintProgressText" : "총 %d 개의 행중 %d 개 행이 완료되었습니다.",
	            "SYS_PrintProgressCancel" : "취소",
	            "SYS_ExportProgressCaption" : "파일 생성",
	            "SYS_ExportProgressText" : "총 %d 개의 행중 %d 개 행이 완료되었습니다.",
	            "SYS_ExportProgressCancel" : "취소",
	            "SYS_ExpandProgressCaption" : "모든행을 확장",
	            "SYS_ExpandProgressText" : "총 %d 개의 행중 %d 개 행이 완료되었습니다.",
	            "SYS_ExpandProgressCancel" : "확장을 멈춤",
	            "SYS_ExportCaption" : "다운로드할 컬럼을 선택",
	            "SYS_PrintCaption" : "출력할 컬럼을 선택",
	            "SYS_DefaultsAll" : "모두 선택",
	            "SYS_DefaultsAlphabet" : "%d ...",
	            "SYS_PrintRows" : "페이지별 최대 표시 행의 개수",
	            "SYS_PrintExpanded" : "",
	            "SYS_PrintFiltered" : "모든행 출력",
	            "SYS_PrintOptions" : "프린트 옵션",
	            "SYS_ExportOptions" : "Export 옵션",
	            "SYS_ExportFormat" : "파일 포맷",
	            "SYS_ExportFormats" : "XLS,CSV",
	            "SYS_ExportExpanded" : "",
	            "SYS_ExportFiltered" : "모든행 내보내기",
	            "SYS_ExportOutline" : "Export tree in Excel outline",
	            "SYS_ExportIndent" : "Indent tree in main column",
	            "SYS_RemoveUnused" : "미사용 페이지 삭제",
	            "SYS_ErrorSave" : "저장중 오류가 발생하였습니다.",
	            "SYS_DatesRepeat" : "반복",
	            "SYS_DatesStart" : "시작",
	            "SYS_DatesEndTime" : "마지막",
	            "SYS_DatesValue" : "값",
	            "SYS_DatesRepeatEnum" : "||주|일|시간",
	            "SYS_DatesRepeatKeys" : "||w|d|h",
	            "SYS_RenderProgressCaptionRows" : "행 페이지 렌더링",
	            "SYS_RenderProgressCaptionCols" : "컬럼 페이지 렌더링",
	            "SYS_RenderProgressCaptionChildren" : "트리 페이지 렌더링",
	            "SYS_StatusInsert" : "입력",
	            "SYS_StatusUpdate" : "수정",
	            "SYS_StatusDelete" : "삭제",
	            "SYS_StatusRead" : "조회",
	            "SYS_SaveConfirm" : "저장하시겠습니까?",
	            "SYS_EmptySaveContent" : "저장할 내역이 없습니다.",
	            "SYS_KeyFieldEmpty" : "%row 번째 행의 [%col](은)는 필수 입력 항목 입니다.",
	            "SYS_SubSum" : "소계",
	            "SYS_Cumulate" : "누계",
	            "SYS_Sum" : "합계",
	            "SYS_Avg" : "평균",
	            "SYS_Cnt" : "개수",
	            "SYS_NoType" : "타입이 맞지않아  편집이 불가합니다.",
	            "SYS_NoEditType" : "편집 불가능한 DataType 입니다.",
	            "SYS_NoValueCheck" : "값이 0 또는 1 이여야 합니다.",
	            "SYS_LicenseError" : "라이센스를 발급받으시기 바랍니다.",
	            "SYS_LicenseExpired" : "라이센스 기간이 만료되었습니다.",
	            "SYS_MaximumBigValue" : "최대값 보다 큰 값 입니다. [최대값=%d]",
	            "SYS_MinimumSmallValue" : "최소값 보다 작은 값 입니다. [최소값=%d]",
	            "SYS_NoDataRow" : "조회된 데이터가 없습니다.",
	            "SYS_CloseFindDialog" : "검색창을 닫으시겠습니까?",
	            "SYS_FindTitle" : "찾기",
	            "SYS_FindContent" : "찾을 내용",
	            "SYS_FindColumn" : "찾을 컬럼",
	            "SYS_AllColumn" : "전체 컬럼",
	            "SYS_SelectedColumn" : "선택 컬럼",
	            "SYS_KindCongruence" : "일치 종류",
	            "SYS_AllCongruence" : "모든 단어 일치",
	            "SYS_FrontCongruence" : "앞글자 일치",
	            "SYS_BackCongruence" : "뒷글자 일치",
	            "SYS_MiddleCongruence" : "가운데 일치",
	            "SYS_StartRowPosition" : "시작 위치",
	            "SYS_FindFromFirstRow" : "첫 행부터 찾기",
	            "SYS_FindFromFocusCell" : "포커스 셀 이후부터 찾기",
	            "SYS_CaseSensitive" : "대/소문자 구분",
	            "SYS_FindWrap" : "끝에서 되돌리기",
	            "SYS_KeepDlg" : "찾은 후 닫지않기",
	            "SYS_FindDialogFindButton" : "찾기",
	            "SYS_FindDialogCancelButton" : "취소"       ,
	            "SYS_InvalidDateFormat" : "날짜 형식에 맞지 않습니다.",
	            "SYS_InvalidTimeFormat" : "시간 형식에 맞지 않습니다.",
	            "SYS_InvalidCombo" : "일치하는 콤보 항목이 없습니다.",
	            "SYS_InvalidNumberFormat" : "숫자 형식에 맞지 않습니다.",
	            "SYS_NoFindString" : "찾으려는 값이 입력되지 않았습니다. 값을 입력하세요.",
	            "SYS_FullInputWarning" : "%row 번째 행의 [%col]을(를) 모두 입력하십시오",
	            "SYS_ExceededInputLength" : "데이터의 길이제한범위를 초과하였습니다.",
	            "SYS_InsertSuccess" : "입력완료",
	            "SYS_UpdateSuccess" : "수정완료",
	            "SYS_SaveSuccess" : "저장완료",
	            "SYS_SaveDup" : "저장중복",
	            "SYS_SaveMiss" : "미처리",
	            "SYS_SaveFail" : "저장오류",
	            "SYS_ColSortAsc" : "오름차순 정렬",
	            "SYS_ColSortDesc" : "내림차순 정렬",
	            "SYS_ColHidden" : "컬럼 숨기기",
	            "SYS_CancelColHidden" : "모든 컬럼 숨기기 취소",
	            "SYS_SaveColInfo" : "컬럼 정보 저장",
	            "SYS_ResetColInfo" : "컬럼 정보 저장 취소",
	            "SYS_ShowFilter" : "필터행 사용",
	            "SYS_HideFilter" : "필터행 사용 안함",
	            "SYS_InvalidGetSaveString" : "KeyFieldError",
	            "SYS_InvalidValue" : "유효하지 않은 문자 또는 문자열이 포함되어 있습니다.",
	            "SYS_SearchDesc" : "조회 중 입니다.",
	            "SYS_SaveDesc" : "저장 중 입니다.",
	            "SYS_DownloadDesc" : "다운로드 중 입니다.",
	            "SYS_UploadDesc" : "업로드 중 입니다.",
	            "SYS_ProcessDesc" : "처리 중 입니다.",
	            "SYS_PivotTitle" : "피벗 테이블 설정",
	            "SYS_PivotTargetCol1" : "대상 컬럼 (일반)",
	            "SYS_PivotTargetCol2" : "대상 컬럼 (숫자형)",
	            "SYS_PivotColLabel" : "컬럼",
	            "SYS_PivotRowLabel" : "행",
	            "SYS_PivotValueLabel" : "값",
	            "SYS_PivotButtonPivot" : "피벗테이블",
	            "SYS_PivotButtonCross" : "크로스테이블",
	            "SYS_PivotButtonBase" : "원본시트",
	            "SYS_PivotButtonInit" : "초기화",
	            "SYS_PivotButtonClose" : "닫기",
	            "SYS_PivotRatioSumRow" : "행합계비율",
	            "SYS_PivotRatioSumCol" : "열합계비율",
	            "SYS_PivotInfoMessage" : "<li>대상 컬럼을 드래그하여 컬럼, 행, 값의 레이블을 설정 합니다.</li><li>컬럼과 행의 레이블에는 동일한 컬럼을 설정할 수 없습니다.</li>",
	            "SYS_ExcelDone" : "엑셀 데이터가 로드 되었습니다.",
	            "SYS_OverMaxRow" : "엑셀 데이터가 최대 행수 설정값 보다 많습니다.",
	            "SYS_NoMatchedHeader" : "엑셀 데이터에 시트 헤더와 동일한 정보가 없습니다.",
	            "SYS_FilterTitle" : "필터 입력",
	            "SYS_FilterInfoMessage" : "<li>검색어와 연산자는 공백으로 구분</li><li>AND 연산자 : and, 공백, &<br/>ex) 대한 and 민국</li><li>OR 연산자 : or, |<br/>ex) 대한 or 민국</li><li>범위 연산자 : ~ <br/>ex) 10 ~ 20</li><li>검색어에 연산자 또는 공백이 포함되는 경우 \"\" 사용<br/>ex) \"대한 민국\", \"You and I\"</li>",
	            "SYS_InvalidPaste" : "일부 셀에서 붙여넣기 작업을 실패하였습니다.",
	            "SYS_InitGroupColsInfo" : "그룹 정보 초기화",
	            "SYS_SaveGroupColsInfo" : "그룹 정보 저장",
	            "SYS_ResetGroupColsInfo" : "그룹 정보 저장 취소"
	        },
	        "MenuButtons" : {
	            "SYS_Ok" : "선택",
	            "SYS_Clear" : "취소",
	            "SYS_Today" : "오늘",
	            "SYS_All" : "전체선택",
	            "SYS_Cancel" : "취소",
	            "SYS_Yesterday" : "어제",
	            "SYS_InputEmpty" : "공백",
	            "SYS_EmptyTip" : "공백일자"
	        },
	        "MenuFilter" : {
	            "SYS_F0" : "사용안함",
	            "SYS_F1" : "같음",
	            "SYS_F2" : "같지 않음",
	            "SYS_F3" : "작음",
	            "SYS_F4" : "같거나 작음",
	            "SYS_F5" : "큼",
	            "SYS_F6" : "같거나 큼",
	            "SYS_F7" : "단어로 시작함",
	            "SYS_F8" : "단어로 시작하지 않음",
	            "SYS_F9" : "단어로 끝남",
	            "SYS_F10" : "단어로 끝나지 않음",
	            "SYS_F11" : "포함함",
	            "SYS_F12" : "포함하지 않음",
	            "SYS_CheckedText" : "1",
	            "SYS_UnCheckedText" : "0"
	        },
	        "Format" : {
	            "SYS_YearName" : "년",
	            "SYS_LongDayNames" : "일요일,월요일,화요일,수요일,목요일,금요일,토요일",
	            "SYS_ShortDayNames" : "일,월,화,수,목,금,토",
	            "SYS_Day2CharNames" : "일,월,화,수,목,금,토",
	            "SYS_Day1CharNames" : "일,월,화,수,목,금,토",
	            "SYS_LongMonthNames" : "1월,2월,3월,4월,5월,6월,7월,8월,9월,10월,11월,12월",
	            "SYS_LongMonthNames2" : "1월,2월,3월,4월,5월,6월,7월,8월,9월,10월,11월,12월",
	            "SYS_ShortMonthNames" : "1월,2월,3월,4월,5월,6월,7월,8월,9월,10월,11월,12월",
	            "SYS_DayNumbers" : "1st,2nd,3rd,4th,5th,6th,7th,8th,9th,10th,11th,12th,13th,14th,15th,16th,17th,18th,19th,20th,21st,22nd,23rd,24th,25th,26th,27th,28th,29th,30th,31st",
	            "SYS_Quarters" : "I,II,III,IV",
	            "SYS_Halves" : "I,II",
	            "SYS_DateSeparator" : "/",
	            "SYS_InputDateSeparators" : "/.-",
	            "SYS_TimeSeparator" : ":",
	            "SYS_InputTimeSeparators" : ":",
	            "SYS_AMDesignator" : "AM",
	            "SYS_PMDesignator" : "PM",
	            "SYS_FirstWeekDay" : "0",
	            "SYS_FirstWeekYearDay" : "3",
	            "SYS_NaD" : "",
	            "SYS_GMT" : "0",
	            "SYS_d" : "yyyy-MM-dd",
	            "SYS_g" : "yyyy-MM-dd HH:mm",
	            "SYS_G" : "yyyy-MM-dd HH:mm:ss",
	            "SYS_m" : "yyyy-MM",
	            "SYS_M" : "MM-dd",
	            "SYS_t" : "HH:mm",
	            "SYS_T" : "HH:mm:ss",
	            "SYS_ValueSeparator" : ";",
	            "SYS_ValueSeparatorHtml" : ";",
	            "SYS_RangeSeparator" : "~",
	            "SYS_RangeSeparatorHtml" : "~",
	            "SYS_RepeatSeparator" : "#",
	            "SYS_CountSeparator" : "*",
	            "SYS_AddSeparator" : "+",
	            "SYS_DecimalSeparator" : ".",
	            "SYS_InputDecimalSeparators" : ".,",
	            "SYS_GroupSeparator" : ",",
	            "SYS_InputGroupSeparators" : "",
	            "SYS_Percent" : "%",
	            "SYS_NaN" : "",
	            "SYS_ng" : "0.######",
	            "SYS_nf" : "0.00",
	            "SYS_nc" : "$###########0.00",
	            "SYS_np" : "0.00%",
	            "SYS_nr" : "0.0000",
	            "SYS_ne" : "0.000000 E+000",
	            "SYS_Cont" : "...",
	            "SYS_ContLeft" : "...",
	            "SYS_ContRight" : "...",
	            "SYS_EmptyDate" : ""
	        },
	        "User" : {
	        }
	    }
	};