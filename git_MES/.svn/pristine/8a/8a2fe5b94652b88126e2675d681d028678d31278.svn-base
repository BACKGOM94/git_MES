package gom.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gom.dao.M980DAO;
import gom.service.CommonService;
import gom.service.M980Service;
import gom.vo.M980VO;

@Service(value = "M980Service")
public class M980Serviceimpl implements M980Service{

	//m980DAO 가져오기
	@Resource(name = "M980DAO")
	private M980DAO m980DAO;
	
	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	
	//코드마스터 새로 생성시 코드 생성 
	@Override
	public String make_category_CD(Map<String, Object> map) throws Exception {
		return m980DAO.make_category_CD(map);
	}
	
	//회원 비밀번호 변경
	@Override
	public void M9808010_1_Insert2(Map<String, Object> map) throws Exception {
		map.put("comp_CD", commonService.user_info().getComp_CD());
		m980DAO.M9808010_1_Insert2(map);
	}
	
	//제품 삭제시 BOM 안에있는 동일제품 삭제
	public void M9801010_1_Delete2(Map<String, Object> map) throws Exception {
		map.put("comp_CD", commonService.user_info().getComp_CD());
		m980DAO.M9801010_1_Delete2(map);
	}
	
	//BOM 추가 전 기존에 있던것들을 제거
	@Override
	public void M9801020_2_delete(Map<String, Object> map) throws Exception {
		m980DAO.M9801020_2_Delete(map);	
	}
	
	//공정 디테일 등록전 기존에 있던 데이터들 삭제
	@Override
	public void M9801030_2_delete(List<Map<String, Object>> list) throws Exception {
		m980DAO.M9801030_2_delete(list.get(0));
	}
	
	//회원 권한 등록전에 현재 가지고있는 권한을 모두 제거
	@Override
	public void M9808010_2_Insert2(Map<String, Object> map) throws Exception {
		map.put("comp_CD", commonService.user_info().getComp_CD());
		m980DAO.M9808010_2_insert2(map);
	}
	
	//차량 디테일 기존에있던 데이터 삭제후 다시 추가
	@Override
	public void M9805030_2_Insert2(Map<String, Object> map) throws Exception {
		m980DAO.M9805030_2_Insert2(map);
		
	}
}
