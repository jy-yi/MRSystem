package com.gsitm.mrs.reservation.service;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.inject.Inject;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gsitm.mrs.reservation.dao.ReservationDAO;
import com.gsitm.mrs.reservation.dto.ReservationDTO;
import com.gsitm.mrs.reservation.dto.ReserveTypeVO;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;
import com.gsitm.mrs.util.MailUtils;

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
	
	/* 메일 보낼 때 포함할 url */
	public static final String URL = "http://192.168.9.201:8000";

	@Inject
	private ReservationDAO dao;

	@Inject
	private MailUtils mailUitls;

	/* ------------- 사용자 ------------- */

	@Override
	public void InputReservationInfo(HttpServletRequest request, ReservationDTO reservationDto, Model model) {
		// 회의실 정보
		int roomNo = Integer.parseInt(request.getParameter("roomNo"));
		Map<String, Object> roomInfo = dao.getRoomInfo(roomNo);
		model.addAttribute("roomInfo", roomInfo);

		// 사용자가 선택한 비품 정보 가져오기
		String equipments = request.getParameter("equipments");
		List<String> splitEquipments = new ArrayList<String>();
		splitEquipments.addAll(Arrays.asList(equipments.split(",")));

		// 비품 목록 중 사용자가 선택한 비품에는 Y, 선택하지 않은 비품에는 N 표시
		List<Map<String, Object>> equipmentList = dao.getEquipmentList(roomNo);
		for (int i = 0; i < equipmentList.size(); i++) {
			for (int j = 0; j < splitEquipments.size(); j++) {
				if (equipmentList.get(i).get("EQUIP_NO").toString().equals(splitEquipments.get(j))) {
					equipmentList.get(i).put("need", true);
					splitEquipments.remove(j);
					break;
				}
			}
		}
		model.addAttribute("equipmentList", equipmentList);

		// 예약 정보
		reservationDto.setEmployeeNo(request.getParameter("employeeNo"));
		String snackwant = reservationDto.getSnackWant();
		if (snackwant != null && snackwant.equals("on")) {
			reservationDto.setSnackWant("Y");
		} else {
			reservationDto.setSnackWant("N");
		}
		model.addAttribute("reservationInfo", reservationDto);

		// 예약자 정보
		String employeeNo = request.getParameter("employeeNo");
		EmployeeDTO employeeDto = dao.getEmployeeInfo(employeeNo);
		model.addAttribute("employeeInfo", employeeDto);

		// checkReservationInfo.jsp에서 이전페이지 이동으로 온건지 확인
		boolean clickPrevBtn = Boolean.parseBoolean(request.getParameter("clickPrevBtn"));
		if (clickPrevBtn) {
			// 회의명, 회의구분, 참여인원, 주관부서, 협조부서 정보를 담아간다.
			model.addAttribute("savedData", true);
			model.addAttribute("name", request.getParameter("name"));
			model.addAttribute("purpose", request.getParameter("purpose"));
			String participation = request.getParameter("participation").substring(1,
					request.getParameter("participation").length() - 1);
			model.addAttribute("participation", participation);
			model.addAttribute("mainDept", request.getParameter("mainDept"));
			model.addAttribute("subDept", request.getParameter("subDept"));
		}
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
		Map<String, Object> map = new HashMap<>();
		map.put("employeeNoArr", employeeNoArr);
		map.put("mainDeptList", mainDeptList);
		return dao.getDepartmentList(map);
	}

	/** 회의실 예약 입력 정보 조회 */
	@Override
	public void checkReservationInfo(HttpServletRequest request, Model model) {
		final int ROOM_PRICE_PER_HOUR = 10000;

		// 사용자 정보
		String employeeNo = request.getParameter("employeeNo");
		model.addAttribute("employeeDto", dao.getEmployeeInfo(employeeNo));

		// 방 정보
		int roomNo = Integer.parseInt(request.getParameter("roomNo"));
		Map<String, Object> roomInfo = dao.getRoomInfo(roomNo);
		model.addAttribute("roomInfo", roomInfo);

		// 사용 시간 정보
		long diff = 0;
		int price = 0;
		String date = null;
		try {
			// 사용시간 정보
			SimpleDateFormat orginFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date start = orginFormat.parse(request.getParameter("startDate"));
			Date end = orginFormat.parse(request.getParameter("endDate"));

			// 시간 구하기
			diff = (end.getTime() - start.getTime()) / 60000;

			ReserveTypeVO rtv=calcDate(start, end);
			double reservationHours=rtv.getReserveHours();
			
			// 30분당 5000천원 적용
			price = ((int) reservationHours * ROOM_PRICE_PER_HOUR);
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm");
			date = transFormat.format(start).toString() + " ~ " + transFormat.format(end).toString();
		} catch (ParseException e) {
			e.printStackTrace();
		}

		model.addAttribute("startDate", request.getParameter("startDate"));
		model.addAttribute("endDate", request.getParameter("endDate"));
		model.addAttribute("date", date);
		model.addAttribute("price", price);

		// 회의 정보
		model.addAttribute("meetingName", request.getParameter("name"));
		model.addAttribute("purpose", request.getParameter("purpose"));

		// 참여인원
		StringTokenizer token = new StringTokenizer(request.getParameter("participation"), ",");
		List<String> participationList = new ArrayList<>();
		while (token.hasMoreTokens()) {
			participationList.add(token.nextToken());
		}
		model.addAttribute("participation", dao.getEmployeeList(participationList));
		// 이전 페이지 기능 구현을 위해 empNo로 구성된 List도 model에 담는다
		model.addAttribute("participationEmpNos", participationList);

		// 주관 부서
		token = new StringTokenizer(request.getParameter("mainDept"), ",");
		List<String> mainDeptList = new ArrayList<>();
		while (token.hasMoreTokens()) {
			mainDeptList.add(token.nextToken());
		}
		model.addAttribute("mainDept", dao.getDepartmentListByDeptNo(mainDeptList));

		// 협조 부서
		String subDept = request.getParameter("subDept");
		if (subDept.length() != 0) {
			token = new StringTokenizer(request.getParameter("subDept"), ",");
			List<String> subDeptList = new ArrayList<>();
			while (token.hasMoreTokens()) {
				subDeptList.add(token.nextToken());
			}
			model.addAttribute("subDept", dao.getDepartmentListByDeptNo(subDeptList));
		}

		// 비품 목록
		String equipments = request.getParameter("equipments");
		if (!equipments.equals("")) {
			token = new StringTokenizer(equipments, ",");
			List<Integer> equipList = new ArrayList<>();
			while (token.hasMoreTokens()) {
				equipList.add(Integer.parseInt(token.nextToken()));
			}
			model.addAttribute("equipments", dao.getEquipmentsByEquipNo(equipList));
		}
		// 간식 여부

		model.addAttribute("snackWant", request.getParameter("snackWant"));
	}

	/** 예약 정보 DB에 저장 */
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public void doReserve(Map<String, Object> reserveData) {
		String empNo = (String) reserveData.get("empNo");
		int roomNo = Integer.parseInt((String) reserveData.get("roomNo"));
		String name = (String) reserveData.get("name");
		String email = (String) reserveData.get("email");
		String purpose = (String) reserveData.get("purpose");
		String startDate = (String) reserveData.get("startDate");
		String endDate = (String) reserveData.get("endDate");
		String snackWant = (String) reserveData.get("snackWant");
		List<String> mainDept = (List<String>) reserveData.get("mainDept");
		List<String> subDept = (List<String>) reserveData.get("subDept");
		List<String> equipments = (List<String>) reserveData.get("equipments");
		String p = (String) reserveData.get("participation");
		String participation = p.substring(1, p.length() - 1).replaceAll(" ", "");
		
		// reservation number를 받아온다
		int resNo = dao.getReservationNo();

		// reservation DB에 넣을 데이터를 담은 dto
		ReservationDTO reservationDto = new ReservationDTO();

		reservationDto.setReservationNo(resNo);
		reservationDto.setEmployeeNo(empNo);
		reservationDto.setRoomNo(roomNo);
		reservationDto.setName(name);
		reservationDto.setPurpose(purpose);
		reservationDto.setStartDate(startDate);
		reservationDto.setEndDate(endDate);
		reservationDto.setSnackWant(snackWant);
		
		// 예약 DB에 데이터 insert
		dao.insertReservation(reservationDto);
		
		// waiting DB에 예약 정보를 담는다
		dao.insertWaiting(resNo);
		
		// Participation DB에 넣을 데이터를 담은 map
		// res_no, emp_no, money
		Map<String, Object> participationMap = new HashMap<>();
		participationMap.put("resNo", resNo);
		StringTokenizer token = new StringTokenizer(participation, ",");
		List<String> participationList = new ArrayList<>();

		while (token.hasMoreTokens()) {
			String participationEmpNo = token.nextToken();
			participationList.add(participationEmpNo);
			participationMap.put("empNo", participationEmpNo);
			dao.insertParticipation(participationMap);
		}

		// Lead_Department DB에 넣을 데이터를 담은 map + count
		Map<String, Object> leadDepartmentMap = new HashMap<>();
		Map<String, Object> infoMap = new HashMap<>();
		infoMap.put("participationList", participationList);
		leadDepartmentMap.put("resNo", resNo);
		leadDepartmentMap.put("isMain", "Y");

		for (String deptNo : mainDept) {
			if (!infoMap.containsKey("deptNo"))
				infoMap.put("deptNo", Integer.parseInt(deptNo));
			else
				infoMap.replace("deptNo", Integer.parseInt(deptNo));
			leadDepartmentMap.put("deptNo", Integer.parseInt(deptNo));

			// 해당 부서의 participation 수를 구한다
			leadDepartmentMap.put("count", dao.getNumOfParticipation(infoMap));
			dao.insertParticipateDepartment(leadDepartmentMap);
		}

		// subDept는 필수 입력 항목X
		if (subDept.size() != 0) {
			// Sub_Department DB에 넣을 데이터를 담은 map
			Map<String, Object> subDepartmentMap = new HashMap<>();
			subDepartmentMap.put("resNo", resNo);
			subDepartmentMap.put("isMain", "N");
			for (String deptNo : subDept) {
				if (!infoMap.containsKey("deptNo"))
					infoMap.put("deptNo", Integer.parseInt(deptNo));
				else
					infoMap.replace("deptNo", Integer.parseInt(deptNo));

				subDepartmentMap.put("deptNo", Integer.parseInt(deptNo));
				subDepartmentMap.put("count", dao.getNumOfParticipation(infoMap));

				dao.insertParticipateDepartment(subDepartmentMap);
			}
		}

		// equipment는 필수 입력 항목X
		if (equipments.size() != 0) {
			// borrowed_equipment DB에 넣을 데이터를 담은 map
			Map<String, Object> borrwedEquipmentMap = new HashMap<>();
			borrwedEquipmentMap.put("resNo", resNo);
			for (String equipNo : equipments) {
				borrwedEquipmentMap.put("equipNo", Integer.parseInt(equipNo));
				dao.insertBorrowedEquipments(borrwedEquipmentMap);
			}
		}
		
		// 상위 결제자와 회의실 관리자()에게 예약 확인 메일 전송
		/**
		 * 단기 예약 일 경우 -> 신청자/참석자/상위결재자에게 예약 확인 메일 -> reservation status 1로 장기 예약 일
		 * 경우&교육실 예약 -> 신청자/참석자에게 예약 확인 메일, 상위결재자에게 예약 승인 메일 -> 승인 시 관리자에게 예약 승인 메일 ->
		 * waiting 테이블의 칼럼 y로 -> 둘 다 y면 status 1로 그리고 예약 신청 완료 메일(신청자/참석자/상위결재자)
		 */

		// for, 시작 일자와 종료 일자의 정보 얻기
		SimpleDateFormat orginFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date start = null;
		Date end = null;
		try {
			start = orginFormat.parse(startDate);
			end = orginFormat.parse(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(start);
		int startYear = calendar.get(Calendar.YEAR);
		int startMonth = calendar.get(Calendar.MONTH) + 1;
		int startDayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);

		calendar.setTime(end);
		int endYear = calendar.get(Calendar.YEAR);
		int endMonth = calendar.get(Calendar.MONTH) + 1;
		int endDayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);

		// 단기 예약인지 여부
		boolean isShortTermReservation = (startYear == endYear && startMonth == endMonth && startDayOfMonth == endDayOfMonth);
		// 교육실인지 여부
		boolean isEduRoom = (dao.getRoomType(roomNo)).equals("교육실");
		String applicant = dao.getEmpName(empNo); // 신청자 이름
		String term = startDate + " ~ " + endDate;
		String reservationName = name; // 회의명
		
		EmployeeDTO manager = dao.getMgrInfo(empNo);
		
		String reason = "";
		String mgrEmpNo = manager.getEmployeeNo();
		String mgrName = manager.getName();
		String mgrEmail = manager.getEmail();

		List<String> emailList = new ArrayList<>(); // 메일 보내야 할 모든 이메일 목록
		emailList.add(email); // 신청자 이메일
		System.err.println("resNo:"+resNo);
		emailList.addAll(dao.getEmailList(resNo)); // 해당 회의 참석자들의 이메일
		
		if (isShortTermReservation && !isEduRoom) { // 교육실이 아닌 회의실의 단기 예약
			String title = "[GS ITM] 회의실 예약 안내"; // 메일 제목

			emailList.add(mgrEmail); // 신청자의 상위 결재자 이메일

			String emails = StringUtils.join(emailList, ","); // 이메일 목록 콤마(,)로 구분

			mailSend(empNo, emails, title, applicant, reason, term, reservationName, "신청", "");

			// 단기 예약일 경우 별도의 승인없이 예약 가능
			Map<String, Object> statusMap=new HashMap<>();
			statusMap.put("reservationNo", resNo);
			statusMap.put("status", 1);
			dao.updateStatus(statusMap);
			reservationDto.setStatus(1);
		} else { // 장기 예약 or 교육실 예약
			System.out.println("장기예약");
			// 신청자&참석자에게 예약 확인 메일 보내기
			String title = "[GS ITM] 회의실 예약 안내"; // 메일 제목

			String emails = StringUtils.join(emailList, ","); // 이메일 목록 콤마(,)로 구분
			mailSend(empNo, emails, title, applicant, reason, term, reservationName, "신청", "");

			// 상위결재자에게 예약 승인 메일
			title = "[GS ITM] 회의실 예약 승인 요청"; // 메일 제목

			mailSend(empNo, mgrEmail, title, applicant, reason, term, reservationName, "신청", URL + "/reservation/dashboard?type=manager&resNo="+resNo+"&mgrNo="+mgrEmpNo);
			
		}

	}

	/** 사원번호로 회의 참여자 정보 얻어오기 */
	@Override
	public List<Map<String, Object>> getParticipations(List<String> participationNos) {
		return dao.getEmployeeList(participationNos);
	}

	/** 해당 날짜의 예약정보들 조회 */
	@Override
	public List<Map<String, Object>> getReservationsByDate(Map<String, Object> roomData) {
		return dao.getReservationsByDate(roomData);
	}

	/** 장기 예약 날짜 선택 페이지 서비스 */
	@Override
	public void chooseDate(Model model, int roomNo) {
		model.addAttribute("anotherReservationInfo", dao.getReservationsByRoomNo(roomNo));
		model.addAttribute("roomInfo", dao.getRoomInfo(roomNo));
		model.addAttribute("equipmentList", dao.getEquipmentList(roomNo));
	}
	
	/** 예약시간 계산(단위:hour) */
	public ReserveTypeVO calcDate(Date startDate, Date endDate) {
		ReserveTypeVO reserveType = new ReserveTypeVO();

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(endDate);
		int endYear = calendar.get(Calendar.YEAR);
		int endMonth = calendar.get(Calendar.MONTH) + 1;
		int endDayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
		int endHour = calendar.get(Calendar.HOUR_OF_DAY);
		int endMinute = calendar.get(Calendar.MINUTE);

		calendar.setTime(startDate);
		int startYear = calendar.get(Calendar.YEAR);
		int startMonth = calendar.get(Calendar.MONTH) + 1;
		int startDayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
		int startHour = calendar.get(Calendar.HOUR_OF_DAY);
		int startMinute = calendar.get(Calendar.MINUTE);

		double reserveHours = 0.0; // 예약 시간

		if (startDayOfMonth == endDayOfMonth && startMonth == endMonth && startYear == endYear) {
			// 단기 예약
			reserveType.setLongTerm(false);
			reserveHours = (endHour - startHour) + (endMinute - startMinute) / 60.0;
			if (startHour < 12 && endHour > 12)
				reserveHours -= 1;
		} else {
			// 장기 예약
			reserveType.setLongTerm(true);
			for (Calendar cal = calendar; cal.get(Calendar.YEAR) <= endYear && cal.get(Calendar.MONTH) <= endMonth
					&& cal.get(Calendar.DAY_OF_MONTH) <= endDayOfMonth; cal.add(Calendar.DAY_OF_MONTH, 1)) {
				// 평일만 계산
				switch (cal.get(Calendar.DAY_OF_WEEK)) {
				case 2:
				case 3:
				case 4:
				case 5:
				case 6: {
					int year = calendar.get(Calendar.YEAR);
					int month = calendar.get(Calendar.MONTH) + 1;
					int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
					int hour = calendar.get(Calendar.HOUR_OF_DAY);
					int minute = calendar.get(Calendar.MINUTE);

					if (dayOfMonth == startDayOfMonth && month == startMonth && year == startYear) { // 첫날 계산
						reserveHours += (18 - hour) + (0 - minute) / 60.0;
						if (hour < 12) {
							reserveHours -= 1;
						}
					} else if (dayOfMonth == endDayOfMonth && month == endMonth && year == endYear) { // 마지막날 계산
						reserveHours += (endHour - 9) + (endMinute - 0) / 60.0;
						if (endHour > 12) {
							reserveHours -= 1;
						}
					} else { // 중간날 게산
						reserveHours += 8;
					}
				}
					break;
				}
			}
		}
		reserveType.setReserveHours(reserveHours);
		
		return reserveType;
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

	/** 마이페이지 예약 현황 리스트 */
	@Override
	public List<Map<String, Object>> getReservationList(String employeeNo) {
		return dao.getReservationList(employeeNo);
	}

	/** 취소 사유 추가 */
	@Override
	public void insertCancel(Map<String, Object> map) {
		dao.insertCancel(map);
	}

	/** 참여 사원 이메일 리스트 조회 */
	@Override
	public List<String> getEmailList(int reservaionNo) {
		return dao.getEmailList(reservaionNo);
	}

	/** 마이페이지 가장 최근 예약 표시 */
	@Override
	public List<Map<String, Object>> getLatestReservation(String employeeNo) {
		return dao.getLatestReservation(employeeNo);
	}
	
	/** 가장 최근 1개 가져오기 */
	public Map<String, Object> getOne(String employeeNo){
		return dao.getOne(employeeNo);
	}

	/** 대시보드 */
	public List<Map<String, Object>> getDashBoard(int roomNo) {
		return dao.getDashBoard(roomNo);
	}
	
	/** 시작 버튼 처리 - 승인상태 변경 */
	public void updateStart(Map<String, Object> map) {
		dao.updateStart(map);
	}

	/** 끝 버튼 처리 - 대여물품 삭제 */
	public void deleteBorEquip(int reservationNo) {
		dao.deleteBorEquip(reservationNo);
	}

	/* ------------- 회의실 ------------- */

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
		//TODO: form에서 넘긴 equipmentNo로 equipmentname 알아내기, Y,N 여부
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
	
	/** 상위결재자 승인 상태 변경 */
	@Override
	public void updateMgrApproval(Map<String, Object> map) {
		
		int reservationNo = Integer.parseInt(map.get("reservationNo").toString());
		Map<String, Object> reservationMap = dao.getReservationInfoByResNo(reservationNo);
		
		String empNo = reservationMap.get("EMP_NO").toString();
		String name = reservationMap.get("EMPNAME").toString();
		String term = reservationMap.get("START_DATE") + " ~ " + reservationMap.get("END_DATE");
		String reservationName = reservationMap.get("RESENAME").toString();
		String email = "";
		
		/* 상위결재자가 예약을 승인했을 경우 */
		if (map.get("mgrApproval").equals("Y")) {
			String title = "[GS ITM] 회의실 예약 승인 요청";
			email = dao.getAdminEmail(Integer.parseInt(reservationMap.get("ROOM_NO").toString()));	// 예약된 회의실의 관리자 메일
			
			mailSend(empNo, email, title, name, "", term, reservationName, "신청", URL+"/reservation/approvalWaitingList");
		/* 상위결재자가 예약을 반려했을 경우 */
		} else {
			String title = "[GS ITM] 회의실 예약 반려 안내";
			String reason = map.get("reason").toString();
			email = reservationMap.get("EMAIL").toString();
			
			List<String> emailList = new ArrayList<>(); // 메일 보내야 할 모든 이메일 목록
			emailList.add(email); // 신청자 이메일
			emailList.addAll(dao.getEmailList(reservationNo)); // 해당 회의 참석자들의 이메일
			
			mailSend(empNo, email, title, name, reason, term, reservationName, "반려", URL+"/reservation/statusList");
		}
		
		dao.updateMgrApproval(map);
		
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

	/* ------------- 공통 ------------- */

	/** 메일 전송 */
	@Override
	public boolean mailSend(String empNo, String email, String title, String name, String reason, String term,
			String reservationName, String type, String url) {

		String host = "smtp.naver.com";
		int port = 587;
		final String username = "a_spree@naver.com";
		final String password = "dhwlddj23";

		// String recipient = empNo;
		String content = mailUitls.getMailTemplate(name, reason, term, reservationName, type, url);

		// 정보를 담기 위한 객체 생성
		Properties props = System.getProperties();

		// SMTP 서버 정보 설정
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.ssl.trust", host);

		Session session = Session.getDefaultInstance(props, new Authenticator() {
			String un = username;
			String pw = password;

			protected PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});

		session.setDebug(true);

		Message mimeMessage = new MimeMessage(session);

		try {
			mimeMessage.setFrom(new InternetAddress(username));
			mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			mimeMessage.setSubject(MimeUtility.encodeText(title, "UTF-8", "B"));
			mimeMessage.setContent(content, "text/html; charset=utf-8");
			Transport.send(mimeMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return true;
	}

	/** 예약시간 계산(단위:hour) */
	/*public ReserveTypeVO calcDate(Date startDate, Date endDate) {
		ReserveTypeVO reserveType = new ReserveTypeVO();
	  
		Calendar calendar = Calendar.getInstance();
		
		calendar.setTime(endDate);
		int endYear = calendar.get(Calendar.YEAR);
		int endMonth = calendar.get(Calendar.MONTH)+1;
		int endDayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
		int endHour = calendar.get(Calendar.HOUR_OF_DAY);
		int endMinute = calendar.get(Calendar.MINUTE);
	  
		calendar.setTime(startDate);
		int startYear = calendar.get(Calendar.YEAR);
		int startMonth = calendar.get(Calendar.MONTH)+1;
		int startDayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
		int startHour = calendar.get(Calendar.HOUR_OF_DAY);
		int startMinute = calendar.get(Calendar.MINUTE);
	  
		double reserveHours = 0.0; // 예약 시간
	  
		if(startDayOfMonth==endDayOfMonth && startMonth==endMonth && startYear==endYear) {
			// 단기 예약
			reserveType.setLongTerm(false);
		    reserveHours = (endHour-startHour) + (endMinute-startMinute)/60.0;
		    if(startHour<12 && endHour>12) reserveHours -= 1;
		} else {
			// 장기 예약
			reserveType.setLongTerm(true);
			for(Calendar cal = calendar; 
				cal.get(Calendar.YEAR) <= endYear && cal.get(Calendar.MONTH) <= endMonth && cal.get(Calendar.DAY_OF_MONTH) <= endDayOfMonth;
				cal.add(Calendar.DAY_OF_MONTH, 1)) {
			    // 평일만 계산
				switch (cal.get(Calendar.DAY_OF_WEEK)) {
					case 2: case 3: case 4: case 5: case 6:{
					int year = calendar.get(Calendar.YEAR);
					int month = calendar.get(Calendar.MONTH)+1;
					int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
					int hour = calendar.get(Calendar.HOUR_OF_DAY);
					int minute = calendar.get(Calendar.MINUTE);
		      
					if(dayOfMonth==startDayOfMonth && month==startMonth && year==startYear) { //첫날 계산
						reserveHours += (18-hour) + (0-minute)/60.0;
						if(hour < 12) {
							reserveHours -= 1;
						}
					} else if(dayOfMonth==endDayOfMonth && month==endMonth && year==endYear) { // 마지막날 계산
						reserveHours += (endHour-9) + (endMinute-0)/60.0;
						if(endHour > 12) {
						reserveHours -= 1;
					}
					} else { // 중간날 게산
						reserveHours += 8;
					}
					}
				break;
			}
			}
		}
		reserveType.setReserveHours(reserveHours);
	return reserveType;
	}*/
	
	@Scheduled(cron="0 10/30 9-18 * * *")
	public void checkNoShow() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.MINUTE, -10);
		String timeStr = format.format(cal.getTime());
		System.out.println("------------- "+timeStr+"------------------");
		
		int result = dao.updateNoshow(timeStr);
	}
	
	@Scheduled(cron="0 0/30 9-18 * * *")
	public void checkEnd() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		String timeStr = format.format(cal.getTime());
		System.out.println("------------- "+timeStr+"------------------");
		
		int result = dao.updateCheckEnd(timeStr);
	}
}
