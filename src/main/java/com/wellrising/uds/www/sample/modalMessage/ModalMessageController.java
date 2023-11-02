package com.wellrising.uds.www.sample.modalMessage;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ModalMessageController {
	private static final Logger log = LoggerFactory.getLogger(ModalMessageController.class);

	@RequestMapping(value = "/modalMessage.do", method = RequestMethod.GET)
	public String modalMessage(Locale locale, Model model) throws Exception {
		log.info("Welcome home! The client locale is {}.", locale);

		return "/sample/modalMessage/modalMessage";
	}

	@RequestMapping(value = "/modalBootstrapMessage.do", method = RequestMethod.GET)
	public String modalBootstrapMessage(Locale locale, Model model) throws Exception {
		log.info("Welcome home! The client locale is {}.", locale);

		return "/sample/modalMessage/modalBootstrapMessage";
	}


}
