package com.wellrising.uds.www.sample.properties;

import java.util.Properties;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

@Controller
public class PropertiesController {
	// <util:properties /> 사용
	@Value("#{globalProps['Globals.FileStorePath']}")
	private String fileStorePath;

	// org.springframework.beans.factory.config.PropertiesFactoryBean 사용
	@Resource(name="propertyConfigurer")
	private Properties propertyConfigurer1;

	@Autowired
	private Properties propertyConfigurer;

}
