package com.hub.root.main.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hub.root.main.dto.MainDTO;
import com.hub.root.main.dto.MainImgDTO;
import com.hub.root.main.dto.MainMapDTO;
import com.hub.root.main.dto.MainReviewDTO;

public interface mainMapper {
	public List<MainDTO> mainPage1();
	public List<String> getAllCategories();
	public List<MainImgDTO> getStoreImgToMain(String storeId);
	
	public void mainPage2(MainMapDTO MapDTO);
	public List<MainMapDTO> getStoreInfo(@Param("params") Map<String, Object> params);
	public List<MainMapDTO> getStoreInfoByCategory(@Param("category") String category);
	
	public List<MainImgDTO> getStoreImage(String storeId);
	public List<MainImgDTO> getStoreSmallImage(String storeId);
	public List<MainReviewDTO> getReviewList(String userId);
	public List<MainReviewDTO> getPopularityList(@Param("params") Map<String, Object> params);
	public List<MainReviewDTO> getReviewList(@Param("params") Map<String, Object> params);
	
	public int infoSave(MainDTO dto);
	public void saveImagePathToStoreImg(MainImgDTO dto);
	public void storeSave(MainMapDTO dto);
}