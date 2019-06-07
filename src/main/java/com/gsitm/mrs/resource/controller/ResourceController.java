package com.gsitm.mrs.resource.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonView;
import com.gsitm.mrs.reservation.dto.BorrowedEquipmentDTO;
import com.gsitm.mrs.reservation.service.ReservationService;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.resource.dto.RoomDTO;
import com.gsitm.mrs.resource.dto.WorkplaceDTO;
import com.gsitm.mrs.resource.service.ResourceService;

/**
 * 자원 관련 프로젝트 Controller @RequestMapping("/reservation") URI 매칭
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
	 * @param workplaceDTO
	 *            추가할 지사 객체
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
	
	
	/* ------------- 회의실 ------------- */

	/**
	 * 회의실 관리 페이지
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
	 * @param model
	 * @param roomNo	조회할 회의실 번호
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
	
	@RequestMapping(value = "/addRoom", method = RequestMethod.POST)
	public String addRoom(RoomDTO roomDTO) throws Exception {
		
		System.out.println(roomDTO.toString());

//		/* 멀티 셀렉트로 view에서 넘어온 회의실 번호 토큰 분리 */
//		 StringTokenizer token = new StringTokenizer(roomNoList , ",");
//		 while(token.hasMoreTokens()) {
//			 equipmentDTO.setRoomNo(Integer.parseInt(token.nextToken()));
//			 service.addEquipment(equipmentDTO);
//		 }

		return "redirect:/resource/equipmentList";
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
	 * @param roomNoList	비치될 회의실 번호
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addEquipment", method = RequestMethod.POST)
	public String addEquipment(EquipmentDTO equipmentDTO, String roomNoList) throws Exception {

		/* 멀티 셀렉트로 view에서 넘어온 회의실 번호 토큰 분리 */
		 StringTokenizer token = new StringTokenizer(roomNoList , ",");
		 while(token.hasMoreTokens()) {
			 equipmentDTO.setRoomNo(Integer.parseInt(token.nextToken()));
			 service.addEquipment(equipmentDTO);
		 }

		return "redirect:/resource/equipmentList";
	}
	
	/**
	 * 비품 수정
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
