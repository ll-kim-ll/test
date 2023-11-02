package com.wellrising.uds.www.member.m1.device.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.wellrising.uds.core.comm.response.CommonResult;
import com.wellrising.uds.core.comm.response.service.ResponseService;
import com.wellrising.uds.core.comm.response.service.ResponseService.CommonResponse;
import com.wellrising.uds.www.member.m1.device.service.M1DeviceCommandService;

@Controller
@RequestMapping("/device")
public class M1DeviceCommandController {
	private static final Logger log = LoggerFactory.getLogger(M1DeviceCommandController.class);

	@Autowired M1DeviceCommandService m1DeviceCommandService;

	@Autowired ResponseService responseService;

	@GetMapping("/commandDevice.do")
	public String commandDeviceView(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식
		model.addAttribute("menuNm", "디바이스 설정");
		model.addAttribute("sParam", params);
		return "/member/m1/device/commandDevice";
	}

	@GetMapping("/commandDeviceInsert.do")
	public String commandDeviceInsertView(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식
		model.addAttribute("menuNm", "클라언트 설정");
		model.addAttribute("sParam", params);

		return "/member/m1/device/commandDeviceInsert";
	}

	@PostMapping("/commandDeviceList.do")
	@ResponseBody
	public Map<String, Object> commandDeviceList(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map> resultList = new ArrayList<Map>();

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지

		params.put("firstIndex", paginationInfo.getFirstRecordIndex());
		params.put("lastIndex", paginationInfo.getLastRecordIndex());
		params.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		try {
			/* 테스트 코드 */
			resultList = m1DeviceCommandService.selectCommandDeviceList(params);
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

	@PostMapping("/commandDeviceInsert.do")
	@ResponseBody
	public CommonResult commandDeviceInsert(@RequestParam Map<String, Object> params, HttpSession session, Model model) throws Exception { // get 방식

		String userId = (String) session.getAttribute("userId");
		params.put("userId", userId);

		try {
			m1DeviceCommandService.insertCommandDevice(params);
		}
		catch(Exception e) {
			return responseService.getFailResult(CommonResponse.FAILURE);
		}

		return responseService.getSuccessResult();
	}

}
