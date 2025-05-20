package gom.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;

import gom.dao.M970DAO;
import gom.service.CommonService;
import gom.service.M970Service;
import gom.vo.M970VO;

@Service(value = "M970Service")
public class M970Serviceimpl implements M970Service {

	//m970DAO 가져오기
	@Resource(name = "M970DAO")
	private M970DAO m970DAO;
	
	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	//M9709030_2_Delete
	@Override
	public void M9709030_2_Delete(Map<String, Object> map) throws Exception {
		Map<String, Object> map2 = new HashMap<String, Object>();
		
		map2.put("comp_CD",commonService.user_info().getComp_CD());
		
		String [] data_String = map.get("item_CD_97").toString().split("‡");
		
		map2.put("item_CD_97",data_String[0]);
		
		m970DAO.M9709030_2_Delete(map2);
	}
	
	//Lot 변경시 Lot 타입에 맞는 데이터 가져오기
	@Override
	public M970VO Lot_Change(Map<String, Object> map) throws Exception {
		return m970DAO.Lot_Change(map);
	}
}
