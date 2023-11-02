package com.wellrising.uds.core.comm.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommonFailResult<T> extends CommonResult {
	private T detail;
}
