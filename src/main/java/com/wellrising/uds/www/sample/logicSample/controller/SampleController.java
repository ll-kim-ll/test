package com.wellrising.uds.www.sample.logicSample.controller;

import java.text.DateFormat;
import java.util.Date;
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

import com.wellrising.uds.core.comm.EnumData0;
import com.wellrising.uds.core.comm.EnumData1;
import com.wellrising.uds.core.comm.EnumData2;
import com.wellrising.uds.core.comm.StaticContants;
import com.wellrising.uds.www.sample.logicSample.service.SampleDaoService;
import com.wellrising.uds.www.sample.logicSample.service.SampleMapperService;
import com.wellrising.uds.www.sample.logicSample.service.SampleSqlmapService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class SampleController {
	private static final Logger log = LoggerFactory.getLogger(SampleController.class);

	@Autowired
	SampleMapperService sampleMapperService;

	@Autowired
	SampleDaoService sampleDaoService;

	@Autowired
	SampleSqlmapService sampleSqlmapService;


	@RequestMapping(value = "/logicSample.do", method = RequestMethod.GET)
	@ResponseBody // json 타입 전송
/*	public String home(@RequestParam("param") String param, Model model) throws Exception {
 *  public String home(@RequestBody HashMap<String, String> map, Model model) throws Exception {
 *  public String home(@ModelAttribute MemberVo searchVo, Model model) throws Exception {
*/
	public String sample(Locale locale, Model model) throws Exception {
		log.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		// MAPPER
		Map resultMapper = sampleMapperService.selectSample();

		// DAO
		Map resultDao = sampleDaoService.selectSample();

		// SQLMAP
		Map resultSqlmap = sampleSqlmapService.selectSample();



		// Enum 테스트
		log.debug("EnumData0_name : "+EnumData0.INSERT.code);

		log.debug("EnumData1_name : "+EnumData1.INSERT.getCode());

		log.debug("EnumData2_name : "+EnumData2.INSERT.getName());
		log.debug("EnumData2_code : "+EnumData2.INSERT.getCode());
		log.debug("EnumData2_codeNum : "+ Integer.toString(EnumData2.INSERT.getCodeNum()));

		EnumData2 eDataName = EnumData2.findByName("save");
		EnumData2 eDataCode = EnumData2.findByCode("U");
		EnumData2 eDataCodeNum = EnumData2.findByCodeNum(3);

		// 정적인 값 정의
		String string = StaticContants.INSERT;

		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("test", "1212" );


		return "home";
	}

}
