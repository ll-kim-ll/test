package com.wellrising.uds.www.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.wellrising.uds.core.comm.pagination.PaginationInfo;
import com.wellrising.uds.core.comm.response.CommonResult;
import com.wellrising.uds.core.comm.response.service.ResponseService.CommonResponse;
import com.wellrising.uds.www.admin.service.WRDeviceInfoService;

@Controller
@RequestMapping("/admin")
public class WRDeviceInfoController {
	private static final Logger log = LoggerFactory.getLogger(WRDeviceInfoController.class);

	@Autowired WRDeviceInfoService wRDeviceInfoService;

	@GetMapping("/device.do")
	public String deviceView(Model model) throws Exception { // get 방식
		model.addAttribute("menuNm", "장치 조회");

		return "/admin/device/deviceInfo";
	}

	@PostMapping("/deviceInfoList.do")
	@ResponseBody
	public Map<String, Object> selectDeviceList(@RequestParam Map<String, Object> params, Model model) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map> resultList = new ArrayList<Map>();

		PaginationInfo paginationInfo = new PaginationInfo();

//		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지
		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지

		params.put("firstIndex", paginationInfo.getFirstRecordIndex());
		params.put("lastIndex", paginationInfo.getLastRecordIndex());
		params.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		try {
			resultList = wRDeviceInfoService.selectDeviceList(params);
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

	@PostMapping("/routerList.do")
	@ResponseBody
	public Map<String, Object> selectRouterList(@RequestParam Map<String, Object> params, Model model) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map> resultList = new ArrayList<Map>();

		PaginationInfo paginationInfo = new PaginationInfo();

//		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지
		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지

		params.put("firstIndex", paginationInfo.getFirstRecordIndex());
		params.put("lastIndex", paginationInfo.getLastRecordIndex());
		params.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		try {
			resultList = wRDeviceInfoService.selectRouterList(params);
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

	@PostMapping("/clientList.do")
	@ResponseBody
	public Map<String, Object> selectClientList(@RequestParam Map<String, Object> params, Model model) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map> resultList = new ArrayList<Map>();

		try {
			resultList = wRDeviceInfoService.selectClientList(params);
		}
		catch(Exception e) {
			log.debug(e.getMessage());
		}

		int totalCount = 0;
		if(resultList.size()>0) {
			totalCount = resultList.size();
		}

		resultMap.put("data", resultList);
		resultMap.put("count", totalCount);

		return resultMap;
	}

}
