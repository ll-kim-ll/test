package com.wellrising.uds.www.member.m1.device.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class M1MonitoringService extends AbstractService{

	public List<Map<String, Object>> selectStatistics(Map params) {
		return dao.selectList("m1Monitoring.selectMonitoring", params);
	}

	public List<Map<String, Object>> selectMinuteMonitoring() {
		return dao.selectList("m1Monitoring.selectMinuteMonitoring");
	}

	public List<Map<String, Object>> selectHourMonitoring() {
		return dao.selectList("m1Monitoring.selectHourMonitoring");
	}

	public List<Map<String, Object>> selectWeekMonitoring() {
		return dao.selectList("m1Monitoring.selectWeekMonitoring");
	}

	public List<Map<String, Object>> selectMonthMonitoring() {
		return dao.selectList("m1Monitoring.selectMonthMonitoring");
	}
}
