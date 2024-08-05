package com.hub.root.businessM.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.hub.root.businessM.DTO.BookPageDTO;
import com.hub.root.businessM.DTO.ReservationDTO;
import com.hub.root.businessM.DTO.businMDTO;
import com.hub.root.businessM.DTO.businMMenuDTO;
import com.hub.root.businessM.DTO.businMPhotoDTO;
import com.hub.root.businessM.DTO.storeReviewDTO;
import com.hub.root.businessM.mybatis.businMMapper;

@Service
public class businMService {
	private final businMMapper mapper;

	@Autowired
    public businMService(businMMapper mapper) {
        this.mapper = mapper;
    }

	public String businMChk(String store_id) {
		businMDTO result = null;
		try {
			result = mapper.businMChk(store_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("보선-회원체크 mapper에서 나온 store_name : " + result.getStore_name());
		return result.getStore_name();
	}


	public String register01(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
	    String store_id = (String) session.getAttribute("storeId");
		String storeName = businMChk(store_id);
		if(storeName == null) {
			request.setAttribute("msg", "회원정보가 잘못 되었습니다.\n고객센터로 문의 바랍니다");
	        request.setAttribute("url", "storeInfo");

	        return "businessM/businMalert";
		}

		model.addAttribute("storeName", storeName);
		model.addAttribute("storeId", store_id);

		return "businessM/store/register01";
	}

	public String register02(HttpServletRequest request, Model model, String store_name) {

		HttpSession session = request.getSession();
		String store_id = (String) session.getAttribute("storeId");
		String storeName = businMChk(store_id);

		if(!storeName.equals(store_name)) {
			request.setAttribute("msg", "가게이름이 다릅니다. 다시 시도해주세요");
	        request.setAttribute("url", "register01");

	        return "businessM/businMalert";
		}
		
		businMDTO dto = mapper.businMChk2(store_id);
		if(dto.getStore_zip() != null) {
			model.addAttribute("dto", dto);
			return "businessM/store/register02";
		}else {
			return "businessM/store/register02";
		}	
	}

	public String register03(HttpServletRequest request, Model model, String store_zip,
								String store_add, String store_add_info) {
		
		HttpSession session = request.getSession();
		session.setAttribute("store_zip", store_zip);
		session.setAttribute("store_add", store_add);
		session.setAttribute("store_add_info", store_add_info);

		String store_id = (String) session.getAttribute("storeId");
		String storeName = businMChk(store_id);
		
		businMDTO dto = mapper.businMChk2(store_id);
		if(dto.getStore_zip() != null) {
		
		    String storeCategory = dto.getStore_category();
		    String otherCategory = "";
		    	
		    if (storeCategory != null) {
		        String[] categories = storeCategory.split("/");
		        List<String> categoryList = Arrays.asList(categories);
		        otherCategory = categoryList.stream()
                  .filter(cat -> !cat.equals("한식") && !cat.equals("양식") 
                		  && !cat.equals("중식") && !cat.equals("일식")
                		  && !cat.equals("뷔페") && !cat.equals("카페")
                		  && !cat.equals("디저트"))
                  .collect(Collectors.joining(", "));
		    }
		    
		    String storeAmenities = dto.getStore_amenities();
		    String otherAmenities = "";
		    
		    if (storeAmenities != null) {
		    	String[] amenities = storeAmenities.split("/");
		    	List<String> amenitiesList = Arrays.asList(amenities);
		    	otherAmenities = amenitiesList.stream()
		    			.filter(cat -> !cat.equals("포장") && !cat.equals("주차") 
		    					&& !cat.equals("화장실") && !cat.equals("인터넷")
		    					&& !cat.equals("아기의자") && !cat.equals("장애인")
		    					&& !cat.equals("수유방") && !cat.equals("놀이시설"))
		    			.collect(Collectors.joining(", "));
		    }
	
			model.addAttribute("dto", dto);
			model.addAttribute("otherCategory",otherCategory);
			model.addAttribute("otherAmenities",otherAmenities);
			return "businessM/store/register03";
		}else {
			return "businessM/store/register03";
		}	
	}

	public String register04(HttpServletRequest request, Model model, String store_introduce,
								String[] store_categoryS, String[] store_amenitiesS, String store_note,
								int store_max_person, String store_booking_rule) {
		HttpSession session = request.getSession();
		session.setAttribute("store_introduce", store_introduce);
		String store_category = String.join("/", store_categoryS);
		store_category = store_category.replace("기타/", "");
		session.setAttribute("store_category", store_category);
		//List<String> amenityList = Arrays.asList(store_amenities.split(","));
		String store_amenities = String.join("/", store_amenitiesS);
		store_amenities = store_amenities.replace("기타/", "");
		session.setAttribute("store_amenities", store_amenities);
		session.setAttribute("store_note", store_note);
		session.setAttribute("store_max_person", store_max_person);
		session.setAttribute("store_booking_rule", store_booking_rule);

		String store_id = (String) session.getAttribute("storeId");
		
		businMDTO dto = mapper.businMChk2(store_id);
		if(dto.getStore_zip() != null) {
			model.addAttribute("dto", dto);
			return "businessM/store/register04";
		}else {
			return "businessM/store/register04";
		}	
	}

	public String registerFinish(businMDTO dto, HttpServletRequest request,
						String[] store_business_hours) {
		HttpSession session = request.getSession(false); // 세션이 없으면 null 반환

	    if (session != null) {
		Enumeration<String> attributeNames = session.getAttributeNames();

			//attributeNames 세션의 모든 이름(키)을 가져옴, attributeValue 세션의 모든 값을 가져옴
	        while (attributeNames.hasMoreElements()) {
	            String attributeName = attributeNames.nextElement();
	            Object attributeValue = session.getAttribute(attributeName);
	            System.out.println("보선-가게등록용 세션 " + attributeName + "의 값: " + attributeValue);
	        }
	    }

	    dto.setStore_id((String) session.getAttribute("storeId"));
	    dto.setStore_zip((String) session.getAttribute("store_zip"));
	    dto.setStore_add((String) session.getAttribute("store_add"));
	    dto.setStore_add_info((String) session.getAttribute("store_add_info"));
	    dto.setStore_introduce((String) session.getAttribute("store_introduce"));
	    dto.setStore_category((String) session.getAttribute("store_category"));
	    dto.setStore_amenities((String)session.getAttribute("store_amenities"));
	    dto.setStore_note((String) session.getAttribute("store_note"));
	    dto.setStore_max_person((Integer) session.getAttribute("store_max_person"));
	    dto.setStore_booking_rule((String) session.getAttribute("store_booking_rule"));
	    String store_business_hoursS = String.join("/", store_business_hours);
	    dto.setStore_business_hours(store_business_hoursS);

		int row;
		try {
			row = register(dto);
			if(row == 0) {
				request.setAttribute("msg", "문제 발생\n다시 시도해주세요");
		        request.setAttribute("url", "register01");

		        return "businessM/businMalert";
			}else {
				System.out.println("보선-가게등록 업뎃 성공");
			}
		} catch (IOException e) {
			e.printStackTrace();

		}
		// 세션 전체 삭제 (invalidate)
		// session.invalidate();

		// 세션에서 데이터 삭제
		session.removeAttribute("store_zip");
		session.removeAttribute("store_add");
		session.removeAttribute("store_add_info");
		session.removeAttribute("store_introduce");
		session.removeAttribute("store_category");
		session.removeAttribute("store_amenities");
		session.removeAttribute("store_note");
		session.removeAttribute("store_max_person");
		session.removeAttribute("store_booking_rule");

		Enumeration<String> attributeNames1 = session.getAttributeNames();
		while (attributeNames1.hasMoreElements()) {
			String attributeName = attributeNames1.nextElement();
			Object attributeValue = session.getAttribute(attributeName);
			System.out.println("\n보선-가게등록 완료 후 세션 " + attributeName + "의 값: " + attributeValue);
		}

		return "businessM/store/registerFinish";
	}


	public int register(businMDTO dto) throws IOException {

		int result = mapper.register(dto);

		return result;

	}

	public businMDTO infoChk(String store_id) {
		businMDTO dto = new businMDTO();
		try {
			dto = mapper.infoChk(store_id);
			if(dto != null) {
				String[] businHours = dto.getStore_business_hours().split("/");
				int lastNum = businHours.length - 1;
				String hours =  businHours[0] + " ~ " + businHours[lastNum];
				dto.setStore_business_hours(hours);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	public List<businMMenuDTO> menuChk(String store_id) {
		List<businMMenuDTO> dto = new ArrayList<businMMenuDTO>();
			try {
				dto = mapper.menuChk(store_id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(!dto.isEmpty()) {
				System.out.println("보선-기존 메뉴 존재");
				for(int i=0 ; dto.size() > i ; i++) {
					String menuImgPath = null;
					menuImgPath = saveFileAndGetPath_Menu(dto.get(i).getStore_menu_img());
					dto.get(i).setStore_menu_img(menuImgPath);
				}
			}else {
				dto = null;
			}
			return dto;	
	}
	
	public String photoChk(Model model, String store_id){
		
		List<businMPhotoDTO> dto = new ArrayList<businMPhotoDTO>();
		Map<String, Object> PMap = new HashMap<String, Object>();
		
		String storeMainImage = mapper.photoMainChk(store_id);
		if(storeMainImage != null) {
			storeMainImage = saveFileAndGetPath_Menu(storeMainImage);	
		}else {
			storeMainImage = null;
			PMap = null;
			model.addAttribute("PMap", PMap);
			return "businessM/info/photoInfo";
		}
		
		dto = mapper.photoChk(store_id);
		if(!dto.isEmpty()) {
			String imgPath = null;
			for(int i=0 ; dto.size() > i ; i++) {
				imgPath = saveFileAndGetPath_Menu(dto.get(i).getStore_img_root());
				dto.get(i).setStore_img_root(imgPath);	
			}	
		}else {
			dto = null;
		}
		
		PMap.put("dto", dto);
		PMap.put("storeMainImage", storeMainImage);
		model.addAttribute("PMap", PMap);
		
		return "businessM/info/photoInfo";
	}

	
	
	

	// 구현 추가
	public String DOWNLOAD_FOLDER = "C:/tablehub_image/businessM";

	//이미지 저장경로 \\\\192.168.42.40\\공유폴더\\tableHub\\businessM
	// 업로드된 파일을 저장할 경로

	private static String UPLOAD_FOLDER = "C:/tablehub_image/businessM";

	//private static String UPLOAD_FOLDER = "C:/tablehub_image/businessM"; //수정

	public String storeImage(HttpServletRequest request,
				MultipartFile file01, MultipartFile file02, MultipartFile file03,
				MultipartFile file04, MultipartFile file05) {
		   try {
	            // 업로드 폴더가 없을 경우 생성
	            if (!Files.exists(Paths.get(UPLOAD_FOLDER))) {
	                Files.createDirectories(Paths.get(UPLOAD_FOLDER));
	            }
	        
	        String file01Path=null, file02Path=null, file03Path=null, file04Path=null, file05Path=null;
            // 각 파일을 업로드 폴더에 저장
	        if(!file01.isEmpty()) {
	        	file01Path = saveFileAndGetPath(file01);
	        }if(!file02.isEmpty()) {
	        	file02Path = saveFileAndGetPath(file02);
	        }if(!file03.isEmpty()) {
	        	file03Path = saveFileAndGetPath(file03);
		   	}if(!file04.isEmpty()) {
	        	file04Path = saveFileAndGetPath(file04);
			}if(!file05.isEmpty()) {
	        	file05Path = saveFileAndGetPath(file05);
			}
			
            System.out.println("보선-값이 들어온 사진은? : \n 01 : "+file01Path+"\n 02 : "+file02Path+"\n 03 : "+file03Path
            					+"\n 04 : "+file04Path+"\n 05 : "+file05Path);

            HttpSession session = request.getSession();
            String store_id = (String) session.getAttribute("storeId");
            System.out.println("보선-세션 아이디 store_id 확인 : "+store_id);

            int result02 = mapper.storeImageDelete(store_id);
            if(result02>0) {
            	System.out.println("기존 이미지 삭제");
            }else {
            	System.out.println("기존 이미지 없음");
            }


            String[] arr = {file01Path, file02Path, file03Path, file04Path, file05Path};
            List<String> FilePaths = new ArrayList<>();

            for (String path  : arr) {
            	if (path  != null) {
            		FilePaths.add(path );
            	}
            }

            Map<String, Object> param = new HashMap<>();
            param.put("FilePaths", FilePaths);   // FilePaths는 List<String> 타입
            param.put("store_id", store_id);     // store_id는 String 타입

            //맵 로그 뽑기
            for (Entry<String, Object> entry : param.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                System.out.println("\n보선- Key: " + key + ", Value: " + value);
            }

            int result01 = mapper.storeImage01(param);

            System.out.println("보선-사진 등록및수정 갯수 : "+result01);
	         if(result01 > 0)
	            	return "businessM/photo/photoRFinish";
	         else {
	            	request.setAttribute("msg", "오류발생\n 사진이 등록되지 않았습니다.\n 다시 시도해주세요");
	    	        request.setAttribute("url", "businessM/menu/menuRegister");
	    	        return "businessM/businMalert";
	         }
	        } catch (Exception e) {
	            e.printStackTrace();
	            return "파일 업로드 실패: " + e.getMessage();
	        }

	    }

	// 파일을 저장하는 메서드
	private String saveFileAndGetPath(MultipartFile file) throws IOException {
		if (file != null) {
	        byte[] bytes = file.getBytes();
	        /* 파일을 바이트 배열로 변환하는 이유는 파일을 읽거나 다루기 쉽게 하기 위함입니다.
	         * 예를 들어 파일을 디스크에 저장할 때나 네트워크를 통해 전송할 때는 바이트 배열 형태로 변환하여 다루는 것이 일반적. */

	        String uniqueFileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	        Path path = Paths.get(UPLOAD_FOLDER + "/" + uniqueFileName);
	        Files.write(path, bytes);
	        return path.toString();
	    }
	    return "non";
	}
	
	   public static String saveFileAndGetPath_Menu(String mainImg) {
	    	String[] parts = mainImg.split("\\\\");
	        String splitImgPath = parts[parts.length - 1];
	        // 분할한 파일경로의 마지막이 파일 이름이므로 배열의 마지막요소 할당

	        return splitImgPath;
	    }
	
	
	public String menuRegisterChk(HttpServletRequest request, MultipartHttpServletRequest mul,
			String store_id){
		List<businMMenuDTO> dto = new ArrayList<businMMenuDTO>();
		dto = mapper.menuChk(store_id);
			if(!dto.isEmpty()) {
				System.out.println("기존 메뉴 존재");
				/*
				  for(int i =0 ; dto.size() < i ; i++ ) {
					File file = new File(dto.get(i).getStore_menu_img());
			        
			    		if(file.delete()){
			    			System.out.println("파일삭제 성공");
			    		}else{
			    			System.out.println("파일삭제 실패");
			    		}
					}
			    		*/
				int menuDel = mapper.menuDel(store_id);
					if(menuDel > 0) {
						System.out.println("보선-메뉴 수정을 위한 삭제 완료");
						String result = menuRegister(request, mul, store_id);
						return result;
					}else {
						request.setAttribute("msg", "오류발생\n 메뉴를 수정할 수 없습니다.\n 고객센터로 문의바랍니다");
						request.setAttribute("url", "businessM/menu/menuRegister");
						return "businessM/businMalert";
					}
			}else {
				
			System.out.println("보선-기존메뉴 없음. 메뉴등록 시작");
			String result = menuRegister(request, mul, store_id);
			return result;
			}
	}

	public String menuRegister(HttpServletRequest request, MultipartHttpServletRequest mul,
							String store_id){

		int rowCount = Integer.parseInt(request.getParameter("rowCount"));
		System.out.println("보선-등록하는 메뉴 갯수 : "+ (rowCount));
		/*
		System.out.println("보선-파일이름 있냐!!!!!!"+  request.getParameter("menu_photo")
						+"\n null? : "+ (request.getParameter("menu_photo") == null )
			
						);
				*/
		
		List<String> categories = new ArrayList<>();
		List<String> names = new ArrayList<>();
		List<Integer> prices = new ArrayList<>();
		List<String> photos = new ArrayList<>();
		List<String> notes = new ArrayList<>();

		for (int i = 0; i < rowCount; i++) {
			try {
			String category = request.getParameter("menu_category" + i);
			String name = request.getParameter("menu_name" + i);
			String priceStr = request.getParameter("menu_price" + i);
	        Integer price = null;
	        String note = request.getParameter("menu_note" + i);
	        String file;
	        MultipartFile filePath = ((MultipartRequest) mul).getFile("menu_photo" + i);
	        System.out.println("보선-!!!파일 이름!!"+ filePath
	        			+"\n 멀티 : "+((MultipartRequest) mul).getFile("menu_photo" + i)
	        			+"\n 파라미터 : "+request.getParameter("menu_photo")
	        			);
	        MultipartFile fileName = mul.getFile("menu_photo");
	        if(fileName == null) {
	        	System.out.println("파일 없음");
	        }else {
	        	String Name = fileName.getOriginalFilename().toString();
	        	
	        }

	            if (priceStr != null && !priceStr.trim().isEmpty()) {
	                price = Integer.parseInt(priceStr.trim());
	            } else {
	                System.out.println("보선-Invalid price value: " + priceStr);
	                // 예외 처리 또는 기본값 설정
	            }
	            
            
	            if(fileName == null) {
	            	file = "default.jpg";
	            }else {
	            	file = saveFileAndGetPath(filePath);
	            }
			  
			  categories.add(category);
			  names.add(name);
			  prices.add(price);
			  notes.add(note);
			  photos.add(file);
			  
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		Map<String, Object> menuparam = new HashMap<>();
		menuparam.put("store_id", store_id);
		menuparam.put("categories", categories);
		menuparam.put("names", names);
		menuparam.put("prices", prices);
		menuparam.put("notes", notes);
		menuparam.put("photos", photos);
		
		System.out.println("보선-메뉴리스트들 확인 \n카테고리 : "+ categories+"\n이름 : "+names
		  +"\n가격 : "+prices+"\n설명 : "+notes+"\n사진경로 : "+photos);
		
		int result = mapper.menuRegister(menuparam);
			if(result > 0)
				return "businessM/menu/menuRFinish";
			else {
				request.setAttribute("msg", "오류발생\n 사진이 등록되지 않았습니다.\n 다시 시도해주세요");
				request.setAttribute("url", "/businessM/menuRgister");
				
				return "businessM/businMalert";
			}



}

	
	
	
	
	
	


//----------------- 민석 서비스

	public List<BookPageDTO> book(int page, String store_id, String type) {

		int start = (page - 1) * 8 + 1;
		int end = page * 8;

		System.out.println("값 확인!!!!!" + start);
		System.out.println("값 확인!!!!!" + end);

		List<BookPageDTO> list= mapper.book(start, end, store_id, type);

		System.out.println(list.size());

		return list;
	}

	public int totalPage(String store_id, String type) {
		int result = mapper.totalPage(store_id, type);

		return result;
	}


//------------------------------ 구현 작업 내용

	public Map<String, Object> getReview(String storeId, int curPage) {
		int totalReview = mapper.getTotalReview(storeId);
		System.out.println("TotalReview : " + totalReview);

		// 리뷰의 총 갯수를 이용하여 페이징 처리 작업
		Map<String, Object> map = pageCalc(totalReview, curPage);

		// 해당되는 페이지에 맞춰 데이터 불러오기
		List<storeReviewDTO> list = mapper.getReview(storeId,
													(int)map.get("startNum"),
													(int)map.get("endNum") );
		map.put("list", list);
		return map;
	}

	// getReview에서 불러온 데이터에서 다른 db를 참조해야하는 부분들의 정보를 불러옴
	public Map<String, Object> getReviewDetail(String memId, int reviewNum) {
		Map<String, Object> map = mapper.getReviewDetail(memId, reviewNum);
		return map;
	}

	// getReview 페이징 처리
	private Map<String, Object> pageCalc(int totalReview, int curPage) {
		Map<String, Object> map = new HashMap<>();

		// 한 페이지에 6개의 컨텐츠 표시
		int viewCont = 6;

		// 페이지의 시작, 끝 번호
		int startNum = curPage * viewCont - (viewCont - 1);
		int endNum = curPage * viewCont;
		int totalPage = (totalReview / viewCont) + ((totalReview % viewCont) == 0 ? 0 : 1);

		map.put("viewCont", viewCont);
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		map.put("totalReview", totalReview);
		map.put("curPage", curPage);
		map.put("totalPage", totalPage);

		return map;
	}

	public Map<String, Object> deleteReview(int[] reviews) {
		Map<String, Object> map = new HashMap<>();
		int result = mapper.deleteReview(reviews);
		String msg = "";

		if (result == 0) {
			msg = "삭제하는 중 문제가 발생하였습니다. 새로고침 후 다시 시도해주세요";
		} else {
			msg = "삭제가 완료되었습니다.";
		}

		map.put("msg", msg);

		return map;
	}


//------------------- 민석 추가
	public ReservationDTO reservationInfo(String store_id)
	{
		ReservationDTO dto = mapper.reservationInfo(store_id);

		return dto;
	}
}




