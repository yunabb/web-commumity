package com.community.vo;

import java.sql.Date;

public class Bell {

	private int bellNo;
	private Post post;
	private Employee sendEmp;
	private Employee receiveEmp;
	private String content;
	private String readingStatus;
	private String deleted;
	private Date createdDate;
	private Date updatedDate;
	private Date deletedDate;
	private Review review;
	
	public int getBellNo() {
		return bellNo;
	}
	public void setBellNo(int bellNo) {
		this.bellNo = bellNo;
	}
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public Employee getSendEmp() {
		return sendEmp;
	}
	public void setSendEmp(Employee sendEmp) {
		this.sendEmp = sendEmp;
	}
	public Employee getReceiveEmp() {
		return receiveEmp;
	}
	public void setReceiveEmp(Employee receiveEmp) {
		this.receiveEmp = receiveEmp;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReadingStatus() {
		return readingStatus;
	}
	public void setReadingStatus(String readingStatus) {
		this.readingStatus = readingStatus;
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
	public Review getReview() {
		return review;
	}
	public void setReview(Review review) {
		this.review = review;
	}
	
	
}
