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
import gom.service.M510Service;
import gom.vo.M510VO;

@Controller(value = "/M510")
public class M510Controller {

	//Common 서비스
	@Resource(name = "CommonService")
	private CommonService commonService;
	
	//M510Service 서비스
	@Resource(name = "M510Service")
	private M510Service m510Service;

	//M5101020 으로 이동하는 함수
	@RequestMapping("/M510/M5101010.do")
	public ModelAndView M5101010(ModelAndView mav) throws Exception {
				
		//M5101010_1_Sheet 컬럼 만들기
		String M5101010_1_Sheet = "["; 
		
		M5101010_1_Sheet += commonService.IBSheet_col("equi_NM", 10,false,false,false) + ",";
		M5101010_1_Sheet += commonService.IBSheet_col("equi_location", 0,false,false,false) + ",";
		M5101010_1_Sheet += commonService.IBSheet_col("equi_standard", 20,false,false,false) + ",";
		M5101010_1_Sheet += commonService.IBSheet_col("memo", 30,false,false,false) + ",";
		M5101010_1_Sheet += commonService.IBSheet_col("last_DT", 20,false,false,false) + ",";
		M5101010_1_Sheet += commonService.IBSheet_col("last_TM", 30,false,false,false) + "]";

		mav.addObject("M5101010_1_Sheet", M5101010_1_Sheet);
		
		mav.setViewName("/M510/M5101010");
		commonService.security(mav);
		return mav;
	}
	
	//M5101020 으로 이동하는 함수
	@RequestMapping("/M510/M5101020.do")
	public ModelAndView M5101020(ModelAndView mav) throws Exception {
				
		List<M510VO> list = m510Service.M5101020_1_View(commonService.user_info().getComp_CD());

		for (int i = 0; i < list.size(); i++) {
			
			list.get(i).setPercentage(Float.parseFloat(String.format("%.1f",(float)list.get(i).getCount() / (float)list.get(i).getTarget_CT() * 100.0)));
			
			mav.addObject("view_spot_"+list.get(i).getView_spot(),list.get(i));
		}
		
		
		mav.setViewName("/M510/M5101020");
		commonService.security(mav);
		return mav;
	}
	
	//M5101021 으로 이동하는 함수
	@RequestMapping("/M510/M5101021.do")
	public ModelAndView M5101021(ModelAndView mav) throws Exception {
		
		//M5101021_1_Sheet 컬럼 만들기
		String M5101021_1_Sheet = "["; 
		M5101021_1_Sheet += commonService.IBSheet_col("삭제", 10,false,false,true) + ",";
		M5101021_1_Sheet += commonService.IBSheet_col("상태", 10,true,false,true) + ",";
		M5101021_1_Sheet += commonService.IBSheet_col("view_spot", 10,false,false,false) + ",";
		M5101021_1_Sheet += commonService.IBSheet_col("comp_CD", 0,true,false,false) + ",";
		M5101021_1_Sheet += commonService.IBSheet_col("equi_CD_combo", 20,false,false,true) + ",";
		M5101021_1_Sheet += commonService.IBSheet_col("equi_location", 30,false,false,false) + ",";
		M5101021_1_Sheet += commonService.IBSheet_col("target_CT", 20,false,true,true) + ",";
		M5101021_1_Sheet += commonService.IBSheet_col("item_CD", 30,false,false,true) + ",";
		M5101021_1_Sheet += commonService.IBSheet_col("cycle", 30,false,false,true) + ",";
		M5101021_1_Sheet += commonService.IBSheet_col("memo", 60,false,false,true) + "]";

		mav.addObject("M5101021_1_Sheet", M5101021_1_Sheet);
		
		mav.setViewName("/M510/M5101021");
		return mav;
	}
	
	//M5101030 으로 이동하는 함수
	@RequestMapping("/M510/M5101030.do")
	public ModelAndView M5101030(ModelAndView mav) throws Exception {
		
		//M5101030_1_Sheet 컬럼 만들기
		String M5101030_1_Sheet = "["; 
		M5101030_1_Sheet += commonService.IBSheet_col("equi_CD", 10,true,false,false) + ",";
		M5101030_1_Sheet += commonService.IBSheet_col("equi_NM", 10,false,false,false) + ",";
		M5101030_1_Sheet += commonService.IBSheet_col("equi_location", 10,false,false,false) + ",";
		M5101030_1_Sheet += commonService.IBSheet_col("equi_standard", 20,false,false,false) + ",";
		M5101030_1_Sheet += commonService.IBSheet_col("memo", 20,true,false,false) + ",";
		M5101030_1_Sheet += commonService.IBSheet_col("total_make", 30,true,false,false) + ",";
		M5101030_1_Sheet += commonService.IBSheet_col("total_error", 20,true,false,false) + ",";
		M5101030_1_Sheet += commonService.IBSheet_col("error_percent", 30,true,false,false) + "]";

		mav.addObject("M5101030_1_Sheet", M5101030_1_Sheet);
		
		//M5101030_2_Sheet 컬럼 만들기
		String M5101030_2_Sheet = "["; 
		M5101030_2_Sheet += commonService.IBSheet_col("check_DT", 10,false,false,false) + ",";
		M5101030_2_Sheet += commonService.IBSheet_col("total_make", 10,false,false,false) + ",";
		M5101030_2_Sheet += commonService.IBSheet_col("total_error", 10,false,false,false) + "]";

		mav.addObject("M5101030_2_Sheet", M5101030_2_Sheet);
		
		mav.setViewName("/M510/M5101030");
		return mav;
	}
	
	//M5102010 으로 이동하는 함수
	@RequestMapping("/M510/M5102010.do")
	public ModelAndView M5102010(ModelAndView mav) throws Exception {
		
		//M5102010_1_Sheet 컬럼 만들기
		String M5102010_1_Sheet = "["; 
		M5102010_1_Sheet += commonService.IBSheet_col("equi_NM", 0,false,false,false) + ",";
		M5102010_1_Sheet += commonService.IBSheet_col("equi_location", 0,false,false,false) + ",";
		M5102010_1_Sheet += commonService.IBSheet_col("equi_standard", 0,false,false,false) + ",";
		M5102010_1_Sheet += commonService.IBSheet_col("check_DT", 0,false,false,false) + ",";
		M5102010_1_Sheet += commonService.IBSheet_col("check_TM", 0,false,false,false) + ",";
		M5102010_1_Sheet += commonService.IBSheet_col("error_FL", 0,false,false,false) + "]";

		mav.addObject("M5102010_1_Sheet", M5102010_1_Sheet);
		
		mav.setViewName("/M510/M5102010");
		return mav;
	}
	
	//M5102020 으로 이동하는 함수
	@RequestMapping("/M510/M5102020.do")
	public ModelAndView M5102020(ModelAndView mav) throws Exception {
		
		//M5102020_1_Sheet 컬럼 만들기
		String M5102020_1_Sheet = "["; 
		M5102020_1_Sheet += commonService.IBSheet_col("상태", 0,true,false,true) + ",";
		M5102020_1_Sheet += commonService.IBSheet_col("equi_CD", 0,true,false,false) + ",";
		M5102020_1_Sheet += commonService.IBSheet_col("equi_NM", 0,false,false,false) + ",";
		M5102020_1_Sheet += commonService.IBSheet_col("equi_location", 0,false,false,false) + ",";
		M5102020_1_Sheet += commonService.IBSheet_col("equi_standard", 0,false,false,false) + ",";
		M5102020_1_Sheet += commonService.IBSheet_col("check_DT", 0,false,false,false) + ",";
		M5102020_1_Sheet += commonService.IBSheet_col("check_TM", 0,false,false,false) + ",";
		M5102020_1_Sheet += commonService.IBSheet_col("error_FL", 0,false,false,true) + "]";

		mav.addObject("M5102020_1_Sheet", M5102020_1_Sheet);
		
		mav.setViewName("/M510/M5102020");
		return mav;
	}
	
	//M5102030 으로 이동하는 함수
	@RequestMapping("/M510/M5102030.do")
	public ModelAndView M5102030(ModelAndView mav) throws Exception {
		
		//M5102030_1_Sheet 컬럼 만들기
		String M5102030_1_Sheet = "["; 
		M5102030_1_Sheet += commonService.IBSheet_col("equi_CD", 10,true,false,false) + ",";
		M5102030_1_Sheet += commonService.IBSheet_col("equi_NM", 10,false,false,false) + ",";
		M5102030_1_Sheet += commonService.IBSheet_col("equi_location", 10,false,false,false) + ",";
		M5102030_1_Sheet += commonService.IBSheet_col("equi_standard", 20,false,false,false) + "]";

		mav.addObject("M5102030_1_Sheet", M5102030_1_Sheet);
		
		//M5102030_2_Sheet 컬럼 만들기
		String M5102030_2_Sheet = "["; 
		M5102030_2_Sheet += commonService.IBSheet_col("check_DT", 10,false,false,false) + ",";
		M5102030_2_Sheet += commonService.IBSheet_col("ing_time", 10,false,false,false) + ",";
		M5102030_2_Sheet += commonService.IBSheet_col("total_make", 10,false,false,false) + "]";

		mav.addObject("M5102030_2_Sheet", M5102030_2_Sheet);
		
		mav.setViewName("/M510/M5102030");
		return mav;
	}
	
	//M5102040 으로 이동하는 함수
	@RequestMapping("/M510/M5102040.do")
	public ModelAndView M5102040(ModelAndView mav) throws Exception {
		
		//M5102040_1_Sheet 컬럼 만들기
		String M5102040_1_Sheet = "["; 
		M5102040_1_Sheet += commonService.IBSheet_col("equi_CD", 10,true,false,false) + ",";
		M5102040_1_Sheet += commonService.IBSheet_col("equi_NM", 10,false,false,false) + ",";
		M5102040_1_Sheet += commonService.IBSheet_col("equi_location", 10,false,false,false) + ",";
		M5102040_1_Sheet += commonService.IBSheet_col("equi_standard", 20,false,false,false) + "]";

		mav.addObject("M5102040_1_Sheet", M5102040_1_Sheet);
		
		//M5102040_2_Sheet 컬럼 만들기
		String M5102040_2_Sheet = "["; 
		M5102040_2_Sheet += commonService.IBSheet_col("check_DT", 10,false,false,false) + ",";
		M5102040_2_Sheet += commonService.IBSheet_col("total_make", 10,false,false,false) + ",";
		M5102040_2_Sheet += commonService.IBSheet_col("total_error", 10,false,false,false) + "]";

		mav.addObject("M5102040_2_Sheet", M5102040_2_Sheet);
		
		mav.setViewName("/M510/M5102040");
		return mav;
	}
	
	//M5102050 으로 이동하는 함수
	@RequestMapping("/M510/M5102050.do")
	public ModelAndView M5102050(ModelAndView mav) throws Exception {
		
		//M5102050_1_Sheet 컬럼 만들기
		String M5102050_1_Sheet = "["; 
		M5102050_1_Sheet += commonService.IBSheet_col("send_DTTM", 10,false,false,false) + ",";
		M5102050_1_Sheet += commonService.IBSheet_col("kpiFld_CD", 10,true,false,false) + ",";
		M5102050_1_Sheet += commonService.IBSheet_col("kpiDtl_CD", 10,true,false,false) + ",";
		M5102050_1_Sheet += commonService.IBSheet_col("value", 10,true,false,false) + ",";
		M5102050_1_Sheet += commonService.IBSheet_col("rate", 10,true,false,false) + "]";	

		mav.addObject("M5102050_1_Sheet", M5102050_1_Sheet);
		
		//M5102050_2_Sheet 컬럼 만들기
		String M5102050_2_Sheet = "["; 
		M5102050_2_Sheet += commonService.IBSheet_col("send_DTTM", 10,false,false,false) + ",";
		M5102050_2_Sheet += commonService.IBSheet_col("kpiFld_CD", 10,false,false,false) + ",";
		M5102050_2_Sheet += commonService.IBSheet_col("kpiDtl_CD", 10,false,false,false) + ",";
		M5102050_2_Sheet += commonService.IBSheet_col("value", 10,false,false,false) + ",";
		M5102050_2_Sheet += commonService.IBSheet_col("rate", 10,false,false,false) + "]";				

		mav.addObject("M5102050_2_Sheet", M5102050_2_Sheet);
		
		//M5102050_3_Sheet 컬럼 만들기
		String M5102050_3_Sheet = "["; 
		M5102050_3_Sheet += commonService.IBSheet_col("send_DTTM", 10,false,false,false) + ",";
		M5102050_3_Sheet += commonService.IBSheet_col("kpiFld_CD", 10,false,false,false) + ",";
		M5102050_3_Sheet += commonService.IBSheet_col("kpiDtl_CD", 10,false,false,false) + ",";
		M5102050_3_Sheet += commonService.IBSheet_col("value", 10,false,false,false) + ",";
		M5102050_3_Sheet += commonService.IBSheet_col("rate", 10,false,false,false) + "]";				

		mav.addObject("M5102050_3_Sheet", M5102050_3_Sheet);
		
		mav.setViewName("/M510/M5102050");
		return mav;
	}
	
	//M5102060 으로 이동하는 함수
	@RequestMapping("/M510/M5102060.do")
	public ModelAndView M5102060(ModelAndView mav) throws Exception {
				
		//M5102060_1_Sheet 컬럼 만들기
		String M5102060_1_Sheet = "["; 
		
		M5102060_1_Sheet += commonService.IBSheet_col("kpiFld_CD", 20,false,false,false) + ",";
		M5102060_1_Sheet += commonService.IBSheet_col("kpiDtl_CD", 20,false,false,false) + ",";
		M5102060_1_Sheet += commonService.IBSheet_col("unit", 20,false,false,false) + ",";
		M5102060_1_Sheet += commonService.IBSheet_col("cycle", 20,false,false,false) + ",";
		M5102060_1_Sheet += commonService.IBSheet_col("befor_CT", 20,false,false,false) + ",";
		M5102060_1_Sheet += commonService.IBSheet_col("taget_CT", 20,false,false,false) + ",";
		M5102060_1_Sheet += commonService.IBSheet_col("improvement_rate", 20,false,false,false) + ",";
		M5102060_1_Sheet += commonService.IBSheet_col("achievement_rate", 20,false,false,false) + "]";

		System.out.println(M5102060_1_Sheet);
		mav.addObject("M5102060_1_Sheet", M5102060_1_Sheet);
		
		mav.setViewName("/M510/M5102060");
		commonService.security(mav);
		return mav;
	}
	
	//코드를 만들기 위한 함수
	@RequestMapping(value = "/M510/get_equi_location.do")
	public String make_CD(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD", commonService.user_info().getComp_CD());
		map.put("equi_CD", request.getParameter("equi_CD").toString());

		model.addAttribute("equi_location", m510Service.get_equi_location(map));
		
		return "jsonView";
	}
	
	//M510_DataIn 함수
	@RequestMapping("/M510/DataIn.do")
	public void M510_DataIn(HttpServletRequest request, HttpServletResponse responsel) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_CD", request.getParameter("comp_CD").toString());		
		map.put("equi_CD", request.getParameter("equi_CD").toString());
		
		if (request.getParameter("read_TM") == null || request.getParameter("read_TM") == "") map.put("read_TM", 0);
		else map.put("read_TM", request.getParameter("read_TM").toString());
		
		m510Service.M510_DataIn(map);

		if (request.getParameter("comp_CD").toString().equals("COM202408260003")) {
			Thread.sleep(2000);
			m510Service.M510_DataIn(map);
		}
		
		
	}
	
	//M510_InKpi 함수
	@RequestMapping("/M510/InKpi.do")
	public void M510_InKpi(HttpServletRequest request, HttpServletResponse responsel) throws Exception {
		
		int cycle = Integer.parseInt(request.getParameter("cycle").toString());

		m510Service.M510_InKpi(cycle);
		
	}
	
	//M510_Data 함수
	@RequestMapping("/M510/Common_Data.do")
	public String M510_Data(@RequestParam Map<String,Object> map,ModelMap model) throws Exception {
		
		if (map.get("sStatus") != null) commonService.Data_Change(commonService.IBSheet_Data_Converstion(map));			
		else model.addAttribute("Data",commonService.Data_View(map));
		return "jsonView";
	}
	
}
