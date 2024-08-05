package com.hub.root.store.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hub.root.store.DTO.reviewNumDTO;
import com.hub.root.store.DTO.storeInfoDTO;
import com.hub.root.store.DTO.storeMenuDTO;
import com.hub.root.store.DTO.storeReviewDTO;
import com.hub.root.store.DTO.storeReviewImgDTO;
import com.hub.root.store.service.storeService;

@Controller
public class storeController {
	private storeInfoDTO infoDTO;
	private storeMenuDTO menuDTO;
	private storeReviewDTO reviewDTO;
	private storeReviewImgDTO reviewImgDTO;
	private reviewNumDTO numDTO;

	private final storeService ser;
	@Autowired
	public storeController(storeService ser) {
		this.ser = ser;
		System.out.println("보선-가게 컨트롤러 생성자 실행");
	}

	@GetMapping("store")
	public String store(HttpServletRequest request, Model model,
			@RequestParam String store_id) {
			//info(request, model, store_id);
			String result = ser.storeChk(request, model, store_id);
			if(result == "가게") {
				request.setAttribute("msg", "등록된 가게가 없습니다");
		        request.setAttribute("url", "register01");

		        return "businessM/businMalert";
		    }else if (result == "대표사진"){ 
		    	request.setAttribute("msg", "대표사진을 등록해주세요");
		    	request.setAttribute("url", "businessM/photo/photoRegister");
		    	
		    	return "businessM/businMalert";
		        	
			}else {
				Map<String, Object> MainInfoMap = ser.store(request, model, store_id);
				model.addAttribute("store_id", store_id);
				model.addAttribute("Map",MainInfoMap);
				return "store/store";
			}
			
	}


	@GetMapping("/store/info")
	public String info(HttpServletRequest request, Model model
				,@RequestParam String store_id) {
		Map<String, Object> infoMap = new HashMap<String, Object>();
		infoMap = ser.storeInfo(store_id);
		model.addAttribute("Map",infoMap);	
		
		return "store/info";
	}

	@GetMapping("/store/menu")
	public String menu(HttpServletRequest request, Model model
			,@RequestParam String store_id) {

		List<storeMenuDTO> menuDTO = ser.storeMenu(store_id);
		model.addAttribute("dto",menuDTO);

		return "store/menu";

	}

	@GetMapping("/store/review")
	public String review(HttpServletRequest request, Model model
			,@RequestParam String store_id) {
		List<reviewNumDTO> numDTO = ser.storeReview(store_id);
		model.addAttribute("dto",numDTO);
		return "store/review";
	}

	@GetMapping("/store/photo")
	public String photo(HttpServletRequest request, Model model
			,@RequestParam String store_id) {

		Map<String, Object> photoMap = ser.photos(store_id);
		model.addAllAttributes(photoMap);

		return "store/photo";

	}

	@GetMapping("/store/map")
	public String map(HttpServletRequest request, Model model
			,@RequestParam String store_id) {

		String storeAdd = ser.storeMap(store_id);
		model.addAttribute("storeAdd", storeAdd);

		return "store/map";
	}

	@GetMapping(value="store/jjim", produces="application/json; charset=utf-8" )
	@ResponseBody
	public Map<String, Object> jjim(HttpServletRequest request,
			@RequestParam String store_id) {
		Map<String, Object> Jmap = ser.jjim(request, store_id);
		return Jmap;

	}
}

