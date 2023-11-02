package com.wellrising.uds.core.comm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class LoggerInterceptor extends HandlerInterceptorAdapter{
	private static final Logger log = LoggerFactory.getLogger(LoggerInterceptor.class);

	//컨트롤러 호출전 작동하는 핸들러
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if (log.isDebugEnabled()) {
			log.debug("LoggerInterceptor START ======================================");
			log.debug(" Request URI : " + request.getRequestURI()); }
			return super.preHandle(request, response, handler);
		}

	//컨트롤러 호출후 작동하는 핸들러
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if (log.isDebugEnabled()) {
			log.debug("LoggerInterceptor END ======================================\n");
		}
	}
}
