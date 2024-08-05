package com.hub.root.store.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.hub.root.member.dto.MemberDTO;
import com.hub.root.store.DTO.reviewNumDTO;
import com.hub.root.store.DTO.storeBookmarkDTO;
import com.hub.root.store.DTO.storeInfoDTO;
import com.hub.root.store.DTO.storeMenuDTO;
import com.hub.root.store.DTO.storeReviewDTO;
import com.hub.root.store.DTO.storeReviewImgDTO;
import com.hub.root.store.mybatis.storeMapper;

@Service
public class storeService {
	private final storeMapper mapper;
	private storeInfoDTO infoDTO;
	private storeMenuDTO menuDTO;
	private storeReviewDTO reviewDTO;
	private storeReviewImgDTO reviewImgDTO;
	private storeBookmarkDTO bookmarkDTO;
	private reviewNumDTO numDTO;
	private MemberDTO memDTO;

	@Autowired
	public storeService(storeMapper mapper) {
		this.mapper = mapper;
	}
	
	public String storeChk(HttpServletRequest request, Model model,
				String store_id){
		HttpSession session = request.getSession();
	    String businessM_id = (String) session.getAttribute("storeId");
	    System.out.println("보선-세션 사업자아이디 : "+businessM_id);
	    
	    String result = "";
	   
	    if(businessM_id == null) {
	    	System.out.println("사업자 아이디 없으므로 세부페이지 온");
	    	return result;
	    }else {
	    	System.out.println("사업자 아이디 존재");
	    	infoDTO = mapper.storeInfo(store_id);
	    	String mainImg = mapper.storeImgMain(store_id);
	    	
	    	//System.out.println("보선 비교 : "+(infoDTO.getStore_zip() != null)
	    	//		+"따옴표"+(infoDTO.getStore_zip() != ""));
	    	
	    	if(infoDTO.getStore_zip() == null) {
	    		System.out.println("가게 등록창으로 이동시킴");
	    		result = "가게";
	    		return result;
		    }else if(mainImg == null){
		    	System.out.println("대표사진 등록창으로 이동시킴");
		    	result = "대표사진";
		    	return result;
		    }else {
		    	System.out.println("가게등록 되어있음");
		    	return result;	
		    }
	    	
	    }
		
	}

	public Map<String, Object> store(HttpServletRequest request, Model model,
			String store_id) {
		List<String> storeImg = new ArrayList<>();
		List<String> reviewImg = new ArrayList<>();
		infoDTO = mapper.storeInfo(store_id);
		String mainImg = mapper.storeImgMain(store_id);
		storeImg = mapper.storeImg(store_id);
		List<storeBookmarkDTO> Bmark  = mapper.storeBookmark(store_id);
		List<storeReviewDTO> review = mapper.storeReview(store_id);
		reviewImg = mapper.storeReviewImg(store_id);

		int totalBookmark = Bmark.size();
		int totalreview = review.size();
		int scoreAvr= averageScore(review);

		infoDTO.setStore_add(statefix(infoDTO.getStore_add()));
		infoDTO.setStore_category(infoDTO.getStore_category().replace("/", ", "));
		mainImg = mainImgname(mainImg);
		storeImg = Imgsname(storeImg);

		reviewImg = reviewImage(reviewImg);

		System.out.println("보선--infoDTO확인--"
						+"\n store_category : "+infoDTO.getStore_category()
						+"\n store_name : "+infoDTO.getStore_name()
						+"\n store_add : "+infoDTO.getStore_add()
						+"\n store_max_person : "+infoDTO.getStore_max_person()
						+"\n --메인 이미지--"
						+"\n mainImg :"+mainImg
						+"\n --북마크--"
						+"\n totalBookmark :"+totalBookmark
						);
		 for (int i = 0; i < storeImg.size(); i++) {
	            Object element = storeImg.get(i);
	            //System.out.println("일반사진" + (i + 1) + ": " + element);
	        }
		 for (int i = 0; i < reviewImg.size(); i++) {
			 Object element = reviewImg.get(i);
			 //System.out.println("리뷰사진" + (i + 1) + ": " + element);
		 }


		Map<String, Object> MainInfoMap = new HashMap<>();
		MainInfoMap.put("infoDTO", infoDTO); // DTO값
		MainInfoMap.put("mainImg", mainImg); // String
		MainInfoMap.put("storeImg", storeImg); // List
		MainInfoMap.put("totalBookmark", totalBookmark); // Integer
		MainInfoMap.put("totalreview", totalreview); // Integer
		MainInfoMap.put("totalreview", totalreview); // Integer
		MainInfoMap.put("scoreAvr", scoreAvr); // Integer
		MainInfoMap.put("reviewImg", reviewImg); // List
		
		return MainInfoMap;
	    }



	public Map<String, Object> storeInfo(String store_id) {
		Map<String, Object> infoMap = new HashMap<String, Object>();

		storeInfoDTO infoDTO = mapper.storeInfo(store_id);

		if(infoDTO.getStore_zip() != null) {
			String[] businHours = infoDTO.getStore_business_hours().split("/");
			int lastNum = businHours.length - 1;
			String hours =  businHours[0] + " ~ " + businHours[lastNum];
			infoDTO.setStore_business_hours(hours);
		String imgPath = mapper.storeImgMain(store_id);
		String mainImg = mainImgname(imgPath);
		
		infoMap.put("dto", infoDTO);
		infoMap.put("mainImg", mainImg);
		
		}else {
			infoMap = null;
		}

		
		return infoMap;
	}


	public Map<String, Object> jjim(HttpServletRequest request, String store_id) {

		HttpSession session = request.getSession();
	    String user_id = (String) session.getAttribute("userId");
		String storeId = (String) session.getAttribute("storeId");



	    int result01=0, result02=0;
	    int num=0;
	    Map<String, Object> Jmap = new HashMap<>();

	    if(storeId != null) {
	    	Jmap.put("result", 0);
	    	Jmap.put("msg", "사업자 회원은 찜하기를 할 수 없습니다.");
	    	Jmap.put("url", "member/login");

	    	return Jmap;
	    }else if(user_id == null) {
			Jmap.put("result", 0);
			Jmap.put("msg", "회원 로그인이 필요한 서비스입니다");
			Jmap.put("url", "member/login");

	        return Jmap;
	    }else {
	    	result01 = mapper.jjimchk(user_id, store_id);

	    	if(result01 == 1){
	    		result02 = mapper.jjimcancle(user_id, store_id);

	    		if(result02 == 0) {
	    			Jmap.put("result", 0);
	    			Jmap.put("msg", "찜 취소 실패\n고객센터로 문의주세요");
	    			Jmap.put("url", "store/store");

	    	        return Jmap;
	    		}else {
	    			Jmap.put("result", 1);
	    			Jmap.put("msg", "찜이 취소되었습니다");

	    			return Jmap;
	    		}

	    	}else {
	    		num = mapper.jjim(user_id, store_id);

	    		if(num == 1) {
	    			Jmap.put("result", 1);
	    			Jmap.put("msg", "가게를 찜했습니다");

	    			return Jmap;
	    		}else {
	    			Jmap.put("result", 0);
	    			Jmap.put("msg", "찜 실패\n고객센터로 문의주세요");
	    			Jmap.put("url", "store/store");

	    			return Jmap;
	    		}
	    	}
	    }
	}

	public List<storeMenuDTO> storeMenu(String store_id) {
		List<storeMenuDTO> menuDTO = mapper.storeMenu(store_id);
		
		if(menuDTO.isEmpty()) {
			menuDTO = null;
			return menuDTO;
		}else {
		menuDTO = (menuImg(menuDTO));
		return menuDTO;
		}
	}


	public List<reviewNumDTO> storeReview(String store_id){
		List<storeReviewDTO> reviewDTO = mapper.storeReview(store_id);
		List<reviewNumDTO> numDTO = new ArrayList<reviewNumDTO>();
		
		if(reviewDTO.isEmpty()) {
			numDTO = null;
			return numDTO;
		}
		
		List<storeReviewImgDTO> reviewImgDTO = mapper.reviewImage(store_id);
		String matchID = null;
		String memberImgPath = null;
		String memberImg = null;
	
			for (storeReviewDTO reviewNum : reviewDTO) {
			matchID = reviewNum.getMember_id();
			memberImgPath = mapper.memberInfo(matchID);
				if(memberImgPath == null) {
					memberImg = "non";
				}else {
					memberImg = mainImgname(memberImgPath);
				}
			int revNum = reviewNum.getStore_review_num();
			
				for (storeReviewImgDTO imageNum : reviewImgDTO) {
					int imgNum = imageNum.getStore_review_num();
						
						if(revNum == imgNum) {
						    reviewNumDTO num = new reviewNumDTO();
			                num.setStore_review_num(revNum);
			                num.setStore_id(store_id);
			                num.setMember_id(reviewNum.getMember_id());
			                num.setStore_review_body(reviewNum.getStore_review_body());
			                num.setStore_review_date_create(reviewNum.getStore_review_date_create());
			                num.setStore_review_score(reviewNum.getStore_review_score());
			                num.setBooking_id(reviewNum.getBooking_id());
			                String imgPath = mainImgname(imageNum.getStore_review_img_image());
			                num.setStore_review_img_image(imgPath);
			                num.setMember_img(memberImg);
			                
			                numDTO.add(num);
						}

					}
				}	
		return numDTO;
	}


	public  Map<String, Object> photos (String store_id) {

		List<String> storeImg = new ArrayList<>();
		List<String> reviewImg = new ArrayList<>();
		storeImg = mapper.storeImg(store_id);
		reviewImg = mapper.storeReviewImg(store_id);

		storeImg = Imgsname(storeImg);
		reviewImg = reviewImage(reviewImg);

		Map<String, Object> photoMap = new HashMap<>();
		photoMap.put("storeImg", storeImg);
		photoMap.put("reviewImg", reviewImg);

		return photoMap;

	}

	public String storeMap(String store_id) {

		infoDTO = mapper.storeInfo(store_id);
		String storeAdd = infoDTO.getStore_add();

		return storeAdd;

	}






	//-------------------------------------------


	public int averageScore(List<storeReviewDTO> review) {
		if(review.size() == 0) {
			return 0;
		}else {
			int total = 0;

			for(storeReviewDTO score : review) {
				total += score.getStore_review_score();
			}
			int avr = total / review.size();
			return avr;
		}
	}


	public String statefix(String store_add) {

	    String[] parts = store_add.split(" ");
	    String state = parts[1];// 서울 가나다 > 가나다 할당 (인덱스 1번에 해당하는 문장)
	    String stateFix = state.substring(0, 2); // 가나다 > 가나 만 할당 (인덱스 0번부터 1번까지)
	    /* 안전한 변환을 위해 체크를 해서 할당하는 방식도 있으나 주소가 일관되게 들어오므로 체크없이 할당함
	    String state = parts.length > 1 ? parts[1] : "";
	    String statePrefix = state.length() >= 2 ? state.substring(0, 2) : "";
	    */

	    return stateFix;
	}

	   public static String mainImgname(String mainImg) {
	    	String[] parts = mainImg.split("\\\\");
	        String splitImgPath = parts[parts.length - 1];
	        // 분할한 파일경로의 마지막이 파일 이름이므로 배열의 마지막요소 할당

	        return splitImgPath;
	    }


	    public static List<String> Imgsname(List<String> storeImg) {
	    	 List<String> fileNames = new ArrayList<>();

	    	    for (String imgPath : storeImg) {
	    	        // 파일 경로를 역슬래시(\\) 또는 슬래시(/)로 분할하여 배열로 변환
	    	        String[] parts = imgPath.split("\\\\");
	    	        String fileName = parts[parts.length - 1];

	    	        fileNames.add(fileName);
	    	    }

	    	    return fileNames;
	    	}

	    public static List<String> reviewImage (List<String> reviewImg) {
	    	List<String> fileNames = new ArrayList<>();

	    	for (String imgPath : reviewImg) {
	    		// 파일 경로를 역슬래시(\\) 또는 슬래시(/)로 분할하여 배열로 변환
	    		String[] parts = imgPath.split("\\\\");
	    		String fileName = parts[parts.length - 1];

	    		fileNames.add(fileName);
	    	}

	    	return fileNames;
	    }


	public static List<storeMenuDTO> menuImg(List<storeMenuDTO> menuDTO) {

    	for (storeMenuDTO imgPath : menuDTO) {
    		// 파일 경로를 역슬래시(\\) 또는 슬래시(/)로 분할하여 배열로 변환
    		String[] parts = imgPath.getStore_menu_img().split("\\\\");
    		String fileName = parts[parts.length - 1];

    		imgPath.setStore_menu_img(fileName);
    	}

    	return menuDTO;
    }
	// 민석
	public String phone(String user_id) {
		String result = mapper.phone(user_id);
		System.out.println("user_id : " + user_id);
		return result;
	}


	/*

	 */
}
