package com.wellrising.uds.www.sample.logicSample.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellrising.uds.www.sample.logicSample.dao.SampleDao;


@Service
public class SampleDaoService {
	private static final Logger log = LoggerFactory.getLogger(SampleDaoService.class);

	@Autowired
	SampleDao sampledao;

	public Map selectSample() throws Exception {
		Map result = sampledao.selectSample();
		return result;
	}
}
