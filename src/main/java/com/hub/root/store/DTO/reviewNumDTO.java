package com.hub.root.store.DTO;

import java.util.Date;

public class reviewNumDTO { //리뷰 , 리뷰 이미지, 멤버 인포 테이블 합쳐놓은 DTO
	
	String store_id, member_id, store_review_body, store_review_img_image, member_img;
	int store_review_num, store_review_score, booking_id;
	Date store_review_date_create;
	
	
	public String getMember_img() {
		return member_img;
	}
	public void setMember_img(String member_img) {
		this.member_img = member_img;
	}

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
	public String getStore_review_img_image() {
		return store_review_img_image;
	}
	public void setStore_review_img_image(String store_review_img_image) {
		this.store_review_img_image = store_review_img_image;
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
	public void setBooking_id(int bookint_id) {
		this.booking_id = bookint_id;
	}
	public Date getStore_review_date_create() {
		return store_review_date_create;
	}
	public void setStore_review_date_create(java.util.Date date) {
		this.store_review_date_create = date;
	}



}
