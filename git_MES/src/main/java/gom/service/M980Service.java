package gom.service;

import java.util.List;
import java.util.Map;

import gom.vo.M980VO;

public interface M980Service {

	//코드마스터 새로 생성시 코드 생성 
	public String make_category_CD(Map<String , Object> map) throws Exception;
	
	//회원 비밀번호 변경
	public void M9808010_1_Insert2 (Map<String, Object> map) throws Exception;

	//제품 삭제시 BOM 안에있는 동일제품 삭제
	public void M9801010_1_Delete2(Map<String, Object> map) throws Exception;
	
	//BOM 추가 전 기존에 있던것들을 제거
	public void M9801020_2_delete (Map<String, Object> map) throws Exception;

	//공정 디테일 등록전 기존에 있던 데이터들 삭제
	public void M9801030_2_delete(List<Map<String, Object>> list) throws Exception;
	
	//회원 권한 등록전에 현재 가지고있는 권한을 모두 제거
	public void M9808010_2_Insert2(Map<String, Object> map) throws Exception;

	//차량 디테일 기존에있던 데이터 삭제후 다시 추가
	public void M9805030_2_Insert2(Map<String, Object> map) throws Exception;
	
}
