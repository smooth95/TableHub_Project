package com.hub.root.member.controller.info;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hub.root.member.service.info.MemberInfoService;

@RestController
@RequestMapping("member/myPage")
public class MemberInfoRestController {
	@Autowired MemberInfoService mis;


    @PostMapping(value="memberImgModify", produces = "application/json; charset=utf-8")
	public String memberImgModify(MultipartHttpServletRequest file, HttpSession session) {
    	System.out.println("memInfoRestCont memberImgModify 실행");
		String msg;
		int result = mis.memberImgModify(file, (String)session.getAttribute("userId"), file.getParameter("imgName"));
		if (result == 1) {
			msg = "저장이 완료되었습니다.";
		} else {
			msg = "저장하는 과정에서 문제가 발생하였습니다. 새로고침후 다시 진행해주세요";
		}

		return msg;
	}

    @PostMapping(value="memberImgDelete", produces = "application/json;charset=utf-8")
    public String memberImgDelete(@RequestBody Map<String, Object> map) {
    	System.out.println("memInfoRestCont MemberImgDelete 실행");
    	String msg = mis.memberImgDelete((String)map.get("imgName"), (String)map.get("id"));
    	return msg;
    }

    @PutMapping(value="memberNickModify", produces="application/json; charset=utf-8")
    public String memberNickModify(@RequestBody Map<String, Object> map, HttpSession session) {
    	System.out.println("memInfoRestCont memberNickModify 실행");
    	String msg = mis.memberNickModify( (String)map.get("nick"), (String)session.getAttribute("userId"));
    	return msg;
    }
    @PutMapping(value="memberStatusModify", produces="application/json; charset=utf-8")
    public String memberStatusModify(@RequestBody Map<String, Object> map, HttpSession session) {
    	System.out.println("memInfoRestCont memberStatusModify 실행");
    	String msg = mis.memberStatusModify((String)map.get("status"), (String)session.getAttribute("userId"));

    	return msg;
    }
    @PatchMapping(value="memberPhone", produces="application/json; charset=utf-8")
    public String memberPhone(@RequestBody Map<String, Object> map, HttpSession session) {
    	System.out.println("memInfoRestCont memberPhone 실행");
    	String msg = mis.memberPhoneModify((String)map.get("phone"), (String)session.getAttribute("userId"));
    	return msg;
    }

    @PatchMapping(value="memberEmail", produces="application/json; charset=utf-8")
    public Map<String, Object> memberEmail(@RequestBody Map<String, Object> map, HttpSession session, HttpServletRequest req) {
    	System.out.println("memInfoRestCont memberEmail 실행");

    	Cookie[] cookie = req.getCookies();
		String code = (String)map.get("code");

		String email = "";
		if (cookie != null) {
			for(Cookie c : cookie) {
				if (c.getName().equals("email")) {
					email = c.getValue();
					break;
				}
			}
		}
		String ses = (String)session.getAttribute(email);
		int result;
		if (code.equals(ses)) {
	    	map = mis.memberEmailModify((String)map.get("email"), (String)session.getAttribute("userId"));
		} else {
			map.put("result", -1);
			map.put("msg", "인증코드가 일치하지 않습니다. 다시 확인해주세요");
		}

    	return map;
    }

    @PatchMapping(value="memberPassword", produces="application/json; charset=utf-8")
    public Map<String, Object> memberPassword (@RequestBody Map<String, Object> map, HttpSession session) {
    	System.out.println("memInfoRestCont memberPassword 실행");
    	String currentPwd = (String)map.get("currentPwd");
    	String changePwd = (String)map.get("changePwd");
    	map = mis.memberPasswordModify(currentPwd, changePwd, (String)session.getAttribute("userId"));
    	if ((int)map.get("result") == 1) {
    		session.invalidate();
    	}
    	return map;
    }




    @GetMapping(value="bookingReady", produces="application/json; charset=utf-8")
    public Map<String, Object> bookingReady(HttpSession session, @RequestParam String page) {
    	System.out.println("memInfoRestCont bookingReady 실행");
    	String id = (String)session.getAttribute("userId");
    	Map<String, Object> map = mis.getReadyBooking(page, id);

    	return map;
    }
    @GetMapping(value="bookingAlready", produces="application/json; charset=utf-8")
    public Map<String, Object> bookingAlready(HttpSession session, @RequestParam String page) {
    	System.out.println("memInfoRestCont bookingAlready 실행");
    	String id = (String)session.getAttribute("userId");
    	Map<String, Object> map = mis.getAlreadyBooking(page, id);
    	return map;
    }

    @GetMapping(value="getBookingInfo", produces="application/json; charset=utf-8")
    public Map<String, Object> getBookingInfo (@RequestParam String storeId,
    					@RequestParam(value = "bookingId", required = false, defaultValue = "0") int bookingId) {
    	System.out.println("memInfoRestCont getBookingInfo 실행");
    	Map<String, Object> map = mis.getBookingInfo(storeId, bookingId);
    	return map;
    }

    @DeleteMapping(value={"readyBooking", "alreadyBooking"}, produces="application/json; charset=utf-8")
    public String booking(@RequestParam int bookId) {
    	System.out.println("memInfoRestCont readyBooking 실행");
    	int result = mis.deleteBooking(bookId);

    	return null;
    }

	@GetMapping(value="pwdCheck", produces="application/json; charset=utf-8")
	public Map<String, Object> pwdCheck(@RequestParam("inputPwd") String pwd, HttpSession session, HttpServletResponse res) {
    	System.out.println("memInfoRestCont pwdCheck 실행");
		String id = (String)session.getAttribute("userId");
		Map<String, Object> map = mis.pwdCheck(pwd, id);
		if ((int)map.get("result") == 1) {
			Cookie cook = new Cookie("myPage", id);
			cook.setPath("/root/member");
			res.addCookie(cook);
		}
		return map;
	}

	@DeleteMapping(value="deleteUser")
	public Map<String, Object> deleteUser(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
		System.out.println("memInfoRestCont deleteUser 실행");
		Map<String, Object> map = mis.deleteUser((String)session.getAttribute("userId"));
		String token = null;
		Cookie[] cookies = req.getCookies();
		
		// 삭제가 완료되었으면 1 아니면 0
		if ((int)map.get("result") == 1) {
			System.out.println("if문실행");
			
			//쿠키값이 존재한다면 if문 실행
			if (cookies != null) {
				for (Cookie c : cookies) {
					if (c.getName().equals("snsToken")) {
						token = c.getValue();
						c.setMaxAge(0);
						res.addCookie(c);
					}
					if (c.getName().equals("myPage")) {
						System.out.println("myPage Cookie 삭제");
						c.setMaxAge(0);
						res.addCookie(c);
					}
				}
			}
			
			//쿠키값 삭제
			
			//삭제된 사용자가 간편로그인 계정이면 if문 실행
			if (token != null) {
				try {
		            // URL 설정
		            URL url = new URL("https://nid.naver.com/oauth2.0/token");
		            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		            
		            // 요청 설정
		            connection.setRequestMethod("POST");
		            connection.setDoOutput(true);
		            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

		            // 요청 바디 설정
		            String parameters = "grant_type=delete"
				    				+ "&client_id=NY8JwdpMRrDBs7eqhg8A"
				    				+ "&client_secret=4_1nA0P4RP"
				    				+ "&access_token="+token;
		            byte[] postData = parameters.getBytes(StandardCharsets.UTF_8);

		            // 요청 바디 전송
		            try (OutputStream outputStream = connection.getOutputStream()) {
		                outputStream.write(postData);
		            }

		            // 응답 코드 확인
		            int responseCode = connection.getResponseCode();
		            System.out.println("Response Code: " + responseCode);

//		            if (responseCode == HttpURLConnection.HTTP_OK) {
//		                try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
//		                    String line;
//		                    StringBuilder response = new StringBuilder();
//		                    while ((line = reader.readLine()) != null) {
//		                        response.append(line);
//		                    }
//		                    return response.toString();
//		                }
//		            } else {
//		                return "Request failed with response code: " + responseCode;
//		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
			}
			
		} else {
			System.out.println("else문실행");
		}
		session.invalidate();
		return map;
	}

	@GetMapping(value="board", produces="application/json; charset=utf-8")
	public Map<String, Object> getBoard(HttpSession session, @RequestParam String page) {
		System.out.println("memInfoRestCont getBoard 실행");
		Map<String, Object> map = mis.getBoard((String)session.getAttribute("userId"), page);
		return map;
	}

	@GetMapping(value="board/replyCount", produces="application/json; charset=utf-8")
	public Map<String, Object> getBoardReplyCount(@RequestParam int boardId){
		System.out.println("boardId : " + boardId);
		Map<String, Object> map = mis.getBoardReplyCount(boardId);
		return map;
	}

	@DeleteMapping(value="board", produces="application/json; charset=utf-8")
	public Map<String, Object> deleteBoard(@RequestBody Map<String, int[]> boards) {
		System.out.println("memInfoRestCont deleteBoard 실행");
		int[] boardsArr = boards.get("content");
		Map<String, Object> map = mis.deleteBoard(boardsArr);
		return map;
	}

	@GetMapping(value="review", produces="application/json; charset=utf-8")
	public Map<String, Object> getReview(HttpSession session, @RequestParam String page) {
		System.out.println("memInfoRestCont getReview 실행");
		Map<String, Object> map = mis.getReview((String)session.getAttribute("userId"), page);
		return map;
	}

	@GetMapping(value="review/reviewInfo", produces="application/json; charset=utf-8")
	public Map<String, Object> getReviewStoreInfo(@RequestParam String storeId, @RequestParam int reviewNum) {
		System.out.println("memInfoRestCont getReviewStoreName 실행");
		System.out.println("reviewNum : " + reviewNum);
		Map<String, Object> map = mis.getReviewInfo(storeId, reviewNum);
		return map;
	}

	@DeleteMapping(value="review", produces="application/json; charset=utf-8")
	public Map<String, Object> deleteReview(@RequestBody Map<String, Object> map) {
		System.out.println("memInfoRestCont deleteReview 실행");
		System.out.println("storeNum : " + map.get("storeNum"));
		map = mis.deleteReview((int)map.get("storeNum"));
		return map;
	}



	/*
	 * 게시판 불러오기 및 삭제하기
	 */
	@GetMapping(value="reply", produces="application/json; charset=utf-8")
	public Map<String, Object> getReply(@RequestParam int page, HttpSession session) {
		System.out.println("memInfoRestCont getReply 실행");
		Map<String, Object> map = mis.getReply((String)session.getAttribute("userId"), page);
		return map;
	}
	@GetMapping(value="reply/board", produces="application/json; charset=utf-8")
	public Map<String, Object> getBoardInfo(@RequestParam int boardId) {
		System.out.println("memInfoRestCont getBoardInfo 실행");
		Map<String, Object> map = mis.getBoardInfo(boardId);
		return map;
	}
	@GetMapping(value="reply2/board", produces="application/json; charset=utf-8")
	public Map<String, Object> getBoardInfo2(@RequestParam int reviewId) {
		System.out.println("memInfoRestCont getBoardInfo2 실행");
		Map<String, Object> map = mis.getBoardInfo2(reviewId);
		return map;
	}

	@DeleteMapping(value="reply", produces="application/json; charset=utf-8")
	public Map<String, Object> deleteReply(@RequestBody Map<String, List<int[]>> replys) {
		System.out.println("memInfoRestCont deleteReply 실행");
		List<int[]> test = replys.get("content");
		Map<String, Object> map = mis.deleteReply(test);
		return map;
	}



	// 내 활동 관리 상단의 내 정보 간략하게 표시하는 메뉴의 데이터 불러오기
	@GetMapping(value="myContentMyInfo", produces="application/json; charset=utf-8")
	public Map<String, Object> myContentMyInfo (HttpSession session, Model model) {
		Map<String, Object> map = mis.getMyContentMyInfo((String)session.getAttribute("userId"));
		String userNick = mis.getNick((String)session.getAttribute("userId"));
		map.put("userNick", userNick);
		return map;
	}
}
