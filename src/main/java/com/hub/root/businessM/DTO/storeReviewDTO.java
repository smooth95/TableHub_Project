package com.hub.root.businessM.DTO;

import java.util.Date;

public class storeReviewDTO {
	int storeReviewNum, storeReviewScore, BookingId;
	String storeId, memberId, storeReviewBody;
	Date storeReviewDateCreate;
	public int getStoreReviewNum() {
		return storeReviewNum;
	}
	public void setStoreReviewNum(int storeReviewNum) {
		this.storeReviewNum = storeReviewNum;
	}
	public int getStoreReviewScore() {
		return storeReviewScore;
	}
	public void setStoreReviewScore(int storeReviewScore) {
		this.storeReviewScore = storeReviewScore;
	}
	public int getBookingId() {
		return BookingId;
	}
	public void setBookingId(int bookingId) {
		BookingId = bookingId;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getStoreReviewBody() {
		return storeReviewBody;
	}
	public void setStoreReviewBody(String storeReviewBody) {
		this.storeReviewBody = storeReviewBody;
	}
	public Date getStoreReviewDateCreate() {
		return storeReviewDateCreate;
	}
	public void setStoreReviewDateCreate(Date storeReviewDateCreate) {
		this.storeReviewDateCreate = storeReviewDateCreate;
	}



}
