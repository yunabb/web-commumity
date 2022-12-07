package com.community.util;

public class Pagination {

	private int rows;			// 한 화면에 표시되는 데이터 갯수
	private int pages;			// 한 화면에 표시되는 페이지번호 갯수
	private int currentPage;	// 요청한 페이지 번호
	private int totalRows;		// 총 데이터 갯수
	
	/**
	 * 요청한 페이지번호, 전체 데이터 갯수를 전달받아 pagination객체 초기화.
	 * <p> 한 화면에 표시되는 데이터 갯수 : 10개
	 * <p> 한 화면에 표시되는 페이지번호 갯수 : 5개
	 * @param currentPage 요청한 페이지 번호
	 * @param totalRows 전체 데이터 갯수
	 */
	public Pagination(int currentPage, int totalRows) {
		this(currentPage, totalRows, 10, 5);
	}
	
	/**
	 * 요청한 페이지번호, 총 데이터갯수, 한 화면에 표시될 데이터 갯수를 전달받아 pagination객체 초기화.
	 * <p> 한 화면에 표시되는 페이지번호 갯수 : 5개
	 * @param currentPage 요청한 페이지 번호
	 * @param totalRows 총 데이터 갯수
	 * @param rows 한 화면에 표시될 데이터 갯수
	 */
	public Pagination(int currentPage, int totalRows, int rows) {
		this(currentPage, totalRows, rows, 5);
		
	}
	public Pagination(int currentPage, int totalRows, int rows, int pages) {
		this.currentPage = currentPage;
		this.totalRows = totalRows;
		this.rows = rows;
		this.pages = pages;
	}
	public int getBegin() {
		return (currentPage - 1)*rows + 1;
	}
	public int getEnd() {
		return currentPage*rows;
	}
	public int getTotalPages() {
		return (int) Math.ceil((double) totalRows/rows);
	}
	public int getTotalBlocks() {
		return (int) Math.ceil((double) getTotalPages()/pages);
	}
	public int getCurrentPageBlock() {
		return (int) Math.ceil((double) currentPage/pages);
	}
	public int getBeginPage() {
		return (getCurrentPageBlock() - 1)*pages + 1;
	}
	public int getEndPage() {
		return getCurrentPageBlock() == getTotalBlocks() ? getTotalPages() : getCurrentPageBlock()*pages;
	}
	public boolean isFirst() {
		return currentPage <= 1;
	}
	public boolean isLast() {
		return currentPage >= getTotalPages();
	}
	public int getPrevPage() {
		return currentPage - 1;
	}
	public int getNextPage() {
		return currentPage + 1;
	}
}
