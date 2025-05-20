package gom.service;

import java.util.Map;

public interface M310Service {

	//수주내용 저장시 배차 자동등록
	public void M3101010_2_Insert2 (String comp_CD) throws Exception;
	
	//거래처별 제품 콤보박스 데이터로 가져오기
	public Map<String, Object> get_item_CD_ComBo(Map<String, Object> map) throws Exception;
	
}
