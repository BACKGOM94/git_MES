package gom.service.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import gom.dao.M510DAO;
import gom.service.M510Service;
import gom.vo.M510VO;

@Service(value = "M510Service")
public class M510Serviceimpl implements M510Service {

	// m510DAO 가져오기
	@Resource(name = "M510DAO")
	private M510DAO m510DAO;

	// M5101020_1_View
	@Override
	public List<M510VO> M5101020_1_View(String comp_CD) throws Exception {
		return m510DAO.M5101020_1_View(comp_CD);
	}

	// equi_CD 변환시 equi_location 반환
	@Override
	public String get_equi_location(Map<String, Object> map) throws Exception {
		return m510DAO.get_equi_location(map);
	}

	// DATA_equipment_TB insert
	@Override
	public void M510_DataIn(Map<String, Object> map) throws Exception {
		m510DAO.M510_DataIn(map);
	}

	// Kpi 데이터 작업 함수
	@Override
	public void M510_InKpi(int cycle) throws Exception {

		List<M510VO> Kpi_list = m510DAO.get_kpi_List(cycle);

		boolean Test = false;

		String URL_Lv1 = "http://www.ssf-kpi.kr:8080/kpiLv1/kpiLv1Insert";
		String URL_Lv2 = "http://www.ssf-kpi.kr:8080/kpiLv2/kpiLv2Insert";
		String URL_Lv3 = "http://www.ssf-kpi.kr:8080/kpiLv3/kpiLv3Insert";

		if (Test) {
			URL_Lv1 += "Tst";
			URL_Lv2 += "Tst";
			URL_Lv3 += "Tst";
		}

		HashMap<String, Object> map = new HashMap<String, Object>();

		String data_Lv1 = "";
		String data_Lv2 = "";
		String data_Lv3 = "";
		String achrt = "";
		String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		String time = LocalTime.now().format(DateTimeFormatter.ofPattern("HHmmss"));

		switch (cycle) {

		// Lv2,3 전송 ,cycle = 1,주기 일
		case 1:
			data_Lv2 = "{\"KPILEVEL2\" :[";
			data_Lv3 = "{\"KPILEVEL3\" :[";

			for (int i = 0; i < Kpi_list.size(); i++) {
				M510VO m510vo = Kpi_list.get(i);
				switch (m510vo.getKpiFld_CD()) {

				case "P":
					switch (m510vo.getKpiDtl_CD()) {
					case "Z":
						map.put("comp_CD", m510vo.getComp_CD());
						map.put("cycle", cycle);
						achrt = Float.toString((Float.parseFloat(m510vo.getBefor_CT())
								- Float.parseFloat(m510DAO.get_kpi_read_time(map)))
								/ Float.parseFloat(m510vo.getBefor_CT()) * 100);
						data_Lv2 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"P\", \"kpiDtlCd\": \"Z\", \"kpiDtlNm\": \"측정리드타임\", \"achrt\": \""
								+ achrt + "\", \"trsDttm\": \"" + date + time + "\"},";
						data_Lv3 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"P\", \"kpiDtlCd\": \"Z\", \"kpiDtlNm\": \"측정리드타임\", \"msmtVl\": \""
								+ m510DAO.get_kpi_read_time(map) + "\", \"unt\": \"" + m510vo.getUnit()
								+ "\", \"trsDttm\": \"" + date + time + "\"},";

						kpi_log_insert(m510vo, date + time, 2, m510DAO.get_kpi_read_time(map), achrt);
						kpi_log_insert(m510vo, date + time, 3, m510DAO.get_kpi_read_time(map), achrt);

						break;

					case "B":
						map.put("comp_CD", m510vo.getComp_CD());
						map.put("cycle", cycle);
						achrt = Float.toString(
								(Float.parseFloat(m510DAO.get_kpi_count(map)) - Float.parseFloat(m510vo.getBefor_CT()))
										/ Float.parseFloat(m510vo.getBefor_CT()) * 100);
						data_Lv2 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"P\", \"kpiDtlCd\": \"B\", \"kpiDtlNm\": \"생산량증가\", \"achrt\": \""
								+ achrt + "\", \"trsDttm\": \"" + date + time + "\"},";
						data_Lv3 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"P\", \"kpiDtlCd\": \"B\", \"kpiDtlNm\": \"생산량증가\", \"msmtVl\": \""
								+ m510DAO.get_kpi_count(map) + "\", \"unt\": \"" + m510vo.getUnit()
								+ "\", \"trsDttm\": \"" + date + time + "\"},";

						kpi_log_insert(m510vo, date + time, 2, m510DAO.get_kpi_count(map), achrt);
						kpi_log_insert(m510vo, date + time, 3, m510DAO.get_kpi_count(map), achrt);

						break;

					default:
						break;
					}

					break;

				case "Q":
					switch (m510vo.getKpiDtl_CD()) {
					case "Z":
						map.put("comp_CD", m510vo.getComp_CD());
						map.put("cycle", cycle);
						achrt = Float.toString(
								(Float.parseFloat(m510DAO.get_kpi_count(map)) - Float.parseFloat(m510vo.getBefor_CT()))
										/ Float.parseFloat(m510vo.getBefor_CT()) * 100);
						data_Lv2 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"Q\", \"kpiDtlCd\": \"Z\", \"kpiDtlNm\": \"계측건수\", \"achrt\": \""
								+ achrt + "\", \"trsDttm\": \"" + date + time + "\"},";
						data_Lv3 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"Q\", \"kpiDtlCd\": \"Z\", \"kpiDtlNm\": \"계측건수\", \"msmtVl\": \""
								+ m510DAO.get_kpi_count(map) + "\", \"unt\": \"" + m510vo.getUnit()
								+ "\", \"trsDttm\": \"" + date + time + "\"},";

						kpi_log_insert(m510vo, date + time, 2, m510DAO.get_kpi_count(map), achrt);
						kpi_log_insert(m510vo, date + time, 3, m510DAO.get_kpi_count(map), achrt);

						break;

					default:
						break;
					}
					break;

				default:
					break;
				}
			}
			data_Lv2 = StringUtils.removeEnd(data_Lv2, ",") + "]}";
			data_Lv3 = StringUtils.removeEnd(data_Lv3, ",") + "]}";
			// Lv2 데이터 전송
			Transfer(URL_Lv2, data_Lv2);
			Transfer(URL_Lv3, data_Lv3);

			// Lv1 전송 , 매일 보내야함 cycle 0 인것
			List<M510VO> Kpi_list_Lv0 = m510DAO.get_kpi_List(0);

			Set<String> cert_key = new HashSet<String>();

			for (int i = 0; i < Kpi_list_Lv0.size(); i++) {
				M510VO m510vo = Kpi_list_Lv0.get(i);
				kpi_log_insert(m510vo, date + time, 1, "0", "0");
				cert_key.add(m510vo.getCert_Key());
			}

			Iterator<String> iterSet = cert_key.iterator();

			data_Lv1 = "{\"KPILEVEL1\" :[";
			while (iterSet.hasNext()) {
				data_Lv1 += "{\"kpiCertKey\": \"" + iterSet.next() + "\", \"ocrDttm\": \"" + date
						+ "\", \"systmOprYn\": \"Y\", \"trsDttm\": \"" + date + time + "\"}";

				if (iterSet.hasNext())
					data_Lv1 += ",";
			}
			data_Lv1 += "]}";

			// Lv1 데이터 전송
			Transfer(URL_Lv1, data_Lv1);

			break;

		case 3:
			data_Lv2 = "{\"KPILEVEL2\" :[";
			data_Lv3 = "{\"KPILEVEL3\" :[";

			for (int i = 0; i < Kpi_list.size(); i++) {
				M510VO m510vo = Kpi_list.get(i);
				switch (m510vo.getKpiFld_CD()) {

				case "P":
					switch (m510vo.getKpiDtl_CD()) {
					case "B":
						map.put("comp_CD", m510vo.getComp_CD());
						map.put("cycle", cycle);
						achrt = Float.toString(
								(Float.parseFloat(m510DAO.get_kpi_count(map)) - Float.parseFloat(m510vo.getBefor_CT()))
										/ Float.parseFloat(m510vo.getBefor_CT()) * 100);
						data_Lv2 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"P\", \"kpiDtlCd\": \"B\", \"kpiDtlNm\": \"생산량증가\", \"achrt\": \""
								+ achrt + "\", \"trsDttm\": \"" + date + time + "\"},";
						data_Lv3 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"P\", \"kpiDtlCd\": \"B\", \"kpiDtlNm\": \"생산량증가\", \"msmtVl\": \""
								+ m510DAO.get_kpi_count(map) + "\", \"unt\": \"" + m510vo.getUnit()
								+ "\", \"trsDttm\": \"" + date + time + "\"},";

						kpi_log_insert(m510vo, date + time, 2, m510DAO.get_kpi_count(map), achrt);
						kpi_log_insert(m510vo, date + time, 3, m510DAO.get_kpi_count(map), achrt);

						break;

					default:
						break;
					}

					break;

				case "Q":
					switch (m510vo.getKpiDtl_CD()) {
					case "A":
						map.put("comp_CD", m510vo.getComp_CD());
						map.put("cycle", cycle);
						achrt = Float.toString((Float.parseFloat(m510vo.getBefor_CT())
								- Float.parseFloat(m510DAO.get_kpi_error_count(map)))
								/ Float.parseFloat(m510vo.getBefor_CT()) * 100);
						data_Lv2 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"Q\", \"kpiDtlCd\": \"A\", \"kpiDtlNm\": \"불량 감소\", \"achrt\": \""
								+ achrt + "\", \"trsDttm\": \"" + date + time + "\"},";
						data_Lv3 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"Q\", \"kpiDtlCd\": \"A\", \"kpiDtlNm\": \"불량 감소\", \"msmtVl\": \""
								+ m510DAO.get_kpi_error_count(map) + "\", \"unt\": \"" + m510vo.getUnit()
								+ "\", \"trsDttm\": \"" + date + time + "\"},";

						kpi_log_insert(m510vo, date + time, 2, m510DAO.get_kpi_error_count(map), achrt);
						kpi_log_insert(m510vo, date + time, 3, m510DAO.get_kpi_error_count(map), achrt);

						break;

					case "B":
						map.put("comp_CD", m510vo.getComp_CD());
						map.put("cycle", cycle);
						
						float data = Float.parseFloat(m510DAO.get_kpi_error_count(map)) / Float.parseFloat(m510DAO.get_kpi_count(map)) * 100;
						
						achrt = Float.toString((Float.parseFloat(m510vo.getBefor_CT())
								- data)
								/ Float.parseFloat(m510vo.getBefor_CT()) * 100);
						data_Lv2 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"Q\", \"kpiDtlCd\": \"B\", \"kpiDtlNm\": \"불량률 감소\", \"achrt\": \""
								+ achrt + "\", \"trsDttm\": \"" + date + time + "\"},";
						data_Lv3 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"Q\", \"kpiDtlCd\": \"B\", \"kpiDtlNm\": \"불량률 감소\", \"msmtVl\": \""
								+ data + "\", \"unt\": \"" + m510vo.getUnit()
								+ "\", \"trsDttm\": \"" + date + time + "\"},";

						kpi_log_insert(m510vo, date + time, 2, Float.toString(data), achrt);
						kpi_log_insert(m510vo, date + time, 3, Float.toString(data), achrt);
						
						break;

					case "Z":
						
						map.put("comp_CD", m510vo.getComp_CD());
						map.put("cycle", cycle);
						achrt = Float.toString(
								(Float.parseFloat(m510DAO.get_kpi_count(map)) - Float.parseFloat(m510vo.getBefor_CT()))
										/ Float.parseFloat(m510vo.getBefor_CT()) * 100);
						data_Lv2 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"Q\", \"kpiDtlCd\": \"Z\", \"kpiDtlNm\": \"계측건수\", \"achrt\": \""
								+ achrt + "\", \"trsDttm\": \"" + date + time + "\"},";
						data_Lv3 += "{\"kpiCertKey\": \"" + m510vo.getCert_Key() + "\", \"ocrDttm\": \"" + date
								+ "\", \"kpiFldCd\": \"Q\", \"kpiDtlCd\": \"Z\", \"kpiDtlNm\": \"계측건수\", \"msmtVl\": \""
								+ m510DAO.get_kpi_count(map) + "\", \"unt\": \"" + m510vo.getUnit()
								+ "\", \"trsDttm\": \"" + date + time + "\"},";
						kpi_log_insert(m510vo, date + time, 2, m510DAO.get_kpi_count(map), achrt);
						kpi_log_insert(m510vo, date + time, 3, m510DAO.get_kpi_count(map), achrt);					

						break;

					default:
						break;
					}
					break;

				default:
					break;
				}
			}
			data_Lv2 = StringUtils.removeEnd(data_Lv2, ",") + "]}";
			data_Lv3 = StringUtils.removeEnd(data_Lv3, ",") + "]}";
			// Lv2 데이터 전송
			Transfer(URL_Lv2, data_Lv2);
			Transfer(URL_Lv3, data_Lv3);
			break;
		default:
			break;
		}

	}

	private void kpi_log_insert(M510VO m510vo, String dateTime, int level, String value, String achrt)
			throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("comp_CD", m510vo.getComp_CD());
		map.put("kpiFld_CD", m510vo.getKpiFld_CD());
		map.put("kpiDtl_CD", m510vo.getKpiDtl_CD());
		map.put("send_DTTM", dateTime);
		map.put("value", value);
		map.put("rate", achrt);
		map.put("level", level);		
		m510DAO.kpi_log_insert(map);
	}

	//데이터 전송 함수
	private void Transfer(String URL , String Data) throws IOException {
		
		    URL url = new URL(URL); // 요청을 보낼 URL을 정의
		    HttpURLConnection connection = (HttpURLConnection) url.openConnection(); // URL에 대한 연결을 염

		    connection.setRequestMethod("POST"); // HTTP 요청 방식을 POST로 설정
		    connection.setDoOutput(true); // 요청 본문에 데이터를 전송할 수 있도록 함
		    connection.setRequestProperty("Content-Type", "application/json"); // 요청의 컨텐츠 타입을 JSON으로 설정

		    String jsonInputString = Data;
		    // 서버로 전송할 JSON 형식의 문자열을 정의

		    try(OutputStream os = connection.getOutputStream()) {
		        byte[] input = jsonInputString.getBytes("utf-8"); // JSON 문자열을 바이트 배열로 변환
		        os.write(input, 0, input.length); // 변환된 바이트 배열을 출력 스트림을 통해 전송		    
		    }
		    
	        int responseCode = connection.getResponseCode(); // 서버로부터 받은 HTTP 응답 코드를 가져옴
	        
	        if (responseCode != 200) {
				System.out.println(" ================ Problem occurred ================ ");
			}
	        
	        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream())); // 서버로부터의 응답을 읽기 위한 BufferedReader를 생성
	        String inputLine;
	        StringBuffer response = new StringBuffer(); // 서버 응답을 저장할 StringBuffer 객체를 생성

	        while ((inputLine = in.readLine()) != null) { // 서버 응답의 끝까지 한 줄씩 읽어 들임
	            response.append(inputLine); // 읽은 데이터를 StringBuffer 객체에 추가
	        }
	        in.close(); // BufferedReader를 닫아 리소스를 해제
	  
	    }
}
