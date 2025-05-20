package gom.dao;

import java.util.List;
import java.util.Map;

import org.apache.poi.ss.formula.functions.Replace;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import gom.vo.CommonVO;
import gom.vo.MenuVO;
import gom.vo.UserVO;

@SuppressWarnings({"unchecked","rawtypes"})
@Repository(value = "CommonDAO")
public class CommonDAO extends EgovAbstractDAO{
	
	//로그인을 위한 함수
	public UserVO actionLogin(CommonVO commonVO) throws Exception {
		return (UserVO) select("CommonDAO.actionLogin", commonVO);
	}
	
	//접속로그를 남기기 위한 함수
	public void make_log(CommonVO commonVO) throws Exception {
		insert("CommonDAO.make_log", commonVO);
	}
	
	//상단 메뉴 리스트 가져오기
	public List<MenuVO> get_Top_menu(CommonVO commonVO) throws Exception {
		return (List<MenuVO>) list("CommonDAO.get_Top_menu",commonVO);
	}
	
	//좌측 메뉴 리스트 가져오기
	public List<MenuVO> get_Left_menu(CommonVO commonVO) throws Exception {
		return (List<MenuVO>) list("CommonDAO.get_Left_menu",commonVO);
	}

	//각 페이지 이동시 권한 있는지 확인	
	public int security(CommonVO commonVO) throws Exception {
		return (int)select("commonDAO.security", commonVO);
	}
	
	//비밀번호 변경시 비밀번호 확인
	public int check_pwdChange(Map<String, Object> map) throws Exception {
		return (int)select("commonDAO.check_pwdChange",map);
	}
	
	//비밀번호 변경시 비밀번호 확인후 변경
	public void action_pwdChange(Map<String, Object> map) throws Exception {
		update ("commonDAO.action_pwdChange",map);
	}
	
	//코드를 만들기 위한 함수
	public String make_CD(Map<String, Object> map) throws Exception {
		String value = "";
	
		switch (map.get("unionKey").toString()) {
		case "COM": value = (String)select("commonDAO.make_comp_CD");
			break;
		case "ITE" : value = (String)select("commonDAO.make_item_CD",map);
			break;
		case "EQU" : value = (String)select("commonDAO.make_equi_CD",map);
			break;
		case "CLI" : value = (String)select("commonDAO.make_clie_CD",map);
			break;
		case "PRO" : value = (String)select("commonDAO.make_proc_CD",map);
			break;
		case "WOR" : value = (String)select("commonDAO.make_work_CD",map);
			break;
		case "ORD" : value = (String)select("commonDAO.make_orde_CD",map);
			break;
		case "INV" : value = (String)select("commonDAO.make_inve_CD",map);
			break;
		case "MAN" : value = (String)select("commonDAO.make_manu_CD",map);
			break;
		case "VEH" : value = (String)select("commonDAO.make_vehi_CD",map);
			break;
		case "SAL" : value = (String)select("commonDAO.make_sale_CD",map);
			break;
		case "I97" : value = (String)select("commonDAO.make_I97_CD",map);
			break;
		case "C97" : value = (String)select("commonDAO.make_C97_CD",map);
			break;
		case "L97" : value = (String)select("commonDAO.make_L97_CD",map);
			break;
		case "E97" : value = (String)select("commonDAO.make_E97_CD",map);
			break;
		case "D97" : value = (String)select("commonDAO.make_D97_CD",map);
			break;
		case "X97" : value = (String)select("commonDAO.make_X97_CD",map);
			break;
		default:
			break;
		}
		
		return value;
	}
	
	//View페이지를 처리해주는 함수
	public List Data_View(Map<String, Object> map) throws Exception {	
		String queryId = map.get("sheetNm").toString().substring(0, 4) + "DAO." + map.get("sheetNm").toString().replace("Sheet","View");
		return (List) list(queryId,map);
	}
		
	//CRUD를 처리해주는 함수
	public void Data_Change(List<Map<String, Object>> list) throws Exception {			
		
		String queryId = "";		
		for (int i = 0; i < list.size(); i++) {		
			if (list.get(i).get("sStatus").toString().equals("D")) { 
				queryId = list.get(i).get("sheetNm").toString().substring(0, 4) + "DAO." + list.get(i).get("sheetNm").toString().replace("Sheet","Delete");
				delete(queryId,list.get(i));
			} else {
				queryId = list.get(i).get("sheetNm").toString().substring(0, 4) + "DAO." + list.get(i).get("sheetNm").toString().replace("Sheet","Insert");
				insert(queryId,list.get(i));
			}						
		}
	}
	
	//데이터 중복확인
	public String double_Check(Map<String, Object> map) throws Exception {
		String queryId = "commonDAO.double_Check_" + map.get("col_NM").toString();
		return (String)select(queryId,map);
	}
	
	//카테고리 데이터 가져오기
	public List<CommonVO> IBSheet_select_category_Data(Map<String, Object> map) throws Exception {
		return (List<CommonVO>) list("commonDAO.category_Data",map);
	}
	
	//카테고리 데이터 가져오기
	public String IBSheet_combo_category_Data(Map<String, Object> map) throws Exception {
		
		String value = "'ComboText':'";
		
		List<CommonVO> list = (List<CommonVO>)list("commonDAO.category_Data",map);
		
		for (int i = 0; i < list.size(); i++) {
			value += list.get(i).getSome_NM();
			
			if (i != list.size()-1) value += "|";
		}
		
		value += "','ComboCode':'";
		
		for (int i = 0; i < list.size(); i++) {
			value += list.get(i).getSome_CD();
			
			if (i != list.size()-1) value += "|";
		}
		
		value += "'";

		return value;
	}
	
	//데이터 변경시 다른데이터의 콤보박스 자동 변경
	public List<CommonVO> set_data_combo(Map<String, Object> map) {
		String queryId = "commonDAO.set_data_combo_" + map.get("unique_Key").toString();
		return (List<CommonVO>) list(queryId,map);
	}
	
	//데이터값에 따른 다른 데이터 변경시 데이터 가져오는 함수
	public List<CommonVO> set_data(Map<String, Object> map) {
		String queryId = "commonDAO.get_data_" + map.get("Master_NM").toString();
		return (List<CommonVO>) list(queryId,map);
	}
	
	//IBSheet 마스터데이터 이름들을 셀렉박스데이터를 만들기위한 함수 
	public List<CommonVO> IBSheet_select_data_master(Map<String, Object> map) throws Exception {
	
		String queryId = "commonDAO.IBSheet_" + map.get("col_name");
		return (List<CommonVO>)list(queryId,map);
	}
	
	//IBSheet 마스터데이터 이름들을 콤보박스데이터를 만들기위한 함수 
	public String IBSheet_combo_data_master(Map<String, Object> map) throws Exception {
	
		String value = "'ComboText':'";
		
		String queryId = "commonDAO.IBSheet_" + map.get("col_name");
		List<CommonVO> list = (List<CommonVO>)list(queryId,map);
	
		for (int i = 0; i < list.size(); i++) {
			
			value += list.get(i).getSome_NM().replace("'", "&#39;");						
			
			if (i != list.size()-1) value += "|";
		}
		
		value += "','ComboCode':'";
		
		for (int i = 0; i < list.size(); i++) {
			value += list.get(i).getSome_CD();
			
			if (i != list.size()-1) value += "|";
		}
		
		value += "'";

		value = value.replaceAll("\"","&quot;");

		return value;
	}

}
