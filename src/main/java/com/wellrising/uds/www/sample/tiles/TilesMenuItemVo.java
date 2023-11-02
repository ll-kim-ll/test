package com.wellrising.uds.www.sample.tiles;

import lombok.Data;

@Data
public class TilesMenuItemVo {
	private String id;
	private String nm;

	public TilesMenuItemVo(String id, String nm) throws Exception {
		this.id = id;
		this.nm = nm;
	}
}
