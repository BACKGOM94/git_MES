package gom.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import gom.vo.M210VO;

@SuppressWarnings("unchecked")
@Repository(value = "M210DAO")
public class M210DAO extends EgovAbstractDAO {

	public List<M210VO> get_item_CD_ComBo(String comp_CD) {
		return (List<M210VO>) list("M210DAO.get_item_CD_ComBo" , comp_CD);
	}
	
	public List<M210VO> make_BOM_Data(Map<String, Object> map) {
		return (List<M210VO>) list("M210DAO.make_BOM_Data" , map);
	}
	
	public List<M210VO> make_BOM_Data2(Map<String, Object> map) {
		return (List<M210VO>) list("M210DAO.make_BOM_Data2" , map);
	}

}
