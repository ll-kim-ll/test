package com.wellrising.uds.core.comm.pagination;

public class PaginationInfo {
	private int currentPageNo;
//	private int recordCountPerPage = 10;
//	private int pageSize = 10;
	private int totalRecordCount;
	private int totalPageCount;
	private int firstPageNoOnPageList;
	private int lastPageNoOnPageList;
	private int firstRecordIndex;
	private int lastRecordIndex;
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


	public int getRecordCountPerPage() {
		return this.recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public int getPageSize() {
		return this.pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrentPageNo() {
		return this.currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
	}

	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}

	public int getTotalRecordCount() {
		return this.totalRecordCount;
	}

	public int getTotalPageCount() {
		this.totalPageCount = (this.getTotalRecordCount() - 1) / this.getRecordCountPerPage() + 1;
		return this.totalPageCount;
	}

	public int getFirstPageNo() {
		return 1;
	}

	public int getLastPageNo() {
		return this.getTotalPageCount();
	}

	public int getFirstPageNoOnPageList() {
		this.firstPageNoOnPageList = (this.getCurrentPageNo() - 1) / this.getPageSize() * this.getPageSize() + 1;
		return this.firstPageNoOnPageList;
	}

	public int getLastPageNoOnPageList() {
		this.lastPageNoOnPageList = this.getFirstPageNoOnPageList() + this.getPageSize() - 1;
		if (this.lastPageNoOnPageList > this.getTotalPageCount()) {
			this.lastPageNoOnPageList = this.getTotalPageCount();
		}

		return this.lastPageNoOnPageList;
	}

	public int getFirstRecordIndex() {
		this.firstRecordIndex = (this.getCurrentPageNo() - 1) * this.getRecordCountPerPage();
		return this.firstRecordIndex;
	}

	public int getLastRecordIndex() {
		this.lastRecordIndex = this.getCurrentPageNo() * this.getRecordCountPerPage();
		return this.lastRecordIndex;
	}
}
