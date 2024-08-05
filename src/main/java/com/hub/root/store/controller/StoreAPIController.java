package com.hub.root.store.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.hub.root.store.service.storeService;

@RestController
public class StoreAPIController {

	private final storeService ser;
	@Autowired
	public StoreAPIController(storeService ser) {
		this.ser = ser;
		System.out.println("보선-가게 컨트롤러 생성자 실행");
	}

	@GetMapping("/store/phone")
	public Map<String, String> phone(@RequestHeader("user_id") String user_id) {

		Map<String, String> map = new HashMap<>();
		String result = ser.phone(user_id);
		System.out.println("전화번호 : " + result);
		map.put("member_phone", result);

		return map;
	}
}
