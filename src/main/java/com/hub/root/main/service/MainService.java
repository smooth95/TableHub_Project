package com.hub.root.main.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.hub.root.main.dto.MainDTO;
import com.hub.root.main.dto.MainImgDTO;
import com.hub.root.main.dto.MainMapDTO;
import com.hub.root.main.dto.MainReviewDTO;

public interface MainService {
	public List<MainDTO> mainPage1(Model model);
	public List<String> getAllCategories();
	public List<List<MainImgDTO>> getStoreImgToMain(List<String> storeIds);
	//public List<MainImgDTO> getMenuByCategory(String category);
	//public List<MainImgDTO> getStoreImg(String category);
	
	public List<MainReviewDTO> getReviewList(Map<String, Object> params);
	public List<MainReviewDTO> getPopularityList(Map<String, Object> params);
	public List<MainMapDTO> getStoreInfo(Map<String, Object> params);
	public List<MainMapDTO> getStoreInfoByCategory(String category); //?
	public List<MainImgDTO> getStoreImage(String storeId);
	public List<List<MainImgDTO>> getStoreSmallImages(List<String> storeIds);
	//public List<MainImgDTO> getStoreSmallImage(String storeId);

	public void infoSave(String store_id,String store_menu_name,int store_menu_price,String store_menu_detail,String store_menu_category, String imagePath);
	public String saveMenuImage(MultipartFile mul);
	public void saveImagePathToStoreImg(String store_id, String store_img_root);
	public void storeSave(String store_id,String store_pwd,String store_email,String store_phone,String store_main_phone,String store_name,String store_add,
			String store_add_info,String store_category,String store_note,String store_introduce,String store_business_hours);
}