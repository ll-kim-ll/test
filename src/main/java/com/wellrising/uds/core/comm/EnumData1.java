package com.wellrising.uds.core.comm;

import java.util.Arrays;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum EnumData1 {
	DELETE("D"),
	INSERT("I"),
	UPDATE("U");

	private String code;

	public static EnumData1 findByName(String name) {
		return Arrays.stream(EnumData1.values())
				.filter(type -> (name.equalsIgnoreCase(type.getCode())))
				.findAny() // 하나만 반환
//				.orElse(""); // 업을 경우
				.orElse(INSERT);
	}

}




