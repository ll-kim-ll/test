package com.wellrising.uds.core.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.security.core.userdetails.UserDetails;

import com.wellrising.uds.core.comm.util.user.WRUserDetailsHelper;

public class DaoSqlSessionTemplate extends SqlSessionTemplate {
	public DaoSqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
		super(sqlSessionFactory);
		// TODO Auto-generated constructor stub
	}


	@Override
	public int insert(String statement, Object parameter) {
		// TODO Auto-generated method stub
		setMap(parameter);

		return super.insert(statement, parameter);
	}

	@Override
	public int update(String statement, Object parameter) {
		// TODO Auto-generated method stub
		setMap(parameter);

		return super.update(statement, parameter);
	}

	@Override
	public int delete(String statement, Object parameter) {
		// TODO Auto-generated method stub
		setMap(parameter);
		return super.delete(statement, parameter);
	}

	/* 사용자 ID 맵 추가 */
	private void setMap(Object obj) {
		if(WRUserDetailsHelper.isAuthenticated()) {
			UserDetails userDetails = (UserDetails) WRUserDetailsHelper.getAuthenticatedUser();
			if (userDetails != null && obj instanceof Map) {
				Map<String, Object> map = (Map<String, Object>) obj;
				if (!map.containsKey("CreateUser")) {
					map.put("C_USER", userDetails.getUsername());
				}
				/*
			HttpServletRequest request = RequestUtils.getRequest();
			map.put("JobWorkStation", RequestUtils.getRequest().getRemoteAddr());
			map.put("ProgramID", request.getRequestURI());
				 */
			}
		}
	}


}
