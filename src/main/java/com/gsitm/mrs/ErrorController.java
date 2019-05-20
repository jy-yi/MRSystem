package com.gsitm.mrs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 에러 페이지 관련 프로젝트 Controller @RequestMapping("/error") URI 매칭
 * 
 * @Package : com.gsitm.mrs
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
@Controller
@RequestMapping("/error")
public class ErrorController {
	
	@RequestMapping
    public String defaultError() {
        return "error/default";
    }
 
	@RequestMapping("/no-resource")
    public String noResource() {
        return "error/404";
    }
 
	@RequestMapping("/server-error")
    public String serverError() {
        return "error/500";
    }

}