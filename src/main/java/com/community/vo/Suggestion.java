package com.community.vo;

public class Suggestion {

	private Post post;
	private Employee employee;
	
	public Suggestion() {}
	
	public Suggestion(Post post) {
		this.post = post;
	}
	public Suggestion(Employee employee) {
		this.employee = employee;
	}
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
}
