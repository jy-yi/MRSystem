package com.gsitm.mrs.resource.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

	@RequestMapping(value = "/roomList", method = RequestMethod.GET)
	public String roomList() {
		
		logger.info("(관리자) 회의실 관리");
		
		return "admin/resource/roomList";
	}

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
		
		model.addAttribute("equipmentList", equipmentList);
		
		return "admin/resource/equipmentList";
	}
}
