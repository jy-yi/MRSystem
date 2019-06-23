package com.gsitm.mrs.util;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mail")
public class MailController {
	
	@Inject
	private JavaMailSender mailSender;
	
	@RequestMapping(value="/mailSend")
	public String mailSend(String tomail) {
		
		String setfrom = "jy.yi.9515@gmail.com";
//		String tomail = email;		// 받는 사람 이메일
		String title = "메일 테스트";
		String content = "테스트~~~~";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setFrom(setfrom);		// 보내는 사람 이메일
			messageHelper.setTo(tomail);		// 받는 사람 이메일
			messageHelper.setSubject(title);	// 메일 제목 (생략 가능)
			messageHelper.setText(content);		// 메일 내용
			
			mailSender.send(message);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return "redirect:/";
	}
}
