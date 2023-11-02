package com.wellrising.uds.www.sample.tiles;

import java.util.Locale;

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
public class TilesController {
	private static final Logger log = LoggerFactory.getLogger(TilesController.class);

	@RequestMapping(value = "/tiles.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
		return "test/tileTest";
	}

	@RequestMapping(value = "/tilesSampleHome.do", method = RequestMethod.GET)
	public String tilesSampleHome(Locale locale, Model model) throws Exception {
		return "sample/tileSampleHome";
	}

	@RequestMapping(value = "/tilesUserHome.do", method = RequestMethod.GET)
	public String tilesUserHome(Locale locale, Model model) throws Exception {
		return "user/tileUserHome";
	}

	@RequestMapping(value = "/tilesMemberHome.do", method = RequestMethod.GET)
	public String tilesMemberHome(Locale locale, Model model) throws Exception {
		return "member/tileMemberHome";
	}

	@RequestMapping(value = "/tilesAdminHome.do", method = RequestMethod.GET)
	public String tilesAdminHome(Locale locale, Model model) throws Exception {
		return "admin/tileAdminHome";
	}


}
