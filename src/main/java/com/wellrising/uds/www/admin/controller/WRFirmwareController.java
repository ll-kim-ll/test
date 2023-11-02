package com.wellrising.uds.www.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import com.wellrising.uds.util.idGeneration.service.WRIdGenerationService;
import com.wellrising.uds.www.admin.service.WRFirmwareService;

@Controller
@RequestMapping("/admin")
public class WRFirmwareController {
	private static final Logger log = LoggerFactory.getLogger(WRFirmwareController.class);

	@Value("#{globalProps['Globals.FileStorePath.Firmware']}")
	private String uploadDir;

	@Autowired WRFirmwareService wRFirmwareService;

	@Autowired WRIdGenerationService idGenerationService;

	@Autowired ResponseService responseService;

	@GetMapping("/firmware.do")
	public String firmwareView(Model model) throws Exception { // get 방식
		model.addAttribute("menuNm", "펌웨어 설정");

		return "/admin/firmware/firmwareInfo";
	}

	@PostMapping("/firmwareList.do")
	@ResponseBody
	public Map<String, Object> selectFirmwareList(@RequestParam Map<String, Object> params, Model model) throws Exception { // get 방식
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Map> resultList = new ArrayList<Map>();

		PaginationInfo paginationInfo = new PaginationInfo();

//		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지
		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지

		params.put("firstIndex", paginationInfo.getFirstRecordIndex());
		params.put("lastIndex", paginationInfo.getLastRecordIndex());
		params.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		try {
			resultList = wRFirmwareService.selectFirmwareList(params);
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

	@PostMapping("/firmwareInsert.do")
	@ResponseBody
	public CommonResult insertFirmware(@RequestParam Map<String, Object> params, HttpServletRequest request, MultipartHttpServletRequest mRequest, HttpSession session, Model model) throws Exception { // get 방식

//		String userId = (String) session.getAttribute("userId");
//		params.put("userId", userId);

		try {
			wRFirmwareService.insertFirmware(params, request, mRequest);
		}
		catch(Exception e) {
 			return responseService.getFailResult(CommonResponse.FAILURE);
		}

		return responseService.getSuccessResult();
	}

	@GetMapping("/firmwareDownload.do")
	public void firmwareDownload(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response ) throws Exception { // get 방식
		wRFirmwareService.firmwareDownload(params, request, response);
	}
/*
	@GetMapping("/firmwareDownload.do")
	public ResponseEntity<Resource> firmwareDownload(@RequestParam(value = "dwldLink") String dwldLink, HttpServletRequest request, HttpServletResponse response ) throws Exception { // get 방식
		//wRFirmwareService.firmwareDownload(params, request, response);

		Path path1 = Paths.get(uploadDir + File.separator + dwldLink); String contentType = Files.probeContentType(path1);
		Resource resource = new InputStreamResource(Files.newInputStream(path1));

		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachement; filename=\"" + "firmware" +"\"")
				.header(HttpHeaders.CONTENT_TYPE, contentType)
				.body(resource);
	}
*/
}
