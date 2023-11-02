package com.wellrising.uds.www.sample.file;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/file")
public class FileViewController {
	private static final Logger log = LoggerFactory.getLogger(FileViewController.class);

	@RequestMapping(value = "/fileVew.do", method = RequestMethod.GET)
	public String fileVew(Locale locale, Model model) throws Exception {
		return "/sample/file/fileView";
	}

}
