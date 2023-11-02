package com.wellrising.uds.www.sample.securitySample.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/login")
@Controller
public class CustomLoginCommonController {
	private static final Logger log = LoggerFactory.getLogger(CustomLoginCommonController.class);

	// 단순 페이지만 넘겨줌
	@RequestMapping(value="/loginPage.do")
	public String loginPage(HttpServletRequest request) throws Exception {

		return "security/loginPage";
	}

	@GetMapping("/customLogin.do")
	public String loginInput(HttpServletRequest request, Model model) throws Exception {
		// 요청 시점의 사용자 URI 정보를 Session의 Attribute에 담아서 전달(잘 지워줘야 함)
		// 로그인이 틀려서 다시 하면 요청 시점의 URI가 로그인 페이지가 되므로 조건문 설정
/*
 * CustomAccessFailureHandler 상세 처리 후 loginPage.jsp 이동 처리 함
 *

		logger.info("loginFailMsg : " + request.getAttribute("loginFailMsg"));
		if(request.getAttribute("loginFailMsg") != null) {
			String loginFailMsg = request.getAttribute("loginFailMsg").toString();
			if(loginFailMsg != null) {
				model.addAttribute("err", true);
				model.addAttribute("loginFailMsg", loginFailMsg);
			}
		}
*/


		return "security/loginPage";
	}

	/*context-security 정의한 /customLogout.do 랑은 상관 없음. 시큐리티에서 이름 변경해서 전송 하는듯 함.  */
/*
	@GetMapping("/customLogout.do")
	public String logoutPage() {
		logger.info("custom logout");
		return "security/loginPage";
	}

	@PostMapping("/customLogout.do")
	public void logout() {
		logger.info("custom logout");
	}
*/
}
