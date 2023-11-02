package com.wellrising.uds.core.comm.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 사용자IP 체크 인터셉터
 * @author 유지보수팀 이기하
 * @since 2013.03.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일     수정자          수정내용
 *  ----------  --------    ---------------------------
 *  2013.03.28	이기하          최초 생성
 *  </pre>
 */

public class IpObtainInterceptor extends HandlerInterceptorAdapter {
	private static final Logger log = LoggerFactory.getLogger(IpObtainInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		log.debug("IpObtainInterceptor 시작 ------------------------------------");
		String clientIp = request.getRemoteAddr();

//		LoginVO loginVO = (LoginVO) WRUserDetailsHelper.getAuthenticatedUser();
		Map loginVO = null;

		if (loginVO != null) {
//			loginVO.setIp(clientIp);
		}

		return true;
	}
}
