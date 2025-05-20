package gom.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.access.service.EgovUserDetailsHelper;
import gom.dao.CommonDAO;
import gom.service.CommonService;
import gom.vo.CommonVO;
import gom.vo.MenuVO;
import gom.vo.UserVO;

@SuppressWarnings("rawtypes")
@Service(value = "CommonService")
public class CommonServiceimpl implements CommonService{
	
	@Resource(name = "CommonDAO")
	private CommonDAO commonDAO;
	
	//로그 사용을 위한 Logger객체 생성
	private static final Logger LOG = LoggerFactory.getLogger(CommonServiceimpl.class);
	
	//로그 사용을 위한 함수
	@Override
	public void log(String log){
		LOG.debug(log);
	}
	
	//로그인을 위한 함수
	@Override
	public UserVO actionLogin(CommonVO commonVO) throws Exception {
		return commonDAO.actionLogin(commonVO);
	}
	
	//로그인 중인 회원 정보를 가져옴
	@Override
	public UserVO user_info() {
		return (UserVO)EgovUserDetailsHelper.getAuthenticatedUser();
	}
	
	//접속로그를 남기기 위한 함수
	@Override
	public void make_log(CommonVO commonVO) throws Exception {
		commonDAO.make_log(commonVO);
	}
	
	//권한에 맞는 Top 메뉴를 가져온다
	@Override
	public List<MenuVO> get_Top_menu(CommonVO commonVO) throws Exception {
		return commonDAO.get_Top_menu(commonVO);
	}
	
	//권한에 맞는 Left 메뉴를 가져온다
	@Override
	public List<MenuVO> get_Left_menu(CommonVO commonVO) throws Exception {
		return commonDAO.get_Left_menu(commonVO);
	}
	
	//각페이지 이동시 권한이 있는지 여부 체크
	@Override
	public ModelAndView security(ModelAndView mav) throws Exception {

		UserVO userVO = EgovUserDetailsHelper.isAuthenticated() ? (UserVO)EgovUserDetailsHelper.getAuthenticatedUser() : null;

		if(EgovUserDetailsHelper.isAuthenticated() && userVO != null) {

			CommonVO commonVO = new CommonVO();
			commonVO.setComp_CD(userVO.getComp_CD());
			commonVO.setMemb_ID(userVO.getMemb_ID());
			commonVO.setPgmURL(mav.getViewName().substring(0, 14) + ".do");
			
			if (commonDAO.security(commonVO) == 1) {

				mav.addObject("comp_CD", userVO.getComp_CD());
				LOG.debug("Security authentication successful Go to " + mav.getViewName());	
			} else {		
				LOG.debug("Security authentication failure");	
				mav.setViewName("/Common/LoginPage");
			}			
		}else {
			LOG.debug("Security authentication failure");
			mav.setViewName("/Common/LoginPage");	
		}
		
		return mav;
		
	}
	
	//Data_View
	@Override
	public List Data_View(Map<String, Object> map) throws Exception {
		if (map.get("comp_CD") == null) map.put("comp_CD", user_info().getComp_CD());	
		return commonDAO.Data_View(map);
	}
	
	//Data_Change
	@Override
	public void Data_Change(List<Map<String, Object>> list) throws Exception {
		
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).get("comp_CD") == null || list.get(i).get("comp_CD").toString() == "") list.get(i).put("comp_CD", user_info().getComp_CD());
		}
		commonDAO.Data_Change(list);
	}
	
	//비밀번호 변경시 비밀번호 확인	
	@Override
	public int check_pwdChange(Map<String, Object> map) throws Exception {
		return commonDAO.check_pwdChange(map);
	}

	//비밀번호 변경시 비밀번호 확인후 변경
	@Override
	public void action_pwdChange(Map<String, Object> map) throws Exception {
		commonDAO.action_pwdChange(map);
	}
	
	//코드를 만들기 위한 함수
	@Override
	public String make_CD(String unionKey) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("comp_CD", user_info().getComp_CD());
		map.put("unionKey", unionKey);
		return commonDAO.make_CD(map);
	}
	
	//데이터 중복 확인
	@Override
	public String double_Check(Map<String, Object> map) throws Exception {
		return commonDAO.double_Check(map);
	}
	
	//카테고리 데이터 가져오기
	@Override
	public List<CommonVO> IBSheet_select_category_Data(int category_CD) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("comp_CD", user_info().getComp_CD());
		map.put("category_CD", category_CD);
		return commonDAO.IBSheet_select_category_Data(map);
	}
	
	//데이터 변경시 다른데이터의 콤보박스 자동 변경
	@Override
	public List<CommonVO> set_data_combo(Map<String, Object> map) throws Exception {
		return commonDAO.set_data_combo(map);
	}
	
	//데이터값에 따른 다른 데이터 변경시 데이터 가져오는 함수
	@Override
	public List<CommonVO> set_data(Map<String, Object> map) throws Exception {
		return commonDAO.set_data(map);
	}
	
	//IBSheet Data 저장을 위해 데이터모양을 DB에 넣을수 있게 변환시켜준다
	@Override
	public List<Map<String, Object>> IBSheet_Data_Converstion(Map<String, Object> map) {

		int datacount = map.get("sStatus").toString().split("‡").length;

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		for (int i = 0; i < datacount; i++) {
			Map<String, Object> data = new HashMap<String,Object>();
			for(String key : map.keySet()) {
				if (!key.equals("sheetNm")) {
					String [] data_String = map.get(key).toString().split("‡");
					data.put(key, data_String[i].trim());
				}
			}
			data.put("sheetNm", map.get("sheetNm"));
			list.add(data);
		}

		return list;
	}
	
	//IBSheet 마스터데이터 이름들을 셀렉박스데이터를 만들기위한 함수 
	public List<CommonVO> IBSheet_select_data_master(Map<String, Object> map) throws Exception {
		return commonDAO.IBSheet_select_data_master(map);
	}
	
	//IBSheet column을 매개변수에 따라 맞춰서 제작한다
	@Override
	public String IBSheet_col(String col_name, int col_size, Boolean hidden, Boolean keyField, Boolean Edit)
			throws Exception {
		
		String value = "";
		String combo_value = "";
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("col_name", col_name);
		map.put("comp_CD", user_info().getComp_CD());
		
		switch (col_name) {
		//발주 관련
		case "orde_CD":
			value = "{'Header':'발주 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "quantity":
			value = "{'Header':'수량','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "order_price":
			value = "{'Header':'단가','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "supply_price":
			value = "{'Header':'공급가액','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "tax_price":
			value = "{'Header':'세액','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "total_price":
			value = "{'Header':'총 금액','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "order_DT":
			value = "{'Header':'발주일자','Type': 'Date','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "complete_FL":
			value = "{'Header':'완료여부','Type': 'CheckBox','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "in_quantity":
			value = "{'Header':'입고 수량','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "out_quantity":
			value = "{'Header':'출고 수량','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "re_quantity":
			value = "{'Header':'반품 수량','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
			
		//생산관련
		case "manu_CD":
			value = "{'Header':'생산 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;			
		case "manu_DT":
			value = "{'Header':'생산 일자','Type': 'Date','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "use_quantity":
			value = "{'Header':'사용 수량','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
			
		//수주 관련
		case "sale_CD":
			value = "{'Header':'수주 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;	
		case "disp_CD":
			value = "{'Header':'배차 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;	
		case "sale_DT":
			value = "{'Header':'수주 일자','Type': 'Date','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "sale_price":
			value = "{'Header':'단가','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "set_item_FL":
			value = "{'Header':'적재여부','Type': 'CheckBox','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "vehi_DT":
			value = "{'Header':'수주 일자','Type': 'Date','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
			
		//재고관련
		case "inve_CD":
			value = "{'Header':'재고 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "befor_CD":
			value = "{'Header':'이전 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "move_DT":
			value = "{'Header':'이동일자','Type': 'Date','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
			
		//제품 관련
		case "item_CD":
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'제품 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'item_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "item_CD_Tree":
			map.put("col_name", "item_CD");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'제품 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'item_sub_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + ",'TreeCol':'1'}";
			break;
		case "item_CD_Tree2":
			map.put("col_name", "item_CD");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'제품 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'item_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + ",'TreeCol':'1'}";
			break;
		case "item_NM":
			value = "{'Header':'제품 명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "order_unit_C":
			map.put("category_CD", "980001");
			combo_value = commonDAO.IBSheet_combo_category_Data(map);
			value = "{'Header':'주문 단위','Type': 'Combo','Width':"+ col_size +",'SaveName':'order_unit_C','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "exchange_value":
			value = "{'Header':'환산계수','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "inventory_unit_C":
			map.put("category_CD", "980001");
			combo_value = commonDAO.IBSheet_combo_category_Data(map);
			value = "{'Header':'재고 단위','Type': 'Combo','Width':"+ col_size +",'SaveName':'inventory_unit_C','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "inventory_item_CD":
			value = "{'Header':'재고 제품코드','Type': 'Text','Width':"+ col_size +",'SaveName':'inventory_item_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "tax_FL":
			value = "{'Header':'세금여부','Type': 'CheckBox','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "item_group_C":
			map.put("category_CD", "980002");
			combo_value = commonDAO.IBSheet_combo_category_Data(map);
			value = "{'Header':'품목군','Type': 'Combo','Width':"+ col_size +",'SaveName':'item_group_C','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "barcode":
			value = "{'Header':'바코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "price":
			value = "{'Header':'단가','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "standard":
			value = "{'Header':'규격','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "use_order":
			value = "{'Header':'주문여부','Type': 'CheckBox','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "use_production":
			value = "{'Header':'생산여부','Type': 'CheckBox','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "use_sale":
			value = "{'Header':'판매여부','Type': 'CheckBox','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "need_count":
			value = "{'Header':'소요량','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "loss_rate":
			value = "{'Header':'손실률','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "real_need_count":
			value = "{'Header':'실소요량','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "proc_CD":
			value = "{'Header':'공정코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "proc_NM":
			value = "{'Header':'공정명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "work_CD":
			value = "{'Header':'작업장코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "work_NM":
			value = "{'Header':'작업장명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "proc_CD_combo":
			map.put("col_name", "proc_CD");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'공정 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'proc_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;	
		case "work_CD_combo":
			map.put("col_name", "work_CD");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'작업장 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'work_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;	
		case "work_SQ":
			value = "{'Header':'작업순번','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;

		//거래처 관련
		case "clie_CD":
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'거래처 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'clie_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;	
		case "clie_CD_order":
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'거래처 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'clie_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;	
		case "clie_CD_sale":
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'거래처 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'clie_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;	
		case "clie_NM":
		value = "{'Header':'거래처 명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "manager_NM":
			value = "{'Header':'담당자명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;		
		case "manager_phone_NO":
			value = "{'Header':'연락처','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Format':'###-####-####','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "enter_FL":
			value = "{'Header':'입고처여부','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "exit_FL":
			value = "{'Header':'출고처여부','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
			
		//차량 관련
		case "vehi_CD":
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'차량코드','Type': 'Combo','Width':"+ col_size +",'SaveName':'vehi_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;				
		case "vehi_NO":
			value = "{'Header':'차량번호','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;		
		case "vehi_kind_C":
			map.put("category_CD", "980007");
			combo_value = commonDAO.IBSheet_combo_category_Data(map);
			value = "{'Header':'차량종류','Type': 'Combo','Width':"+ col_size +",'SaveName':'vehi_kind_C','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "race_seq":
			value = "{'Header':'배송순서','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
			
		//설비 관련
		case "equi_CD":
			value = "{'Header':'설비코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "equi_CD_combo":
			map.put("col_name", "equi_CD");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'설비 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'equi_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "equi_NM":
			value = "{'Header':'설비명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "equi_location":
			value = "{'Header':'설비 위치','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "equi_standard":
			value = "{'Header':'설비 규격','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "view_spot":
			value = "{'Header':'위치','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "target_CT":
			value = "{'Header':'목표 수량','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "cycle":
			combo_value = "'ComboCode' : '1|2|3','ComboText':'일|주|월'";
			value = "{'Header':'주기','Type': 'Combo','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "last_DT":
			value = "{'Header':'최근작업 일자','Type': 'Date','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "last_TM":
			value = "{'Header':'최근작업 시간','Type': 'Time','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "total_make":
			value = "{'Header':'총 생산량','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "total_error":
			value = "{'Header':'총 불량량','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "error_percent":
			value = "{'Header':'불량 비율','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "check_DT":
			value = "{'Header':'측정날짜','Type': 'Date','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "check_TM":
			value = "{'Header':'측정시간','Type': 'Time','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "error_FL":
			combo_value = "'ComboCode' : '0|1','ComboText':'정상|불량'";
			value = "{'Header':'불량여부','Type': 'Combo','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "ing_time":
			value = "{'Header':'가동시간','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "send_DTTM":
			value = "{'Header':'전송일자','Type': 'DateTime','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "kpiFld_CD":
			value = "{'Header':'성과지표구분코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "kpiDtl_CD":
			value = "{'Header':'세부성과지표코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "value":
			value = "{'Header':'측정값','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "rate":
			value = "{'Header':'달성률','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "befor_CT":
			value = "{'Header':'현재값','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "taget_CT":
			value = "{'Header':'목표값','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "unit":
			value = "{'Header':'단위','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "improvement_rate":
			value = "{'Header':'향상률','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "achievement_rate":
			value = "{'Header':'달성률','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;

		//회원 관련
		case "memb_ID":
			value = "{'Header':'아이디','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "memb_PW":
			value = "{'Header':'패스워드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "memb_NM":
			value = "{'Header':'회원 이름','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "memb_rating":
			value = "{'Header':'회원 등급','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "birthdate_DT":
			value = "{'Header':'생일','Type': 'Date','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "phone_NO":
			value = "{'Header':'연락처','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Format':'###-####-####','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "rank_GB":
			map.put("category_CD", "980003");
			combo_value = commonDAO.IBSheet_combo_category_Data(map);
			value = "{'Header':'직급','Type': 'Combo','Width':"+ col_size +",'SaveName':'rank_GB','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "work_type_GB":
			map.put("category_CD", "980004");
			combo_value = commonDAO.IBSheet_combo_category_Data(map);
			value = "{'Header':'직무','Type': 'Combo','Width':"+ col_size +",'SaveName':'work_type_GB','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "sex_GB":
			map.put("category_CD", "980005");
			combo_value = commonDAO.IBSheet_combo_category_Data(map);
			value = "{'Header':'성별','Type': 'Combo','Width':"+ col_size +",'SaveName':'sex_GB','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "memb_status_GB":
			map.put("category_CD", "980006");
			combo_value = commonDAO.IBSheet_combo_category_Data(map);
			value = "{'Header':'회원상태','Type': 'Combo','Width':"+ col_size +",'SaveName':'memb_status_GB','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
			
		//코드 관련
		case "category_CD":
			value = "{'Header':'대분류 명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;	
		case "sub_category_CD":
			value = "{'Header':'소분류 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;	
		case "sub_category_NM":
			value = "{'Header':'소분류 명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;	
			
		//회사 관련
		case "comp_CD":
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'회사 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'comp_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "comp_ko_NM":
			value = "{'Header':'한글 회사명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "comp_en_NM":
			value = "{'Header':'영어 회사명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "join_DT":
			value = "{'Header':'가입일','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "leader_NM":
			value = "{'Header':'대표자명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;		
		case "leader_phone_NO":
			value = "{'Header':'연락처','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Format':'###-####-####','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "address":
			value = "{'Header':'주소','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "address_detail":
			value = "{'Header':'상세주소','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "email":
			value = "{'Header':'이메일','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "memo":
			value = "{'Header':'비고','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		
		//메뉴 관련
		case "menu_CD_Tree":
			map.put("col_name", "menu_CD");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'메뉴 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'menu_CD','Align':'left','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + ",'TreeCol':'1'}";
			break;
		case "upp_menu_CD":
			map.put("col_name", "menu_CD");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'메뉴 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'upp_menu_CD','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "auth":
			value = "{'Header':'권한','Type': 'CheckBox','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
			
		//97(재돈) 관련
		case "color_CD_97":
			value = "{'Header':'색상 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "color_NM_97":
			value = "{'Header':'색상 명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "item_CD_97":
			value = "{'Header':'아이템 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "item_NM_97":
			value = "{'Header':'아이템 명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "client_CD_97":
			value = "{'Header':'거래처 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "client_NM_97":
			value = "{'Header':'거래처 명','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "contact_97":
			value = "{'Header':'연락처','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "phone_NO_97":
			value = "{'Header':'전화번호','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "account_NO":
			value = "{'Header':'계좌번호','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "yesterday_inventory":
			value = "{'Header':'전일재고','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "inventory":
			value = "{'Header':'재고','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;			
		case "enter_FL_97":
			value = "{'Header':'발주처 여부','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "exit_FL_97":
			value = "{'Header':'출고처 여부','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "supply_FL_97":
			value = "{'Header':'공급처 여부','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "lot_CD_97":
			value = "{'Header':'Lot 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "lot_NM_97":
			value = "{'Header':'Lot 번호','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "lot_CD_97_combo":
			map.put("col_name", "lot_CD_97");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'Lot 번호','Type': 'ComboEdit','Width':"+ col_size +",'SaveName':'lot_CD_97','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "client_CD_97_combo":
			map.put("col_name", "client_CD_97");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'거래처 명|거래처 명','Type': 'ComboEdit','Width':"+ col_size +",'SaveName':'client_CD_97','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "color_CD_97_combo":
			map.put("col_name", "color_CD_97");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'색상 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'color_CD_97','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "item_CD_97_combo":
			map.put("col_name", "item_CD_97");
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'아이템 명','Type': 'Combo','Width':"+ col_size +",'SaveName':'item_CD_97','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "data_CD_97":
			value = "{'Header':'데이터 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "regist_DT":
			value = "{'Header':'등록 일자','Type': 'Date','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "division":
			combo_value = "'ComboText':'생산|출고|반품|재고조정','ComboCode':'1|2|3|4'";
			value = "{'Header':'구분자','Type': 'Combo','Width':"+ col_size +",'SaveName':'division','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "count_97":
			value = "{'Header':'번수','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "real_order":
			value = "{'Header':'원발주처','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "enter_clie_CD_97":
			combo_value = commonDAO.IBSheet_combo_data_master(map);			
			value = "{'Header':'발주처','Type': 'ComboEdit','Width':"+ col_size +",'SaveName':'enter_clie_CD_97','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "exit_clie_CD_97":
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'출고처','Type': 'ComboEdit','Width':"+ col_size +",'SaveName':'exit_clie_CD_97','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "supply_clie_CD_97":
			combo_value = commonDAO.IBSheet_combo_data_master(map);
			value = "{'Header':'공급처','Type': 'Combo','Width':"+ col_size +",'SaveName':'supply_clie_CD_97','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + "," + combo_value + ",'Edit':" + Edit + "}";
			break;
		case "supply_clie_NM_97":
			value = "{'Header':'공급처','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "exit_CD_97":
			value = "{'Header':'출고 코드','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "box_CT":
			value = "{'Header':'C/T','Type':'Int','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "style_NO":
			value = "{'Header':'style_NO','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "order_NO":
			value = "{'Header':'발주 번호','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b1_in" :
			value = "{'Header':'1월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b1_out" :
			value = "{'Header':'1월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b1_re" :
			value = "{'Header':'1월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b2_in" :
			value = "{'Header':'2월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b2_out" :
			value = "{'Header':'2월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b2_re" :
			value = "{'Header':'2월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b3_in" :
			value = "{'Header':'3월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b3_out" :
			value = "{'Header':'3월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b3_re" :
			value = "{'Header':'3월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b4_in" :
			value = "{'Header':'4월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b4_out" :
			value = "{'Header':'4월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b4_re" :
			value = "{'Header':'4월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b5_in" :
			value = "{'Header':'5월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b5_out" :
			value = "{'Header':'5월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b5_re" :
			value = "{'Header':'5월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b6_in" :
			value = "{'Header':'6월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b6_out" :
			value = "{'Header':'6월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b6_re" :
			value = "{'Header':'6월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b7_in" :
			value = "{'Header':'7월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b7_out" :
			value = "{'Header':'7월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b7_re" :
			value = "{'Header':'7월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b8_in" :
			value = "{'Header':'8월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b8_out" :
			value = "{'Header':'8월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b8_re" :
			value = "{'Header':'8월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b9_in" :
			value = "{'Header':'9월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b9_out" :
			value = "{'Header':'9월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b9_re" :
			value = "{'Header':'9월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b10_in" :
			value = "{'Header':'10월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b10_out" :
			value = "{'Header':'10월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b10_re" :
			value = "{'Header':'10월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b11_in" :
			value = "{'Header':'11월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b11_out" :
			value = "{'Header':'11월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b11_re" :
			value = "{'Header':'11월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b12_in" :
			value = "{'Header':'12월|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b12_out" :
			value = "{'Header':'12월|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b12_re" :
			value = "{'Header':'12월|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_1_in" :
			value = "{'Header':'1분기|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_1_out" :
			value = "{'Header':'1분기|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_1_re" :
			value = "{'Header':'1분기|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_2_in" :
			value = "{'Header':'2분기|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_2_out" :
			value = "{'Header':'2분기|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_2_re" :
			value = "{'Header':'2분기|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_3_in" :
			value = "{'Header':'3분기|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_3_out" :
			value = "{'Header':'3분기|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_3_re" :
			value = "{'Header':'3분기|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_4_in" :
			value = "{'Header':'4분기|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_4_out" :
			value = "{'Header':'4분기|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "b_4_re" :
			value = "{'Header':'4분기|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "to_in" :
			value = "{'Header':'합계|입고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "to_out" :
			value = "{'Header':'합계|출고','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "to_re" :
			value = "{'Header':'합계|반품','Type':'AutoSum','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':" + hidden + ",'KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;

			
		//IBSheet 기본기능
		case "삭제":
			value = "{'Header':'삭제','Type': 'DelCheck','Width':"+ col_size +",'Hidden':'" + hidden + "','KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "삭제_Tree":
			value = "{'Header':'삭제','Type': 'DelCheck','Width':"+ col_size +",'Align':'left','Hidden':'" + hidden + "','KeyField':" + keyField + ",'TreeCol':'1' }";
			break;
		case "상태":
			value = "{'Header':'상태','Type': 'Status','Width':"+ col_size +",'SaveName':'sStatus','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "DummyCheck":
			value = "{'Header':'','Type': 'DummyCheck','Width':"+ col_size +",'SaveName':'chk','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
		case "Level":
			value = "{'Header':'레벨','Type': 'Text','Width':"+ col_size +",'SaveName':'"+ col_name +"','Align':'center','Hidden':'" + hidden + "','KeyField':" + keyField + ",'Edit':" + Edit + "}";
			break;
			
		default:
			break;
		}
		
		return value;
	}
}
