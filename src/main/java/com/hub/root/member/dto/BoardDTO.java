package com.hub.root.member.dto;

import java.util.Date;

public class BoardDTO {
	String title, content, memId;
	Date create, modify;
	int id, view;

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
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public Date getCreate() {
		return create;
	}
	public void setCreate(Date create) {
		this.create = create;
	}
	public Date getModify() {
		return modify;
	}
	public void setModify(Date modify) {
		this.modify = modify;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getView() {
		return view;
	}
	public void setView(int view) {
		this.view = view;
	}


}
