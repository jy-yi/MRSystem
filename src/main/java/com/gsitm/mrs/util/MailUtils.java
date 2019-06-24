package com.gsitm.mrs.util;

import org.springframework.stereotype.Component;

/**
 * 이메일 템플릿
 * 
 * @Package : com.gsitm.mrs.util
 * @date : 2019. 6. 24.
 * @author : 이종윤
 */
@Component
public class MailUtils {
	
	public String getMailTemplate(String name, String reason, String term, String reservationName, String type) {
		
		String template =
				"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">" + 
				"<html xmlns=\"http://www.w3.org/1999/xhtml\">" + 
				"<head>" + 
				"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />" + 
				"<title></title>" + 
				"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />" + 
				"</head>" + 
				"<body style=\"margin: 0; padding: 0;\">" + 
				"	<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"text-align: center; color: #153643; \">" + 
				"		<tr>" + 
				"			<td align=\"center\"  style=\"padding: 20px 0 20px 0;\">" + 
				"				<img src=\"https://postfiles.pstatic.net/MjAxOTA2MjRfODUg/MDAxNTYxMzM4MDk3MzM4.iCvEY-WIVEe93XqXAmEiVH4JNuJfhaGEmEOKOfrVhZ0g.7bF2YG6hAAs0YMfIA7IfvsHJWuHztdTIz1j5hdtCt4wg.JPEG.a_spree/logo_homepage.jpg?type=w773\" " + 
				"					 width=\"70%\" style=\"display: block;\" />" + 
				"			</td>" + 
				"		</tr>" + 
				"		<tr>" + 
				"			<td style=\"padding: 40px 0 40px 0;\">" + 
				"				<table border=\"1\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border: 1px #cccccc;\">" + 
				"					<tr>" + 
				"						<td colspan=\"2\"> 회의실 예약 세부 신청 내역 </td>" + 
				"					</tr>" + 
				"					<tr>" + 
				"						<td> 신청자 </td>" + 
				"						<td> " + name + " </td>" + 
				"					</tr>" + 
				"					<tr>" + 
				"						<td> 회의명 </td>" + 
				"						<td> " + reservationName + " </td>" + 
				"					</tr>" + 
				"					<tr>" + 
				"						<td> 기간 </td>" + 
				"						<td> " + term +  "</td>" + 
				"					</tr>" + 
				"					<tr>" + 
				"						<td colspan=\"2\" style=\"padding: 10px 0 10px 0;\">" + 
				"							" + name + " 님이 신청하신 회의실 예약이 다음과 같은 사유로 " + type + " 되었습니다. " + 
				"						</td>" + 
				"					</tr>" + 
				"					<tr>" + 
				"						<td colspan=\"2\" style=\"padding: 20px 0 20px 0;\">" + 
				"							" + reason +  
				"						</td>" + 
				"					</tr>" + 
				"				</table>" + 
				"			</td>" + 
				"		</tr>" + 
				"		<tr>" + 
				"			<td style=\"padding: 10px 0 10px 0;\">" + 
				"				<img src=\"https://postfiles.pstatic.net/MjAxOTA2MjRfMTM4/MDAxNTYxMzM5MDgyMjc0.L4_LaccbtDCFgoeFKr279OBhMJCxM7j-NiBIeVvMa1gg.s-CfOy1YH_qDUFOqaM_eoLCeFrKlxv-TcTaAeOYZ61cg.PNG.a_spree/check.png?type=w773\" " + 
				"					 width=\"200\" height=\"60\" style=\"display: block; margin-left: auto; margin-right: auto;\" />" + 
				"			</td>" + 
				"		</tr>" + 
				"	</table>" + 
				"</body>" + 
				"</html>";
		
		return template;
	}

}
