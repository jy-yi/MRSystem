package com.gsitm.mrs.reservation.service;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gsitm.mrs.reservation.dao.ReservationDAO;
import com.gsitm.mrs.reservation.dto.ReservationDTO;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.resource.dto.RoomDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;

import freemarker.log.Logger;


/**
 * ReservationService 인터페이스 구현 클래스
 * 
 * @Package : com.gsitm.mrs.reservation.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 * 
 * @date : 2019. 5. 24.
 * @author : 김나윤
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
	
	/** 사원들의 부서 정보 조회 */
	@Override
	public List<Map<String, Object>> getDepartmentList(List<String> employeeNoArr, List<String> mainDeptList) {
		Map<String, Object> map=new HashMap<>();
		map.put("employeeNoArr", employeeNoArr);
		map.put("mainDeptList", mainDeptList);
		return dao.getDepartmentList(map);
	}

	/** 회의실 예약 입력 정보 조회 */
	@Override
	public void checkReservationInfo(HttpServletRequest request, Model model) {
		final int ROOM_PRICE_PER_30MINUTES=5000;
		
		// 사용자 정보
		String employeeNo=request.getParameter("employeeNo");
		model.addAttribute("employeeDto",dao.getEmployeeInfo(employeeNo));
		
		// 방 정보
		int roomNo=Integer.parseInt(request.getParameter("roomNo"));
		Map<String, Object> roomInfo=dao.getRoomInfo(roomNo);
		model.addAttribute("roomInfo",roomInfo);

		// 사용 시간 정보
		long diff=0;
		int price=0;
		String date=null;
		try {
			// 사용시간 정보
			SimpleDateFormat orginFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date start=orginFormat.parse(request.getParameter("startDate"));
			Date end=orginFormat.parse(request.getParameter("endDate"));
			
			// 분 구하기
			diff=(end.getTime()-start.getTime())/60000;
			
			// 30분당 5000천원 적용
			price=((int)(diff/30)*ROOM_PRICE_PER_30MINUTES);
			SimpleDateFormat transFormat=new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm");
			date=transFormat.format(start).toString()+" ~ "+transFormat.format(end).toString()+"("+diff+"분)";
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("startDate",request.getParameter("startDate"));
		model.addAttribute("endDate",request.getParameter("endDate"));
		model.addAttribute("date",date);
		model.addAttribute("price",price);

		// 회의 정보
		model.addAttribute("meetingName",request.getParameter("name"));
		model.addAttribute("purpose",request.getParameter("purpose"));

		// 참여인원
		StringTokenizer token = new StringTokenizer(request.getParameter("participation"), ",");
		List<String> participationList = new ArrayList<>();
		while(token.hasMoreTokens()) {
			participationList.add(token.nextToken());
		}
		model.addAttribute("participation", dao.getEmployeeList(participationList));

		// 주관 부서
		token = new StringTokenizer(request.getParameter("mainDept"), ",");
		List<String> mainDeptList = new ArrayList<>();
		while(token.hasMoreTokens()) {
			mainDeptList.add(token.nextToken());
		}
		model.addAttribute("mainDept", dao.getDepartmentListByDeptNo(mainDeptList));

		// 협조 부서
		String subDept=request.getParameter("subDept");
		if(!subDept.equals("")) {
			token = new StringTokenizer(subDept, ",");
			List<String> subDeptList = new ArrayList<>();
			while(token.hasMoreTokens()) {
				subDeptList.add(token.nextToken());
			}
			model.addAttribute("subDept", dao.getDepartmentListByDeptNo(subDeptList));
		}
		
		// 비품 목록
		String equipments=request.getParameter("equipments");
		if(!equipments.equals("")) {
			token = new StringTokenizer(equipments, ",");
			List<Integer> equipList = new ArrayList<>();
			while(token.hasMoreTokens()) {
				equipList.add(Integer.parseInt(token.nextToken()));
			}
			model.addAttribute("equipments", dao.getEquipmentsByEquipNo(equipList));
		}
		// 간식 여부

		model.addAttribute("snackWant", request.getParameter("snackWant"));
	}
	
	/** 예약 정보 DB에 저장 */
	@Override
	@Transactional
	public void doReserve(Map<String, Object> reserveData) {
		/*
		reservation DB
			res_no,
			*emp_no,
			*room_no,
			*name,
			*purpose,
			*start_date,
			*end_date,
			*snack_want,
			*status->default?
		waiting DB
			res_no
			mgr_approval
			admin_approval
		Lead_Department DB
			res_no
			*dept_no
			is_main
		borrowed_equipment DB
			*equip_no
			res_no
	*/
		String empNo=(String)reserveData.get("empNo");
		int roomNo=Integer.parseInt((String)reserveData.get("roomNo"));
		String name=(String)reserveData.get("name");
		String purpose=(String)reserveData.get("purpose");
		String startDate=(String)reserveData.get("startDate");
		String endDate=(String)reserveData.get("endDate");
		String snackWant=(String)reserveData.get("snackWant");
		List<String> mainDept=(List<String>)reserveData.get("mainDept"); 
		List<String> subDept=(List<String>)reserveData.get("subDept"); 
		List<String> equipments=(List<String>)reserveData.get("equipments"); 

		// reservation number를 받아온다
		int resNo=dao.getReservationNo();
		
		// reservation DB에 넣을 데이터를 담은 dto
		ReservationDTO reservationDto=new ReservationDTO();
		reservationDto.setReservationNo(resNo);
		reservationDto.setEmployeeNo(empNo);
		reservationDto.setRoomNo(roomNo);
		reservationDto.setName(name);
		reservationDto.setPurpose(purpose);
		reservationDto.setStartDate(startDate);
		reservationDto.setEndDate(endDate);
		reservationDto.setSnackWant(snackWant);
		dao.insertReservation(reservationDto);
		
		// waiting DB에 예약 정보를 담는다
		dao.insertWaiting(resNo);
		
		// Lead_Department DB에 넣을 데이터를 담은 map
		Map<String, Object> leadDepartmentMap=new HashMap<>();
		leadDepartmentMap.put("resNo",resNo);
		leadDepartmentMap.put("isMain","Y");
		for(String deptNo:mainDept) {
			leadDepartmentMap.put("deptNo", Integer.parseInt(deptNo));
			dao.insertParticipateDepartment(leadDepartmentMap);
		}

		// Sub_Department DB에 넣을 데이터를 담은 map
		Map<String, Object> subDepartmentMap=new HashMap<>();
		subDepartmentMap.put("resNo",resNo);
		subDepartmentMap.put("isMain","N");
		for(String deptNo:subDept) {
			subDepartmentMap.put("deptNo", Integer.parseInt(deptNo));
			dao.insertParticipateDepartment(subDepartmentMap);
		}
		System.out.println("subDept Input 끝");
		
		// borrowed_equipment DB에 넣을 데이터를 담은 map
		Map<String, Object> borrwedEquipmentMap=new HashMap<>();
		//borrwedEquipmentMap.put("resNo",resNo);
		for(String equipNo:equipments) {
			borrwedEquipmentMap.put("equipNo", Integer.parseInt(equipNo));
			dao.insertBorrowedEquipments(borrwedEquipmentMap);
		}
		
	}
	
	/* ------------- 마이페이지 ------------- */
	
	/** 마이페이지 예약 현황 캘린더 */
	@Override
	public List<Map<String, Object>> getReservationInfo(String employeeNo) {
		return dao.getReservationInfo(employeeNo);
	}
	
	/** 마이페이지 캘린더 상세 조회 */
	@Override
	public Map<String, Object> getCalendarInfo(int reservationNo) {
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
	
	/** 마이페이지 가장 최근 예약 표시 */
	@Override
	public ReservationDTO getLatestReservation(String employeeNo) {
		return dao.getLatestReservation(employeeNo);
	}
	
	/** 대시보드 */
	public List<Map<String, Object>> getDashBoard(int roomNo) {
		return dao.getDashBoard(roomNo);
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
	
	/** 예약 상태 변경 */
	@Override
	public void updateStatus(Map<String, Object> map) {
		dao.updateStatus(map);
	}

	/** 관리자 승인 상태 변경 */
	@Override
	public void updateAdminApproval(Map<String, Object> map) {
		dao.updateAdminApproval(map);
	}
	
	/** 반려 사유 추가 */
	@Override
	public void insertRefuse(Map<String, Object> map) {
		dao.insertRefuse(map);
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

	/** 예약 취소 목록 조회 */
	@Override
	public List<Map<String, Object>> getReservationCancelList() {
		return dao.getReservationCancelList();
	}

}
