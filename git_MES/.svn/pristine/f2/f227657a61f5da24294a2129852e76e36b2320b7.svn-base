package gom.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gom.dao.M210DAO;
import gom.service.CommonService;
import gom.service.M210Service;
import gom.vo.M100VO;
import gom.vo.M210VO;

@Service(value = "M210Service")
public class M210Serviceimpl implements M210Service{

	//M210DAO 가져오기
	@Resource(name = "M210DAO")
	private M210DAO m210DAO;
	
	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	//제품명 콤보박스 데이터로 가져오기
	@Override
	public Map<String, Object> get_item_CD_ComBo(String comp_CD) throws Exception {
		
		List<M210VO> list = m210DAO.get_item_CD_ComBo(comp_CD);
		
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
	
	//BOM 계산하여 필요한 제품 양을 가져오는 함수
	@Override
	public List<M210VO> make_BOM_Data(Map<String, Object> map) throws Exception {
		return m210DAO.make_BOM_Data(map);
	}
	
	//BOM 계산하여 필요한 제품 양을 가져오는 함수
	@Override
	public List<M210VO> make_BOM_Data2(Map<String, Object> map) throws Exception {
		return m210DAO.make_BOM_Data2(map);
	}
	
}
