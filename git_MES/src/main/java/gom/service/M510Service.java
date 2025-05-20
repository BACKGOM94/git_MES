package gom.service;

import java.util.List;
import java.util.Map;

import gom.vo.M510VO;

public interface M510Service {

	//M5101020_1_View
	public List<M510VO> M5101020_1_View (String comp_CD) throws Exception;
		
	//equi_CD 변환시 equi_location 반환
	public String get_equi_location(Map<String, Object> map) throws Exception;
	
	//DATA_equipment_TB insert
	public void M510_DataIn(Map<String, Object> map) throws Exception;

	//Kpi 데이터 작업 함수
	public void M510_InKpi(int cycle) throws Exception;
}
