package com.wellrising.uds.www.member.m1.device.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.wellrising.uds.www.member.m1.device.service.M1StatisticsService;

@Controller
@RequestMapping(value="/device")
public class M1StatisticsController {
	private static final Logger log = LoggerFactory.getLogger(M1StatisticsController.class);

	@Autowired
	M1StatisticsService m1StatisticsService;

	@GetMapping("/statistics.do")
	public String statisticsView(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식
//		model.addAttribute("menuNm", "통계");
//		model.addAttribute("sParam", params);

		return "/member/m1/device/statistics";
		//return "redirect:/device/statistics1.do";
		//return "forward:/device/statistics1.do"; // params 그대로 전달 됨.
	}

	@GetMapping("/statistics1.do")
	public String statisticsView1(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식
		model.addAttribute("menuNm", "통계");
		model.addAttribute("sParam", params);

		return "/member/m1/device/statistics";
	}

}

