package com.gsitm.mrs.reservation.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 
 * @Package : com.gsitm.mrs.reservation.dto
 * @date : 2019. 5. 28.
 * @author : 이종윤
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class WaitingDTO {

	private int reservationNo;
	private String managerApproval;
	private String adminApproval;

}
