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
import com.wellrising.uds.core.comm.response.service.ResponseService;
import com.wellrising.uds.core.comm.response.service.ResponseService.CommonResponse;
import com.wellrising.uds.www.admin.service.WREnvironmentBaseService;

@Controller
@RequestMapping("/admin")
public class WREnvironmentBaseController {
	private static final Logger log = LoggerFactory.getLogger(WREnvironmentBaseController.class);

	@Autowired ResponseService responseService;

	@Autowired WREnvironmentBaseService wREnvironmentBaseService;

	@GetMapping("/environmentBase.do")
	public String deviceView(Model model) throws Exception { // get 방식
		model.addAttribute("menuNm", "환경 기본정보 조회");

		return "/admin/environment/environmentBase";
	}

	@PostMapping("/environmentBaseList.do")
	@ResponseBody
	public Map<String, Object> selectEnvironmentBaseList(@RequestParam Map<String, Object> params, Model model) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map> resultList = new ArrayList<Map>();

		PaginationInfo paginationInfo = new PaginationInfo();

//		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지
		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지

		params.put("firstIndex", paginationInfo.getFirstRecordIndex());
		params.put("lastIndex", paginationInfo.getLastRecordIndex());
		params.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		try {
			resultList = wREnvironmentBaseService.selectEnvironmentBaseList(params);
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


	@PostMapping("/environmentBaseInsert.do")
	@ResponseBody
	public CommonResult insertEnvironmentBase(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식

//		String userId = (String) session.getAttribute("userId");
//		params.put("userId", userId);

		try {
			wREnvironmentBaseService.insertEnvironmentBase(params);
		}
		catch(Exception e) {
 			return responseService.getFailResult(CommonResponse.FAILURE);
		}

		return responseService.getSuccessResult();
	}

	@PostMapping("/environmentBaseDelete.do")
	@ResponseBody
	public CommonResult deleteEnvironmentBase(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식

//		String userId = (String) session.getAttribute("userId");
//		params.put("userId", userId);

		try {
			wREnvironmentBaseService.deleteEnvironmentBase(params);
		}
		catch(Exception e) {
			return responseService.getFailResult(CommonResponse.FAILURE);
		}

		return responseService.getSuccessResult();
	}

}
