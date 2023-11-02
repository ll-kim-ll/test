package com.wellrising.uds.www.com.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class WRCodeService extends AbstractService {
	private static final Logger log = LoggerFactory.getLogger(WRCodeService.class);

	public List<Map> selectcodeClcode(Map<String, Object> params) throws Exception{
		// TODO Auto-generated method stub
		return dao.selectList("wRCode.selectcodeClcode", params);
	}


}
