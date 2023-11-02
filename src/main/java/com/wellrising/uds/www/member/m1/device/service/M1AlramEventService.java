package com.wellrising.uds.www.member.m1.device.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class M1AlramEventService extends AbstractService{

	public List<Map<String, Object>> selectAlramEventList(Map params) {
		return dao.selectList("m1AlramEvent.selectAlramEventList", params);
	}
}
