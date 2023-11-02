package com.wellrising.uds.core.comm;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.support.JdbcUtils;

@SuppressWarnings("serial")
public class ConvertUnderscoreNameToPropertyName extends HashMap<String, Object> {
	private static final Logger log = LoggerFactory.getLogger(ConvertUnderscoreNameToPropertyName.class);

    @Override
    public Object put(String key, Object value) {
        return super.put(JdbcUtils.convertUnderscoreNameToPropertyName(key), value);
    }
}
