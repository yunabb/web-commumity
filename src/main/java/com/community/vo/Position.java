package com.community.vo;

public class Position {

	private int no;
	private String name;
	
	public Position() {}
	
	public Position(int no) {
		this.no = no;
	}
	
	public Position(String name) {
		this.name = name;
	}
	
	public Position(int no, String name) {
		this.no = no;
		this.name = name;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
