package com.wellrising.uds.www.member.m1.device.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class M1StatisticsService extends AbstractService{

	public List<Map<String, Object>> selectStatistics(Map params) {
		return dao.selectList("M1Monitoring.selectStatistics", params);
	}
}
