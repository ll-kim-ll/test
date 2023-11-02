package com.wellrising.uds.www.sample.chart.c3;

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
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class C3ChartController {
	private static final Logger log = LoggerFactory.getLogger(C3ChartController.class);

	@RequestMapping(value = "/c3ChartSample.do", method = RequestMethod.GET)
	public String jspfHome(Locale locale, Model model) throws Exception {



		return "/sample/chart/c3/c3Sample";
	}

	@RequestMapping(value = "/c3ChartSampleData.do", method = RequestMethod.GET)
	@ResponseBody
	public Map c3ChartSampleData(Locale locale, Model model) throws Exception {
		Map<String, List> result = new HashMap<String,List>();
		List<Integer> data1 = new ArrayList<Integer>();
		List<Integer> data2 = new ArrayList<Integer>();


		data1.add(300);
		data1.add(100);
		data1.add(250);
		data1.add(150);
		data1.add(300);
		data1.add(150);
		data1.add(550);

		data2.add(100);
		data2.add(200);
		data2.add(150);
		data2.add(50);
		data2.add(100);
		data2.add(250);

		result.put("data1", data1 );
		result.put("data2", data2 );

		return result;
	}


}
