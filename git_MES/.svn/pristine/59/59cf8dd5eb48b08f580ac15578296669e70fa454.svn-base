package gom.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gom.dao.M100DAO;
import gom.service.CommonService;
import gom.service.M100Service;
import gom.vo.M100VO;

@Service(value = "M100Service")
public class M100Serviceimpl implements M100Service{

	//m100DAO 가져오기
	@Resource(name = "M100DAO")
	private M100DAO m100DAO;
	
	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	//재고 추가시 Details도 같이 추가
	@Override
	public void M1001020_3_Data_controll(List<Map<String, Object>> list) throws Exception {		
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).put("comp_CD",commonService.user_info().getComp_CD());
		}
		
		m100DAO.M1001020_3_Data_controll(list);	
	}
	
	//입고처리시 재고에 마주처서 환산한 값을 구해옴
	@Override
	public M100VO item_sandData(Map<String, Object> map) throws Exception {
		return m100DAO.item_sandData(map);
	}
	
	//거래처별 제품 콤보박스 데이터로 가져오기
	@Override
	public Map<String, Object> get_item_CD_ComBo(Map<String, Object> map) throws Exception {
		
		List<M100VO> list = m100DAO.get_item_CD_ComBo(map);
		
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
