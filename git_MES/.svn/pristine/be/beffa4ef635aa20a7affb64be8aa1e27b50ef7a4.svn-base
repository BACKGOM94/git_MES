package gom.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository(value = "M980DAO")
public class M980DAO extends EgovAbstractDAO {

	//코드마스터 새로 생성시 코드 생성 
	public String make_category_CD(Map<String , Object> map) throws Exception {
		return (String)select("M980DAO.make_category_CD",map);
	}
	
	//회원 비밀번호 변경
	public void M9808010_1_Insert2 (Map<String, Object> map) throws Exception {
		update("M980DAO.M9808010_1_Insert2",map);
	}

	//제품 삭제시 BOM 안에있는 동일제품 삭제
	public void M9801010_1_Delete2(Map<String, Object> map) throws Exception {
		delete("M980DAO.M9801010_1_Delete2",map);	
	}
	
	//BOM 추가 전 기존에 있던것들을 제거
	public void M9801020_2_Delete (Map<String, Object> map) throws Exception {
		delete("M980DAO.M9801020_2_Delete",map);
	}

	//회원 권한 등록전에 현재 가지고있는 권한을 모두 제거
	public void M9808010_2_insert2(Map<String, Object> map) throws Exception{
		delete("M980DAO.M9808010_2_Insert2",map);		
	}

	//공정 디테일 등록전 기존에 있던 데이터들 삭제
	public void M9801030_2_delete(Map<String, Object> map) throws Exception {
		delete("M980DAO.M9801030_2_Delete",map);
	}
	
	//차량 디테일 기존에있던 데이터 삭제후 다시 추가
	public void M9805030_2_Insert2(Map<String, Object> map) throws Exception {
		delete("M980DAO.M9805030_2_Insert2",map);
	}
	
}
