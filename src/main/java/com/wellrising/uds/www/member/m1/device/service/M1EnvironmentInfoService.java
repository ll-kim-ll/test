package com.wellrising.uds.www.member.m1.device.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class M1EnvironmentInfoService extends AbstractService{

	public List<Map<String, Object>> selectEnvironmentInfo(Map params) {
		return dao.selectList("m1EnvironmentInfo.selectEnvironmentInfo", params);
	}
}
