package com.wellrising.uds.www.sample.securitySample.service;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

public class CustomAccessDeniedHandler implements AccessDeniedHandler{
	private static final Logger log = LoggerFactory.getLogger(CustomAccessDeniedHandler.class);

	// url 접근 제한 오류 페이지
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("Access Denied Handler");
		log.error("Redirect.....");
		response.sendRedirect("/accessDenied.do");
	}
}
