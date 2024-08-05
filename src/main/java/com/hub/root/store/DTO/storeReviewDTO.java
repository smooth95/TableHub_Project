package com.hub.root.store.DTO;

import java.util.Date;


public class storeReviewDTO {

	String store_id, member_id, store_review_body;
	int store_review_num, store_review_score, booking_id;
	Date store_review_date_create;

	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getStore_review_body() {
		return store_review_body;
	}
	public void setStore_review_body(String store_review_body) {
		this.store_review_body = store_review_body;
	}
	public int getStore_review_num() {
		return store_review_num;
	}
	public void setStore_review_num(int store_review_num) {
		this.store_review_num = store_review_num;
	}
	public int getStore_review_score() {
		return store_review_score;
	}
	public void setStore_review_score(int store_review_score) {
		this.store_review_score = store_review_score;
	}
	public int getBooking_id() {
		return booking_id;
	}
	public void setBooking_id(int booking_id) {
		this.booking_id = booking_id;
	}
	public Date getStore_review_date_create() {
		return store_review_date_create;
	}
	public void setStore_review_date_create(Date store_review_date_create) {
		this.store_review_date_create = store_review_date_create;
	}

}
