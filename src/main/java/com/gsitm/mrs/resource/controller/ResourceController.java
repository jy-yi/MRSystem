package com.gsitm.mrs.resource.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gsitm.mrs.reservation.dto.BorrowedEquipmentDTO;
import com.gsitm.mrs.reservation.service.ReservationService;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.resource.dto.RoomDTO;
import com.gsitm.mrs.resource.dto.WorkplaceDTO;
import com.gsitm.mrs.resource.service.ResourceService;

/**
 * 자원 관련 프로젝트 Controller @RequestMapping("/resource") URI 매칭
 * 
 * @Package : com.gsitm.mrs.resource.controller
 * @date : 2019. 5. 8.
 * @author : 이종윤
 * 
 */
@Controller
@RequestMapping("/resource")
public class ResourceController {

	private static final Logger logger = LoggerFactory.getLogger(ResourceController.class);

	@Inject
	private ResourceService service;

	@Inject
	private ReservationService reservationService;

	@Resource(name = "uploadPath")
	private String uploadPath;

	/* ------------- 지사 ------------- */

	/**
	 * 지사 관리 페이지
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/workplaceList", method = RequestMethod.GET)
	public String workplaceList(Model model) {

		logger.info("(관리자) 지사 관리");

		List<WorkplaceDTO> workplaceList = service.getWorkplaceList();

		model.addAttribute("workplaceList", workplaceList);

		return "admin/resource/workplaceList";
	}

	/**
	 * 지사 추가
	 * 
	 * @param workplaceDTO 추가할 지사 객체
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addWorkplace", method = RequestMethod.POST)
	public String addWorkplace(WorkplaceDTO workplaceDTO) throws Exception {

		service.addWorkplace(workplaceDTO);

		return "redirect:/resource/workplaceList";
	}

	/**
	 * 지사 수정
	 * 
	 * @param workplaceDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editWorkplace", method = RequestMethod.POST)
	public String editWorkplace(WorkplaceDTO workplaceDTO) throws Exception {

		service.editWorkplace(workplaceDTO);

		return "redirect:/resource/workplaceList";
	}
	
	/**
	 * 지사 삭제
	 * 
	 * @param workplaceNo	삭제할 지사 번호
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteWorkplace", method = RequestMethod.POST)
	public String deleteWorkplace(String workplaceNo) throws Exception {
		
		service.deleteWorkplace(Integer.parseInt(workplaceNo));

		return "redirect:/resource/workplaceList";
	}

	/* ------------- 회의실 ------------- */

	/**
	 * 회의실 관리 페이지
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/roomList", method = RequestMethod.GET)
	public String roomList(Model model) {

		logger.info("(관리자) 회의실 관리");

		List<Map<String, Object>> roomList = service.getRoomList();
		List<String> equipmentList = service.getEquipmentListDistinct();

		model.addAttribute("roomList", roomList);
		model.addAttribute("equipDistinctList", equipmentList);

		return "admin/resource/roomList";
	}

	/**
	 * 회의실 별 비품 목록 조회
	 * 
	 * @param model
	 * @param roomNo 조회할 회의실 번호
	 * @return
	 */
	@RequestMapping(value = "/getEquipmentList", method = RequestMethod.POST)
	public ModelAndView getEquipmentList(Model model, String roomNo) {

		List<Map<String, Object>> equipmentList = reservationService.getEquipmentList(Integer.parseInt(roomNo));

		ModelAndView mav = new ModelAndView();
		mav.addObject("equipmentList", equipmentList);
		mav.setViewName("jsonView");

		return mav;
	}

	/**
	 * 회의실 등록
	 * 
	 * @param roomDTO	등록할 회의실 객체
	 * @param file		파일 업로드 (회의실 이미지)
	 * @param equipList	선택한 비품 리스트
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addRoom", method = RequestMethod.POST)
	public String addRoom(RoomDTO roomDTO, MultipartFile file, String equipList) throws Exception {

		if (file != null) {
			logger.info("originalName:" + file.getOriginalFilename());
			logger.info("size:" + file.getSize());
			logger.info("ContentType:" + file.getContentType());
		}

		String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());

		logger.info("savedName:" + savedName);

		roomDTO.setImage(savedName);
		
		// TODO: 관리자 로그인 아이디 처리
		service.addRoom(roomDTO);

		/* 멀티 셀렉트로 view에서 넘어온 비품 이름 토큰 분리 */
		 StringTokenizer token = new StringTokenizer(equipList, ",");
		 while(token.hasMoreTokens()) {
			 Date today = new Date();
			 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			 
			 EquipmentDTO equipmentDTO = new EquipmentDTO(1, roomDTO.getRoomNo(), token.nextToken(), format.format(today));
			 service.addEquipment(equipmentDTO);
		 }

		return "redirect:/resource/roomList";
	}

	/**
	 * 업로드된 파일을 저장하는 함수
	 * 
	 * @param originalName	원본 파일 이름
	 * @param fileDate		파일의 바이트 배열
	 * @return
	 * @throws IOException
	 */
	private String uploadFile(String originalName, byte[] fileDate) throws IOException {

		UUID uid = UUID.randomUUID();

		String savedName = uid.toString() + "_" + originalName;
		File target = new File(uploadPath, savedName);

		FileCopyUtils.copy(fileDate, target);  // 데이터가 담긴 바이트 배열을 파일에 기록

		return savedName;

	}
	
	/**
	 * 회의실 수정
	 * 
	 * @param roomDTO	수정할 회의실 객체
	 * @param img		파일 업로드 (회의실 이미지)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editRoom", method = RequestMethod.POST)
	public String editRoom(RoomDTO roomDTO, MultipartFile img) throws Exception {
		
		String savedName = uploadFile(img.getOriginalFilename(), img.getBytes());
		roomDTO.setImage(savedName);
		
		service.editRoom(roomDTO);

		return "redirect:/resource/roomList";
	}
	
	/**
	 * 회의실 삭제
	 * 
	 * @param roomNo	삭제할 회의실 번호
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteRoom", method = RequestMethod.POST)
	public String deleteRoom(String roomNo) throws Exception {
		
		service.deleteRoom(Integer.parseInt(roomNo));

		return "redirect:/resource/roomList";
	}

	/* ------------- 비품 ------------- */

	/**
	 * 비품 관리 페이지
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/equipmentList", method = RequestMethod.GET)
	public String equipmentList(Model model) {

		logger.info("(관리자) 비품 관리");

		List<Map<String, Object>> equipmentList = service.getEquipmentList();
		List<Map<String, Object>> roomList = service.getRoomList();
		List<BorrowedEquipmentDTO> borrowedEquipmentList = service.getBorrowedEquipmentList();
		List<Object> workplaceNameList = new ArrayList<>();

		for (Map<String, Object> map : roomList) {

			Set<Map.Entry<String, Object>> entries = map.entrySet();

			for (Map.Entry<String, Object> entry : entries) {

				/* 지사 이름 중복 제거 */
				if (entry.getKey().equals("WORKPLACENAME")) {
					if (!workplaceNameList.contains(entry.getValue()))
						workplaceNameList.add(entry.getValue());
				}
			}
		}

		/* 비품이 대여 중인지 여부 */
		for (Map<String, Object> map : equipmentList) {

			Integer equipNo = Integer.valueOf(map.get("EQUIPNO").toString());

			for (int i = 0; i < borrowedEquipmentList.size(); i++) {
				if (borrowedEquipmentList.get(i).getEquipmentNo() == equipNo) {
					map.put("isBorrowed", "Y");
				}
			}
		}

		model.addAttribute("equipmentList", equipmentList);
		model.addAttribute("roomList", roomList);
		model.addAttribute("workplaceNameList", workplaceNameList);

		return "admin/resource/equipmentList";
	}

	/**
	 * 비품 추가
	 * 
	 * @param equipmentDTO 추가할 비품 객체
	 * @param roomNoList   비치될 회의실 번호
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addEquipment", method = RequestMethod.POST)
	public String addEquipment(EquipmentDTO equipmentDTO, String roomNoList) throws Exception {

		/* 멀티 셀렉트로 view에서 넘어온 회의실 번호 토큰 분리 */
		StringTokenizer token = new StringTokenizer(roomNoList, ",");
		while (token.hasMoreTokens()) {
			equipmentDTO.setRoomNo(Integer.parseInt(token.nextToken()));
			service.addEquipment(equipmentDTO);
		}

		return "redirect:/resource/equipmentList";
	}

	/**
	 * 비품 수정
	 * 
	 * @param equipmentDTO 수정할 비품 객체
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editEquipment", method = RequestMethod.POST)
	public String editEquipment(EquipmentDTO equipmentDTO) throws Exception {

		service.editEquipment(equipmentDTO);

		return "redirect:/resource/equipmentList";
	}

	/**
	 * 비품 삭제
	 * 
	 * @param equipmentNo 삭제할 비품 번호
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteEquipment", method = RequestMethod.POST)
	public String deleteEquipment(String equipmentNo) throws Exception {

		service.deleteEquipment(Integer.parseInt(equipmentNo));

		return "redirect:/resource/equipmentList";
	}
}
