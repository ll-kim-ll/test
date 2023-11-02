package com.wellrising.uds.www.sample.securitySample.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class RegisterUserService extends AbstractService {
	private static final Logger log = LoggerFactory.getLogger(RegisterUserService.class);

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	public void RegisterUser(UserInfoVO userInfo) throws Exception {

		System.out.println("Befor Encoder : " + userInfo.getUserpw());
		String endcodedPassword = bcryptPasswordEncoder.encode(userInfo.getUserpw());
		System.out.println("After Encoder : " + endcodedPassword);
		System.out.println("Resister User Info : " + userInfo);

		userInfo.setUserpw(endcodedPassword);

		dao.insert("userDetailsCustom.registerUserInfo", userInfo);
		dao.insert("userDetailsCustom.registerUserAuth", userInfo);
	}
}