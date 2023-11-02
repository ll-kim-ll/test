package com.wellrising.uds.www.menu;

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
public class MenuController {
	private static final Logger log = LoggerFactory.getLogger(MenuController.class);

	@RequestMapping(value = "/menu.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {
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

		return "menu";
	}


}
