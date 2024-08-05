package com.hub.root.member.service.info;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hub.root.member.dto.MemberDTO;

public interface MemberInfoService {
	public String IMAGE_REPO = "//C://tablehub_image/member";
	public int memberImgModify(MultipartHttpServletRequest file, String id, String imgName);
	public String memberImgDelete(String imgName, String id);
	public String memberNickModify(String nick, String id);
	public String memberStatusModify(String status, String id);
	public String memberPhoneModify(String phone, String id);
	public Map<String, Object> memberEmailModify(String email, String id);
	public Map<String, Object> memberPasswordModify(String currentPwd, String ChangePwd, String id);
	public MemberDTO getMemberInfo(String id);


	public Map<String, Object> getBookingInfo(String storeId, int id);
	public Map<String, Object> getReadyBooking(String page, String id);
	public Map<String, Object> getAlreadyBooking(String page, String id);
	public int deleteBooking(int bookId);
	public Map<String, Object> pwdCheck(String pwd, String id);
	public Map<String, Object> deleteUser(String id);
	public Map<String, Object> getBoard(String id, String page);
	public Map<String, Object> getBoardReplyCount(int boardId);
	public Map<String, Object> deleteBoard(int[] content);
	public Map<String, Object> getReview(String id, String page);
	public Map<String, Object> getReviewInfo(String storeId, int reviewNum);
	public Map<String, Object> deleteReview(int storeNum);
	public Map<String, Object> getReply(String memId, int page );
	public Map<String, Object> getBoardInfo(int boardId);
	public Map<String, Object> getBoardInfo2(int reviewId);
	public Map<String, Object> deleteReply(List<int[]> content);
	public Map<String, Object> getMyContentMyInfo(String userId);
	public String getNick(String userId);
}
