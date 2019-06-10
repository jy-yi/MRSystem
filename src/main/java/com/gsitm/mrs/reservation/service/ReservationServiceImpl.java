package com.gsitm.mrs.reservation.service;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gsitm.mrs.reservation.dao.ReservationDAO;
import com.gsitm.mrs.reservation.dto.ReservationDTO;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;

import freemarker.log.Logger;

/**
 * ReservationService 인터페이스 구현 클래스
 * 
 * @Package : com.gsitm.mrs.reservation.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
@Service
public class ReservationServiceImpl implements ReservationService {
	
	@Inject
	private ReservationDAO dao;
	
	/* ------------- 사용자 ------------- */

	@Override
	public void InputReservationInfo(HttpServletRequest request, ReservationDTO reservationDto, Model model) {
		// 회의실 정보
		int roomNo=Integer.parseInt(request.getParameter("roomNo"));
		Map<String, Object> roomInfo=dao.getRoomInfo(roomNo);
		model.addAttribute("roomInfo",roomInfo);
		
		// 사용자가 선택한 비품 정보 가져오기
		String equipments=request.getParameter("equipments");
		List<String> splitEquipments=new ArrayList<String>();
		splitEquipments.addAll(Arrays.asList(equipments.split(",")));
		
		// 비품 목록 중 사용자가 선택한 비품에는 Y, 선택하지 않은 비품에는 N 표시
		List<Map<String, Object>> equipmentList=dao.getEquipmentList(roomNo);
		for(int i=0; i<equipmentList.size(); i++) {
			for(int j=0; j<splitEquipments.size(); j++) {
				if(equipmentList.get(i).get("EQUIP_NO").toString().equals(splitEquipments.get(j))) {
					equipmentList.get(i).put("need", true);
					splitEquipments.remove(j);
					break;
				}
			}
		}
		model.addAttribute("equipmentList",equipmentList);
		
		// 예약 정보
		reservationDto.setEmployeeNo(request.getParameter("employeeNo"));
		String snackwant=reservationDto.getSnackWant();
		if(snackwant!=null && snackwant.equals("on")) {
			reservationDto.setSnackWant("Y");
		} else {
			reservationDto.setSnackWant("N");
		}
		model.addAttribute("reservationInfo",reservationDto);
		
		// 예약자 정보
		String employeeNo=request.getParameter("employeeNo");
		EmployeeDTO employeeDto=dao.getEmployeeInfo(employeeNo);
		model.addAttribute("employeeInfo", employeeDto);
		
	}
	
	/** 초성에 해당하는 사원 목록 조회 */
	@Override
	public List<Map<String, Object>> getEmployeeListByChosung(String chosung) {
		return dao.getEmployeeListByChosung(chosung);
	}

	/** 검색 키워드에 해당하는 사원 목록 조회 */
	@Override
	public List<Map<String, Object>> getEmployeeListBySearching(String keyword) {
		return dao.getEmployeeListBySearching(keyword);
	}
	
	/* ------------- 마이페이지 ------------- */
	
	/** 마이페이지 예약 현황 캘린더 */
	@Override
	public List<Map<String, Object>> getReservationInfo(String employeeNo) {
		return dao.getReservationInfo(employeeNo);
	}
	
	/** 마이페이지 캘린더 상세 조회 */
	@Override
	public List<ReservationDTO> getCalendarInfo(int reservationNo) {
		return dao.getCalendarInfo(reservationNo);
	}
	
	/** 마이페이지 예약 현황 리스트*/
	@Override
	public List<Map<String, Object>> getReservationList(String employeeNo) {
		return dao.getReservationList(employeeNo);
	}
	
	/** 마이페이지 목록형 예약 취소 */
	@Override
	public void updateReservation(int reservationNo) {
		dao.updateReservation(reservationNo);
	}
	
	/* ------------- 회의실 ------------- */

	/** 회의실 정보 조회 */
	@Override
	public Map<String, Object> getRoomInfo(int roomNo) {
		return dao.getRoomInfo(roomNo);
	}
	
	/** 회의실 목록 조회 */
	@Override
	public List<Map<String, Object>> getRoomList(int workplaceNo) {
		return dao.getRoomList(workplaceNo);
	}
	
	/** 회의실 비품 목록 조회 */
	@Override
	public List<Map<String, Object>> getEquipmentList(int roomNo) {
		return dao.getEquipmentList(roomNo);
	}

	/** 사용자가 선택한 비품 목록 EquipmentDto에 담기 */
	@Override
	public EquipmentDTO putIntoEuipmentDto(HttpServletRequest request) {
		// 서비스에서 해야 하는 일
		// form에서 넘긴 equipmentNo로 equipmentname 알아내기, Y,N 여부
		return null; 
	}

	
	/* ------------- 관리자 ------------- */
	
	/** 승인 대기 목록 조회 */
	@Override
	public List<Map<String, Object>> getWaitingList() {
		return dao.getWaitingList();
	}

	/** 승인 반려 목록 조회 */
	@Override
	public List<Map<String, Object>> getApprovalCancelList() {
		return dao.getApprovalCancelList();
	}

	/** 예약 완료 목록 조회 */
	@Override
	public List<Map<String, Object>> getSuccessList() {
		return dao.getSuccessList();
	}

}
