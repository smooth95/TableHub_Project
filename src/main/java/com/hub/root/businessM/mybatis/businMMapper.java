package com.hub.root.businessM.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hub.root.businessM.DTO.BookPageDTO;
import com.hub.root.businessM.DTO.businMDTO;
import com.hub.root.businessM.DTO.businMMenuDTO;
import com.hub.root.businessM.DTO.businMPhotoDTO;
import com.hub.root.businessM.DTO.ReservationDTO;
import com.hub.root.businessM.DTO.storeReviewDTO;

public interface businMMapper {
	public businMDTO businMChk(@Param("store_id")String store_id);
	public businMDTO businMChk2(@Param("store_id")String store_id);
	public int register(businMDTO dto);
	//public int storeImage01(@Param("file01Path") String file01Path, @Param("store_id")String store_id);
	//public int storeImage09(@Param("filePath")String filePath, @Param("store_id")String store_id);
	public int storeImage01( Map<String, Object> param );
	public int storeImageDelete( String store_id );
	public int menuRegister( Map<String, Object> menuparam );

	public businMDTO infochk(String store_id);


	//민석 부분
	public List<BookPageDTO> book(@Param("start") int start, @Param("end") int end, @Param("store_id") String store_id, @Param("type") String type);
	public int totalPage(@Param("store_id") String store_id, @Param("type") String type);
	public ReservationDTO reservationInfo(@Param("store_id") String store_id);
	//----



	public businMDTO infoChk(String store_id);
	public List<businMMenuDTO> menuChk(String store_id);
	public List<businMPhotoDTO> photoChk(String store_id);
	public String photoMainChk(String store_id);
	//public int menuNum(String store_id);
	public int menuDel(String store_id);
	

	//구현 부분
	public int getTotalReview(String storeId);
	public List<storeReviewDTO> getReview(@Param("storeId") String storeId ,
										  @Param("startNum") int startNum ,
										  @Param("endNum") int endNum);
	public Map<String, Object> getReviewDetail(@Param("memId") String memId,
												@Param("reviewNum") int reviewNum);
	public int deleteReview(@Param("reviews") int[] reviews);
	//----
	
}
