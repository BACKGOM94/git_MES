package gom.controller;

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
import gom.service.M970Service;
import gom.vo.CommonVO;
import gom.vo.M970VO;

@Controller(value = "/M970")
public class M970Controller {

	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	//M970Service 서비스
	@Resource(name = "M970Service")
	private M970Service M970Service;

	//M9701010 으로 이동하는 함수
	@RequestMapping("/M970/M9701010.do")
	public ModelAndView M9701010(ModelAndView mav) throws Exception {

		//M9701010_1_Sheet 컬럼 만들기
		String M9701010_1_Sheet = "["; 
		
		M9701010_1_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("상태", 0,true,false,false) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("data_CD_97", 0,true,false,false) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("regist_DT", 0,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("division", 0,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("item_CD_97_combo", 0,false,false,false) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("lot_CD_97_combo", 0,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("count_97", 0,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("supply_clie_CD_97", 0,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("enter_clie_CD_97", 0,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("exit_clie_CD_97", 0,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("in_quantity", 0,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("out_quantity", 0,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("inventory", 0,false,false,false) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("real_order", 0,false,false,true) + ",";
		M9701010_1_Sheet += commonService.IBSheet_col("memo", 80,false,false,true) + "]";

		mav.addObject("M9701010_1_Sheet", M9701010_1_Sheet);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD",commonService.user_info().getComp_CD());
		map.put("col_name","color_CD_97");
		mav.addObject("color_CD_97",commonService.IBSheet_select_data_master(map));
		map.put("col_name", "item_CD_97");
		mav.addObject("item_CD_97",commonService.IBSheet_select_data_master(map));

		mav.setViewName("/M970/M9701010");
		commonService.security(mav);
		return mav;
	}
	
	//M9701020 으로 이동하는 함수
	@RequestMapping("/M970/M9701020.do")
	public ModelAndView M9701020(ModelAndView mav) throws Exception {
				
		//M9701020_1_Sheet 컬럼 만들기
		String M9701020_1_Sheet = "["; 
		
		M9701020_1_Sheet += commonService.IBSheet_col("상태", 0,true,false,false) + ",";
		M9701020_1_Sheet += commonService.IBSheet_col("exit_CD_97", 0,true,false,false) + ",";
		M9701020_1_Sheet += commonService.IBSheet_col("regist_DT", 0,false,false,false) + ",";
		M9701020_1_Sheet += commonService.IBSheet_col("enter_clie_CD_97", 0,false,false,false) + ",";
		M9701020_1_Sheet += commonService.IBSheet_col("exit_clie_CD_97", 0,false,false,false) + ",";
		M9701020_1_Sheet += commonService.IBSheet_col("supply_clie_CD_97", 0,false,false,true) + ",";
		M9701020_1_Sheet += commonService.IBSheet_col("total_price", 0,false,false,false) + ",";
		M9701020_1_Sheet += commonService.IBSheet_col("box_CT", 0,false,false,true) + ",";
		M9701020_1_Sheet += commonService.IBSheet_col("order_NO", 0,false,false,true) + "]";

		mav.addObject("M9701020_1_Sheet", M9701020_1_Sheet);
		
		//M9701020_2_Sheet 컬럼 만들기
		String M9701020_2_Sheet = "["; 
		
		M9701020_2_Sheet += commonService.IBSheet_col("상태", 0,true,false,false) + ",";
		M9701020_2_Sheet += commonService.IBSheet_col("data_CD_97", 0,true,false,false) + ",";
		M9701020_2_Sheet += commonService.IBSheet_col("exit_CD_97", 0,true,false,false) + ",";
		M9701020_2_Sheet += commonService.IBSheet_col("lot_CD_97_combo", 0,false,false,false) + ",";
		M9701020_2_Sheet += commonService.IBSheet_col("count_97", 0,false,false,false) + ",";
		M9701020_2_Sheet += commonService.IBSheet_col("item_CD_97_combo", 0,false,false,false) + ",";
		M9701020_2_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701020_2_Sheet += commonService.IBSheet_col("price", 0,false,false,true) + ",";
		M9701020_2_Sheet += commonService.IBSheet_col("out_quantity", 0,false,false,false) + ",";
		M9701020_2_Sheet += commonService.IBSheet_col("total_price", 0,false,false,false) + ",";
		M9701020_2_Sheet += commonService.IBSheet_col("memo", 50,false,false,true) + "]";

		mav.addObject("M9701020_2_Sheet", M9701020_2_Sheet);

		mav.setViewName("/M970/M9701020");
		commonService.security(mav);
		return mav;
	}
	
	//M9701021 으로 이동하는 함수
	@RequestMapping("/M970/M9701021.do")
	public ModelAndView M9701021(ModelAndView mav) throws Exception {
				
		//M9701021_1_Sheet 컬럼 만들기
		String M9701021_1_Sheet = "["; 
		
		M9701021_1_Sheet += commonService.IBSheet_col("삭제", 0,false,false,true) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("상태", 0,true,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("data_CD_97", 0,true,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("exit_CD_97", 0,true,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("lot_CD_97_combo", 0,false,true,true) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("count_97", 0,false,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("item_CD_97_combo", 0,false,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("price", 0,false,false,true) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("out_quantity", 0,false,true,true) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("total_price", 0,false,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("memo", 50,false,false,true) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("enter_clie_CD_97", 0,true,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("exit_clie_CD_97", 0,true,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("supply_clie_CD_97", 0,true,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("regist_DT", 0,true,false,false) + ",";
		M9701021_1_Sheet += commonService.IBSheet_col("box_CT", 0,true,false,false) + "]";

		mav.addObject("M9701021_1_Sheet", M9701021_1_Sheet);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD",commonService.user_info().getComp_CD());
		
		map.put("col_name","enter_clie_CD_97");
		mav.addObject("enter_clie_CD_97",commonService.IBSheet_select_data_master(map));
		map.put("col_name", "exit_clie_CD_97");
		mav.addObject("exit_clie_CD_97",commonService.IBSheet_select_data_master(map));
		map.put("col_name", "supply_clie_CD_97");
		mav.addObject("supply_clie_CD_97",commonService.IBSheet_select_data_master(map));
		mav.setViewName("/M970/M9701021");

		return mav;
	}
	
	//M9701030 으로 이동하는 함수
	@RequestMapping("/M970/M9701030.do")
	public ModelAndView M9701030(ModelAndView mav) throws Exception {
				
		//M9701030_1_Sheet 컬럼 만들기
		String M9701030_1_Sheet = "["; 
		
		M9701030_1_Sheet += commonService.IBSheet_col("supply_clie_CD_97", 0,false,false,false) + ",";
		M9701030_1_Sheet += commonService.IBSheet_col("total_price", 0,false,false,false) + "]";

		mav.addObject("M9701030_1_Sheet", M9701030_1_Sheet);
		
		//M9701030_2_Sheet 컬럼 만들기
		String M9701030_2_Sheet = "["; 
		
		M9701030_2_Sheet += commonService.IBSheet_col("상태", 0,true,false,false) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("exit_CD_97", 0,true,false,false) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("data_CD_97", 0,true,false,false) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("regist_DT", 0,false,false,false) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("item_CD_97_combo", 0,false,false,false) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("exit_clie_CD_97", 0,false,false,false) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("out_quantity", 0,false,false,false) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("price", 0,false,false,false) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("total_price", 0,false,false,false) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("style_NO", 50,false,false,true) + ",";
		M9701030_2_Sheet += commonService.IBSheet_col("order_NO", 50,false,false,true) + "]";

		mav.addObject("M9701030_2_Sheet", M9701030_2_Sheet);
		
		//M9701030_3_Sheet 컬럼 만들기
		String M9701030_3_Sheet = "["; 
		
		M9701030_3_Sheet += commonService.IBSheet_col("supply_clie_CD_97", 0,false,false,false) + ",";
		M9701030_3_Sheet += commonService.IBSheet_col("total_price", 0,false,false,false) + "]";

		mav.addObject("M9701030_3_Sheet", M9701030_3_Sheet);
		
		//M9701030_4_Sheet 컬럼 만들기
		String M9701030_4_Sheet = "["; 
		
		M9701030_4_Sheet += commonService.IBSheet_col("상태", 0,true,false,false) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("exit_CD_97", 0,true,false,false) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("data_CD_97", 0,true,false,false) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("regist_DT", 0,false,false,false) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("item_CD_97_combo", 0,false,false,false) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("exit_clie_CD_97", 0,false,false,false) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("out_quantity", 0,false,false,false) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("price", 0,false,false,false) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("total_price", 0,false,false,false) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("style_NO", 50,false,false,true) + ",";
		M9701030_4_Sheet += commonService.IBSheet_col("order_NO", 50,false,false,true) + "]";

		mav.addObject("M9701030_4_Sheet", M9701030_4_Sheet);

		mav.setViewName("/M970/M9701030");
		
		commonService.security(mav);
		return mav;
	}
	
	//M9701040 으로 이동하는 함수
	@RequestMapping("/M970/M9701040.do")
	public ModelAndView M9701040(ModelAndView mav) throws Exception {
				
		//M9701040_1_Sheet 컬럼 만들기
		String M9701040_1_Sheet = "["; 
		
		M9701040_1_Sheet += commonService.IBSheet_col("lot_CD_97_combo", 0,false,false,false) + ",";
		M9701040_1_Sheet += commonService.IBSheet_col("item_CD_97_combo", 0,false,false,false) + ",";
		M9701040_1_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701040_1_Sheet += commonService.IBSheet_col("inventory", 0,false,false,false) + "]";

		mav.addObject("M9701040_1_Sheet", M9701040_1_Sheet);
		
		//M9701040_2_Sheet 컬럼 만들기
		String M9701040_2_Sheet = "["; 
		
		M9701040_2_Sheet += commonService.IBSheet_col("lot_CD_97_combo", 0,false,false,false) + ",";
		M9701040_2_Sheet += commonService.IBSheet_col("item_CD_97_combo", 0,false,false,false) + ",";
		M9701040_2_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701040_2_Sheet += commonService.IBSheet_col("inventory", 0,false,false,false) + "]";

		mav.addObject("M9701040_2_Sheet", M9701040_2_Sheet);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD",commonService.user_info().getComp_CD());
		map.put("col_name", "item_CD_97");
		mav.addObject("item_CD_97",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M970/M9701040");
		
		commonService.security(mav);
		return mav;
	}
	
	//M9701050 으로 이동하는 함수
	@RequestMapping("/M970/M9701050.do")
	public ModelAndView M9701050(ModelAndView mav) throws Exception {
				
		//M9701040_1_Sheet 컬럼 만들기
		String M9701050_1_Sheet = "["; 
		
		M9701050_1_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701050_1_Sheet += commonService.IBSheet_col("inventory", 0,false,false,false) + "]";

		mav.addObject("M9701050_1_Sheet", M9701050_1_Sheet);
		
		//M9701050_2_Sheet 컬럼 만들기
		String M9701050_2_Sheet = "["; 
		
		M9701050_2_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701050_2_Sheet += commonService.IBSheet_col("out_quantity", 0,false,false,true) + "]";

		mav.addObject("M9701050_2_Sheet", M9701050_2_Sheet);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD",commonService.user_info().getComp_CD());
		map.put("col_name", "item_CD_97");
		mav.addObject("item_CD_97",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M970/M9701050");
		
		commonService.security(mav);
		return mav;
	}
	
	//M9701060 으로 이동하는 함수
	@RequestMapping("/M970/M9701060.do")
	public ModelAndView M9701060(ModelAndView mav) throws Exception {
				
		//M9701060_1_Sheet 컬럼 만들기
		String M9701060_1_Sheet = "["; 
		
		M9701060_1_Sheet += commonService.IBSheet_col("client_CD_97_combo", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b1_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b1_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b1_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b2_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b2_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b2_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b3_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b3_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b3_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b4_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b4_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b4_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b5_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b5_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b5_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b6_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b6_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b6_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b7_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b7_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b7_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b8_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b8_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b8_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b9_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b9_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b9_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b10_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b10_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b10_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b11_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b11_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b11_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b12_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b12_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("b12_re", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("to_in", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("to_out", 0,false,false,false) + ",";
		M9701060_1_Sheet += commonService.IBSheet_col("to_re", 0,false,false,false) + "]";

		mav.addObject("M9701060_1_Sheet", M9701060_1_Sheet);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD",commonService.user_info().getComp_CD());
		map.put("col_name", "item_CD_97");
		mav.addObject("item_CD_97",commonService.IBSheet_select_data_master(map));

		mav.setViewName("/M970/M9701060");

		commonService.security(mav);
		return mav;
	}
	
	//M9701070 으로 이동하는 함수
	@RequestMapping("/M970/M9701070.do")
	public ModelAndView M9701070(ModelAndView mav) throws Exception {
				
		//M9701070_1_Sheet 컬럼 만들기
		String M9701070_1_Sheet = "["; 
		
		M9701070_1_Sheet += commonService.IBSheet_col("client_CD_97_combo", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_1_in", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_1_out", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_1_re", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_2_in", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_2_out", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_2_re", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_3_in", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_3_out", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_3_re", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_4_in", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_4_out", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("b_4_re", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("to_in", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("to_out", 0,false,false,false) + ",";
		M9701070_1_Sheet += commonService.IBSheet_col("to_re", 0,false,false,false) + "]";

		mav.addObject("M9701070_1_Sheet", M9701070_1_Sheet);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD",commonService.user_info().getComp_CD());
		map.put("col_name", "item_CD_97");
		mav.addObject("item_CD_97",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M970/M9701070");
		
		commonService.security(mav);
		return mav;
	}
	
	//M9701080 으로 이동하는 함수
	@RequestMapping("/M970/M9701080.do")
	public ModelAndView M9701080(ModelAndView mav) throws Exception {
				
		//M9701080_1_Sheet 컬럼 만들기
		String M9701080_1_Sheet = "["; 
		
		M9701080_1_Sheet += commonService.IBSheet_col("lot_CD_97_combo", 0,false,false,false) + ",";
		M9701080_1_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701080_1_Sheet += commonService.IBSheet_col("yesterday_inventory", 0,false,false,false) + ",";
		M9701080_1_Sheet += commonService.IBSheet_col("in_quantity", 0,false,false,false) + ",";
		M9701080_1_Sheet += commonService.IBSheet_col("out_quantity", 0,false,false,false) + ",";
		M9701080_1_Sheet += commonService.IBSheet_col("re_quantity", 0,false,false,false) + ",";
		M9701080_1_Sheet += commonService.IBSheet_col("inventory", 0,false,false,false) + "]";

		mav.addObject("M9701080_1_Sheet", M9701080_1_Sheet);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD",commonService.user_info().getComp_CD());
		map.put("col_name", "item_CD_97");
		mav.addObject("item_CD_97",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M970/M9701080");
		
		commonService.security(mav);
		return mav;
	}
	
	//M9701090 으로 이동하는 함수
	@RequestMapping("/M970/M9701090.do")
	public ModelAndView M9701090(ModelAndView mav) throws Exception {
				
		//M9701090_1_Sheet 컬럼 만들기
		String M9701090_1_Sheet = "["; 
		
		M9701090_1_Sheet += commonService.IBSheet_col("color_CD_97_combo", 0,false,false,false) + ",";
		M9701090_1_Sheet += commonService.IBSheet_col("yesterday_inventory", 0,false,false,false) + ",";
		M9701090_1_Sheet += commonService.IBSheet_col("in_quantity", 0,false,false,false) + ",";
		M9701090_1_Sheet += commonService.IBSheet_col("out_quantity", 0,false,false,false) + ",";
		M9701090_1_Sheet += commonService.IBSheet_col("re_quantity", 0,false,false,false) + ",";
		M9701090_1_Sheet += commonService.IBSheet_col("inventory", 0,false,false,false) + "]";

		mav.addObject("M9701090_1_Sheet", M9701090_1_Sheet);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD",commonService.user_info().getComp_CD());
		map.put("col_name", "item_CD_97");
		mav.addObject("item_CD_97",commonService.IBSheet_select_data_master(map));
		
		map.put("col_name", "supply_clie_CD_97");
		mav.addObject("supply_clie_CD_97",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M970/M9701090");
		
		commonService.security(mav);
		return mav;
	}
	
	//M9709010 으로 이동하는 함수
	@RequestMapping("/M970/M9709010.do")
	public ModelAndView M9709010(ModelAndView mav) throws Exception {
				
		//M9709010_1_Sheet 컬럼 만들기
		String M9709010_1_Sheet = "["; 
		
		M9709010_1_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M9709010_1_Sheet += commonService.IBSheet_col("상태", 20,false,false,false) + ",";
		M9709010_1_Sheet += commonService.IBSheet_col("lot_CD_97", 0,true,false,false) + ",";
		M9709010_1_Sheet += commonService.IBSheet_col("lot_NM_97", 50,false,true,true) + ",";
		M9709010_1_Sheet += commonService.IBSheet_col("color_CD_97_combo", 40,false,false,true) + ",";
		M9709010_1_Sheet += commonService.IBSheet_col("item_CD_97_combo", 40,false,false,true) + ",";
		M9709010_1_Sheet += commonService.IBSheet_col("count_97", 40,false,false,true) + ",";
		M9709010_1_Sheet += commonService.IBSheet_col("memo", 90,false,false,true) + "]";

		mav.addObject("M9709010_1_Sheet", M9709010_1_Sheet);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD",commonService.user_info().getComp_CD());
		map.put("col_name","color_CD_97");
		mav.addObject("color_CD_97",commonService.IBSheet_select_data_master(map));
		map.put("col_name", "item_CD_97");
		mav.addObject("item_CD_97",commonService.IBSheet_select_data_master(map));
		
		mav.setViewName("/M970/M9709010");
		commonService.security(mav);
		return mav;
	}
	
	//M9709020 으로 이동하는 함수
	@RequestMapping("/M970/M9709020.do")
	public ModelAndView M9709020(ModelAndView mav) throws Exception {
				
		//M9709020_1_Sheet 컬럼 만들기
		String M9709020_1_Sheet = "["; 
		
		M9709020_1_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("상태", 10,true,false,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("client_CD_97", 0,true,false,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("client_NM_97", 60,false,true,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("contact_97", 60,false,false,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("phone_NO_97", 0,true,false,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("address", 0,true,false,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("account_NO", 0,true,false,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("real_order", 0,true,false,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("enter_FL_97", 0,true,false,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("exit_FL_97", 0,true,false,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("memo", 0,false,false,false) + ",";
		M9709020_1_Sheet += commonService.IBSheet_col("supply_FL_97", 0,true,false,false) + "]";
		mav.addObject("M9709020_1_Sheet", M9709020_1_Sheet);
		
		//M9709020_2_Sheet 컬럼 만들기
		String M9709020_2_Sheet = "["; 
		
		M9709020_2_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M9709020_2_Sheet += commonService.IBSheet_col("상태", 20,false,false,false) + ",";
		M9709020_2_Sheet += commonService.IBSheet_col("client_CD_97", 0,true,false,false) + ",";
		M9709020_2_Sheet += commonService.IBSheet_col("item_CD_97_combo", 60,false,true,true) + ",";
		M9709020_2_Sheet += commonService.IBSheet_col("price", 60,false,true,true) + "]";

		mav.addObject("M9709020_2_Sheet", M9709020_2_Sheet);
		
		mav.setViewName("/M970/M9709020");
		commonService.security(mav);
		return mav;
	}
	
	//M9709030 으로 이동하는 함수
	@RequestMapping("/M970/M9709030.do")
	public ModelAndView M9709030(ModelAndView mav) throws Exception {
				
		//M9709030_1_Sheet 컬럼 만들기
		String M9709030_1_Sheet = "["; 
		
		M9709030_1_Sheet += commonService.IBSheet_col("삭제", 20,false,false,true) + ",";
		M9709030_1_Sheet += commonService.IBSheet_col("상태", 20,false,false,false) + ",";
		M9709030_1_Sheet += commonService.IBSheet_col("item_CD_97", 0,true,false,false) + ",";
		M9709030_1_Sheet += commonService.IBSheet_col("item_NM_97", 0,false,true,true) + ",";
		M9709030_1_Sheet += commonService.IBSheet_col("price", 0,false,true,true) + "]";

		mav.addObject("M9709030_1_Sheet", M9709030_1_Sheet);
		
		mav.setViewName("/M970/M9709030");
		commonService.security(mav);
		return mav;
	}
	
	//M9709040 으로 이동하는 함수
	@RequestMapping("/M970/M9709040.do")
	public ModelAndView M9709040(ModelAndView mav) throws Exception {
				
		//M9709040_1_Sheet 컬럼 만들기
		String M9709040_1_Sheet = "["; 
		
		M9709040_1_Sheet += commonService.IBSheet_col("삭제", 10,false,false,true) + ",";
		M9709040_1_Sheet += commonService.IBSheet_col("상태", 10,false,false,false) + ",";
		M9709040_1_Sheet += commonService.IBSheet_col("color_CD_97", 0,true,false,false) + ",";
		M9709040_1_Sheet += commonService.IBSheet_col("color_NM_97", 0,false,true,true) + "]";

		mav.addObject("M9709040_1_Sheet", M9709040_1_Sheet);
		
		mav.setViewName("/M970/M9709040");
		commonService.security(mav);
		return mav;
	}
	
	//Lot 변경시 Lot 타입에 맞는 데이터 가져오기
	@RequestMapping(value = "/M970/Lot_Change.do")
	public String Lot_Change(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("lot_CD_97", request.getParameter("lot_CD_97").toString());
		map.put("supply_clie_CD", request.getParameter("supply_clie_CD").toString());
		map.put("comp_CD", commonService.user_info().getComp_CD());
		
		model.addAttribute("info", M970Service.Lot_Change(map));
		
		return "jsonView";
	}	
	//M970_Data 함수
	@RequestMapping("/M970/Common_Data.do")
	public String M970_Data(@RequestParam Map<String,Object> map,ModelMap model) throws Exception {		
		if (map.get("sStatus") != null) {		
			if (map.get("sheetNm").equals("M9709030_2_Sheet")) M970Service.M9709030_2_Delete(map);
			commonService.Data_Change(commonService.IBSheet_Data_Converstion(map));			
		}else model.addAttribute("Data",commonService.Data_View(map));		
		return "jsonView";
	}
	
}
