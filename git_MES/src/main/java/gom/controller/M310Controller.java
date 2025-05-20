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
import gom.service.M310Service;

@Controller(value = "/M310")
public class M310Controller {
	
	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	//M310Service 서비스
	@Resource(name = "M310Service")
	private M310Service m310Service;
	
	//M3101010 으로 이동하는 함수
	@RequestMapping("/M310/M3101010.do")
	public ModelAndView M3101010(ModelAndView mav) throws Exception {
			
		//M3101010_1_Sheet 컬럼 만들기
		String M3101010_1_Sheet = "["; 

		M3101010_1_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("상태", 20,false,false,false) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("sale_CD", 40,true,false,false) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("clie_CD_sale", 60,false,true,true) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("manager_NM", 60,false,false,false) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("manager_phone_NO", 60,false,false,false) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("supply_price", 60,false,false,false) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("tax_price", 60,false,false,false) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("total_price", 60,false,false,false) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("sale_DT", 60,false,false,false) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("vehi_CD", 60,false,false,true) + ",";
		M3101010_1_Sheet += commonService.IBSheet_col("complete_FL", 60,false,false,false) + "]";
		
		mav.addObject("M3101010_1_Sheet", M3101010_1_Sheet);
		
		//M3101010_2_Sheet 컬럼 만들기
		String M3101010_2_Sheet = "["; 

		M3101010_2_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("상태", 20,false,false,false) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("clie_CD", 60,true,false,false) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("sale_CD", 40,true,false,false) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("item_CD", 60,false,true,true) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("quantity", 60,false,false,true) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("inventory_unit_C", 60,false,false,false) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("sale_price", 60,false,false,true) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("supply_price", 60,false,false,false) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("tax_price", 60,false,false,false) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("total_price", 60,false,false,false) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("tax_FL", 60,true,false,false) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("standard", 60,false,false,false) + ",";
		M3101010_2_Sheet += commonService.IBSheet_col("item_group_C", 60,false,false,false) + "]";
		
		mav.addObject("M3101010_2_Sheet", M3101010_2_Sheet);
		
		mav.setViewName("/M310/M3101010");
		commonService.security(mav);
		return mav;
	}
	
	//M3101020 으로 이동하는 함수
	@RequestMapping("/M310/M3101020.do")
	public ModelAndView M3101020(ModelAndView mav) throws Exception {
			
		//M1001010_1_Sheet 컬럼 만들기
		String M3101020_1_Sheet = "["; 

		M3101020_1_Sheet += commonService.IBSheet_col("disp_CD", 40,true,false,false) + ",";
		M3101020_1_Sheet += commonService.IBSheet_col("vehi_CD", 60,false,false,false) + ",";
		M3101020_1_Sheet += commonService.IBSheet_col("vehi_DT", 60,false,false,false) + ",";
		M3101020_1_Sheet += commonService.IBSheet_col("set_item_FL", 60,false,false,false) + "]";
		
		mav.addObject("M3101020_1_Sheet", M3101020_1_Sheet);
		
		//M3101020_2_Sheet 컬럼 만들기
		String M3101020_2_Sheet = "["; 

		M3101020_2_Sheet += commonService.IBSheet_col("item_CD_Tree2", 60,false,false,false) + ",";
		M3101020_2_Sheet += commonService.IBSheet_col("sale_CD", 40,true,false,false) + ",";
		M3101020_2_Sheet += commonService.IBSheet_col("clie_CD", 40,false,false,false) + ",";
		M3101020_2_Sheet += commonService.IBSheet_col("quantity", 20,false,false,false) + ",";
		M3101020_2_Sheet += commonService.IBSheet_col("inventory_unit_C", 20,false,false,false) + ",";
		M3101020_2_Sheet += commonService.IBSheet_col("Level", 60,true,false,false) + "]";
		
		mav.addObject("M3101020_2_Sheet", M3101020_2_Sheet);
		
		//M3101020_3_Sheet 컬럼 만들기
		String M3101020_3_Sheet = "["; 

		M3101020_3_Sheet += commonService.IBSheet_col("상태", 20,true,false,false) + ",";
		M3101020_3_Sheet += commonService.IBSheet_col("disp_CD", 60,true,false,false) + ",";
		M3101020_3_Sheet += commonService.IBSheet_col("inve_CD", 60,true,false,false) + ",";
		M3101020_3_Sheet += commonService.IBSheet_col("item_CD_Tree2", 80,false,false,false) + ",";
		M3101020_3_Sheet += commonService.IBSheet_col("move_DT", 60,false,false,false) + ",";
		M3101020_3_Sheet += commonService.IBSheet_col("quantity", 60,false,false,false) + ",";
		M3101020_3_Sheet += commonService.IBSheet_col("use_quantity", 60,false,false,true) + ",";
		M3101020_3_Sheet += commonService.IBSheet_col("Level", 60,true,false,false) + "]";
		
		mav.addObject("M3101020_3_Sheet", M3101020_3_Sheet);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("col_name","vehi_CD");
		map.put("comp_CD",commonService.user_info().getComp_CD());
		mav.addObject("vehi_CD",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M310/M3101020");
		commonService.security(mav);
		return mav;
	}
	
	//M3101030 으로 이동하는 함수
	@RequestMapping("/M310/M3101030.do")
	public ModelAndView M3101030(ModelAndView mav) throws Exception {
			
		//M3101030_1_Sheet 컬럼 만들기
		String M3101030_1_Sheet = "["; 

		M3101030_1_Sheet += commonService.IBSheet_col("상태", 40,true,false,false) + ",";
		M3101030_1_Sheet += commonService.IBSheet_col("disp_CD", 40,true,false,false) + ",";
		M3101030_1_Sheet += commonService.IBSheet_col("vehi_CD", 60,false,false,false) + ",";
		M3101030_1_Sheet += commonService.IBSheet_col("vehi_DT", 60,false,false,false) + ",";
		M3101030_1_Sheet += commonService.IBSheet_col("complete_FL", 60,false,false,false) + "]";
		
		mav.addObject("M3101030_1_Sheet", M3101030_1_Sheet);
		
		//M3101030_2_Sheet 컬럼 만들기
		String M3101030_2_Sheet = "["; 

		M3101030_2_Sheet += commonService.IBSheet_col("sale_CD", 60,true,false,false) + ",";
		M3101030_2_Sheet += commonService.IBSheet_col("clie_CD", 40,false,false,false) + ",";
		M3101030_2_Sheet += commonService.IBSheet_col("manager_NM", 40,false,false,false) + ",";
		M3101030_2_Sheet += commonService.IBSheet_col("manager_phone_NO", 20,false,false,false) + "]";
		
		mav.addObject("M3101030_2_Sheet", M3101030_2_Sheet);
		
		//M3101030_3_Sheet 컬럼 만들기
		String M3101030_3_Sheet = "["; 

		M3101030_3_Sheet += commonService.IBSheet_col("item_CD", 60,false,false,false) + ",";
		M3101030_3_Sheet += commonService.IBSheet_col("inventory_unit_C", 60,false,false,false) + ",";
		M3101030_3_Sheet += commonService.IBSheet_col("quantity", 80,false,false,false) + "]";
		
		mav.addObject("M3101030_3_Sheet", M3101030_3_Sheet);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("col_name","vehi_CD");
		map.put("comp_CD",commonService.user_info().getComp_CD());
		mav.addObject("vehi_CD",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M310/M3101030");
		commonService.security(mav);
		return mav;
	}
	
	//거래처별 제품목록 콤보박스 데이터로 가져오기
	@RequestMapping(value = "/M310/get_item_CD_ComBo")
	public String get_item_CD_ComBo(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();	
		map.put("clie_CD", request.getParameter("clie_CD"));
		map.put("comp_CD", commonService.user_info().getComp_CD());	
		model.addAttribute("combo_data", m310Service.get_item_CD_ComBo(map));
		return "jsonView";
	}
	
	//M310_Data 함수
	@RequestMapping("/M310/Common_Data.do")
	public String M310_Data(@RequestParam Map<String,Object> map,ModelMap model) throws Exception {
		
		if (map.get("sStatus") != null) {
			commonService.Data_Change(commonService.IBSheet_Data_Converstion(map));
			if (map.get("sheetNm").equals("M3101010_2_Sheet")) m310Service.M3101010_2_Insert2(commonService.user_info().getComp_CD());
		}else	model.addAttribute("Data",commonService.Data_View(map));
		
		return "jsonView";
	}
	
}
