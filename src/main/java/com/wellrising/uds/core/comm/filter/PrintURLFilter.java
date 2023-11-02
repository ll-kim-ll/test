package com.wellrising.uds.core.comm.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PrintURLFilter implements Filter {
	private static final Logger log = LoggerFactory.getLogger(PrintURLFilter.class);

	// 필터 인스턴스 종료
	@Override
	public void destroy() {

		log.debug("PrintURLFilter destroy() ---------------------------------");
	}

	// 전/후 처리
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		log.debug("PrintURLFilter doFileter() 시작 ------------------------------------");

		HttpServletRequest req = (HttpServletRequest) request;
		log.debug("요청 URL: " + req.getRequestURI() + " --------------------------------");
		chain.doFilter(request, response);

		log.debug("PrintURLFilter doFileter() 끝 ------------------------------------");
	}

	// 필터 인스턴스 초기화
	@Override
	public void init(FilterConfig config) throws ServletException {
		log.debug("PrintURLFilter init() 시작 ------------------------------------");
		String FilterParam = config.getInitParameter("FilterParam");

		log.debug("FilterParam: " + FilterParam + " -----------------");
		log.debug("PrintURLFilter init() 끝--------------------------------------------------");
	}

}