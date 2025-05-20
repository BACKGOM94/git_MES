<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.File,java.net.URLDecoder,java.text.SimpleDateFormat,java.util.*,java.io.PrintWriter"%>
<%@ page import="java.sql.*,java.util.*,org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.json.simple.JSONValue,org.json.simple.parser.JSONParser"%>
<%
//┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//┃ IBLeaders IBUpload Server Side Program v7.3.0.0
//┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//┃ ○ 설 계 자 : (주)아이비리더스
//┃ ○ 모듈이름 : ibupload.jsp
//┃ ○ 기능설명 : 업로드 및 파일 제거
//┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//┃ⓘ 아이비리더스 2016
//┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ====================================================================================================
// ※ 처음 설치시 주의사항 - 아래 항목들을 검토하고 필수변경요소는 반드시 설정 또는 변경해야 합니다.
// ====================================================================================================
// ① [서버함수 인자1 - 필수변경요소] 업로드 루트 경로 지정 - 실제로 파일이 업로드 되어 저장되는 경로
// ② [서버함수 인자2 - 필수변경요소] 업로드 된 대용량 파일의 임시 경로 지정 - 가용 메모리를 초과하는 대용량 파일의 경우 임시 경로에 일시적으로 파일이 기록되었다가 자동 제거됨
// ③ [서버함수 인자3 - 옵션][기본값:16MB] 가용 메모리 용량 1MB 로 지정할 경우 1MB 이하의 파일들은 모두 메모리 내에서 직접 처리되며, 초과하는 파일들만 임시적으로 파일 처리됨
// ④ [서버함수 인자4 - 옵션][기본값:2GB] 최대 파일 크기 제한 - UI 에서 통과된 파일 크기라고 하더라도, 여기서 최종적으로 다시 한번 걸러짐. 되도록 여유있게 잡아야 됨.
// ⑤ [서버함수 인자5 - 옵션][기본값:utf-8] 업로드 엔코딩 - 업로드 과정에서 웹페이지의 UploadEncoding 값과 서버쪽 수신시 한글 엔코딩 방식이 무엇인지 설정한다. 둘다 반드시 일치해야 됨.
// ⑥ [서버함수 인자6 - 필수검토요소] 서버 응답 여부 - 기본값 true, form.submit() 호출을 통하여 page reloading 되는 게시판 연동의 경우 서버 응답을 하면 응답문이 웹페이지에 표시되는 현상이 있다. 이런 경우 false 로 설정하여 서버 응답문을 무시하도록 한다.
// ====================================================================================================
// ⑦ [설치후, 추가 개발 요소] 업로드 설치가 완료된 후에 현업 업무 로직을 추가할 수 있습니다. ( IBUpload_DoUpload 함수 등 내부 로직의 커스터마이징 작업 )
// ♣1 : [브라우저로부터 받은 업무 성격의 파라메터들의 처리] client 에서 보낸 파라메터 값들에 대한 처리 로직 예제가 들어있습니다.
// ♣2 : [보안안상 위험한 업로드 확장자 파일의 제한 처리] 서버에서 실행될 위험한 파일들의 제한 예제가 들어있습니다. 추가할 파일이 있으면 나열된 확장자에서 더 추가하고 ibuplaodinfo.js 의 limitFileExtServer 값도 동일하게 설정 필요.
// ♣3 : [고유 파일명 저장 규칙에 따른 파일 저장의 처리] 업로드 받은 파일들을 한 폴더내에서 고유한 파일로 변경하기 위한 로직 (가능하면 파일명에 한글이 들어가지 않는 것이 운영상 좋습니다.)
// ♣4 : [브라우저로 응답할 JSON 응답문의 처리 & DB 처리] JSON 형태로 client 에 업무 성격의 파라메터 값들을 보낼 수 있습니다. DB 처리 반영도 가능합니다.
// ♣5 : [파일정책 변경에 따른 관리] - 업로드폴더를 별도로 관리 하는 경우, 또는 DB 에 파일을 직접 저장하는 경우등에 대한 커스터마이징 작업
//====================================================================================================

// ====================================================================================================
// ※ [참고사항] JDK 1.6 에서 설계 및 테스트 되었습니다.
// ====================================================================================================

	//================================================================================
	// ① [필수변경요소] 업로드 루트 경로 지정 - 실제로 파일이 업로드 되어 저장되는 경로
	//================================================================================
	// ※ 보안상의 이유로 UploadRootDir 가 webRoot 아래로 노출되는 것 보다는 오픈되지 않은 별도의 시스템 내부 폴더로 저장하는 것을 권장합니다.
	//================================================================================
	String UploadRootDir = "C:/file_uploaded/";

	//================================================================================
	// ② [필수변경요소] 업로드 된 대용량 파일의 임시 경로 지정 - 가용 메모리를 초과하는 대용량 파일의 경우 임시 경로에 일시적으로 파일이 기록되었다가 자동 제거됨
	//================================================================================
	// 예) "D:/tempDir/";  "/usr/temp/";
	//================================================================================
	String TempDir = "C:/file_uploaded/temp";

	//================================================================================
	// ③ [옵션][기본값:16MB] 가용 메모리 용량 1MB 로 지정할 경우 1MB 이하의 파일들은 모두 메모리 내에서 직접 처리되며, 초과하는 파일들만 임시적으로 파일 처리됨
	//================================================================================
	// 메모리 사용량 설정 (클수록 디스크 기록 부담율이 적어짐 - 16 MB
	//================================================================================
	int AvailableMemory = 16 * 1024 * 1024 ;

	//================================================================================
	// ④ [옵션][기본값:2GB] 최대 파일 크기 제한 - UI 에서 통과된 파일 크기라고 하더라도, 여기서 최종적으로 다시 한번 걸러짐. 되도록 여유있게 잡아야 됨.
	//================================================================================
	// 파일별 최대 용량 제한 - 2 GB
	//================================================================================
	long MaxFileSize = 2*1024*1024*1024 ; //최대 용량 2.04 GB 를 초과할 수 없음.

	//================================================================================
	// ⑤ [옵션][기본값:utf-8] 업로드 엔코딩 - 업로드 과정에서 웹페이지의 UploadEncoding 값과 서버쪽 수신시 한글 엔코딩 방식이 무엇인지 설정한다. 둘다 반드시 일치해야 됨.
	//================================================================================
	// 브라우저에서 $(sel).IBUpload("UploadEncoding","utf-8") 로 설정했다면 utf-8 로 설정해야 한다.
	// 브라우저에서 $(sel).IBUpload("UploadEncoding","euc-kr") 로 설정했다면 euc-kr 로 설정해야 한다.
	// ( 한글 깨짐 주의 ★★★ ) 브라우저에서 설정한 값과 아래의 값은 반드시 일치해야 됨.
	//================================================================================
	String UploadEncoding = "utf-8";
	//String UploadEncoding = "euc-kr";

	//====================================================================================================
	// IBUpload_DoUpload 함수 - 서버 업로드의 처리
	//====================================================================================================
	// String UploadRootDir = "D:/file_uploaded/";
	// String TempDir = "D:/file_uploaded_temp";
	// int AvailableMemory = 16 * 1024 * 1024 ;
	// long MaxFileSize = 2*1024*1024*1024 ; //최대 용량 2.04 GB 를 초과할 수 없음.
	// String UploadEncoding = "utf-8";
	//====================================================================================================
	// 모든 request.getParameter 항목을 ibuploadMap.get 으로 얻을 수 있다.
	// ibuploadMap.get("files") 로 최종 files 결과값을 얻을 수 있다.
	//====================================================================================================
	HashMap<String , Object> ibuploadMap = null;;
	try{
		ibuploadMap = IBUpload_DoUpload ( request, response, UploadRootDir, TempDir, AvailableMemory, MaxFileSize, UploadEncoding);
		if(ibuploadMap==null){
			return;
		}
	}catch(Exception ex){
//		ex.printStackTrace();
		out.println(ex.getMessage());
	}



	//====================================================================================================
	// 디비 저장 로직 구현 부분
	//====================================================================================================
	//해당 위치에 디비 저장에 관한 로직을 구성한다.
	
//	String frm_no = ibuploadMap.get("frm_no");  //화면에서 넘어온 내용을 얻음.
//	String CONTENT =  (String)ibuploadMap.get("frm_CONTENT");   //화면에서 넘어온 내용을 얻음.
//	String FILEDATA =  (String)ibuploadMap.get("filesJSONString");  //!!!!!!!!! 실제 파일 정보 !!!!!!!!!!! (ibupload가 파일을 저장후 저장한 이름과 실제이름 파일 사이즈 등을 리턴함)
//  ...

	
	
	try{
		//실제 화면에 리턴할 데이터
		Map resultMap = (Map)ibuploadMap.get("ResultJSON"); 
		
		//etcdata를 통해 부수적인 내용을 좀더 추가한다.
		Map etcData = new HashMap();
		etcData.put("msg","저장되었습니다.");
		resultMap.put("etcdata",etcData);
							
		out.println( JSONValue.toJSONString(resultMap) );	
		}catch(Exception ex){
//			ex.printStackTrace();
		}
		
%>

<%!
	//====================================================================================================
	// 이하는 서버파트 IBUpload_DoUpload 함수이며 위에서 언급된 커스터마이징 등 특별한 사유가 없는 한 수정할 필요가 없습니다.
	//====================================================================================================
	public HashMap<String , Object> IBUpload_DoUpload (HttpServletRequest request, HttpServletResponse response, String UploadRootDir, String TempDir, int AvailableMemory, long MaxFileSize, String UploadEncoding) throws Exception
	{
		return IBUpload_DoUpload ( request,  response,  UploadRootDir,  TempDir,  AvailableMemory,  MaxFileSize,  UploadEncoding,false);
	}
	public HashMap<String , Object> IBUpload_DoUpload (HttpServletRequest request, HttpServletResponse response, String UploadRootDir, String TempDir, int AvailableMemory, long MaxFileSize, String UploadEncoding,boolean doNotDelete) throws Exception
	{

		File file;
		DiskFileItemFactory factory;
		ServletFileUpload upload;
		List <FileItem> fileItems = null;

		HashMap<String , Object> ibuploadMap = new HashMap<String , Object>();	


		String RequestUrl = request.getRequestURL().toString();
		String WebRootUrl = RequestUrl.substring(0, RequestUrl.length() - request.getRequestURI().length()) + "/";
		String ContentType = ""+request.getContentType();
		String CommandType = "";
		String FileID = "";							// 클릭해 줄 ID (IE 6 ~ IE 9)
		String DeleteFileList = "";					// 제거할 파일 목록(\n 엔터구분자 조합 문자열)
		String files = "";                          // DB 에 저장할 최종 files 값  (예) {name: "관심과집중.mp4", size:"11417124", date:"20160101125959", url: "20160126_180337_82754651"},{name:"오렌지.jpg", size:"1075761", date:"20160101125959", url:"20160126_180801"},
		String files_id = "";                       // DB 에 저장할 최종 files 값에 IBUpload Client 에서 부여한 파일 id 도 포함됨  (예) {id:"file1_1", name:"관심과집중.mp4", size:"11417124", date:"20160101125959", url:"20160126_180337_82754651"},{name:"오렌지.jpg", size:"1075761", date:"20160101125959", url: "20160126_180801"},
		String GetFileUrl = "";						// 다운로드 할 파일 URL
		String DownloadFiles = "";					// 다운로드 할 파일들
		boolean isUTF_force = false;				// Win10 IE11 버그체크
		String FormNo = "";							// 업로드 요청해 온 폼 번호 (응답시 "formX_Y" 형태로 응답해야 한다. X 가 폼번호, Y 는 파일 순번)
		String TestValue = "";						// ExtendParam 한글 깨짐 실험
	    String ParentID = "";
		request.setCharacterEncoding(UploadEncoding);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
	 	response.setHeader("Access-Control-Allow-Origin", "*"); // CrossDomain 보안 설정 옵션

		//--------------------------------------------------------------------------------
		// [IE 6 ~ IE 9 파일 오픈 창 지원 & 파일 업로드 처리]
		//--------------------------------------------------------------------------------
		if (ContentType.indexOf("multipart/form-data") == -1) {

			//================================================================================
			// IE9 이하의 파일 업로드를 지원하려면 이 부분이 반드시 있어야 됨.
			//================================================================================
			if(request.getParameter("cmd")!=null){
				CommandType = request.getParameter("cmd");
			}
			// FileOpen 에 대한 처리 ( IE9 이하 )
			if(CommandType.equals("FileOpen")){
				if(request.getParameter("id")!=null){
					FileID = request.getParameter("id");
				}
				
				ParentID = request.getParameter("parentid");
				throw new Exception("<html><head><script>try{ parent.document.getElementById('" + ParentID + "_IBUpload_Add" + FileID + "').click(); }catch(e){}</script></head></html>");
			}

	        Enumeration<String> e = request.getParameterNames();

	        while(e.hasMoreElements()) {
	            String name = e.nextElement();
	            String fieldValue = "";
	            String[] data = request.getParameterValues(name);
	            if(data!=null) {
	                for(String fieldName : data){
	                    fieldValue = "";
	                    if(request.getParameter(fieldName)!=null){
	                        fieldValue = request.getParameter(fieldName);
	                    }
	                    ibuploadMap.put(fieldName, fieldValue);
	                }
	            }
	        }
		}else{


			List<Map> files_result = new ArrayList();//IBUpload files 에 넣을 결과 값
			List<Map> files_id_result = new ArrayList();//IBUpload files_id 에 넣을 결과 값
			Map server_ResponseText = new HashMap();//DB 저장 결과문 OBJECT


			factory = new DiskFileItemFactory();
			factory.setSizeThreshold(AvailableMemory);
			factory.setRepository(new File(TempDir));
			upload = new ServletFileUpload(factory);
			upload.setSizeMax(MaxFileSize);
//			upload.setFileSizeMax(10*1024*1024);  //한 파일의 최대 사이즈 설정
			
			try {

				request.setCharacterEncoding(UploadEncoding);
				fileItems = upload.parseRequest(request);
				//--------------------------------------------------------------------------------
				// Win10 IE11 오류 대응
				//--------------------------------------------------------------------------------
		 		for (FileItem item : fileItems) {
					if (item.isFormField())
					{
						String fieldName = item.getFieldName();
						String fieldValue = item.getString(UploadEncoding);

						if("_ibupload_ie11_han_check".equals(item.getFieldName())){

							// Windows10,IE11,10240 에서는 무조건 utf-8 로 전송되는 버그가 있다.
							// Windows8 IE11 은 잘됨
							// 갑자기 패치될 가능성 있음..
							// 10547 해결되었다는 소문이 있으나 10586 에서 안됨.
							// UTF-8 로 보내는 IE11 의 버그라고 한다면 여기서 대응처리
							if("ea".equals(String.format("%02x", item.getString(UploadEncoding).getBytes()[0]))){
								UploadEncoding = "utf-8";
								isUTF_force = true;
							}
						} else if("__formNo".equals(fieldName)){
							FormNo = fieldValue;
						} else if("__delList".equals(fieldName)){
							DeleteFileList = fieldValue; // 서버에서 삭제해야할 파일들
						} else if("__files".equals(fieldName)){
							files = fieldValue;  // IBUpload 가 갖고 있었던 최근 files 목록
						} else if("doNotDelete".equals(fieldName)){
							doNotDelete = true;
						} else {

							fieldValue = URLDecoder.decode((String)fieldValue, UploadEncoding);
							
							if(ibuploadMap.containsKey(fieldName)){
								//같은 이름으로 복수개가 넘어왔을 경우 배열형태로 넣는다.
								Object o = ibuploadMap.get(fieldName);
								if(o instanceof String){
									String[] x = {(String)o,fieldValue};
									ibuploadMap.put(fieldName, x);
								}else if(o instanceof String[]){
									String[] x = (String[])o;
									String[] newArr = new String[x.length+1];
									for(int i=0;i<x.length;i++){
										newArr[i] = x[i];
									}
									newArr[newArr.length] = fieldValue;
									ibuploadMap.put(fieldName, newArr);
								}
							}else{
								ibuploadMap.put(fieldName, fieldValue);
							}
						}
					}
				} // end of form data
			} catch(Exception ex) {
//			ex.printStackTrace();
				Map errorJSON = new HashMap();
				errorJSON.put("Error",ex.getMessage());
				server_ResponseText.put("ibupload",errorJSON);
				String errStr = JSONValue.toJSONString(server_ResponseText);
				throw new Exception(errStr);	
			}

			try {

				//--------------------------------------------------------------------------------
				// 파일 업로드 처리 ( type = file 인 경우의 처리 )
				//--------------------------------------------------------------------------------
				// 저장되는 파일 위치 : UploadRootDir / 업로드 파일명
				//--------------------------------------------------------------------------------
				String createFilePath = "";
				String createDirPath = "";
				String newFileSavePath = "";

				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				Random rand = new Random();
				String TodayString = sdf.format(Calendar.getInstance().getTime());

				int UploadCount = 0;
				String oldFieldName = "";

				for (FileItem item : fileItems) {
					if (!item.isFormField()) {
						String fieldName = item.getFieldName();
						String fileName = (""+item.getName()).trim();

						// WIN10-IE11 의 UTF8 한글깨짐에 의한 파일깨짐방지
						if(isUTF_force){
							fileName = new String(fileName.getBytes("EUC-KR"), "iso-8859-1");
						}
						if(!oldFieldName.equals(fieldName)){
							UploadCount = 0;
						}
						oldFieldName = item.getFieldName();

						//====================================================================================================
						// ♣2 : 보안상 위험한 업로드 확장자 파일의 제한 처리
						//====================================================================================================
						// 보안상 IBUpload 의 limitFileExt 속성을 참고하여 아래와 동일한 파일 목록들을 차단하는 것을 권장합니다.
						//====================================================================================================
						boolean isExecFile = true;
						if(" html htm php php2 php3 php4 php5 phtml pwml inc asp aspx ascx jsp cfm cfc pl bat exe com dll vbs js reg cgi htaccess asis sh shtml shtm phtm ".indexOf(" "+fileName.substring(fileName.lastIndexOf(".")+1)+" ") == -1 ) {
							isExecFile = false;
						}

						boolean isUploadCancel = false; // 첨부중에 업로드 취소한 항목들
						if((DeleteFileList+"\r\n").indexOf(fieldName+FormNo+"_"+(UploadCount)+"\r\n") > -1 ){
							isUploadCancel = true;
						}


						if(!"".equals(fileName)) {

							//====================================================================================================
							// ♣3 : 수신 받은 파일들을 한 폴더내에서 고유한 파일명으로 바꿔주고 client 에 그 결과를 응답한다.
							//====================================================================================================
							// 기본적으로 수신받은 파일명은 아래와 같은 형식으로 저장되고 있습니다.
							// 업무상 파일관리 정책에 따라 바꾸셔도 됩니다.
							//
							// 1. 기존적으로 현재날짜와 시간으로 저장됨.
							// 2. 날짜와 시간까지 동일하게 겹친 파일에 한하여 중복시고유번호를 붙임
							//
							// 파일명 형식 : yyyyMMdd_HHmmss_##### (##### 은 중복시 랜덤 고유번호)
							//
							//====================================================================================================
							if(isExecFile == true) {
								newFileSavePath = "_REJECT_";
							} else {
	                            newFileSavePath = TodayString;
	                            createFilePath =  UploadRootDir + TodayString;

	                            if (new File(createFilePath).isFile()) // 중복체크
	                            {
	                                for(int i=1;i<99999;i++)
	                                {
	                                    newFileSavePath = TodayString + "_"+String.format("%08d",rand.nextInt(100000000));
	                                    createFilePath = UploadRootDir + newFileSavePath;
	                                    if (!new File(createFilePath).isFile()) break;
	                                }
	                            }

	                            if(isUploadCancel == false){
	                            file =  new File(createFilePath);
	                            item.write(file) ;
	                        	}
	                        }

	                        if(isUploadCancel == false){

							String item_getName = "";
							item_getName = item.getName();
							if(item_getName.indexOf("\\") > -1){
								item_getName = item_getName.substring(item_getName.lastIndexOf("\\")+1,item_getName.length());
							}

							server_ResponseText.put(fieldName+FormNo+"_"+(UploadCount), newFileSavePath);
							Map tmpResult = new HashMap();
							tmpResult.put("name", item_getName);
							tmpResult.put("size", item.getSize());
							tmpResult.put("date", TodayString);
							tmpResult.put("url", newFileSavePath);
							files_result.add(tmpResult);

							Map tmpIdResult = new HashMap();
							tmpIdResult.put("id", item.getFieldName()+FormNo+"_"+UploadCount);
							tmpIdResult.put("name", item_getName);
							tmpIdResult.put("size", item.getSize());
							tmpIdResult.put("date", TodayString);
							tmpIdResult.put("url", newFileSavePath);
							files_id_result.add(tmpIdResult);
		                    }

							UploadCount++;

						}
					} // end of form file
				} // end of for
			
				if(!doNotDelete){
					//--------------------------------------------------------------------------------
					// 파일 삭제 처리
					//--------------------------------------------------------------------------------
		    		List <String> deleteItem = Arrays.asList(DeleteFileList.split("\n"));
		    		//삭제한 파일을 담는다.
		    		ibuploadMap.put("DeleteFileList", deleteItem);
		    		
		            for (String item : deleteItem) {
		            	item = item.trim();
		            	if(!"".equals(item)){
			                File delFile = new File(IBUpload_RealFilePath(UploadRootDir,item));
			                if (delFile.isFile()) { // 존재할 경우 제거
			                    delFile.delete();
			                }
		            	}
		            }
				}

	            
				//====================================================================================================
				// files 결과문을 최종 준비한다. 
				//====================================================================================================
				// ㆍ upfiles,files 의 값 : {name:"공지사항.hwp", size:"13259", date:"20160401161015", url:"20160401105"},{name:"사진.jpg", size:"1577166", date:"20160410161335", url:"20160410161335"}
				// ㆍ files_id 의 값 : {id:"file0_0", name: "공지사항.hwp", size:"13259", date: "20160401161015", url: "20160401105"},{id:"file0_1", name:"사진.jpg", size:"1577166", date:"20160410161335", url:"20160410161335"}
				//====================================================================================================
	            JSONParser parser = new JSONParser();
				Object obj = parser.parse("["+files+"]"); 
				List<Map> jarr = (List<Map>)obj;
				jarr.addAll(files_result);
				
				//이번에 올린 파일 정보
				ibuploadMap.put("upfiles", files_result);  
				ibuploadMap.put("upfilesJSONString", JSONValue.toJSONString(files_result)); //파일정보 json string
				
				//업로드 상의 전체 파일 정보 (화면 업로드에 이미 등록된 파일 정보까지 포함)
				ibuploadMap.put("files", jarr); 
				ibuploadMap.put("filesJSONString", JSONValue.toJSONString(jarr)); //전체파일정보 json string  (실제 디비에 저장해야 하는 값!!!!!!!!!!!!!!!!!!!!!!!!!!!)
				
				//id 값을 포함한 전체 파일 정보
				ibuploadMap.put("files_id", files_id_result); 

				//====================================================================================================
				// JSON 결과문을 IBUpload Client 로 응답한다.
				//====================================================================================================
				Map m = new HashMap();
				m.put("ibupload", server_ResponseText);
				ibuploadMap.put("ResultJSON", m);//<-- 실제 화면에 리턴해야 하는 값

			} catch(Exception ex) {
//				ex.printStackTrace();
				
				Map errorJSON = new HashMap();
				errorJSON.put("Error",ex.getMessage());
				server_ResponseText.put("ibupload",errorJSON);
				String errStr = JSONValue.toJSONString(server_ResponseText);
				throw new Exception(errStr);	
			}
		}
		return ibuploadMap;
	}


	
	
	
	
	
	
	
	
	//====================================================================================================
	// Client 에서 받은 files 속성값 형태를 파일저장 후, Server 의 files 속성값 형태로 리턴한다.
	//====================================================================================================
	// Client 의 files 속성값 : {name : "공지사항.hwp", id : "file0_0"}
	// Server 의 files 속성값 : {name : "공지사항.hwp", size : "12000", date : "19851231125959", url : "19851231125959"}
	//====================================================================================================
	public Map IBUpload_Update_Files(HashMap<String , Object> ibuploadMap, String client_filedata)
	{
		if("".equals(client_filedata)){return null;}
		if(ibuploadMap.get("files_id")!=null&&((List)ibuploadMap.get("files_id")).size()>0){
			//업로드 상의 전체 파일 정보
		    List<Map> files_id = (List<Map>)ibuploadMap.get("files_id");
	
			//화면에서 넘어온 파일 ID 
			Map jo = (Map)JSONValue.parse(client_filedata);
			String id = jo.get("id")!=null?jo.get("id")+"":"";
	
			for(int i=0;i<files_id.size();i++){
				Map tMap = files_id.get(i);
				if(id.equals((String)tMap.get("id"))){
					return tMap;
				}
			}
		}
	    return null;
	}

	
	
	
	//====================================================================================================
	// ♣5 : client 에서 요청하는 URL KEY 값을 실제로 저장된 디스크의 물리적 전체경로를 리턴함
	//====================================================================================================
	// ㆍ입력값(UrlKey)의 예 : 20161231_235959_000001
	// ㆍ리턴값의 예 : D:/file_uploaded/20161231_235959_000001
	//
	// ※ 업로드 폴더에 실제로 고유 파일을 저장하는 경우에는 변경할 필요가 없습니다.
	// ※ DB 에 저장하거나 별도의 디스크에 저장되어 관리되는 경우 실제 저장된 파일 경로를 리턴해 주시면 됩니다.
	//
	//====================================================================================================
	String IBUpload_RealFilePath(String UploadRootDir, String UrlKey)
	{
		System.out.println("요청된 파일 URL ID  : " + UrlKey);
		System.out.println("실제로 저장된 경로 : [" + UploadRootDir + UrlKey + "]");
		return UploadRootDir + UrlKey;
	}
	
	
	//특정 확장자를 갖은 파일이 업로드 되었을때, 업로드 된 파일을 제거하고, Exception을 발생시킴.
	//param list
	// 1. 업로드 후 리턴된 map
	// 2. 확장자 허용/불허 모드 "allow" or "deny"
	// 3. 확장자 리스트 (콤마로 구분 "jpg,gif,png")
	public void deleteFileExt(String UploadRootDir,HashMap<String , Object> ibuploadMap,String mode, String ext) throws Exception{
		Object o = ibuploadMap.get("upfiles");
		if(o!=null){
			ArrayList<Map> limitFile = new ArrayList();
			List<Map> upFiles = (List<Map>)o;
			for(int i=0;i<upFiles.size();i++){
				Map file = upFiles.get(i);
				String filename = (String)file.get("name");
				if(filename.lastIndexOf(".")>0){
					String fileext = filename.substring(filename.lastIndexOf(".")+1);
					if("allow".equals(mode)){
						if(! ( fileext.toUpperCase().equals(ext.toUpperCase()))){
							limitFile.add(file);
						}
					}else{
						if(fileext.toUpperCase().equals(ext.toUpperCase())){
							limitFile.add(file);
						}
					}
				}
			}
			//지정한 확장자가 아닌 파일은 삭제한 후, 오류 발생
			if(limitFile.size()>0){
				String limitFileName = "";
				//해당파일 삭제
				for(int i=0;i<limitFile.size();i++){
					String filename = (String)(((Map)limitFile.get(i)).get("url"));
					limitFileName = (String)(((Map)limitFile.get(i)).get("name"))+"\n";
					File f = new File(UploadRootDir+"/"+filename);
					if(f.exists()){
						f.delete();
					}
				}
				String msg = "File Extension Error\n"+mode+" Extension : "+ext+"\n\n\nERROR FILE LIST:\n"+limitFileName;
				
				
				Map server_ResponseText = new HashMap();
				Map errorJSON = new HashMap();
				errorJSON.put("Error",msg);
				server_ResponseText.put("ibupload",errorJSON);
				String errStr = JSONValue.toJSONString(server_ResponseText);
				throw new Exception(errStr);	
			}
		}
	}
%>
