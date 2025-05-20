package gom.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gom.dao.M310DAO;
import gom.service.CommonService;
import gom.service.M310Service;
import gom.vo.M100VO;
import gom.vo.M310VO;

@Service(value = "M310Service")
public class M310Serviceimpl implements M310Service{

	//M210DAO 가져오기
	@Resource(name = "M310DAO")
	private M310DAO m310DAO;
	
	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;

	//수주내용 저장시 배차 자동등록
	@Override
	public void M3101010_2_Insert2 (String comp_CD) {
		m310DAO.M3101010_2_Insert2(comp_CD);
	}
	
	//거래처별 제품 콤보박스 데이터로 가져오기
	@Override
	public Map<String, Object> get_item_CD_ComBo(Map<String, Object> map) throws Exception {
		
		List<M310VO> list = m310DAO.get_item_CD_ComBo(map);
		
		Map<String, Object> value_map = new HashMap<String, Object>();
		String ComboText = "";
		String ComboCode = "";
		
		for (int i = 0; i < list.size(); i++) {
			ComboCode +=  list.get(i).getItem_CD();
			if (i != list.size()-1) ComboCode += "|";
		}
		
		for (int i = 0; i < list.size(); i++) {
			ComboText +=  list.get(i).getItem_NM();
			if (i != list.size()-1) ComboText += "|";
		}
		
		value_map.put("ComboCode", ComboCode);
		value_map.put("ComboText", ComboText);
		
		return value_map;
	}
}
