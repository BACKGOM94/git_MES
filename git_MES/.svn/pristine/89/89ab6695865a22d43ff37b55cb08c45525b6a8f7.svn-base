package gom.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gom.dao.M990DAO;
import gom.service.M990Service;
import gom.vo.M990VO;

@Service(value = "M990Service")
public class M990Serviceimpl implements M990Service{

	//m990DAO 가져오기
	@Resource(name = "M990DAO")
	private M990DAO m990DAO;

	//회사 가입시 회사계정 하나 같이 만들기 위한 함수
	@Override
	public void M9901010_1_Insert2(List<Map<String, Object>> list) throws Exception {
		m990DAO.M9901010_1_Insert2(list);
	}
	
	//회사 권한 수정시 먼저 기존에 있던 데이터 삭제해주는 함수
	@Override
	public void M9901010_2_Insert2(List<Map<String, Object>> list) throws Exception {
		m990DAO.M9901010_2_Insert2(list);
	}
	
	//회사 권한 수정시 COM등급 회원 권한 수정
	@Override
	public void M9901010_2_Insert3(List<Map<String, Object>> list) throws Exception {
		m990DAO.M9901010_2_Insert3(list);
		
	}
	
	//kpi 데이터를 가져오기 위한 함수
	@Override
	public M990VO get_Kpi_data(Map<String, Object> map) throws Exception {	
		return m990DAO.get_Kpi_data(map);
	}
}
