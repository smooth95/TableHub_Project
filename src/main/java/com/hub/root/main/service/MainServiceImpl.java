package com.hub.root.main.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.hub.root.main.dto.MainDTO;
import com.hub.root.main.dto.MainImgDTO;
import com.hub.root.main.dto.MainMapDTO;
import com.hub.root.main.dto.MainReviewDTO;
import com.hub.root.main.mybatis.mainMapper;

@Service
public class MainServiceImpl implements MainService{
	@Autowired
	mainMapper mapper;
	@Autowired
	MainFileService mfs;
	@Override
	public List<MainDTO> mainPage1(Model model) {
			try {
			List<MainDTO> dtoList = mapper.mainPage1();
			model.addAttribute("dtoList", dtoList);
			return dtoList;
			} catch (Exception e) {
		           e.printStackTrace(); 
		           throw new RuntimeException("Error fetching main page data", e);
		    }
	}
	
	public List<String> getAllCategories() {
		  // System.out.println("Entering getAllCategories");
		  List<String> categories = mapper.getAllCategories();
		  // System.out.println("categories from mapper: " + categories);
	      if (mapper == null) {
	            System.err.println("Error: mainMapper is not injected!");
	            return new ArrayList<>(); // 빈 리스트 반환
	      }
	      if (categories == null) {
	    	  categories = new ArrayList<>();  // Null 체크 후 빈 리스트로 초기화
	      }
	      // null값 필터링
	      categories = categories.stream()
                .filter(category -> category != null)
                .collect(Collectors.toList());
	      
//	      List<String> nonNull = new ArrayList<>();
//	      for(String category : categories) {
//	    	  if(category != null) {
//	    		  nonNull.add(category);
//	    	  }
//	      }
	      
	      //객체 중복저장X, 하나의 null값만 저장(중복을 자동으로 제거)
	      Set<String> uniqueCategories = new HashSet<>();
	      for (String category : categories) {
	    	  String[] splitCategories = category.split("/");
	    	  for (String splitCategory : splitCategories) {
	    		  uniqueCategories.add(splitCategory.trim()); //각 분리된 카테고리 항목의 앞뒤 공백 제거 후 추가
	    	  }
	      }
	      // System.out.println("Exiting getAllCategories with categories: " + uniqueCategories);
	      return new ArrayList<>(uniqueCategories);
	}
	
	public List<List<MainImgDTO>> getStoreImgToMain(List<String> storeIds){
		try {
		List<List<MainImgDTO>> storeImgToMain = new ArrayList<>();
		for (String storeId : storeIds) {
			List<MainImgDTO> storeImageToMain = mapper.getStoreImgToMain(storeId);
			// System.out.println("Store ID: " + storeId + ", Images: " + storeImageToMain);
			storeImgToMain.add(storeImageToMain);
		}
		return storeImgToMain;
		 } catch (Exception e) {
	            e.printStackTrace(); 
	            throw new RuntimeException("Error fetching store images", e);
	        }
		}
	
	public List<MainReviewDTO> getPopularityList(Map<String, Object> params) {
      return mapper.getPopularityList(params);
  }

  public List<MainReviewDTO> getReviewList(Map<String, Object> params) {
      return mapper.getReviewList(params);
  }
	
  public List<MainMapDTO> getStoreInfo(Map<String, Object> params) {
      try {
      	System.out.println("Parameters in Service: " + params);
          List<MainMapDTO> storeInfo = mapper.getStoreInfo(params);
          
          if (storeInfo == null || storeInfo.isEmpty()) {
              System.out.println("No store information found for the given parameters.");
          } else {
        	  for( MainMapDTO info : storeInfo ) {
        		String businessHour = info.getStore_business_hours();
        	    String[] businHours = businessHour.split("/");
  				int lastNum = businHours.length - 1;
  				String hours =  businHours[0] + " ~ " + businHours[lastNum];
  				info.setStore_business_hours(hours);
              System.out.println("storeInfo size: " + storeInfo.size());
        	  }
          }
          return storeInfo;
      } catch (Exception e) {
          e.printStackTrace();
          return null;
      }
  }
	
	public List<MainMapDTO> getStoreInfoByCategory(String category) {
	    List<MainMapDTO> storeList = mapper.getStoreInfoByCategory(category);
	    return storeList;
	}
	
	public List<MainImgDTO> getStoreImage(String storeId) {
		return mapper.getStoreImage(storeId);
	}
//	public List<MainImgDTO> getStoreSmallImage(String storeId) {
//		return mapper.getStoreSmallImage(storeId);
//	}
	public List<List<MainImgDTO>> getStoreSmallImages(List<String> storeIds) {
	    List<List<MainImgDTO>> storeSmallImgLists = new ArrayList<>();
	    for (String storeId : storeIds) {
	        List<MainImgDTO> storeSmallImages = mapper.getStoreSmallImage(storeId);
	        storeSmallImgLists.add(storeSmallImages);
	    }
	    return storeSmallImgLists;
	}

	public List<MainReviewDTO> getReviewList(String userId){
		return mapper.getReviewList(userId);
	}
	
	public int inputInfo(MainDTO dto) {
		try {
			return mapper.infoSave(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}	
	}
	
	public void infoSave(String store_id,String store_menu_name,int store_menu_price,
						String store_menu_detail,String store_menu_category, String imagePath) {
		MainDTO dto = new MainDTO();
		dto.setStore_id(store_id);
		dto.setStore_menu_name(store_menu_name);
		dto.setStore_menu_price(store_menu_price);
		dto.setStore_menu_detail(store_menu_detail);
		dto.setStore_menu_category(store_menu_category);
		dto.setStore_menu_img(imagePath  != null ? imagePath  : "nan");

		//dto.setStore_menu_img("nan");
		
		/*
		if(!mul.isEmpty()) {
			dto.setStore_menu_img(mfs.saveFile(mul));//이미지 있을경우 처리
		}
		String imgPath = null;
		if (!mul.isEmpty()) {
			imgPath = mfs.saveFile(mul); // 이미지 파일 저장 및 경로 반환
			dto.setStore_menu_img(imgPath); // store_menu 테이블에 저장할 이미지 경로 설정
		}
		*/
		int result = 0;
		try {
			result = mapper.infoSave(dto);
			if (result == 1 && imagePath  != null) {
				saveImagePathToStoreImg(store_id, imagePath); // store_img 테이블에 이미지 경로 저장
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*
		String msg, url;
		if(result == 1) {
			msg = "새글이 추가되었습니다";
			url = "/main/inputInfo";
		}else {
			msg = "문제가 발생되었습니다!";
			url = "/main/mainPage1";
		}
		*/
	}
	
	public String saveMenuImage(MultipartFile mul) {
		return mfs.saveFile(mul);
	}
	
	public void saveImagePathToStoreImg(String store_id, String store_img_root) {		
		MainImgDTO dto = new MainImgDTO();
	    dto.setStore_id(store_id);
	    dto.setStore_img_root(store_img_root);
	    dto.setStore_img_main(2);
	    mapper.saveImagePathToStoreImg(dto);
	}

	public void storeSave(String store_id,String store_pwd,String store_email,String store_phone,String store_main_phone,String store_name,String store_add,
			    String store_add_info,String store_category,String store_note,String store_introduce,String store_business_hours) {
		MainMapDTO dto = new MainMapDTO();
		dto.setStore_id(store_id);
		dto.setStore_pwd(store_pwd);
		dto.setStore_email(store_email);
		dto.setStore_phone(store_phone);
		dto.setStore_main_phone(store_main_phone);
		dto.setStore_name(store_name);
		dto.setStore_add(store_add_info);
		dto.setStore_add_info(store_add_info);
		dto.setStore_category(store_category);
		dto.setStore_note(store_note);
		dto.setStore_introduce(store_introduce);
		dto.setStore_business_hours(store_business_hours);
		mapper.storeSave(dto);
	}
		
}