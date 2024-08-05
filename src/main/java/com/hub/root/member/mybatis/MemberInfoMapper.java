package com.hub.root.member.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hub.root.member.dto.BoardDTO;
import com.hub.root.member.dto.BookingDTO;
import com.hub.root.member.dto.MemberDTO;
import com.hub.root.member.dto.Reply2DTO;
import com.hub.root.member.dto.ReviewDTO;

public interface MemberInfoMapper {
	public int memberImgModify(@Param("fileName") String fileName,@Param("id") String id);
	public int memberImgDelete(String id);
	public int memberNickModify(@Param("nick") String nick, @Param("id") String id);
	public int memberStatusModify(@Param("status") String status, @Param("id") String id);
	public int memberPhoneModify(@Param("phone") String phone, @Param("id") String id);
	public int memberEmailModify(@Param("email") String email, @Param("id") String id);
	public String memberPasswordChk(String id);
	public int memberPasswordModify(@Param("pwd") String pwd, @Param("id") String id);
	public MemberDTO getMemberInfo(String id);

	public List<BookingDTO> getMyBooking(String id);
	public String getStoreName(String storeId);
	public String getStoreImg(String storeId);
	public int getReviewScore(int id);
	public int getBookingReadyCount(String id);
	public int getBookingAlreadyCount(String id);
	public List<BookingDTO> getBookingReadyContent(@Param("id") String id,
							@Param("start") int start,
							@Param("end") int end);
	public List<BookingDTO> getBookingAlreadyContent(@Param("id") String id,
			@Param("start") int start,
			@Param("end") int end);
	public int deleteBooking(int bookId);
	public String pwdCheck(@Param("id") String id);
	public int deleteUser(String id);
	public int getBoardCount(String id);
	public List<BoardDTO> getBoard(@Param("id") String id, @Param("start") int startNum,
									@Param("end") int endNum);
	public int getBoardReplyCount(@Param("boardId") int boardId);
	public int deleteBoard(@Param("content") int[] content);
	public int getReviewCount(String id);
	public List<ReviewDTO> getReview(@Param("id") String id, @Param("start") int startNum,
			@Param("end") int endNum);
	public Map<String, Object> getReviewStoreInfo(@Param("storeId") String storeId);
	public String getReviewImgInfo(@Param("reviewNum") int reviewNum);
	public int deleteReview(@Param("storeNum") int storeNum);
	public int getReplyCount(@Param("memId") String memId);
	public List<Map<String, Object>> getReply(@Param("memId") String memId, @Param("start") int startNum,
			@Param("end") int endNum);
	public List<Reply2DTO> getReply2(@Param("memId") String memId, @Param("start") int startNum,
			@Param("end") int endNum);
	public Map<String, Object> getBoardInfo(@Param("boardId") int boardId);
	public Map<String, Object> getBoardInfo2(@Param("reviewId") int reviewId);
	public int deleteReply(@Param("content") List<Integer> content);
	public int delete2Reply(@Param("content") List<Integer> content);
	public Map<String, Object> getMyContentMyInfo(@Param("userId") String userId);
	public String getNick(@Param("userId") String userId);





}