package com.wellrising.uds.core.comm;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
public enum EnumData0 {
	DELETE("D"),
	INSERT("I"),
	UPDATE("U");

	public String code;

	EnumData0(String code){
		this.code = code;
	}

}




