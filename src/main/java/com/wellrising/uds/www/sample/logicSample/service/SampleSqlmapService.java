package com.wellrising.uds.www.sample.logicSample.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;


@Service
public class SampleSqlmapService extends AbstractService {
	private static final Logger log = LoggerFactory.getLogger(SampleSqlmapService.class);

	public Map selectSample() throws Exception {
		Map result = new HashMap<>();
		List sampleVo = dao.selectList("sampleSqlmap.selectSampleVo");
		List cMap = dao.selectList("sampleSqlmap.selectSampleMap");

		result.put("sampleVo", sampleVo);
		result.put("cMap", cMap);

		return result;
	}
}
