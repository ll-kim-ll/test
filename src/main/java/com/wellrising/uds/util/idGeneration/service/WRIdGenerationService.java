package com.wellrising.uds.util.idGeneration.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class WRIdGenerationService extends AbstractService{
	/**
	 * id 생성
	 * COMTECOPSEQ table_name
	 * prefix 생성 id 앞부분 문자
	 * cipers prefix뺀 나머지 길이
	 * fillChar cipers길이 만큼 채울 문자
	 */
//    public String getIdgen(String tableName, String prefix, char fillChar, int cipers) {
	public String getIdgen(Map<String, Object> param) {
    	dao.update("wRIdGeneration.updateIdGeneration", param);

    	return fillString(param);
    }


	/**
     * 대상 길이만큼 디폴트 Char로 채우기.
     */
//    public static String fillString(String originalStr, char ch, int cipers) {
   	public static String fillString(Map<String, Object> param) {
   		String prefix = param.get("prefix").toString();
   		String originalStr = param.get("nextId").toString();
//   		char ch = (Character)param.get("ch");
   		char ch = param.get("fillChar").toString().charAt(0);
   		int cipers = (int)param.get("cipers");

   		int originalStrLength = originalStr.length();

        if (cipers < originalStrLength) {
            return null;
        }

        int difference = cipers - originalStrLength;

        StringBuffer strBuf = new StringBuffer();
        for (int i = 0; i < difference; i++) {
            strBuf.append(ch);
        }

        strBuf.append(originalStr);

        return prefix+strBuf.toString();
    }
}
