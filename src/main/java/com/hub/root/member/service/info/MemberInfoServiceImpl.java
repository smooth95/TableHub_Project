package com.hub.root.member.service.info;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hub.root.member.dto.BoardDTO;
import com.hub.root.member.dto.BookingDTO;
import com.hub.root.member.dto.MemberDTO;
import com.hub.root.member.dto.Reply2DTO;
import com.hub.root.member.dto.ReplyDTO;
import com.hub.root.member.dto.ReviewDTO;
import com.hub.root.member.mybatis.MemberInfoMapper;

@Service
public class MemberInfoServiceImpl implements MemberInfoService{
	@Autowired MemberInfoMapper mapper;

	BCryptPasswordEncoder en;
	public MemberInfoServiceImpl () {
		en = new BCryptPasswordEncoder();
	}

	@Override
	public int memberImgModify(MultipartHttpServletRequest file, String id, String imgName) {
    	System.out.println("memInfoSer memberImgModify 실행");
		MultipartFile mul = file.getFile("file");
		int result = 0;
		String fileName = saveFile(mul, id);
		deleteFile(id, imgName);
		if (fileName != null) {
			result = mapper.memberImgModify(fileName, id);
		}
		return result;
	}


	public String saveFile( MultipartFile mul, String id) {
    	System.out.println("memInfoSer saveFile 실행");
		String fileName = id + "_" + mul.getOriginalFilename();
		File saveFile = new File(IMAGE_REPO + "/" + fileName);
		try {
			System.out.println("try실행");
			mul.transferTo(saveFile);
			return fileName;
//			return mul.getOriginalFilename();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public void deleteFile(String id, String imgName) {
    	System.out.println("memInfoSer deleteFile 실행");
		File file = new File(IMAGE_REPO + "/" + (id + "_" + imgName));
			if (file.exists() ) {
				System.out.println("파일 있음");
				file.delete();
			} else {
				System.out.println("파일 없음");
			}
	}


	@Override
	public String memberImgDelete(String imgName, String id) {
    	System.out.println("memInfoSer memberImgDelete 실행");

		int result = mapper.memberImgDelete(id);
		String msg;
		if (result == 1) {
			deleteFile(id, imgName);
			msg = "기본이미지로 변경이 완료되었습니다.";
		} else {
			msg = "기본이미지로 되돌리던 중 문제가 발생했습니다. 새로고침 후 다시 시도해주세요";
		}
		return msg;
	}


	@Override
	public String memberNickModify(String nick, String id) {
    	System.out.println("memInfoSer memberNickModify 실행");
		int result = mapper.memberNickModify(nick, id);
		String msg;
		if (result == 1) {
			msg = "변경이 완료되었습니다.";
		} else {
			msg = "문제가 발생하였습니다. 새로고침 후 다시 시도해주세요";
		}
		return msg;
	}


	@Override
	public String memberStatusModify(String status, String id) {
    	System.out.println("memInfoSer memberStatusModify 실행");
		int result = mapper.memberStatusModify( status, id );
		String msg;
		if (result == 1) {
			msg = "상태 메세지 변경이 완료되었습니다.";
		} else {
			msg = "변경에 문제가 발생하였습니다.";
		}
		return msg;
	}


	@Override
	public String memberPhoneModify(String phone, String id) {
    	System.out.println("memInfoSer memberPhoneModify 실행");
		int result = mapper.memberPhoneModify(phone, id);
		String msg;
		if (result == 1) {
			msg = "변경이 완료되었습니다.";
		} else {
			msg = "문제가 발생하였습니다. 새로고침 후 다시 시도해주세요";
		}
		return msg;
	}


	@Override
	public Map<String, Object> memberEmailModify(String email, String id) {
    	System.out.println("memInfoSer memberEmailModify 실행");
		Map<String, Object> map = new HashMap<>();
		int result = mapper.memberEmailModify(email, id);
		String msg;
		if (result == 1) {
			msg = "변경이 완료되었습니다.";
		} else {
			msg = "문제가 발생하였습니다. 새로고침 후 다시 시도해주세요";
		}
		map.put("msg", msg);
		map.put("result", result);
		return map;
	}


	@Override
	public Map<String, Object> memberPasswordModify(String currentPwd, String changePwd, String id) {
    	System.out.println("memInfoSer memberPasswordModify 실행");
		String pwd = mapper.memberPasswordChk(id);
		Map<String, Object> map = new HashMap<>();
		int result;
		String msg;
		if (en.matches(currentPwd, pwd)) {
			String p = en.encode(changePwd);
			result = mapper.memberPasswordModify(p, id);
			if (result == 1) {
				msg = "비밀번호가 변경되었습니다. 로그인페이지로 이동합니다.";
			} else {
				msg = "문제가 발생하였습니다. 새로고침 후 다시 시도해주세요";
			}
		} else {
			result = -1;
			msg = "기존 비밀번호가 일치하지 않습니다. 확인 후 다시 시도해주세요";
		}
		map.put("result", result);
		map.put("msg", msg);
		return map;
	}

	@Override
	public MemberDTO getMemberInfo(String id) {
    	System.out.println("memInfoSer getMemberInfo 실행");
		MemberDTO dto = mapper.getMemberInfo(id);
		return dto;
	}
	@Override
	public Map<String, Object> getBookingInfo(String storeId, int id) {
    	System.out.println("memInfoSer getBookingInfo 실행");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("storeName",(String)mapper.getStoreName(storeId));
		String[] storeImgs = (String[])mapper.getStoreImg(storeId).split("\\\\");
		String storeImg = storeImgs[storeImgs.length - 1];
		map.put("storeImg", storeImg);
		
		int result = mapper.getReviewScore(id);
		System.out.println("result : "+ result);
		map.put("reviewScore", result);
		return map;
	}

	@Override
	public Map<String, Object> getReadyBooking(String page, String id) {
    	System.out.println("memInfoSer getReadyBooking 실행");
		int totalCount = mapper.getBookingReadyCount(id);
		Map<String, Object> map = pageCalc(Integer.parseInt(page), totalCount, 6);
		List<BookingDTO> list = mapper.getBookingReadyContent(
								id, (int)map.get("startNum"),
								(int)map.get("endNum"));
		map.put("list", list);
		return map;
	}

	@Override
	public Map<String, Object> getAlreadyBooking(String page, String id) {
    	System.out.println("memInfoSer getAlreadyBooking 실행");
		int totalCount = mapper.getBookingAlreadyCount(id);
		Map<String, Object> map = pageCalc(Integer.parseInt(page), totalCount, 6);
		List<BookingDTO> list = mapper.getBookingAlreadyContent(
								id, (int)map.get("startNum"),
								(int)map.get("endNum"));
		map.put("list", list);
		return map;
	}

	@Override
	public int deleteBooking(int bookId) {
    	System.out.println("memInfoSer deleteBooking 실행");
		int result = mapper.deleteBooking(bookId);

		return result;
	}

	@Override
	public Map<String, Object> pwdCheck(String pwd, String id) {
    	System.out.println("memInfoSer pwdCheck 실행");
		Map<String, Object> map = new HashMap<>();

		String result = mapper.pwdCheck(id);

		map.put("result", result);
		if (result != "") {
			System.out.println("1");
			en.matches(pwd, id);
			if (en.matches(pwd, result)) {
				map.put("result", 1);
			} else {
				map.put("result", 0);
				map.put("msg", "비밀번호가 일치하지 않습니다. 확인 후 다시 시도해주세요");
			}
		} else {
			map.put("result", 0);
			map.put("msg", "비밀번호가 일치하지 않습니다. 확인 후 다시 시도해주세요");
		}
		return map;
	}

	@Override
	public Map<String, Object> deleteUser(String id) {
		System.out.println("memInfoSer deleteUser 실행");
		Map<String, Object> map = new HashMap<>();
		System.out.println("id : " + id);
		int result = mapper.deleteUser(id);
		map.put("result", result);
		if (result == 1) {
			map.put("msg", "회원탈퇴가 완료되었습니다.\n메인페이지로 이동합니다.");
			map.put("url", "/root/main/mainPage1");
		} else {
			map.put("msg", "문제가 발생하였습니다. \n새로고침 후 다시 시도해주세요");
		}
		return map;
	}

	@Override
	public Map<String, Object> getBoard(String id, String page) {
		System.out.println("memInfoSer getBoard 실행");
		int totalCount = mapper.getBoardCount(id);

		Map<String, Object> map = pageCalc(Integer.parseInt(page), totalCount, 10);
		System.out.println("page : " + map.get("page"));
		System.out.println("count : " + map.get("count"));
		System.out.println("startNum : " + map.get("startNum"));
		System.out.println("endNum : " + map.get("endNum"));
		System.out.println("totalPage : " + map.get("totalPage"));
		List<BoardDTO> list = mapper.getBoard(id,
											(int)map.get("startNum"),
											(int)map.get("endNum"));
		if (!list.isEmpty()) {
			map.put("result", 1);
			map.put("list", list);
		} else {
			map.put("result", 0);
		}
		return map;
	}




	@Override
	public Map<String, Object> getBoardReplyCount(int boardId) {
		Map<String, Object> map = new HashMap<>();
		System.out.println("serviceboardId : " + boardId);
		int boardReplyCount = mapper.getBoardReplyCount(boardId);
		System.out.println("boardReplyCount : " + boardReplyCount);
		map.put("boardReplyCount", boardReplyCount);
		return map;
	}

	@Override
	public Map<String, Object> deleteBoard(int[] content) {
    	System.out.println("memInfoSer deleteBoard 실행");
		int result = mapper.deleteBoard(content);
		Map<String, Object> map = new HashMap<>();
		String msg = "";
		if (result == content.length) {
			msg = "선택한 항목이 삭제되었습니다.";
		} else {
			msg = "삭제하는 중 문제가 발생하였습니다.";
		}
		map.put("msg", msg);
		map.put("result", result);
		return map;
	}

	@Override
	public Map<String, Object> getReview(String id, String page) {
		System.out.println("memInfoSer getReview 실행");
		int totalCount = mapper.getReviewCount(id);

		Map<String, Object> map = pageCalc(Integer.parseInt(page), totalCount, 5);
		System.out.println("page : " + map.get("page"));
		System.out.println("count : " + map.get("count"));
		System.out.println("startNum : " + map.get("startNum"));
		System.out.println("endNum : " + map.get("endNum"));
		System.out.println("totalPage : " + map.get("totalPage"));
		List<ReviewDTO> list = mapper.getReview(id,
											(int)map.get("startNum"),
											(int)map.get("endNum"));

		if (!list.isEmpty()) {
			map.put("result", 1);
			map.put("list", list);
		} else {
			map.put("result", 0);
		}
		return map;
	}


	public Map<String, Object> pageCalc(int page, int count, int pageContent) {
    	System.out.println("memInfoSer pageCalc 실행");
		Map<String, Object> map = new HashMap<>();
		int totalPage = count / pageContent;
		if (count % pageContent != 0) {
			totalPage += 1;
		}
		int startNum = page * pageContent - (pageContent - 1);
		int endNum = page * pageContent;
		map.put("page", page);
		map.put("count", count);
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		map.put("totalPage", totalPage);
		return map;
	}

	@Override
	public Map<String, Object> getReviewInfo(String storeId, int reviewNum) {
		Map<String, Object> map = mapper.getReviewStoreInfo(storeId);
		String reviewImg = mapper.getReviewImgInfo(reviewNum);
		System.out.println("reviewImg : " + map.get("STORE_IMG_ROOT"));
		String[] storeImg = ((String) map.get("STORE_IMG_ROOT")).split("\\\\");
		map.put("STORE_IMG_ROOT", storeImg[storeImg.length-1]);
		
		map.put("reviewImg", reviewImg);
		return map;
	}

	@Override
	public Map<String, Object> deleteReview(int storeNum) {
		System.out.println("memInfoSer deleteReview 실행");
		int result = mapper.deleteReview(storeNum);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		String msg = "";
		if (result == 1) {
			msg = "삭제가 완료되었습니다.";
		} else {
			msg = "삭제중 문제가 발생하였습니다.\n새로고침 후 다시 시도해주세요\n문제가 지속될경우 관리지에게 문의해주세요";
		}
		map.put("msg", msg);
		return map;
	}

	@Override
	public Map<String, Object> getReply(String memId, int page) {
		System.out.println("memInfoSer getReply 실행");
		int totalCount = mapper.getReplyCount(memId);
		Map<String, Object> map = new HashMap<>();

		if (totalCount > 0) {
			map = pageCalc(page, totalCount, 6);

			List<Map<String, Object>> list1 =  mapper.getReply(memId,
										(int)map.get("startNum"),
										(int)map.get("endNum"));
//			List<Reply2DTO> list2 = mapper.getReply2(memId,
//										(int)map.get("startNum"),
//										(int)map.get("endNum"));
//			if (!list1.isEmpty() && !list2.isEmpty()) {
//				System.out.println("댓글대댓글 둘다 널값 아님");
//				List<Object> lists = replyMerge(list1, list2);
//				map.put("list", lists);
//			} else if (!list1.isEmpty()) {
//				System.out.println("대댓글이 널값일때");
//				map.put("list", list1);
//			} else {
//				System.out.println("댓글이 널값일때");
//				map.put("list", list2);
//			}
			map.put("list", list1);
			map.put("result", 1);
		} else {
			map.put("result", 0);
		}

		return map;
	}

	public List<Object> replyMerge(List<ReplyDTO> list1, List<Reply2DTO> list2) {
		List<Object> lists = new ArrayList<>();

		int i = 0;
		int x = 0;
		int y = 0;
		System.out.println("listempty : " + list1.isEmpty());
		System.out.println("list2empty : " + list2.isEmpty());


		while (true) {

			if (!list1.isEmpty() && !list2.isEmpty()) {
				System.out.println("if 1");
				if (list1.get(0).getReviewCreate().after(list2.get(y).getReviewCreate())) {
					System.out.println("list1이 빠름");
					lists.add(list1.get(0));
					list1.remove(0);
				} else {
					System.out.println("list2가 빠름");
					lists.add(list2.get(0));
					list2.remove(0);
				}
			} else if (!list1.isEmpty()) {
				System.out.println("if 2");
				lists.add(list1.get(0));
				list1.remove(0);
			} else if (!list2.isEmpty()){
				System.out.println("if 3");
				lists.add(list2.get(0));
				list2.remove(0);
			} else {
				System.out.println("if 4");
				break;
			}

			if (lists.size() == 10 ) {
				System.out.println("size : " + lists.size());
				break;
			}
		}


		return lists;
	}




	@Override
	public Map<String, Object> getBoardInfo(int boardId) {
		System.out.println("memInfoSer getBoardInfo 실행");
		Map<String, Object> map = new HashMap<>();
		map = mapper.getBoardInfo(boardId);
		map.put("result", 0);
		return map;
	}
	@Override
	public Map<String, Object> getBoardInfo2(int reviewId) {
		System.out.println("memInfoSer getBoardInfo2 실행");
		Map<String, Object> map = new HashMap<>();
		map = mapper.getBoardInfo2(reviewId);
		map.put("result", 0);
		return map;
	}

	@Override
	public Map<String, Object> deleteReply(List<int[]> content) {
    	System.out.println("memInfoSer deleteReply 실행");
    	List<Integer> boardReply = new ArrayList<Integer>();
    	List<Integer> board2Reply = new ArrayList<Integer>();
    	for (int[] is : content) {
    		System.out.println("is[0] : " + is[0]);
			if (is[1] == 1) {
				boardReply.add(is[0]);
			} else if (is[1] == 2) {
				board2Reply.add(is[0]);
			}
		}
    	System.out.println("boardReply : " + boardReply);
    	System.out.println("board2Reply : " + board2Reply);
    	int result = 0;
    	System.out.println("replySize : " + boardReply.size());
    	System.out.println("reply2Size : " + boardReply.size());
    	if (boardReply.size() != 0) {
    		int boardResult = mapper.deleteReply(boardReply);
    		System.out.println("boardResult : " + boardResult);
    		result += boardResult;
    	}
    	if (board2Reply.size() != 0) {
    		int board2Result = mapper.delete2Reply(board2Reply);
    		System.out.println("board2Result : " + board2Result);
    		result += board2Result;
    	}
    	
    	
    	Map<String, Object> map = new HashMap<>();
		
		String msg = "";
		System.out.println("결과값 result : " + result);
		if (result == content.size()) {
			msg = "선택한 항목이 삭제되었습니다.";
		} else {
			msg = "삭제하는 중 문제가 발생하였습니다."; 
		}
		map.put("msg", msg);
		map.put("result", result);
		return map;
	}

	@Override
	public Map<String, Object> getMyContentMyInfo(String userId) {
		Map<String, Object> map = mapper.getMyContentMyInfo(userId);
		if (map.get("REVIEW_SCORE") == null) {
			map.put("REVIEW_SCORE", 0);
		}
		
		return map;
	}

	@Override
	public String getNick(String userId) {
		String userNick = mapper.getNick(userId);
		return userNick;
	}




}

