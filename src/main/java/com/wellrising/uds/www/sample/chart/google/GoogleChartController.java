package com.wellrising.uds.www.sample.chart.google;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wellrising.uds.www.sample.chart.google.service.GoogleChartService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class GoogleChartController {
	private static final Logger log = LoggerFactory.getLogger(GoogleChartController.class);

	@Autowired
	GoogleChartService googleChartService;

	@RequestMapping(value = "/googleChartSample.do", method = RequestMethod.GET)
	public String jspfHome(Locale locale, Model model) throws Exception {

		return "/sample/chart/google/googleSample";
	}

	@RequestMapping(value = "/googleChartSampleData1.do", method = RequestMethod.GET)
	@ResponseBody
	public List googleChartSampleData1(Locale locale, Model model) throws Exception {
		List<List> result = new ArrayList<List>();
		List<Object> data1 = new ArrayList<Object>();
		List<Object> data2 = new ArrayList<Object>();
		List<Object> data3 = new ArrayList<Object>();
		List<Object> data4 = new ArrayList<Object>();
		List<Object> data5 = new ArrayList<Object>();

		data1.add("Mushrooms");
		data1.add(5);
		result.add(data1);

		data2.add("Onions");
		data2.add(2);
		result.add(data2);

		data3.add("Olives");
		data3.add(2);
		result.add(data3);

		data4.add("Zucchini");
		data4.add(2);
		result.add(data4);

		data5.add("Pepperoni");
		data5.add(1);
		result.add(data5);

		return result;
	}

	@RequestMapping(value = "/googleChartSampleData2.do", method = RequestMethod.GET)
	@ResponseBody
	public Map googleChartSampleData2(Locale locale, Model model) throws Exception {
		Map result = new HashMap<>();

		result = googleChartService.getMapChartData();

		return result;
	}
}
