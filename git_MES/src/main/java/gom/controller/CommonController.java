package gom.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.json.stream.JsonParserFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import gom.service.CommonService;
import gom.vo.CommonVO;
import gom.vo.UserVO;

@Controller(value = "/Common")
public class CommonController {
	
	@Resource(name = "CommonService")
	private CommonService commonservice;
	
	//로그인시 최초 탭 생성
	@RequestMapping("/Common/main_Tab_create.do")
	public ModelAndView main_Tab_create (HttpServletRequest request, HttpServletResponse response,ModelAndView mav) throws Exception {
		
		mav.addObject("path",commonservice.user_info().getComp_en_NM());
		mav.setViewName("/Common/inc/main_Tab");

		return mav;
	}
	
	//로그인 함수
	@RequestMapping(value = "/Common/actionLogin.do")
	public ModelAndView actionLogin(ModelAndView mav, @ModelAttribute("CommonVO") CommonVO commonVO,
																HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//로그인 정보를 저장해줄 객체
		UserVO userVO = commonservice.actionLogin(commonVO);
		
		//로그인 실패시
		if (userVO == null) {
			mav.addObject("login_status","N");
			mav.setViewName("/Common/LoginPage");
		}else {
			//사용자 인증 
			request.getSession().setAttribute("loginVO", userVO);
			request.getSession().setAttribute("accessUser", userVO.getMemb_ID());
			
			//로그인로그를 남기기 위한 셋팅
			commonVO.setComp_CD(userVO.getComp_CD());

            URL url = new URL("http://checkip.amazonaws.com");
            URLConnection connection = url.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            commonVO.setIP(in.readLine());	

            //로그인로그 완료
            commonservice.make_log(commonVO);
            
            //로그인 완료 , 메인페이지 이동
			mav.addObject("userInfo",userVO);
			mav.setViewName("/Common/MainPage");
		}
		
		return mav;
	}
	
	//메인페이지 이동 함수
	@RequestMapping(value = "/Common/actionMainPage.do")
	public ModelAndView actionMainPage(ModelAndView mav,HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserVO userVO = commonservice.user_info();
		mav.addObject("userInfo",userVO);
		mav.setViewName("/Common/MainPage");
		return mav;
	}
	
	//로그아웃 함수
	@RequestMapping(value = "/Common/actionLogout.do")
	public ModelAndView actionLogout(ModelAndView mav,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.getSession().setAttribute("loginVO", null);
		request.getSession().setAttribute("accessUser", null);
		mav.setViewName("/Common/LoginPage");
		return mav;
	}
	
    //비밀번호 변경페이지 이동
    @RequestMapping("/Common/pwdChange.do")
    public ModelAndView pwdChange(ModelAndView mav) throws Exception 
    {
    	mav.addObject("memb_ID", commonservice.user_info().getMemb_ID());
    	mav.setViewName("/Common/pwdChangePage");
    	return mav;
    }
    
	//비밀번호 변경을 위한 함수
	@RequestMapping(value = "/Common/action_pwdChange.do")
	public String action_pwdChange(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {
		
		int status = 1;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("comp_CD", commonservice.user_info().getComp_CD());
		map.put("memb_ID", request.getParameter("memb_ID").toString());
		map.put("memb_PW", request.getParameter("memb_PW").toString());
		if (commonservice.check_pwdChange(map) == 1) {
			map.put("memb_PW", request.getParameter("chpw").toString());
			commonservice.action_pwdChange(map);
		}else status = 2;

		model.addAttribute("status", status);
		return "jsonView";
	}
	
	//최초 접속 및 접근 권한이 없는 항목으로 이동할때 초기화면으로 이동해주는 함수
	@RequestMapping(value = "/Common/LoginPage.do")
	public ModelAndView LoginPage(ModelAndView mav) throws Exception {
		mav.setViewName("/Common/LoginPage");
		return mav;
	}
	
	//로그인시 권한에 맞춰서 Top 메뉴 생성 
	@RequestMapping("/Common/get_Top_menu.do")
	public String get_Top_menu(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception{
		CommonVO commonVO = new CommonVO();
		commonVO.setMemb_ID(commonservice.user_info().getMemb_ID());
		
		model.addAttribute("Top_menu_List", commonservice.get_Top_menu(commonVO));

		return "jsonView";
	}
	
	//로그인시 권한에 맞춰서 Left 메뉴 생성 
	@RequestMapping("/Common/get_Left_menu.do")
	public String get_Left_menu(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception{
		
		CommonVO commonVO = new CommonVO();
		commonVO.setMemb_ID(commonservice.user_info().getMemb_ID());
		commonVO.setMenu_CD(Integer.parseInt(request.getParameter("menu_CD")));
		model.addAttribute("Left_menu_List", commonservice.get_Left_menu(commonVO));	

	
		return "jsonView";
	}
	
	//코드를 만들기 위한 함수
	@RequestMapping(value = "/Common/make_CD.do")
	public String make_CD(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {
		model.addAttribute("CD", commonservice.make_CD(request.getParameter("unionKey").toString()));
		return "jsonView";
	}

	//중복확인을 위한 함수
	@RequestMapping(value = "/Common/double_Check.do")
	public String double_Check(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("value", request.getParameter("value").toString());
		map.put("col_NM", request.getParameter("col_NM").toString());
		map.put("comp_CD", commonservice.user_info().getComp_CD());
		
		model.addAttribute("count", commonservice.double_Check(map));
		
		return "jsonView";
	}	
	
	//데이터값에 따른 다른 데이터 변경시 데이터 가져오는 함수
	@RequestMapping(value = "/Common/set_data_combo.do")
	public String set_data_combo(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("unique_Key", request.getParameter("unique_Key").toString());
		map.put("key_data", request.getParameter("key_data").toString());
		map.put("comp_CD", commonservice.user_info().getComp_CD());

		model.addAttribute("info", commonservice.set_data_combo(map));
		
		return "jsonView";
	}	
	
	//데이터값에 따른 다른 데이터 변경시 데이터 가져오는 함수
	@RequestMapping(value = "/Common/set_data.do")
	public String set_data(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("Master_NM", request.getParameter("Master_NM").toString());
		map.put("comp_CD", commonservice.user_info().getComp_CD());
		
		model.addAttribute("info", commonservice.set_data(map));
		
		return "jsonView";
	}	
}
