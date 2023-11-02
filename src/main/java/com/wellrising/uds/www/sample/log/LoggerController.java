package com.wellrising.uds.www.sample.log;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wellrising.uds.core.comm.interceptor.AuthenticInterceptor;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class LoggerController {
	// slf4j logger
	private static final Logger slf4jLogger = LoggerFactory.getLogger(LoggerController.class);
	// // apache logger
	private static final Log apacheLog = LogFactory.getLog(AuthenticInterceptor.class);


	@RequestMapping("/logger.do")
	public String logger() throws Exception {
		slf4jLogger.debug("slf4j logger");
		apacheLog.debug("apacheLog logger");
		log.debug("@Slf4j logger");

		return "home";
	}


}
