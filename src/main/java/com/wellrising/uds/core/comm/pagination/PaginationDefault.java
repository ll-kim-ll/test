package com.wellrising.uds.core.comm.pagination;

import java.io.Serializable;

import lombok.Data;

@Data
public class PaginationDefault implements Serializable{
	private static final long serialVersionUID = 1L;

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
}
