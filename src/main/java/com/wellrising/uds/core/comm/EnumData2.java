package com.wellrising.uds.core.comm;

import java.util.Arrays;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum EnumData2 {
	DELETE("delete", "D", 3),
	INSERT("insert", "I", 1),
	UPDATE("updaet", "U", 2);

	private String name;
	private String code;
	private int codeNum;

	public static EnumData2 findByName(String name) {
		return Arrays.stream(EnumData2.values())
				.filter(type -> (name.equalsIgnoreCase(type.getName())))
				.findAny() // 하나만 반환
//				.orElse(""); // 업을 경우
				.orElse(INSERT);
	}

	public static EnumData2 findByCode(String code) {
		return Arrays.stream(EnumData2.values())
				.filter(type -> (code.equalsIgnoreCase(type.getCode())))
				.findAny()
				.orElse(INSERT);
	}

	public static EnumData2 findByCodeNum(int codeNum) {
		return Arrays.stream(EnumData2.values())
				.filter(type -> (codeNum==type.getCodeNum()))
				.findAny()
				.orElse(INSERT);
	}


}




