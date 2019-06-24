package com.gsitm.mrs.reservation.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 예약 취소 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.reservation.dto
 * @date : 2019. 6. 11.
 * @author : 이종윤
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CancelDTO {

	private int reservationNo;
	private String reason;

}
