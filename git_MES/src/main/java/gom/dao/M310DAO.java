package gom.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import gom.vo.M310VO;

@SuppressWarnings("unchecked")
@Repository(value = "M310DAO")
public class M310DAO extends EgovAbstractDAO {

	//수주내용 저장시 배차 자동등록
	public void M3101010_2_Insert2 (String comp_CD) {
		update("M310DAO.M3101010_2_Insert2",comp_CD);
	}

	//거래처별 제품 콤보박스 데이터로 가져오기
	public List<M310VO> get_item_CD_ComBo(Map<String, Object> map) {
		return (List<M310VO>) list("M310DAO.get_item_CD_ComBo" , map);
	}
	
}
