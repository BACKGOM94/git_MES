package gom.service;

import java.util.List;
import java.util.Map;

import gom.vo.M100VO;

public interface M100Service {

	//재고 추가시 Details도 같이 추가
	public void M1001020_3_Data_controll (List<Map<String, Object>> list) throws Exception;
	
	//입고처리시 재고에 마주처서 환산한 값을 구해옴
	public M100VO item_sandData (Map<String, Object> map) throws Exception;
	
	//거래처별 제품 콤보박스 데이터로 가져오기
	public Map<String, Object> get_item_CD_ComBo(Map<String, Object> map) throws Exception;
}
