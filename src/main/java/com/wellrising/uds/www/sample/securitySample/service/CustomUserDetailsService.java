package com.wellrising.uds.www.sample.securitySample.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.wellrising.uds.core.service.AbstractService;

public class CustomUserDetailsService extends AbstractService implements UserDetailsService  {
	private static final Logger log = LoggerFactory.getLogger(CustomUserDetailsService.class);

	@Override
	public UserDetails loadUserByUsername(String inputUserId) throws UsernameNotFoundException {

		// 최종적으로 리턴해야할 객체
		UserDetailsVO userDetails = new UserDetailsVO();

		// 사용자 정보 select
		UserInfoVO userInfo = dao.selectOne("userDetailsCustom.selectUserInfoOne", inputUserId);

		// 사용자 정보 없으면 null 처리
		if (userInfo == null) {
			log.debug("존재하지 않는 사용자입니다.");
			throw new UsernameNotFoundException("존재하지 않는 사용자입니다.");
		// 사용자 정보 있을 경우 로직 전개 (userDetails에 데이터 넣기)
		} else {
			userDetails.setNmae(userInfo.getUsername());
			userDetails.setUsername(userInfo.getUserid());
			userDetails.setPassword(userInfo.getUserpw());

			// 사용자 권한 select해서 받아온 List<String> 객체 주입
			userDetails.setAuthorities( dao.selectList("userDetailsCustom.selectUserAuthOne", inputUserId) );
		}

		return userDetails;
	}
}
