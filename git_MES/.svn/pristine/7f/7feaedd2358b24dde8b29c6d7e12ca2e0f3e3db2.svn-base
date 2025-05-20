package gom.service;

import java.util.List;
import java.util.Map;

import org.stringtemplate.v4.compiler.STParser.mapExpr_return;

import gom.vo.M990VO;

public interface M990Service {
	
	//회사 가입시 회사계정 하나 같이 만들기 위한 함수
	public void M9901010_1_Insert2 (List<Map<String, Object>> list) throws Exception ;
	
	//회사 권한 수정시 먼저 기존에 있던 데이터 삭제해주는 함수
	public void M9901010_2_Insert2 (List<Map<String, Object>> list) throws Exception ;
	
	//회사 권한 수정시 COM등급 회원 권한 수정
	public void M9901010_2_Insert3 (List<Map<String, Object>> list) throws Exception ;
	
	//kpi 데이터를 가져오기 위한 함수
	public M990VO get_Kpi_data (Map<String, Object> map) throws Exception ;
}
