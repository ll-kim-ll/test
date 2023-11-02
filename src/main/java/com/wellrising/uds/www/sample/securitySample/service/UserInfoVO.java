package com.wellrising.uds.www.sample.securitySample.service;

import lombok.Data;

@Data
public class UserInfoVO {
	private String userid;
	private String userpw;
	private String username;
	private String authority;
	private boolean enabled;
}
