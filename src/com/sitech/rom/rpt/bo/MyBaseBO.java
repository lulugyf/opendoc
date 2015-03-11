package com.sitech.rom.rpt.bo;

public class MyBaseBO {
	protected int firstRowNum = 0;//第一条行号
	protected int pageSize = 8; // 页大小
	protected int pageNum = 1;
	protected int totalCount = 0;
	protected int pageCount = 0;
	public int getFirstRowNum() {
		return (this.getPageNum() - 1) * this.getPageSize();
	}
	public void setFirstRowNum(int firstRowNum) {
		this.firstRowNum = firstRowNum;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getPageCount() {
		int pn = this.getTotalCount()/this.getPageSize();
		if(this.getTotalCount()%this.getPageSize() != 0){
			pn += 1;
		}
		return pn;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
}
