package com.wellrising.uds.www.member.m1.device.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wellrising.uds.core.comm.pagination.PaginationInfo;
import com.wellrising.uds.www.member.m1.device.service.M1DeviceListService;

@Controller
@RequestMapping("/device")
public class M1DeviceListController {
	private static final Logger log = LoggerFactory.getLogger(M1DeviceListController.class);

	@Autowired M1DeviceListService m1DeviceListService;

	@PostMapping("/routerList.do")
	@ResponseBody
	public List<Map> selectRouterList(ModelMap model) throws Exception {
		List<Map> list = new ArrayList<Map>();

		try {
			list = m1DeviceListService.selectRouterList();
		}
		catch(Exception e) {
			Map map = new HashMap();
			map.put("code", "");
			map.put("value", "서버 오류");
			list.add(map);
		}

		return list;
	}

	@PostMapping("/routerDataList.do")
	@ResponseBody
	public Map selectRouterDataList(@RequestParam Map<String, Object> param, ModelMap model) throws Exception {
		Map map = new HashMap();
		List<Map> resultList = new ArrayList<Map>();

		PaginationInfo paginationInfo = new PaginationInfo();

//		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지
		paginationInfo.setCurrentPageNo(Integer.parseInt(param.get("pageIndex").toString()));	// 현재 페이지

		map.put("firstIndex", paginationInfo.getFirstRecordIndex());
		map.put("lastIndex", paginationInfo.getLastRecordIndex());
		map.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		/*
		searchVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVo.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
*/
		try {
			resultList = m1DeviceListService.selectRouterDataList(map);
		}
		catch(Exception e) {
			Map tmp = new HashMap();
			tmp.put("code", "");
			tmp.put("value", "서버 오류");
			resultList.add(tmp);
		}

		paginationInfo.setTotalRecordCount(Integer.parseInt(resultList.get(0).get("totalCount").toString()));

		map.put("data", resultList);
		map.put("count", resultList.size());
		map.put("paging", paginationInfo);

		return map;
	}

	@PostMapping("/routerJsonDataList.do")
	@ResponseBody
	public Map selectRouterJsonDataList(@RequestBody Map<String, Object> param, ModelMap model) throws Exception {
		Map map = new HashMap();
		List<Map> resultList = new ArrayList<Map>();

		PaginationInfo paginationInfo = new PaginationInfo();

//		paginationInfo.setCurrentPageNo(Integer.parseInt(params.get("pageIndex").toString()));	// 현재 페이지
		paginationInfo.setCurrentPageNo(Integer.parseInt(param.get("pageIndex").toString()));	// 현재 페이지

		map.put("firstIndex", paginationInfo.getFirstRecordIndex());
		map.put("lastIndex", paginationInfo.getLastRecordIndex());
		map.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		/*
		searchVo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVo.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		 */
		try {
			resultList = m1DeviceListService.selectRouterDataList(map);
		}
		catch(Exception e) {
			Map tmp = new HashMap();
			tmp.put("code", "");
			tmp.put("value", "서버 오류");
			resultList.add(tmp);
		}

		paginationInfo.setTotalRecordCount(Integer.parseInt(resultList.get(0).get("totalCount").toString()));

		map.put("data", resultList);
		map.put("count", resultList.size());
		map.put("paging", paginationInfo);

		return map;
	}

	@PostMapping("/clientList.do")
	@ResponseBody
	public List<Map> selectClientList(@RequestParam String filter, ModelMap model) throws Exception {
		List<Map> list = new ArrayList<Map>();

		try {
			list = m1DeviceListService.selectClientList(filter);
		}
		catch(Exception e) {
			Map map = new HashMap();
			map.put("code", "");
			map.put("value", "서버 오류");
			list.add(map);
		}

		return list;
	}

	@PostMapping("/deviceList.do")
	@ResponseBody
	public List<Map> selectDeviceList(ModelMap model) throws Exception {
		List<Map> list = new ArrayList<Map>();

		try {
			list = m1DeviceListService.selectDeviceList();
		}
		catch(Exception e) {
			Map map = new HashMap();
			map.put("code", "");
			map.put("value", "서버 오류");
			list.add(map);
		}

		return list;
	}
}
