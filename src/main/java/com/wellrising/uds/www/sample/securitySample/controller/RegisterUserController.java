package com.wellrising.uds.www.sample.securitySample.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wellrising.uds.www.sample.securitySample.service.RegisterUserService;
import com.wellrising.uds.www.sample.securitySample.service.UserInfoVO;

@RequestMapping("/users")
@Controller
public class RegisterUserController {
	private static final Logger log = LoggerFactory.getLogger(RegisterUserController.class);

	@Autowired
	RegisterUserService userService;

	@GetMapping(value="/register.do")
	public String loginPage() throws Exception {
		return "security/register";
	}

	@PostMapping("/register.do")
	public void loginProcessing(UserInfoVO userInfo) throws Exception {
		userService.RegisterUser(userInfo);
	}

}
