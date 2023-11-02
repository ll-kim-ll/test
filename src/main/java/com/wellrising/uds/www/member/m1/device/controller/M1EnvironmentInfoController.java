package com.wellrising.uds.www.member.m1.device.controller;

import java.util.ArrayList;
import java.util.HashMap;
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

import com.wellrising.uds.core.comm.pagination.PaginationInfo;
import com.wellrising.uds.www.member.m1.device.service.M1EnvironmentInfoService;

@Controller
@RequestMapping(value="/device")
public class M1EnvironmentInfoController {
	private static final Logger log = LoggerFactory.getLogger(M1EnvironmentInfoController.class);

	@Autowired
	M1EnvironmentInfoService m1EnvironmentInfoService;

	@GetMapping("/environmentInfo.do")
	public String environmentInfoView(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식
		model.addAttribute("menuNm", "환경정보 조회");
		model.addAttribute("sParam", params);

		return "/member/m1/device/environmentInfo";
	}

	@PostMapping("/environmentInfo.do")
	@ResponseBody
	public Map<String, Object> environmentInfoList(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		PaginationInfo paginationInfo = new PaginationInfo();

//		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지
		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지

		params.put("firstIndex", paginationInfo.getFirstRecordIndex());
		params.put("lastIndex", paginationInfo.getLastRecordIndex());
		params.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		try {
			resultList = m1EnvironmentInfoService.selectEnvironmentInfo(params);
		}
		catch(Exception e) {
			log.debug(e.getMessage());
		}

		int totalCount = 0;
		if(resultList.size()>0) {
			totalCount = Integer.parseInt(resultList.get(0).get("totalCount").toString());
		}
		paginationInfo.setTotalRecordCount(totalCount);

		resultMap.put("data", resultList);
		resultMap.put("count", totalCount);
		resultMap.put("paging", paginationInfo);

		return resultMap;

	}




}
