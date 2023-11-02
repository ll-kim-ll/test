package com.wellrising.uds.www.member.m1.device.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class M1DeviceCommandClientService extends AbstractService {
	private static final Logger log = LoggerFactory.getLogger(M1DeviceCommandClientService.class);

	public List<Map> selectCommandClientList(Map<String, Object> params) throws Exception{
		// TODO Auto-generated method stub
		//List<Map> resultList = new HashMap<Map>();
		return dao.selectList("m1DeviceCommandClient.selectCommandClientList", params);
	}

	public void insertCommandClient(Map<String, Object> params) {
		// TODO Auto-generated method stub
		if(params.get("no").toString().isEmpty()) {
			List<Map> client = dao.selectList("m1DeviceList.selectClientList", params.get("eqpmnId").toString());

			for(int i=0; i<client.size(); i++) {
				String no = client.get(i).get("code").toString();
				params.put("no", no);
				dao.insert("m1DeviceCommandClient.insertCommandClient", params);
			}
		}
		else {
			dao.insert("m1DeviceCommandClient.insertCommandClient", params);
		}


	}

}
