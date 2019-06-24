package com.gsitm.mrs.reservation.service;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.inject.Inject;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gsitm.mrs.reservation.dao.ReservationDAO;
import com.gsitm.mrs.reservation.dto.ReservationDTO;
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

	@Inject
	private ReservationDAO dao;

	@Inject
	private JavaMailSender mailSender;

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
			/*
			 * StringTokenizer token = new StringTokenizer(participation, ","); List<String>
			 * participationList = new ArrayList<>(); while(token.hasMoreTokens()) {
			 * participationList.add(token.nextToken()); }
			 */
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
		final int ROOM_PRICE_PER_30MINUTES = 5000;

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

			// 분 구하기
			diff = (end.getTime() - start.getTime()) / 60000;

			// 30분당 5000천원 적용
			price = ((int) (diff / 30) * ROOM_PRICE_PER_30MINUTES);
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm");
			date = transFormat.format(start).toString() + " ~ " + transFormat.format(end).toString() + "(" + diff
					+ "분)";
		} catch (ParseException e) {
			// TODO Auto-generated catch block
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
	@Override
	@Transactional
	public void doReserve(Map<String, Object> reserveData) {
		/*
		 * reservation DB res_no, emp_no, room_no, name, purpose, start_date, end_date,
		 * snack_want, status->default? waiting DB res_no mgr_approval admin_approval
		 * Lead_Department DB res_no dept_no is_main borrowed_equipment DB equip_no
		 * res_no
		 */
		String empNo = (String) reserveData.get("empNo");
		int roomNo = Integer.parseInt((String) reserveData.get("roomNo"));
		String name = (String) reserveData.get("name");
		String purpose = (String) reserveData.get("purpose");
		String startDate = (String) reserveData.get("startDate");
		String endDate = (String) reserveData.get("endDate");
		String snackWant = (String) reserveData.get("snackWant");
		List<String> mainDept = (List<String>) reserveData.get("mainDept");
		List<String> subDept = (List<String>) reserveData.get("subDept");
		List<String> equipments = (List<String>) reserveData.get("equipments");

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
		dao.insertReservation(reservationDto);

		// waiting DB에 예약 정보를 담는다
		dao.insertWaiting(resNo);

		// Lead_Department DB에 넣을 데이터를 담은 map
		Map<String, Object> leadDepartmentMap = new HashMap<>();
		leadDepartmentMap.put("resNo", resNo);
		leadDepartmentMap.put("isMain", "Y");
		for (String deptNo : mainDept) {
			leadDepartmentMap.put("deptNo", Integer.parseInt(deptNo));
			dao.insertParticipateDepartment(leadDepartmentMap);
		}

		// subDept는 필수 입력 항목X
		if (subDept.size() != 0) {
			// Sub_Department DB에 넣을 데이터를 담은 map
			Map<String, Object> subDepartmentMap = new HashMap<>();
			subDepartmentMap.put("resNo", resNo);
			subDepartmentMap.put("isMain", "N");
			for (String deptNo : subDept) {
				subDepartmentMap.put("deptNo", Integer.parseInt(deptNo));
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
	}

	/** 사원번호로 회의 참여자 정보 얻어오기 */
	@Override
	public List<Map<String, Object>> getParticipations(List<String> participationNos) {
		return dao.getEmployeeList(participationNos);
	}

	/** 예약 날짜 선택 페이지 서비스 */
	@Override
	public void shortTerm_chooseDate(Model model, int roomNo) {
		model.addAttribute("anotherReservationInfo", dao.getReservationsByRoomNo(roomNo));
		model.addAttribute("roomInfo", dao.getRoomInfo(roomNo));
		model.addAttribute("equipmentList", dao.getEquipmentList(roomNo));

	}

	/** 해당 날짜의 예약정보들 조회 */
	@Override
	public List<Map<String, Object>> getReservationsByDate(Map<String, Object> roomData) {
		return dao.getReservationsByDate(roomData);
	}
	
	/** 장기 예약 날짜 선택 페이지 서비스 */
	@Override
	public void longTerm_chooseDate(Model model, int roomNo) {
		model.addAttribute("anotherReservationInfo",dao.getReservationsByRoomNo(roomNo));
		model.addAttribute("roomInfo",dao.getRoomInfo(roomNo));
		model.addAttribute("equipmentList", dao.getEquipmentList(roomNo));
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

	/** 마이페이지 목록형 예약 취소 */
	@Override
	public void updateReservation(int reservationNo) {
		dao.updateReservation(reservationNo);
	}

	/** 마이페이지 가장 최근 예약 표시 */
	@Override
	public List<Map<String, Object>> getLatestReservation(String employeeNo) {
		return dao.getLatestReservation(employeeNo);
	}

	/** 대시보드 */
	public List<Map<String, Object>> getDashBoard(int roomNo) {
		return dao.getDashBoard(roomNo);
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

	/* ------------- 공통 ------------- */

	@Override
	public boolean mailSend(String empNo, String email, String title, String name, String reason, String term, String reservationName) {

		String host = "smtp.naver.com";
		final String username = "a_spree@naver.com";
		final String password = "dhwlddj23";
		int port = 587;
		
		String recipient = empNo;
		String content = mailUitls.getMailTemplate(name, reason, term, reservationName);

		Properties props = System.getProperties();
		
		// 정보를 담기 위한 객체 생성
		// SMTP 서버 정보 설정
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = username;
			String pw = password;

			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});

		session.setDebug(true);
		
		Message mimeMessage = new MimeMessage(session);
		
		try {
			mimeMessage.setFrom(new InternetAddress(username));		
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			mimeMessage.setSubject(MimeUtility.encodeText(title, "UTF-8", "B"));
			mimeMessage.setContent(content, "text/html; charset=utf-8");
			Transport.send(mimeMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}


/*		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			Session session = Session.getDefaultInstance(props);
			MimeMessage msg = new MimeMessage(session);

			messageHelper.setFrom(setfrom); // 보내는 사람 이메일
			messageHelper.setTo(email); // 받는 사람 이메일
			messageHelper.setSubject(title); // 메일 제목 (생략 가능)
			messageHelper.setContent(content, "text/html; charset=utf-8"); // 메일 내용

			mailSender.send(message);

		} catch (Exception e) {
			System.out.println(e);
		}*/

		return true;
	}
	
}
