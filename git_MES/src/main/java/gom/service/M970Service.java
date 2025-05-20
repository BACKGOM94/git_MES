package gom.service;

import java.util.Map;

import gom.vo.M970VO;

public interface M970Service {

	//M9709030_2_Delete
	public void M9709030_2_Delete (Map<String, Object> map) throws Exception;
	
	//Lot 변경시 Lot 타입에 맞는 데이터 가져오기
	public M970VO Lot_Change(Map<String, Object> map) throws Exception;
}
