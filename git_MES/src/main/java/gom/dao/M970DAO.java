package gom.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import gom.vo.M970VO;

@SuppressWarnings("unchecked")
@Repository(value = "M970DAO")
public class M970DAO extends EgovAbstractDAO {

	//M9701020_1_View
	public List<M970VO> M9701020_1_View (String comp_CD) {
		return (List<M970VO>) list("M970DAO.M9701020_1_View",comp_CD);
	}
	
	//M9709030_2_Delete
	public void M9709030_2_Delete (Map<String, Object> map) {
		delete("M970DAO.M9709030_2_Delete",map);
	}
	//equi_CD 변환시 equi_location 반환
	public String get_equi_location(Map<String, Object> map) {
		return (String)select("M970DAO.get_equi_location",map);
	}

	public M970VO Lot_Change(Map<String, Object> map) {
		return (M970VO) select("M970DAO.Lot_Change",map);
	}

	
}
