package gom.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import gom.service.CommonService;
import gom.service.M100Service;

@Controller(value = "/M100")
public class M100Controller {
	
	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	//M980Service 서비스
	@Resource(name = "M100Service")
	private M100Service m100Service;
	
	//M1001010 으로 이동하는 함수
	@RequestMapping("/M100/M1001010.do")
	public ModelAndView M1001010(ModelAndView mav) throws Exception {
			
		//M1001010_1_Sheet 컬럼 만들기
		String M1001010_1_Sheet = "["; 

		M1001010_1_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M1001010_1_Sheet += commonService.IBSheet_col("상태", 20,false,false,false) + ",";
		M1001010_1_Sheet += commonService.IBSheet_col("orde_CD", 40,true,false,false) + ",";
		M1001010_1_Sheet += commonService.IBSheet_col("clie_CD_order", 60,false,true,true) + ",";
		M1001010_1_Sheet += commonService.IBSheet_col("manager_NM", 60,false,false,false) + ",";
		M1001010_1_Sheet += commonService.IBSheet_col("manager_phone_NO", 60,false,false,false) + ",";
		M1001010_1_Sheet += commonService.IBSheet_col("supply_price", 60,false,false,false) + ",";
		M1001010_1_Sheet += commonService.IBSheet_col("tax_price", 60,false,false,false) + ",";
		M1001010_1_Sheet += commonService.IBSheet_col("total_price", 60,false,false,false) + ",";
		M1001010_1_Sheet += commonService.IBSheet_col("order_DT", 60,false,false,false) + ",";
		M1001010_1_Sheet += commonService.IBSheet_col("complete_FL", 60,false,false,false) + "]";
		
		mav.addObject("M1001010_1_Sheet", M1001010_1_Sheet);
		
		//M1001010_2_Sheet 컬럼 만들기
		String M1001010_2_Sheet = "["; 

		M1001010_2_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("상태", 20,false,false,false) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("clie_CD", 60,true,false,false) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("orde_CD", 40,true,false,false) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("item_CD", 60,false,true,true) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("quantity", 60,false,false,true) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("order_unit_C", 60,false,false,false) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("order_price", 60,false,false,true) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("supply_price", 60,false,false,false) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("tax_price", 60,false,false,false) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("total_price", 60,false,false,false) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("tax_FL", 60,true,false,false) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("standard", 60,false,false,false) + ",";
		M1001010_2_Sheet += commonService.IBSheet_col("item_group_C", 60,false,false,false) + "]";
		
		mav.addObject("M1001010_2_Sheet", M1001010_2_Sheet);
		
		mav.setViewName("/M100/M1001010");
		commonService.security(mav);
		return mav;
	}
	
	//M1001020 으로 이동하는 함수
	@RequestMapping("/M100/M1001020.do")
	public ModelAndView M1001020(ModelAndView mav) throws Exception {
			
		//M1001010_1_Sheet 컬럼 만들기
		String M1001020_1_Sheet = "["; 

		M1001020_1_Sheet += commonService.IBSheet_col("orde_CD", 40,true,false,false) + ",";
		M1001020_1_Sheet += commonService.IBSheet_col("clie_CD", 60,false,false,false) + ",";
		M1001020_1_Sheet += commonService.IBSheet_col("order_DT", 60,false,false,false) + ",";
		M1001020_1_Sheet += commonService.IBSheet_col("complete_FL", 60,false,false,false) + "]";
		
		mav.addObject("M1001020_1_Sheet", M1001020_1_Sheet);
		
		//M1001020_2_Sheet 컬럼 만들기
		String M1001020_2_Sheet = "["; 

		M1001020_2_Sheet += commonService.IBSheet_col("clie_CD", 60,true,false,false) + ",";
		M1001020_2_Sheet += commonService.IBSheet_col("orde_CD", 40,true,false,false) + ",";
		M1001020_2_Sheet += commonService.IBSheet_col("item_CD", 60,false,false,false) + ",";
		M1001020_2_Sheet += commonService.IBSheet_col("quantity", 60,false,false,false) + ",";
		M1001020_2_Sheet += commonService.IBSheet_col("order_unit_C", 60,false,false,false) + ",";
		M1001020_2_Sheet += commonService.IBSheet_col("standard", 60,false,false,false) + "]";
		
		mav.addObject("M1001020_2_Sheet", M1001020_2_Sheet);
		
		//M1001020_3_Sheet 컬럼 만들기
		String M1001020_3_Sheet = "["; 

		M1001020_3_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M1001020_3_Sheet += commonService.IBSheet_col("상태", 20,true,false,false) + ",";
		M1001020_3_Sheet += commonService.IBSheet_col("inve_CD", 40,true,false,false) + ",";
		M1001020_3_Sheet += commonService.IBSheet_col("befor_CD", 40,true,false,false) + ",";
		M1001020_3_Sheet += commonService.IBSheet_col("item_CD", 60,false,true,true) + ",";
		M1001020_3_Sheet += commonService.IBSheet_col("in_quantity", 60,false,true,true) + ",";
		M1001020_3_Sheet += commonService.IBSheet_col("out_quantity", 60,true,false,false) + ",";
		M1001020_3_Sheet += commonService.IBSheet_col("inventory_unit_C", 60,false,false,false) + "]";
		
		mav.addObject("M1001020_3_Sheet", M1001020_3_Sheet);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("col_name","clie_CD");
		map.put("comp_CD",commonService.user_info().getComp_CD());
		mav.addObject("clie_CD",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M100/M1001020");
		commonService.security(mav);
		return mav;
	}
	//입고처리시 재고에 마주처서 환산한 값을 구해옴
	@RequestMapping(value = "/M100/item_sandData")
	public String item_sandData(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<String,Object>();
		map.put("comp_CD", commonService.user_info().getComp_CD());
		map.put("item_CD",request.getParameter("item_CD"));
		map.put("quantity",request.getParameter("quantity"));
		model.addAttribute("item_data", m100Service.item_sandData(map));
		
		return "jsonView";
	}
	
	//거래처별 제품목록 콤보박스 데이터로 가져오기
	@RequestMapping(value = "/M100/get_item_CD_ComBo")
	public String get_item_CD_ComBo(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("clie_CD", request.getParameter("clie_CD"));
		map.put("comp_CD", commonService.user_info().getComp_CD());
		
		model.addAttribute("combo_data", m100Service.get_item_CD_ComBo(map));
		
		return "jsonView";
	}
	//M100_Data 함수
	@RequestMapping("/M100/Common_Data.do")
	public String M100_Data(@RequestParam Map<String,Object> map,ModelMap model) throws Exception {
		
		if (map.get("sStatus") != null) {
			commonService.Data_Change(commonService.IBSheet_Data_Converstion(map));
			if (map.get("sheetNm").equals("M1001020_3_Sheet")) m100Service.M1001020_3_Data_controll(commonService.IBSheet_Data_Converstion(map));
		}else	model.addAttribute("Data",commonService.Data_View(map));
				
		return "jsonView";
	}
	
}
