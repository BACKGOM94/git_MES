package gom.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
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
import gom.service.M980Service;

@Controller(value = "/M980")
public class M980Controller {

	//Common 서비스o
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	//M980Service 서비스
	@Resource(name = "M980Service")
	private M980Service m980Service;

	//M9801010 으로 이동하는 함수
	@RequestMapping("/M980/M9801010.do")
	public ModelAndView M9801010(ModelAndView mav) throws Exception {
		
		//M9809010_1_Sheet 컬럼 만들기
		String M9801010_1_Sheet = "["; 

		M9801010_1_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("상태", 10,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("item_CD", 40,false,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("item_NM", 60,true,true,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("order_unit_C", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("exchange_value", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("inventory_unit_C", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("inventory_item_CD", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("tax_FL", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("item_group_C", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("proc_CD", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("price", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("standard", 40,false,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("use_order", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("use_production", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("use_sale", 60,true,false,false) + ",";
		M9801010_1_Sheet += commonService.IBSheet_col("memo", 60,false,false,false) +  "]";
		mav.addObject("M9801010_1_Sheet", M9801010_1_Sheet);

		mav.addObject("item_group_C",commonService.IBSheet_select_category_Data(980002));
		mav.addObject("item_unit_C",commonService.IBSheet_select_category_Data(980001));
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("col_name","item_CD");
		map.put("comp_CD",commonService.user_info().getComp_CD());
		mav.addObject("item_CD",commonService.IBSheet_select_data_master(map));
		map.put("col_name", "proc_CD");
		mav.addObject("proc_CD",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M980/M9801010");
		commonService.security(mav);
		return mav;
	}
	
	//M9801020 으로 이동하는 함수
	@RequestMapping("/M980/M9801020.do")
	public ModelAndView M9801020(ModelAndView mav) throws Exception {
		
		//M9801020_1_Sheet 컬럼 데이터
		String M9801020_1_Sheet = "["; 
	
		M9801020_1_Sheet += commonService.IBSheet_col("item_CD", 30,false,false,false) + ",";
		M9801020_1_Sheet += commonService.IBSheet_col("standard", 20,false,false,false) + ",";
		M9801020_1_Sheet += commonService.IBSheet_col("inventory_unit_C", 10,false,false,false) + "]";

		mav.addObject("M9801020_1_Sheet", M9801020_1_Sheet);
		
		//M9801020_2_Sheet 컬럼 데이터
		String M9801020_2_Sheet = "["; 

		M9801020_2_Sheet += commonService.IBSheet_col("item_CD_Tree", 30,false,true,true) + ",";
		M9801020_2_Sheet += commonService.IBSheet_col("상태", 10,true,false,true) + ",";
		M9801020_2_Sheet += commonService.IBSheet_col("need_count", 30,false,true,true) + ",";
		M9801020_2_Sheet += commonService.IBSheet_col("item_CD", 30,true,false,false) + ",";
		M9801020_2_Sheet += commonService.IBSheet_col("loss_rate", 30,false,true,true) + ",";
		M9801020_2_Sheet += commonService.IBSheet_col("real_need_count", 30,false,false,false) + ",";
		M9801020_2_Sheet += commonService.IBSheet_col("inventory_unit_C", 10,false,false,false) + ",";
		M9801020_2_Sheet += commonService.IBSheet_col("memo", 30,false,false,false) + ",";
		M9801020_2_Sheet += commonService.IBSheet_col("Level", 0,true,false,false)+ "]";

		mav.addObject("M9801020_2_Sheet", M9801020_2_Sheet);

		mav.setViewName("/M980/M9801020");
		
		commonService.security(mav);
		
		return mav;
	}
	
	//M9801020_2_delete.do
	@RequestMapping(value = "/M980/M9801020_2_delete.do")
	public void M9801020_2_delete(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		//맵 객체 생성 밑 데이터 이동
		HashMap<String, Object> map = new HashMap<String, Object>();
		Enumeration<?> requestData = request.getParameterNames();
		while (requestData.hasMoreElements()) {
			String key = requestData.nextElement().toString(); 
			String data = request.getParameter(key); 
			map.put(key, data); 
		}
		
		m980Service.M9801020_2_delete(map);		
	}

	//M9801030 으로 이동하는 함수
	@RequestMapping("/M980/M9801030.do")
	public ModelAndView M9801030(ModelAndView mav) throws Exception {
		
		//M9801030_1_Sheet 컬럼 데이터
		String M9801030_1_Sheet = "["; 

		M9801030_1_Sheet += commonService.IBSheet_col("삭제", 10,false,false,true) + ",";
		M9801030_1_Sheet += commonService.IBSheet_col("상태", 0,true,false,true) + ",";
		M9801030_1_Sheet += commonService.IBSheet_col("proc_CD", 30,true,false,true) + ",";
		M9801030_1_Sheet += commonService.IBSheet_col("proc_NM", 20,false,false,true) + ",";
		M9801030_1_Sheet += commonService.IBSheet_col("memo", 30,false,false,true) + "]";

		mav.addObject("M9801030_1_Sheet", M9801030_1_Sheet);
		
		//M9801030_2_Sheet 컬럼 데이터
		String M9801030_2_Sheet = "["; 

		M9801030_2_Sheet += commonService.IBSheet_col("삭제", 10,false,false,true) + ",";
		M9801030_2_Sheet += commonService.IBSheet_col("상태", 0,true,false,true) + ",";
		M9801030_2_Sheet += commonService.IBSheet_col("proc_CD_combo", 30,true,false,true) + ",";
		M9801030_2_Sheet += commonService.IBSheet_col("work_CD_combo", 30,false,false,true) + ",";
		M9801030_2_Sheet += commonService.IBSheet_col("work_SQ", 20,false,false,true) + "]";

		mav.addObject("M9801030_2_Sheet", M9801030_2_Sheet);
		
		//M9801030_3_Sheet 컬럼 데이터
		String M9801030_3_Sheet = "["; 

		M9801030_3_Sheet += commonService.IBSheet_col("삭제", 10,false,false,true) + ",";
		M9801030_3_Sheet += commonService.IBSheet_col("상태", 0,true,false,true) + ",";
		M9801030_3_Sheet += commonService.IBSheet_col("work_CD", 30,true,false,true) + ",";
		M9801030_3_Sheet += commonService.IBSheet_col("work_NM", 20,false,false,true) + ",";
		M9801030_3_Sheet += commonService.IBSheet_col("memo", 30,false,false,true) + "]";

		mav.addObject("M9801030_3_Sheet", M9801030_3_Sheet);
		
		mav.setViewName("/M980/M9801030");
		
		commonService.security(mav);
		
		return mav;
	}

	//M9805010 으로 이동하는 함수
	@RequestMapping("/M980/M9805010.do")
	public ModelAndView M9805010(ModelAndView mav) throws Exception {
		
		//M9805010_1_Sheet 컬럼 만들기
		String M9805010_1_Sheet = "["; 

		M9805010_1_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("상태", 10,true,false,false) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("clie_CD", 40,false,false,false) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("clie_NM", 60,true,true,true) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("manager_NM", 60,false,false,false) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("manager_phone_NO", 60,false,false,false) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("address", 60,true,false,false) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("address_detail", 60,true,false,false) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("email", 60,true,false,false) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("enter_FL", 60,true,false,false) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("exit_FL", 60,true,false,false) + ",";
		M9805010_1_Sheet += commonService.IBSheet_col("memo", 60,true,false,false) + "]";
		
		mav.addObject("M9805010_1_Sheet", M9805010_1_Sheet);
		
		//M9805010_2_Sheet 컬럼 만들기
		String M9805010_2_Sheet = "["; 

		M9805010_2_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M9805010_2_Sheet += commonService.IBSheet_col("상태", 10,false,false,false) + ",";
		M9805010_2_Sheet += commonService.IBSheet_col("clie_CD", 60,true,false,true) + ",";
		M9805010_2_Sheet += commonService.IBSheet_col("item_CD", 60,false,true,true) + ",";
		M9805010_2_Sheet += commonService.IBSheet_col("price", 60,false,false,true) + "]";
		
		mav.addObject("M9805010_2_Sheet", M9805010_2_Sheet);
		
		mav.setViewName("/M980/M9805010");
		commonService.security(mav);
		return mav;
	}
	
	//M9805030 으로 이동하는 함수
	@RequestMapping("/M980/M9805030.do")
	public ModelAndView M9805030(ModelAndView mav) throws Exception {
		
		//M9805030_1_Sheet 컬럼 만들기
		String M9805030_1_Sheet = "["; 

		M9805030_1_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M9805030_1_Sheet += commonService.IBSheet_col("상태", 10,true,false,false) + ",";
		M9805030_1_Sheet += commonService.IBSheet_col("vehi_CD", 40,false,false,false) + ",";
		M9805030_1_Sheet += commonService.IBSheet_col("vehi_NO", 60,true,false,false) + ",";
		M9805030_1_Sheet += commonService.IBSheet_col("vehi_kind_C", 60,false,false,false) + ",";
		M9805030_1_Sheet += commonService.IBSheet_col("memo", 60,false,false,false) + "]";
		
		mav.addObject("M9805030_1_Sheet", M9805030_1_Sheet);
		
		//M9805030_2_Sheet 컬럼 만들기
		String M9805030_2_Sheet = "["; 

		M9805030_2_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M9805030_2_Sheet += commonService.IBSheet_col("상태", 10,true,false,false) + ",";
		M9805030_2_Sheet += commonService.IBSheet_col("vehi_CD", 60,true,true,true) + ",";
		M9805030_2_Sheet += commonService.IBSheet_col("clie_CD", 60,false,true,true) + ",";
		M9805030_2_Sheet += commonService.IBSheet_col("race_seq", 60,false,true,true) + ",";
		M9805030_2_Sheet += commonService.IBSheet_col("manager_NM", 60,false,false,false) + ",";
		M9805030_2_Sheet += commonService.IBSheet_col("manager_phone_NO", 60,false,false,false) + "]";
		
		mav.addObject("M9805030_2_Sheet", M9805030_2_Sheet);
		
		mav.addObject("vehi_kind",commonService.IBSheet_select_category_Data(980007));

		mav.setViewName("/M980/M9805030");
		commonService.security(mav);
		return mav;
	}
	
	//M9806010 으로 이동하는 함수
	@RequestMapping("/M980/M9806010.do")
	public ModelAndView M9806010(ModelAndView mav) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("col_name","category_CD");
		
		//대분류 목록
		mav.addObject("category_Data",commonService.IBSheet_select_data_master(map));
		
		//M9809010_1_Sheet 컬럼 만들기
		String M9806010_1_Sheet = "["; 
		M9806010_1_Sheet += commonService.IBSheet_col("상태", 10,false,false,true) + ",";
		M9806010_1_Sheet += commonService.IBSheet_col("equi_CD", 0,true,false,false) + ",";
		M9806010_1_Sheet += commonService.IBSheet_col("equi_NM", 30,false,true,true) + ",";
		M9806010_1_Sheet += commonService.IBSheet_col("equi_location", 30,false,true,true) + ",";
		M9806010_1_Sheet += commonService.IBSheet_col("equi_standard", 30,false,false,true) + ",";
		M9806010_1_Sheet += commonService.IBSheet_col("memo", 60,false,false,true) + "]";

		mav.addObject("M9806010_1_Sheet", M9806010_1_Sheet);
		
		mav.setViewName("/M980/M9806010");
		
		commonService.security(mav);
		
		return mav;
	}
	
	//M9808010 으로 이동하는 함수
	@RequestMapping("/M980/M9808010.do")
	public ModelAndView M9808010(ModelAndView mav) throws Exception {
		
		//M9809010_1_Sheet 컬럼 만들기
		String M9808010_1_Sheet = "["; 

		M9808010_1_Sheet += commonService.IBSheet_col("삭제", 10,false,false,true) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("상태", 10,true,false,true) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("memb_ID",0,true,true,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("memb_PW",0,true,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("memb_NM",30,false,true,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("memb_rating",0,true,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("join_DT",0,true,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("birthdate_DT",0,true,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("address",0,true,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("address_detail",0,true,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("phone_NO",30,false,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("email",0,true,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("rank_GB",10,false,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("work_type_GB",10,false,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("sex_GB",0,true,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("memb_status_GB",0,true,false,false) + ",";
		M9808010_1_Sheet += commonService.IBSheet_col("memo",0,true,false,false) + "]";
		
		mav.addObject("M9808010_1_Sheet", M9808010_1_Sheet);
		
		//M9808010_2_Sheet 컬럼 데이터
		String M9808010_2_Sheet = "[";
		
		M9808010_2_Sheet += commonService.IBSheet_col("menu_CD_Tree", 10,false,false,false) + ",";
		M9808010_2_Sheet += commonService.IBSheet_col("auth", 10,false,false,true) + ",";
		M9808010_2_Sheet += commonService.IBSheet_col("upp_menu_CD",0,true, false,false) + ",";
		M9808010_2_Sheet += commonService.IBSheet_col("Level",0,true, false,false) + ",";
		M9808010_2_Sheet += commonService.IBSheet_col("memb_ID",0,true, false,false) + ",";
		M9808010_2_Sheet += commonService.IBSheet_col("상태",0,true, false,true) + "]";
		
		mav.addObject("M9808010_2_Sheet", M9808010_2_Sheet);
		
		mav.addObject("rank_GB",commonService.IBSheet_select_category_Data(980003));
		mav.addObject("work_type_GB",commonService.IBSheet_select_category_Data(980004));
		mav.addObject("sex_GB",commonService.IBSheet_select_category_Data(980005));
		mav.addObject("memb_status_GB",commonService.IBSheet_select_category_Data(980006));
		
		mav.setViewName("/M980/M9808010");
		commonService.security(mav);
		return mav;
	}
	
	//M9809010 으로 이동하는 함수
	@RequestMapping("/M980/M9809010.do")
	public ModelAndView M9809010(ModelAndView mav) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("col_name","category_CD");
		
		//대분류 목록
		mav.addObject("category_Data",commonService.IBSheet_select_data_master(map));
		
		//M9809010_1_Sheet 컬럼 만들기
		String M9809010_1_Sheet = "["; 
		M9809010_1_Sheet += commonService.IBSheet_col("삭제", 10,false,false,true) + ",";
		M9809010_1_Sheet += commonService.IBSheet_col("상태", 10,false,false,true) + ",";
		M9809010_1_Sheet += commonService.IBSheet_col("category_CD", 60,true,false,true) + ",";
		M9809010_1_Sheet += commonService.IBSheet_col("sub_category_NM", 60,false,false,true) + ",";
		M9809010_1_Sheet += commonService.IBSheet_col("sub_category_CD", 60,true,false,true) + "]";

		mav.addObject("M9809010_1_Sheet", M9809010_1_Sheet);
		
		mav.setViewName("/M980/M9809010");
		
		commonService.security(mav);
		
		return mav;
	}
	
	//코드를 만들기 위한 함수
	@RequestMapping(value = "/M980/make_category_CD.do")
	public String make_category_CD(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD", commonService.user_info().getComp_CD());
		map.put("category_CD", request.getParameter("category_CD"));
		
		model.addAttribute("CD", m980Service.make_category_CD(map));
		
		return "jsonView";
	}
	
	//M980_Data 함수
	@RequestMapping("/M980/Common_Data.do")
	public String M980_Data(@RequestParam Map<String,Object> map,ModelMap model) throws Exception {
		
		if (map.get("order_unit_C") == "") map.put("order_unit_C", 0);
		if (map.get("inventory_unit_C") == "") map.put("inventory_unit_C", 0);
		if (map.get("item_group_C") == "") map.put("item_group_C", 0);

		if (map.get("sStatus") != null) {
			List<Map<String, Object>> list = commonService.IBSheet_Data_Converstion(map);
			
			if (list.get(0).get("sheetNm").toString().equals("M9801010_1_Sheet")) {
				for (int i = 0; i < list.size(); i++) {
					if (list.get(i).get("sStatus").toString().equals("D")) m980Service.M9801010_1_Delete2(list.get(i));					
				}
			}

			if (map.get("sheetNm").equals("M9801030_2_Sheet")) m980Service.M9801030_2_delete(list);
			if (list.get(0).get("sheetNm").toString().equals("M9808010_1_Sheet")) {
				for (int i = 0; i < list.size(); i++) {
					if (list.get(i).get("sStatus").toString().equals("U")) 
						if (!map.get("memb_PW").toString().equals("")) m980Service.M9808010_1_Insert2(list.get(i));
				}
			}					
			if (map.get("sheetNm").equals("M9808010_2_Sheet")) m980Service.M9808010_2_Insert2(list.get(0));		
			commonService.Data_Change(list);			
		}else model.addAttribute("Data",commonService.Data_View(map));
		
		return "jsonView";
	}
	
}
