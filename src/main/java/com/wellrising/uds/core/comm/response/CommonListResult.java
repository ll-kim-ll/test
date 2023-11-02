package com.wellrising.uds.core.comm.response;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommonListResult<T> extends CommonResult {
	private List<T> list;
}
