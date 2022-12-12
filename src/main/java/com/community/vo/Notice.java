package com.community.vo;

import java.util.Date;

public class Notice {

	private int postNo;				// 게시글 번호
	private Board board;			// 게시판 번호
	private String title;			// 게시글 제목
	private Employee employee;		// 작성자 번호
	private String content;			// 게시글 내용
	private String important;		// 중요게시글 여부
	private int readCount;			// 조회수
	private int suggestionCount;	// 추천수
	private int commentCount;		// 댓글 갯수
	private String deleted;			// 삭제여부
	private Date createdDate;		// 등록일
	private Date updatedDate;		// 수정일
	private Date DeletedDate;		// 삭제일
	
	public int getPostNo() {
		return postNo;
	}
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	public Board getBoard() {
		return board;
	}
	public void setBoard(Board board) {
		this.board = board;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Employee getEmployees() {
		return employee;
	}
	public void setEmployees(Employee employee) {
		this.employee = employee;
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
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getSuggestionCount() {
		return suggestionCount;
	}
	public void setSuggestionCount(int suggestionCount) {
		this.suggestionCount = suggestionCount;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public Date getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}
	public Date getDeletedDate() {
		return DeletedDate;
	}
	public void setDeletedDate(Date deletedDate) {
		DeletedDate = deletedDate;
	}
	@Override
	public String toString() {
		return "Notice [postNo=" + postNo + ", board=" + board + ", title=" + title + ", employee=" + employee
				+ ", content=" + content + ", important=" + important + ", readCount=" + readCount
				+ ", suggestionCount=" + suggestionCount + ", commentCount=" + commentCount + ", deleted=" + deleted
				+ ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", DeletedDate=" + DeletedDate
				+ "]";
	}
	
	
}
