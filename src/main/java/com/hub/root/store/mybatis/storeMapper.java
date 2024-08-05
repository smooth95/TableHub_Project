package com.hub.root.store.mybatis;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hub.root.store.DTO.storeBookmarkDTO;
import com.hub.root.store.DTO.storeInfoDTO;
import com.hub.root.store.DTO.storeMenuDTO;
import com.hub.root.store.DTO.storeReviewDTO;
import com.hub.root.store.DTO.storeReviewImgDTO;

public interface storeMapper {
	public storeInfoDTO storeInfo( String store_id);
	public String storeImgMain(String store_id);
	public List<String> storeImg(String store_id);
	public List<storeBookmarkDTO> storeBookmark(String store_id);
	public List<storeMenuDTO> storeMenu(String store_id);
	public List<storeReviewDTO> storeReview(String store_id);
	public List<String> storeReviewImg(String store_id);
	public List<storeReviewImgDTO> reviewImage(String store_id);
	public String memberInfo(String memberID);
	public int jjimchk(@Param("user_id") String user_id, @Param("store_id") String store_id);
	public int jjimcancle(@Param("user_id") String user_id, @Param("store_id") String store_id);
	public int jjim(@Param("user_id") String user_id, @Param("store_id") String store_id);

	//민석
	public String phone(@Param("user_id") String user_id);
}
