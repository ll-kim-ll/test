package com.wellrising.uds.www.sample.logicSample.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.wellrising.uds.www.sample.logicSample.mapper.SampleMapper;


@Service
public class SampleMapperService {
	private static final Logger log = LoggerFactory.getLogger(SampleMapperService.class);

	
	@Resource(name="sampleMapper")
	private SampleMapper sampleMapper;

	public Map selectSample() throws Exception {
		Map result = new HashMap<>();

		List sampleVo = sampleMapper.selectSampleVo();
		List cMap = sampleMapper.selectSampleMap();

		result.put("sampleVo", sampleVo);
		result.put("cMap", cMap);

		return result;
	}
}
