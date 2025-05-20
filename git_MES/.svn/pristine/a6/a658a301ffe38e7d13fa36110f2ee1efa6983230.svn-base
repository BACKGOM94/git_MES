package gom.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import gom.vo.M510VO;

@SuppressWarnings("unchecked")
@Repository(value = "M510DAO")
public class M510DAO extends EgovAbstractDAO {

	//M5101020_1_View
	public List<M510VO> M5101020_1_View (String comp_CD) {
		return (List<M510VO>) list("M510DAO.M5101020_1_View",comp_CD);
	}
	
	//equi_CD 변환시 equi_location 반환
	public String get_equi_location(Map<String, Object> map) {
		return (String)select("M510DAO.get_equi_location",map);
	}

	//DATA_equipment_TB insert
	public void M510_DataIn(Map<String, Object> map) {
		insert("M510DAO.M510_DataIn",map);
	}
	
	//실행해야하는 kpi 리스트를 가져옴
	public List<M510VO> get_kpi_List(int cycle) {
		return (List<M510VO>) list("M510DAO.get_kpi_List",cycle);
	}
	
	//평균 리드타임을 가져온다
	public String get_kpi_read_time(Map<String, Object> map) {
		return (String) select("M510DAO.get_kpi_read_time",map);
	}
	
	//평균 리드타임을 가져온다
	public String get_kpi_count(Map<String, Object> map) {
		return (String) select("M510DAO.get_kpi_count",map);
	}
	
	//평균 리드타임을 가져온다
	public String get_kpi_error_count(Map<String, Object> map) {
		return (String) select("M510DAO.get_kpi_error_count",map);
	}
	
	//평균 리드타임을 가져온다
	public void kpi_log_insert(Map<String, Object> map) {
		insert("M510DAO.kpi_log_insert",map);
	}
		
}
