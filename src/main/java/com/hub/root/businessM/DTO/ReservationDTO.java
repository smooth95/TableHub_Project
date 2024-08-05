package com.hub.root.businessM.DTO;

public class ReservationDTO {
	int store_max_team;
	String store_business_hours;
	String store_add;
	String store_add_info;
	String store_name;


	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public int getStore_max_team() {
		return store_max_team;
	}
	public void setStore_max_team(int store_max_team) {
		this.store_max_team = store_max_team;
	}
	public String getStore_business_hours() {
		return store_business_hours;
	}
	public void setStore_business_hours(String store_business_hours) {
		this.store_business_hours = store_business_hours;
	}
	public String getStore_add() {
		return store_add;
	}
	public void setStore_add(String store_add) {
		this.store_add = store_add;
	}
	public String getStore_add_info() {
		return store_add_info;
	}
	public void setStore_add_info(String store_add_info) {
		this.store_add_info = store_add_info;
	}
}
