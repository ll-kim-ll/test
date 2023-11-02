package com.wellrising.uds.www.member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static final Logger log = LoggerFactory.getLogger(MemberController.class);

	@GetMapping("/dashboard.do")
	public String dashboardView(Model model) throws Exception { // get 방식
		model.addAttribute("menuNm", "대시보드");

		return "/member/dashboard";
	}

	@GetMapping("/dashboard2.do")
	public String dashboardView2(Model model) throws Exception { // get 방식
		model.addAttribute("menuNm", "대시보드");

		return "/member/dashboard2";
	}
}
