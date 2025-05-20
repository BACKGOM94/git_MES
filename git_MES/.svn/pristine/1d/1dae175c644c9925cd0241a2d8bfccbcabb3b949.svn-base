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
import gom.service.M990Service;

@Controller(value = "/M990")
public class M990Controller {
	
	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	//M990Service 서비스
	@Resource(name = "M990Service")
	private M990Service m990Service;
	
	//M9901010 으로 이동하는 함수
	@RequestMapping("/M990/M9901010.do")
	public ModelAndView M9901010(ModelAndView mav) throws Exception {
		
		//M9901010_1_Sheet 컬럼 데이터
		String M9901010_1_Sheet = "["; 

		M9901010_1_Sheet += commonService.IBSheet_col("삭제",10,false, false,true) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("상태",0,true, false,true) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("comp_CD",20,false, false,false) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("comp_ko_NM",0,true, true,false) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("comp_en_NM",0,true, false,false) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("memb_ID",0,true, true,true) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("memb_PW",0,true, false,false) + ",";		
		M9901010_1_Sheet += commonService.IBSheet_col("join_DT",0,true, false,false) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("leader_NM",20,false, true,false) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("leader_phone_NO",30,false, true,false) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("address",0,true, false,false) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("address_detail",0,true, false,false) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("email",0,true, false,false) + ",";
		M9901010_1_Sheet += commonService.IBSheet_col("memo",0,true, false,false)+ "]";
		
		mav.addObject("M9901010_1_Sheet", M9901010_1_Sheet);
		
		//M9901010_2_Sheet 컬럼 데이터
		String M9901010_2_Sheet = "[";
		
		M9901010_2_Sheet += commonService.IBSheet_col("menu_CD_Tree", 10,false,false,false) + ",";
		M9901010_2_Sheet += commonService.IBSheet_col("auth", 10,false,false,true) + ",";
		M9901010_2_Sheet += commonService.IBSheet_col("upp_menu_CD",0,true, false,false) + ",";
		M9901010_2_Sheet += commonService.IBSheet_col("Level",0,true, false,false) + ",";
		M9901010_2_Sheet += commonService.IBSheet_col("comp_CD",0,true, false,false) + ",";
		M9901010_2_Sheet += commonService.IBSheet_col("memb_ID",0,true, false,false) + ",";
		M9901010_2_Sheet += commonService.IBSheet_col("상태",0,true, false,true) + "]";
		
		mav.addObject("M9901010_2_Sheet", M9901010_2_Sheet);
		
		mav.setViewName("/M990/M9901010");
		
		commonService.security(mav);
		
		return mav;
	}
	
	//M9901020 으로 이동하는 함수
	@RequestMapping("/M990/M9901020.do")
	public ModelAndView M9901020(ModelAndView mav) throws Exception {
						
		mav.setViewName("/M990/M9901020");
		
		commonService.security(mav);
		
		return mav;
	}
	
	//kpi 데이터를 가져오기 위한 함수
	@RequestMapping(value = "/M990/get_Kpi_data.do")
	public String get_Kpi_data(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("comp_CD", request.getParameter("comp_CD").toString());
		map.put("check_DT", request.getParameter("_date").toString());
		
		model.addAttribute("kpi_data", m990Service.get_Kpi_data(map));
		
		return "jsonView";
	}	
	
	//M990_Data 함수
	@RequestMapping("/M990/Common_Data.do")
	public String M990_Data(@RequestParam Map<String,Object> map,ModelMap model) throws Exception {

		if (map.get("sStatus") != null) {
			if (map.get("sheetNm").equals("M9901010_2_Sheet")) m990Service.M9901010_2_Insert2(commonService.IBSheet_Data_Converstion(map));
			commonService.Data_Change(commonService.IBSheet_Data_Converstion(map));
			if (map.get("sheetNm").equals("M9901010_1_Sheet")) m990Service.M9901010_1_Insert2(commonService.IBSheet_Data_Converstion(map));
			if (map.get("sheetNm").equals("M9901010_2_Sheet")) m990Service.M9901010_2_Insert3(commonService.IBSheet_Data_Converstion(map));
		}else	model.addAttribute("Data",commonService.Data_View(map));

		return "jsonView";
	}
}
