package com.community.vo;

public class File {
	
	private int fileNo;				// 파일번호
	private String name;			// 파일이름
	private Post post;	// 게시글 번호
	
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	

}
