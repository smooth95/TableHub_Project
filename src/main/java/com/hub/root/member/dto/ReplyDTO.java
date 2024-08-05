package com.hub.root.member.dto;

import java.util.Date;

public class ReplyDTO {
	int reviewId, boardId;
	String memberId, reviewContent;
	Date reviewCreate;

	public int getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public Date getReviewCreate() {
		return reviewCreate;
	}
	public void setReviewCreate(Date reviewCreate) {
		this.reviewCreate = reviewCreate;
	}


}
