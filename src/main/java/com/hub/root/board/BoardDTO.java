package com.hub.root.board;

public class BoardDTO {
	public int getBoard_id() {
		return Board_id;
	}
	public void setBoard_id(int board_id) {
		Board_id = board_id;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public String getMember_id() {
		return Member_id;
	}
	public void setMember_id(String member_id) {
		Member_id = member_id;
	}
	public int getBoard_view() {
		return Board_view;
	}
	public void setBoard_view(int board_view) {
		Board_view = board_view;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getImgFileName() {
		return imgFileName;
	}
	public void setImgFileName(String imgFileName) {
		this.imgFileName = imgFileName;
	}
	public String getSavedate() {
		return savedate;
	}
	public void setSavedate(String savedate) {
		this.savedate = savedate;
	}
	int Board_id;
	int Board_view;
	int hit;
	String Title;
	String Content;
	String imgFileName;
	String savedate;
	String Member_id;
}
