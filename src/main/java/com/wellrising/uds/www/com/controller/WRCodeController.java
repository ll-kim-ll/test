package com.wellrising.uds.www.com.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wellrising.uds.core.comm.response.service.ResponseService;
import com.wellrising.uds.www.com.service.WRCodeService;

@Controller
@RequestMapping("/com")
public class WRCodeController {
	private static final Logger log = LoggerFactory.getLogger(WRCodeController.class);

	@Autowired
	WRCodeService wRCodeService;

	@Autowired
	ResponseService responseService;

	@PostMapping("/selectcodeClcode.do")
	@ResponseBody
	public List<Map> selectcodeClcode(@RequestParam Map<String, Object> params, HttpSession session, Model model) throws Exception { // get 방식
		List<Map> result = new ArrayList<Map>();
		return wRCodeService.selectcodeClcode(params);
	}

}
