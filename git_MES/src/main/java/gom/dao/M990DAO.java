package gom.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import gom.vo.M990VO;

@Repository(value = "M990DAO")
public class M990DAO extends EgovAbstractDAO {

	//회사 가입시 회사계정 하나 같이 만들기 위한 함수
	public void M9901010_1_Insert2 (List<Map<String, Object>> list) throws Exception {
		
		for (int i = 0; i < list.size(); i++) {
			
			if (!list.get(i).get("sStatus").toString().equals("D")) {
				if (list.get(i).get("memb_PW").toString() == "") insert("M990DAO.M9901010_1_Insert3",list.get(i)); 
				else 	insert("M990DAO.M9901010_1_Insert2",list.get(i));	
			}
		}
	}
	
	//회사 권한 수정시 먼저 기존에 있던 데이터 삭제해주는 함수
	public void M9901010_2_Insert2 (List<Map<String, Object>> list) throws Exception {
		delete("M990DAO.M9901010_2_Insert2",list.get(0));	
	}

	//회사 권한 수정시 COM등급 회원 권한 수정
	public void M9901010_2_Insert3 (List<Map<String, Object>> list) throws Exception {
		for (int i = 0; i < list.size(); i++) {
			if(!(list.get(i).get("sStatus").toString().equals("D"))) insert("M990DAO.M9901010_2_Insert3",list.get(i));
		}	
	}
	
	//KPI 정보 확인시 데이터 가져오기
	public M990VO get_Kpi_data (Map<String, Object> map ) throws Exception {
		return (M990VO) select("M990DAO.get_Kpi_data", map);	
	}
	
}
