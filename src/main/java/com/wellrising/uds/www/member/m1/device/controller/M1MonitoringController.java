package com.wellrising.uds.www.member.m1.device.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wellrising.uds.www.member.m1.device.service.M1MonitoringService;

@Controller
@RequestMapping(value="/device")
public class M1MonitoringController {
	private static final Logger log = LoggerFactory.getLogger(M1MonitoringController.class);

	@Autowired
	M1MonitoringService m1MonitoringService;

	@GetMapping("/monitoring.do")
	public String monitoringView(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식
		model.addAttribute("menuNm", "모니터링");

		return "/member/m1/device/monitoring";
	}

	@PostMapping("/minuteMonitoring.do")
	@ResponseBody
	public List<Map<String, Object>> getMinuteMonitoring(Model model) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		resultList = m1MonitoringService.selectMinuteMonitoring();

		return resultList;
	}

	@PostMapping("/hourMonitoring.do")
	@ResponseBody
	public List<Map<String, Object>> getHourMonitoring(Model model) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		resultList = m1MonitoringService.selectHourMonitoring();

		return resultList;
	}

	@PostMapping("/weekMonitoring.do")
	@ResponseBody
	public List<Map<String, Object>> getWeekMonitoring(Model model) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		resultList = m1MonitoringService.selectWeekMonitoring();

		return resultList;
	}

	@PostMapping("/monthMonitoring.do")
	@ResponseBody
	public List<Map<String, Object>> getMonthMonitoring(Model model) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		resultList = m1MonitoringService.selectMonthMonitoring();

		return resultList;
	}


}

