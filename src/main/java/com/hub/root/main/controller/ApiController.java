package com.hub.root.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hub.root.main.dto.MainMapDTO;
import com.hub.root.main.service.MainService;

@RestController
@RequestMapping("mainAPI")
public class ApiController {
	@Autowired MainService ms;

	@GetMapping("storeList")
	public List<MainMapDTO> storeList(
				@RequestParam(required=false) String keyword,
				@RequestParam(required=false) String searchType,
				@RequestParam(required=false) String category
				) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", !keyword.equals("null") ? keyword : "");
        params.put("searchType", !searchType.equals("null") ? searchType : "");
        params.put("category", !category.equals("null") ? category : "");

        List<MainMapDTO> storeList123 = ms.getStoreInfo(params);

        return storeList123;
	}

}
