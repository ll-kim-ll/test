package com.wellrising.uds.www.sample.logicSample.service;


import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SampleVo {
	private int userNumber;	//유저번호
	private String userId;
	private String userName;
	private String pw;
}
