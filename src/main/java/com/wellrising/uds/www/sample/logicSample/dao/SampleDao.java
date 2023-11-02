package com.wellrising.uds.www.sample.logicSample.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SampleDao {
	private static final Logger log = LoggerFactory.getLogger(SampleDao.class);

	@Autowired
	SqlSessionTemplate sqlsession;

	public Map selectSample() throws Exception {
		Map result = new HashMap<>();
		List sampleVo = sqlsession.selectList("sampleDao.selectSampleVo");
		List cMap = sqlsession.selectList("sampleDao.selectSampleMap");

		result.put("sampleVo", sampleVo);
		result.put("cMap", cMap);

		return result;
	}
}
