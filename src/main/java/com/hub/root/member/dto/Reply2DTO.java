package com.hub.root.member.dto;

import java.util.Date;

public class Reply2DTO {
	int review2Id, reviewId;
	String memberId, reviewContent;
	Date reviewCreate;

	public int getReview2Id() {
		return review2Id;
	}
	public void setReview2Id(int review2Id) {
		this.review2Id = review2Id;
	}
	public int getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
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
