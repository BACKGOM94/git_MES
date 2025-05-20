package gom.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import gom.vo.CommonVO;
import gom.vo.MenuVO;
import gom.vo.UserVO;

@SuppressWarnings("rawtypes")
public interface CommonService{

	//로그를 남기기 위한 함수
	public void log(String log);
	
	//로그인을 위한 함수
	public UserVO actionLogin(CommonVO commonVO) throws Exception;
	
	//사용자 정보를 가져옴
	public UserVO user_info();
	
	//접속로그를 남기기 위한 함수
	public void make_log(CommonVO commonVO) throws Exception;
	
	//권한에 맞는 Top 메뉴를 가져온다
	public List<MenuVO> get_Top_menu(CommonVO commonVO) throws Exception;
	
	//권한에 맞는 Left 메뉴를 가져온다
	public List<MenuVO> get_Left_menu(CommonVO commonVO) throws Exception;
	
	//각 페이지 이동시 권한 있는지 확인	
	public ModelAndView security(ModelAndView mav) throws Exception ;
	
	//비밀번호 변경시 비밀번호 확인
	public int check_pwdChange(Map<String, Object> map) throws Exception;
	
	//비밀번호 변경시 비밀번호 확인후 변경
	public void action_pwdChange(Map<String, Object> map) throws Exception; 
	
	//Data_View
	public List Data_View(Map<String, Object> map) throws Exception;
		
	//Data_Change
	public void Data_Change(List<Map<String, Object>> list) throws Exception;
	
	//코드를 만들기 위한 함수
	public String make_CD(String unionKey) throws Exception;

	//데이터 중복 확인
	public String double_Check(Map<String, Object> map) throws Exception;
	
	//카테고리 데이터 가져오기
	public List<CommonVO> IBSheet_select_category_Data(int category_CD) throws Exception;

	//데이터 변경시 다른데이터의 콤보박스 자동 변경
	public List<CommonVO> set_data_combo(Map<String, Object> map) throws Exception;
	
	//데이터값에 따른 다른 데이터 변경시 데이터 가져오는 함수
	public List<CommonVO> set_data(Map<String, Object> map) throws Exception;
	
	//IBSheet Data 저장을 위해 데이터모양을 DB에 넣을수 있게 변환시켜준다
	public List<Map<String, Object>> IBSheet_Data_Converstion(Map<String, Object> map);
	
	//IBSheet 마스터데이터 이름들을 셀렉박스데이터를 만들기위한 함수 
	public List<CommonVO> IBSheet_select_data_master(Map<String, Object> map) throws Exception;
	
	//IBSheet column을 매개변수에 따라 맞춰서 제작한다
	public String IBSheet_col(String col_name , int col_size, Boolean hidden , Boolean keyField , Boolean Edit) throws Exception;


}
