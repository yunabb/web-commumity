package com.community.vo;

import java.util.Date;

public class TempPost {
	
	private int tempNo;			// 게시글 번호
	private String title;		// 게시글 제목
	private String content;		// 게시글 내용
	private String important;	// 중요게시글 여부
	private Date createdDate;	// 등록일
	private Board board;		// 게시판번호
	private Employee employee;	// 작성자번호
	private String deleted;		// 삭제여부
	
	public TempPost() {}
	
	public TempPost(int tempNo) {
		this.tempNo = tempNo;
	}

	public int getTempNo() {
		return tempNo;
	}

	public void setTempNo(int tempNo) {
		this.tempNo = tempNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImportant() {
		return important;
	}

	public void setImportant(String important) {
		this.important = important;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Board getBoard() {
		return board;
	}

	public void setBoard(Board board) {
		this.board = board;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

}
