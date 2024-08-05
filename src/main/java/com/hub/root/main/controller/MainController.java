package com.hub.root.main.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.hub.root.main.dto.MainImgDTO;
import com.hub.root.main.dto.MainMapDTO;
import com.hub.root.main.dto.MainReviewDTO;
import com.hub.root.main.service.MainFileService;
import com.hub.root.main.service.MainService;

@Controller
@RequestMapping("main")//main이라는 경로에 대한 요청
public class MainController {
	@Autowired MainService ms;
	// 헤더 페이지 요청 처리===================================
	@GetMapping("header")
	public String header(@RequestParam(required=false) String store_id, Model model) {
		Map<String, Object> params = new HashMap<>();
	       if (store_id != null) {
	           params.put("storeId", store_id);
	       }
	       model.addAttribute("storeId", store_id);
		return "main/header";
	}
	
	// mainPage1 요청 처리===================================
	@GetMapping("mainPage1")
	public String main( @RequestParam(name="category", required=false) String category,
						HttpSession session,Model model) {
		String user = (String) session.getAttribute("userId");
		String store = (String) session.getAttribute("storeId");
		
		if(user != null) {
			model.addAttribute("user", user);
		}	else if (store != null) {
	        model.addAttribute("store", store);
	    }
		
		List<String> categories = ms.getAllCategories();
		if (categories == null) {
	        categories = new ArrayList<>(); // 널일 경우 빈 리스트로 초기화
	    }

		Map<String, List<MainMapDTO>> categoryStoreMap = new HashMap<>();
		Map<String, List<List<MainImgDTO>>> categoryImagesMap = new HashMap<>();
		    
	    for (String cat : categories) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("category", cat);
	        List<MainMapDTO> storeList = ms.getStoreInfo(params); // 특정 카테고리에 해당하는 가게 정보 가져오기
	        List<String> storeIds = new ArrayList<>();
	        
	        if(storeList != null) {
	        for (MainMapDTO storeInfo : storeList) {
	            storeIds.add(storeInfo.getStore_id());
	        	}
	        }
	        List<List<MainImgDTO>> storeImgToMain = storeList != null && !storeList.isEmpty() ? ms.getStoreImgToMain(storeIds) : new ArrayList<>();
	        categoryStoreMap.put(cat, storeList != null ? storeList : new ArrayList<>());
	        categoryImagesMap.put(cat, storeImgToMain);
	    }
		    
		model.addAttribute("categories", categories);
		model.addAttribute("selectedCategory", category);
		model.addAttribute("categoryStoreMap", categoryStoreMap);
		model.addAttribute("categoryImagesMap", categoryImagesMap);
		
		return "main/mainPage1";
	}
	
	// mainPage1에 카테고리별 이미지 가져오기 =====================
//		@GetMapping("menuByCategory")
//		public String getMenuByCategory(@RequestParam String category, HttpSession session, Model model) {
//			String user = (String) session.getAttribute("userId");
//			String store = (String) session.getAttribute("storeId");
//			
//			//List<MainImgDTO> dtoList = ms.getMenuByCategory(category);
//			List<String> categories = ms.getAllCategories();
//			
//			List<MainImgDTO> dtoList = ms.getStoreImg(category);
//			
//			List<String> storeIds = new ArrayList<>();
//		    for (MainImgDTO storeInfo : dtoList) {
//		        storeIds.add(storeInfo.getStore_id());
//		    }	
//			
//			//List<List<MainImgDTO>> storeSmallImgLists = ms.getStoreSmallImages(storeIds);
//			 
//			//model.addAttribute("storeList", storeList);
//			model.addAttribute("dtoList", dtoList);
//			model.addAttribute("categories", categories);
//			return "main/mainPage1";
//		}
	
	// mainPage2 요청 처리===================================
	@RequestMapping("mainPage2")
	public String mainPage2(@RequestParam(required=false) String keyword, 
	                        @RequestParam(required=false) String searchType,
	                        @RequestParam(required=false) String category,
	                        @RequestParam(required=false) String sortType,
	                        HttpSession session, Model model) {   
		String user = (String) session.getAttribute("userId");
		String store = (String) session.getAttribute("storeId");
	    
//			if(user != null) {
//				model.addAttribute("user", user);
//			}	else if (store != null) {
//		        model.addAttribute("store", store);
//		    }
//		    Map<String, Object> params = new HashMap<>();
//		    String key = (keyword != null) ? keyword : "null";
//		    String search = (searchType != null) ? searchType : "null";
//		    String cat = (category != null) ? category : "null";
//
//		    params.put("keyword", key);
//		    params.put("searchType", search);
//		    params.put("category", cat);
//		    params.put("sortType", sortType);
	    
	    Map<String, Object> params = new HashMap<>();
        if (keyword != null) {
            params.put("keyword", keyword);
        }
        if (searchType != null) {
            params.put("searchType", searchType);
        }
        if (category != null) {
            params.put("category", category);
        }
        if (sortType != null) {
            params.put("sortType", sortType);
        }

//		    List<MainMapDTO> storeList = ms.getStoreInfo(params);
//		    if (storeList == null) {
//		        storeList = new ArrayList<>();
//		    }
	    
	    if("review".equals(sortType)) {
	    	List<MainReviewDTO> reviewList = ms.getReviewList(params);
	    	model.addAttribute("reviewList", reviewList);
	    }else if("popularity".equals(sortType)) {
	    	List<MainReviewDTO> popularityList = ms.getPopularityList(params);
	    	model.addAttribute("popularityList", popularityList);
	    }else {
	    	List<MainMapDTO> storeList = ms.getStoreInfo(params);
	    	model.addAttribute("storeList", storeList);
	    	
		List<String> storeIds = new ArrayList<>();
	    for (MainMapDTO storeInfo : storeList) {
	        storeIds.add(storeInfo.getStore_id());
	    }	
	    
	    List<MainImgDTO> storeImgList = new ArrayList<>();
	    for(MainMapDTO storeInfo : storeList) {
	    	List<MainImgDTO> storeImage = ms.getStoreImage(storeInfo.getStore_id());
	    	//storeImgList.add(storeImage);
	    	  if (!storeImage.isEmpty()) {
	              storeImgList.add(storeImage.get(0));
	              //System.out.println("image path: "+storeImage.get(0).getStore_img_root());
	          } else {
	              storeImgList.add(null); // 이미지가 없는 경우
	          }
	    }
	    
//		    List<MainImgDTO> storeSmallImgList = new ArrayList<>();
//		    for(MainMapDTO storeInfo : storeList) {
//		    	List<MainImgDTO> storeSmallImage = ms.getStoreSmallImage(storeInfo.getStore_id());
//		    	  if (!storeSmallImage.isEmpty()) {
//		    		  int maxImages = Math.min(4, storeSmallImage.size());
//		    		  for(int i = 0; i < maxImages; i++) {
//		    			  storeSmallImgList.add(storeSmallImage.get(i));
//		              //System.out.println("image path: "+storeSmallImage.get(i).getStore_img_root());
//		    		  }
//		          } else {
//		        	  storeSmallImage.add(null); // 이미지가 없는 경우
//		          }
//		    }

	    // 위에서 처리시 모든 store_id에 대해 이미지 추가 방식이므로, store_id별로 분리
	    List<List<MainImgDTO>> storeSmallImgLists = ms.getStoreSmallImages(storeIds);
	    
	    model.addAttribute("storeListSize", storeList.size());
	    model.addAttribute("storeImgList", storeImgList);
	    model.addAttribute("storeSmallImgLists", storeSmallImgLists);
	    }
	    
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("category", category);
	    model.addAttribute("sortType", sortType);

	    return "main/mainPage2";
	}
	
	// 정보 입력 페이지 요청 처리(store_menu)====================
	@RequestMapping("inputInfo")
	public String inputInfo() {
		return "main/inputInfo";
	}
	
	// 정보 저장 요청 처리(store_menu)=========================
	@RequestMapping("infoSave")
	public void infoSave(@RequestParam("store_menu_img") MultipartFile mul,
							HttpServletResponse res,
							@RequestParam String store_id,
							@RequestParam String store_menu_name,
							@RequestParam int store_menu_price,
							@RequestParam String store_menu_detail,
							@RequestParam String store_menu_category,
							HttpSession session, Model model) throws IOException{
		String imagePath  = ms.saveMenuImage(mul);
		String store = (String) session.getAttribute("storeId");
	    
		if(store != null) {
			model.addAttribute("store", store);
		}
		ms.infoSave(store_id,store_menu_name,store_menu_price,store_menu_detail,store_menu_category, imagePath);
		//ms.saveImagePathToStoreImg(store_id, imgPath);
	}
	
	// 파일 다운로드 요청 처리==================================
	@GetMapping("download")
	public void download(@RequestParam String fileName, HttpServletRequest req, HttpServletResponse res) throws Exception {
	    File file = new File(MainFileService.IMAGE_REPO + "/" + fileName);

	    if (file.exists()) {
	        String mimeType = req.getServletContext().getMimeType(file.getName());
	        if (mimeType == null) {
	            mimeType = "application/octet-stream";
	        }
	        res.setContentType(mimeType);
	        res.setContentLength((int) file.length());
	        res.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

	        try (FileInputStream in = new FileInputStream(file)) {
	            FileCopyUtils.copy(in, res.getOutputStream());
	        }
	    } else {
	        System.err.println("File not found: " + file.getAbsolutePath());
	        res.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
	    }
	}

	// 정보 입력 페이지 요청 처리(store_info)====================
	@RequestMapping("storeInfo")
	public String storeInfo() {
		return "main/storeInfo";
	}
	// 정보 저장 요청 처리(store_info)=========================
	@RequestMapping("storeSave")
	public void storeSave(	HttpServletResponse res,
							@RequestParam String store_id,
							@RequestParam String store_pwd,
							@RequestParam String store_email,
							@RequestParam String store_phone,
							@RequestParam String store_main_phone,
							@RequestParam String store_name,
							@RequestParam String store_add,
							@RequestParam String store_add_info,
							@RequestParam String store_category,
							@RequestParam String store_note,
							@RequestParam String store_introduce,
							@RequestParam String store_business_hours) throws IOException{
		ms.storeSave(store_id,store_pwd,store_email,store_phone,store_main_phone,store_name,store_add,
				store_add_info,store_category,store_note,store_introduce,store_business_hours);
	}
}