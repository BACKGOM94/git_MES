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
import gom.service.M210Service;

@Controller(value = "/M210")
public class M210Controller {
	
	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	//M980Service 서비스
	@Resource(name = "M210Service")
	private M210Service m210Service;
	
	//M2101010 으로 이동하는 함수
	@RequestMapping("/M210/M2101010.do")
	public ModelAndView M2101010(ModelAndView mav) throws Exception {
			
		//M2101010_1_Sheet 컬럼 만들기
		String M2101010_1_Sheet = "["; 

		M2101010_1_Sheet += commonService.IBSheet_col("삭제", 15,true,false,true) + ",";
		M2101010_1_Sheet += commonService.IBSheet_col("상태", 20,true,false,false) + ",";
		M2101010_1_Sheet += commonService.IBSheet_col("manu_CD", 30,false,false,false) + ",";
		M2101010_1_Sheet += commonService.IBSheet_col("manu_DT", 30,false,false,false) + ",";
		M2101010_1_Sheet += commonService.IBSheet_col("complete_FL", 30,false,false,false) + "]";
		
		mav.addObject("M2101010_1_Sheet", M2101010_1_Sheet);
		
		//M2101010_2_Sheet 컬럼 만들기
		String M2101010_2_Sheet = "["; 

		M2101010_2_Sheet += commonService.IBSheet_col("삭제", 30,false,false,true) + ",";
		M2101010_2_Sheet += commonService.IBSheet_col("상태", 20,true,false,false) + ",";
		M2101010_2_Sheet += commonService.IBSheet_col("manu_CD", 60,true,false,false) + ",";
		M2101010_2_Sheet += commonService.IBSheet_col("item_CD", 60,false,true,true) + ",";
		M2101010_2_Sheet += commonService.IBSheet_col("quantity", 60,false,true,true) + ",";
		M2101010_2_Sheet += commonService.IBSheet_col("inventory_unit_C", 60,false,false,false) + ",";
		M2101010_2_Sheet += commonService.IBSheet_col("complete_FL", 60,false,false,false) + "]";
		
		mav.addObject("M2101010_2_Sheet", M2101010_2_Sheet);
		
		//M2101010_3_Sheet 컬럼 만들기
		String M2101010_3_Sheet = "["; 

		M2101010_3_Sheet += commonService.IBSheet_col("work_CD_combo", 60,false,false,false) + ",";
		M2101010_3_Sheet += commonService.IBSheet_col("work_SQ", 60,false,false,false) + ",";
		M2101010_3_Sheet += commonService.IBSheet_col("complete_FL", 60,false,false,false) + "]";
		
		mav.addObject("M2101010_3_Sheet", M2101010_3_Sheet);
		
		mav.setViewName("/M210/M2101010");
		commonService.security(mav);
		return mav;
	}
	
	//M2101020 으로 이동하는 함수
	@RequestMapping("/M210/M2101020.do")
	public ModelAndView M2101020(ModelAndView mav) throws Exception {
			
		//M2101020_1_Sheet 컬럼 만들기
		String M2101020_1_Sheet = "["; 

		M2101020_1_Sheet += commonService.IBSheet_col("삭제", 15,true,false,false) + ",";
		M2101020_1_Sheet += commonService.IBSheet_col("상태", 20,true,false,false) + ",";
		M2101020_1_Sheet += commonService.IBSheet_col("manu_CD", 30,false,false,false) + ",";
		M2101020_1_Sheet += commonService.IBSheet_col("manu_DT", 30,false,false,false) + ",";
		M2101020_1_Sheet += commonService.IBSheet_col("complete_FL", 30,false,false,false) + "]";
		
		mav.addObject("M2101020_1_Sheet", M2101020_1_Sheet);
		
		//M2101020_2_Sheet 컬럼 만들기
		String M2101020_2_Sheet = "["; 

		M2101020_2_Sheet += commonService.IBSheet_col("삭제", 30,true,false,false) + ",";
		M2101020_2_Sheet += commonService.IBSheet_col("상태", 20,true,false,false) + ",";
		M2101020_2_Sheet += commonService.IBSheet_col("manu_CD", 60,true,false,false) + ",";
		M2101020_2_Sheet += commonService.IBSheet_col("item_CD", 60,false,false,false) + ",";
		M2101020_2_Sheet += commonService.IBSheet_col("quantity", 60,false,false,false) + ",";
		M2101020_2_Sheet += commonService.IBSheet_col("inventory_unit_C", 60,false,false,false) + ",";
		M2101020_2_Sheet += commonService.IBSheet_col("complete_FL", 60,true,false,false) + "]";
		
		mav.addObject("M2101020_2_Sheet", M2101020_2_Sheet);
		
		//M2101020_3_Sheet 컬럼 만들기
		String M2101020_3_Sheet = "["; 

		M2101020_3_Sheet += commonService.IBSheet_col("상태", 20,true,false,false) + ",";
		M2101020_3_Sheet += commonService.IBSheet_col("manu_CD", 60,true,false,false) + ",";
		M2101020_3_Sheet += commonService.IBSheet_col("inve_CD", 60,true,false,false) + ",";
		M2101020_3_Sheet += commonService.IBSheet_col("item_CD_Tree2", 80,false,false,false) + ",";
		M2101020_3_Sheet += commonService.IBSheet_col("move_DT", 60,false,false,false) + ",";
		M2101020_3_Sheet += commonService.IBSheet_col("quantity", 60,false,false,false) + ",";
		M2101020_3_Sheet += commonService.IBSheet_col("use_quantity", 60,false,false,true) + ",";
		M2101020_3_Sheet += commonService.IBSheet_col("Level", 60,true,false,false) + "]";
		
		mav.addObject("M2101020_3_Sheet", M2101020_3_Sheet);
		
		mav.setViewName("/M210/M2101020");
		commonService.security(mav);
		return mav;
	}
	
	//M2101030 으로 이동하는 함수
	@RequestMapping("/M210/M2101030.do")
	public ModelAndView M2101030(ModelAndView mav) throws Exception {
			
		//M2101030_1_Sheet 컬럼 만들기
		String M2101030_1_Sheet = "["; 

		M2101030_1_Sheet += commonService.IBSheet_col("상태", 20,true,false,false) + ",";
		M2101030_1_Sheet += commonService.IBSheet_col("DummyCheck", 20,false,false,true) + ",";
		M2101030_1_Sheet += commonService.IBSheet_col("item_CD", 30,false,false,false) + ",";
		M2101030_1_Sheet += commonService.IBSheet_col("quantity", 30,false,false,false) + ",";
		M2101030_1_Sheet += commonService.IBSheet_col("work_CD_combo", 30,true,false,false) + ",";
		M2101030_1_Sheet += commonService.IBSheet_col("manu_CD", 30,false,false,false) + ",";
		M2101030_1_Sheet += commonService.IBSheet_col("proc_CD_combo", 30,false,false,false) + "]";
		
		mav.addObject("M2101030_1_Sheet", M2101030_1_Sheet);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("col_name","work_CD");
		map.put("comp_CD",commonService.user_info().getComp_CD());
		mav.addObject("work_CD",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M210/M2101030");
		commonService.security(mav);
		return mav;
	}

	//제품명명 콤보박스 데이터로 가져오기
	@RequestMapping(value = "/M210/get_item_CD_ComBo")
	public String get_item_CD_ComBo(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		model.addAttribute("combo_data", m210Service.get_item_CD_ComBo(commonService.user_info().getComp_CD()));
		
		return "jsonView";
	}
	
	//BOM 계산하여 필요한 제품 양을 가져오는 함수
	@RequestMapping(value = "/M210/make_BOM_Data.do")
	public String make_BOM_Data(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("comp_CD",commonService.user_info().getComp_CD());
		map.put("item_CD",request.getParameter("item_CD"));
		map.put("quantity", request.getParameter("quantity"));
		
		model.addAttribute("list", m210Service.make_BOM_Data(map));
		
		return "jsonView";
	}
	
	//BOM 계산하여 필요한 제품 양을 가져오는 함수
	@RequestMapping(value = "/M210/make_BOM_Data2.do")
	public String make_BOM_Data2(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("comp_CD",commonService.user_info().getComp_CD());
		map.put("item_CD",request.getParameter("item_CD"));
		
		model.addAttribute("list", m210Service.make_BOM_Data2(map));
		
		return "jsonView";
	}
	
	//M210_Data 함수
	@RequestMapping("/M210/Common_Data.do")
	public String M210_Data(@RequestParam Map<String,Object> map,ModelMap model) throws Exception {
		
		if (map.get("sStatus") != null)	commonService.Data_Change(commonService.IBSheet_Data_Converstion(map));
		else	model.addAttribute("Data",commonService.Data_View(map));
				
		return "jsonView";
	}
	
}
