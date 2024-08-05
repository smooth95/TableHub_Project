package com.hub.root.businessM.controller;


import java.io.File;
import java.io.FileInputStream;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hub.root.businessM.DTO.businMDTO;
import com.hub.root.businessM.DTO.businMMenuDTO;
import com.hub.root.businessM.DTO.businMPhotoDTO;
import com.hub.root.businessM.service.businMService;

@Controller
public class businMController {
	private final businMService ser;

		@Autowired
		public businMController(businMService ser) {
			this.ser = ser;
			System.out.println("보선-사업자 회원 컨트롤러 생성자 실행");
		}

		@GetMapping("register01")//단순 첫째 페이지 보여주기
		public String register01(HttpServletRequest request, Model model) {

			HttpSession session = request.getSession();
		    String store_id = (String) session.getAttribute("storeId");
			if(store_id == null) {
				request.setAttribute("msg", "로그인이 필요한 서비스입니다");
		        request.setAttribute("url", "member/login");
		        return "businessM/businMalert";
			}

			String result = ser.register01(request, model);
			return result;
		}

		@PostMapping("register02")//첫째 페이지 정보 받고, 둘째 페이지로
		public String register02(HttpServletRequest request, Model model , 
				@RequestParam("store_name") String store_name) {
			String result = ser.register02(request, model, store_name);
			return result;
		}

		@PostMapping("register03")//둘째 페이지 정보 받고, 셋째 페이지로
		public String register03(HttpServletRequest request, Model model,
				@RequestParam("store_zip") String store_zip,
				@RequestParam("store_add") String store_add,
				@RequestParam("store_add_info") String store_add_info) {
			//파라미터 만드는건 입력폼의 name, 한번에 여러줄로 만들 수 없음

			String result = ser.register03(request, model, store_zip, store_add, store_add_info);
			return result;
		}

		@PostMapping("register04")//셋째 페이지 정보 받고, 넷째 페이지로
		public String register04(HttpServletRequest request, Model model,
				@RequestParam("store_introduce") String store_introduce,
				@RequestParam("store_category") String[] store_categoryS,
				@RequestParam("store_amenities") String[] store_amenitiesS,
				@RequestParam("store_note") String store_note,
				@RequestParam("store_max_person") int store_max_person,
				@RequestParam("store_booking_rule") String store_booking_rule) {

			String result = ser.register04(request, model, store_introduce, store_categoryS,
					store_amenitiesS, store_note, store_max_person, store_booking_rule);
			return result;
		}


		@PostMapping("registerFinish")//가게 정보 DB에 저장하고, 마지막 페이지로
		public String registerFinish(businMDTO dto, HttpServletRequest request,
				@RequestParam("store_business_hours") String[] store_business_hours) {
			String result = ser.registerFinish(dto, request, store_business_hours);
			return result;

		}

		@GetMapping("businMmenu")//사업자 마이페이지
		public String businMmenu(HttpServletRequest request,
				@RequestParam String category) {
			
			System.out.println("보선-카테고리 넘버는? : "+ category);
	
			HttpSession session = request.getSession();
		    String store_id = (String) session.getAttribute("storeId");
			if(store_id == null) {
				request.setAttribute("msg", "로그인이 필요한 서비스입니다");
		        request.setAttribute("url", "member/login");
		        return "businessM/businMalert";
			}
			request.setAttribute("cateNum", category);
			return "businessM/businMmenu";
		}

		@GetMapping("/businessM/menuInfo")//마이페이지 내 메뉴정보확인
		public String menuInfo(HttpServletRequest request, Model model) {
			HttpSession session = request.getSession();
			String store_id = (String) session.getAttribute("storeId");

			List<businMMenuDTO> dto =  new ArrayList<businMMenuDTO>();
			dto = ser.menuChk(store_id);
			model.addAttribute("Mdto", dto);
			return "businessM/info/menuInfo";
		}

		@GetMapping("/businessM/storeInfo")//마이페이지 내 정보확인및수정(기본메뉴페이지)
		public String storeInfo(HttpServletRequest request, Model model) {
			HttpSession session = request.getSession();
			String store_id = (String) session.getAttribute("storeId");

			businMDTO dto = new businMDTO();
			dto = ser.infoChk(store_id);
			model.addAttribute("dto", dto);
			return "businessM/info/storeInfo";
		}

		@GetMapping("/businessM/photoInfo")//마이페이지 내 사진정보확인
		public String photoInfo(HttpServletRequest request, Model model) {
			HttpSession session = request.getSession();
			String store_id = (String) session.getAttribute("storeId");

			String result = ser.photoChk(model, store_id);
			return result;
		}

		@GetMapping("/businessM/bookInfo")//마이페이지 내 예약관리
		public String bookInfo() {
			return "businessM/info/bookInfo";
		}

		@GetMapping("/businessM/menu/menuRegister")//메뉴등록화면
		public String menuRegister(HttpServletRequest request, Model model) {
			HttpSession session = request.getSession();
			String store_id = (String) session.getAttribute("storeId");
			
			List<businMMenuDTO> dto = ser.menuChk(store_id);
			model.addAttribute("dto", dto);
			return "businessM/menu/menuRegister";
		}
		@GetMapping("/businessM/menu/menuRFinish")//메뉴등록 완료화면
		public String menuRFinish() {
			return "businessM/menu/menuRFinish";
		}

		@GetMapping("/businessM/photo/photoRegister")//사진등록화면
		public String photoRegister() {
			return "businessM/photo/photoRegister";
		}
		@GetMapping("/businessM/photo/photoRFinish")//사진등록 완료화면
		public String photoRFinish() {
			return "businessM/photo/photoRFinish";
		}

		//photoRegister.jsp에서 form action="storeImgSave"으로 받아오는 경로
	    @PostMapping("/businessM/photo/storeImgSave")//사진 정보 DB에 저장하고, 사진등록 완료 화면으로
	    public String storeImgSave(HttpServletRequest request,
	            @RequestParam("storeImage01") MultipartFile file01,
	            @RequestParam("storeImage02") MultipartFile file02,
	            @RequestParam("storeImage03") MultipartFile file03,
	            @RequestParam("storeImage04") MultipartFile file04,
	            @RequestParam("storeImage05") MultipartFile file05 ) {
	    	String result = ser.storeImage(request, file01, file02, file03, file04, file05);
	    	return result;
	    }
	    @PostMapping("/businessM/menu/menuSave")
	    public String menuRegister(HttpServletRequest request, MultipartHttpServletRequest mul) {
	    	System.out.println("보선-메뉴등록 컨트롤러 실행");
	    	HttpSession session = request.getSession();
		    String store_id = (String) session.getAttribute("storeId");
	
	    	String result = ser.menuRegisterChk(request, mul, store_id);
	    	return result;
	    }





//-------------------------------------구현 작업 영역 start


	  		@GetMapping("/businessM/reviewInfo")//마이페이지 내 고객후기보기
	  		public String reviewInfo() {
	  			return "businessM/info/reviewInfo";
	  		}

	  		@GetMapping("/businessM/review")
	  		@ResponseBody
	  		public Map<String, Object> getReview(HttpSession session, @RequestParam int curPage) {
	  			System.out.println("curPage : " + curPage);
	  			String storeId = (String)session.getAttribute("storeId");
	  			Map<String, Object> map = ser.getReview(storeId, curPage);
	  			return map;
	  		}

	  		@GetMapping(value = "/businessM/reviewDetail", produces = "application/json; charset=utf-8")
	  		@ResponseBody
	  		public Map<String, Object> getReviewDetail(@RequestParam Map<String, Object> map) {
	  			System.out.println("memId : " + map.get("memId"));
	  			System.out.println("reviewNum : " + Integer.parseInt((String) map.get("reviewNum")));
	  			String memId = (String)map.get("memId");
	  			int reviewNum = Integer.parseInt((String) map.get("reviewNum"));
	  			map = ser.getReviewDetail(memId, reviewNum);
	  			return map;
	  		}

	  		@DeleteMapping(value="/businessM/review", produces = "application/json; charset=utf-8")
	  		@ResponseBody
	  		public Map<String, Object> deleteReview(@RequestBody Map<String, int[]> getReviews) {
	  			int[] reviews = getReviews.get("reviews");
	  			Map<String, Object> map = ser.deleteReview(reviews);
	  			return map;
	  		}

	  		@GetMapping("/businessM/download")
	  		public void download(@RequestParam String img, HttpServletResponse res) throws Exception {
	  	    	String originImgName = img;

	  			res.setContentType("text/plain; charset=utf-8");
	  			res.addHeader("Content-disposition", "attachment;fileName="+URLEncoder.encode(img, "UTF-8"));
	  			File file;

	  			// 해당 파일을 불러온다.
	  			file = new File(ser.DOWNLOAD_FOLDER + "/" + img);
	  			// 파일이 존재한다면 해당 파일을 사용자에게 전달한다.
	  			
	  			if(file.exists()) {
	  				FileInputStream in = new FileInputStream(file);
	  				FileCopyUtils.copy(in, res.getOutputStream());
	  				in.close();
	  			} else {
	  		        System.err.println("File not found: " + file.getAbsolutePath()); // 추가된 로그
	  		        res.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
	  		    }
	  		}

//-----------------------------------------구현 작업 영역 end

}

