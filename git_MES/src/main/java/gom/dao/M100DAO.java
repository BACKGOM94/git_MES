package gom.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import gom.vo.M100VO;

@SuppressWarnings("unchecked")
@Repository(value = "M100DAO")
public class M100DAO extends EgovAbstractDAO {

	//재고 추가시 Details도 같이 추가후 발주목록에서 해당 발주 완료
	public void M1001020_3_Data_controll (List<Map<String, Object>> list) {
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).get("sStatus").toString().equals("I")) {
				insert("M100DAO.M1001020_3_Insert2",list.get(i));
				update("M100DAO.M1001020_3_Insert3",list.get(i));	
			}else if (list.get(i).get("sStatus").toString().equals("D")) update("M100DAO.M1001020_3_Delete2",list.get(i));	
		}
	}
	
	//입고처리시 재고에 마주처서 환산한 값을 구해옴
	public M100VO item_sandData (Map<String, Object> map) {
		return (M100VO) select("M100DAO.item_sandData",map);
	}

	//거래처별 제품 콤보박스 데이터로 가져오기
	public List<M100VO> get_item_CD_ComBo(Map<String, Object> map) {
		return (List<M100VO>) list("M100DAO.get_item_CD_ComBo" , map);
	}
}
