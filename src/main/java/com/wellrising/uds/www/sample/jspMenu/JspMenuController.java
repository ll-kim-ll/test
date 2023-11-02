package com.wellrising.uds.www.sample.jspMenu;

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
public class JspMenuController {
	private static final Logger log = LoggerFactory.getLogger(JspMenuController.class);

	@RequestMapping(value = "/jspHome.do", method = RequestMethod.GET)
	public String jspHome(Locale locale, Model model) throws Exception {
		return "/sample/jspMenu/jspHome";
	}

	@RequestMapping(value = "/jspMenu.do", method = RequestMethod.GET)
	public String jspMenu(Locale locale, Model model) throws Exception {
		List<Map<String, String>> menuList = new ArrayList<Map<String, String>>();
		Map<String, String> menu1 = new HashMap<String,String>();
		Map<String, String> menu2 = new HashMap<String,String>();
		Map<String, String> menu3 = new HashMap<String,String>();

		menu1.put("id", "1");
		menu1.put("nm", "메뉴1");
		menu2.put("id", "2");
		menu2.put("nm", "메뉴2");
		menu3.put("id", "3");
		menu3.put("nm", "메뉴3");

		menuList.add(menu1);
		menuList.add(menu2);
		menuList.add(menu3);

		model.addAttribute("menuList", menuList );

		return "/sample/jspMenu/jspMenu";
	}

}
