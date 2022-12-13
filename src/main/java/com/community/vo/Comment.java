package com.community.vo;

import java.util.Date;

public class Comment {
	
	// 게시글들의 댓글	
	private int commentNo;			// 댓글 번호
	private Employee employee;		// 작성자 직원번호		
	private String content;		    // 댓글 내용
	private String deleted;		    // 댓글 삭제여부
	private Date createdDate;	    // 등록일
	private Date updatedDate;	    // 수정일
	private Date deletedDate;	    // 삭제일
	private StoryPost storyPost;	// 게시글 번호	
	
	public Comment() {}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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
		return deletedDate;
	}

	public void setDeletedDate(Date deletedDate) {
		this.deletedDate = deletedDate;
	}

	public StoryPost getStoryPost() {
		return storyPost;
	}

	public void setStoryPost(StoryPost storyPost) {
		this.storyPost = storyPost;
	}

	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo + ", employee=" + employee + ", content=" + content + ", deleted="
				+ deleted + ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", deletedDate="
				+ deletedDate + ", storyPost=" + storyPost + "]";
	}

}
