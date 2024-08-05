<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="<%= request.getContextPath() %>" />
<c:set var="keyword" value="${param.keyword }" />
<c:set var="searchType" value="${param.searchType }" />
<c:set var="category" value="${param.category }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/main/mainPage2.css?after"/>
<script  type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@splidejs/splide@3/dist/js/splide.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=da3de66ef64ff42d5b0dc40d2235b72a&libraries=services"></script>
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans:400" rel="stylesheet">
 
<%@ include file="./header.jsp" %>
</head>
<body>
	<div class="page">
		<div class="main-container">
			<!-- ===== left side ===== -->
			<div class="main-items left-item">
				
				<!-- ===== navbar ===== -->
				<div class="nav-container">
					<nav class="nav-main">
						<form id="sortFormPopularity" action="${path }/main/mainPage2" method="get">
							<input type="hidden" name="sortType" value="popularity"> 
							<button type="submit" class="nav-item">인기순</button>
						</form>
					</nav>
					<nav class="nav-main">
						<form id="sortFormReview" action="${path }/main/mainPage2" method="get">
							<input type="hidden" name="sortType" value="review"> 
							<button type="submit" class="nav-item">리뷰순</button>
						</form>
					</nav>
				</div>
				
				<!-- ===== 위치가져오기, 상세보기 부분 ===== -->
				
				<div class="location-condition">
					<button class="loc_btn" >현 위치로 설정</button>
					<button class="loc_btn1" onclick="getOtherLocation()">다른 지역 선택</button>
				</div>
				
				<c:choose>
			    	<c:when test="${not empty storeList}">
					<div class="location-condition">		
						<c:if test="${not empty storeList[0].store_category}">
	                        <span># 
	                        <c:set var="seenCategories" value="" />
	                        
	                        <!-- 특정 카테고리로 검색 시 -->
	                        <c:forEach var="category" items="${fn:split(storeList[0].store_category, '/')}">
	                            <c:if test="${fn:contains(category, param.keyword)}">
	                                <c:if test="${not fn:contains(seenCategories, category)}">
	                                    <c:if test="${!empty seenCategories}">
	                                        /
	                                    </c:if>
	                                    ${category}
	                                    <c:set var="seenCategories" value="${seenCategories}${category}/" />
	                                </c:if>
	                            </c:if>
	                        </c:forEach>
	                        
	                        <!-- "ALL" 또는  메뉴 이름으로 검색 시 모든 카테고리 출력 -->
	                        <c:if test="${param.searchType == 'menu_name' || param.searchType == 'all' || param.searchType == null}">
                                <c:if test="${not fn:contains(seenCategories, keyword)}">
                                    <c:if test="${!empty seenCategories}">
                                        /
                                    </c:if>
                                    ${keyword}
                                    <c:set var="seenCategories" value="${seenCategories}${keyword}/" />
                                </c:if>
	                        </c:if>
                        	</span><br>
                 	    </c:if>
					</div>
				
				<!-- ===== 메뉴 상세보기 부분 ===== -->
				<c:forEach var="store" items="${storeList}" varStatus="status">
		            <div class="menu-detail" id="listItem${status.index}" >
		                <div class="detail-container-left">
		                    <div class="menu-detail-imgBig">
							    <c:if test="${not empty storeImgList[status.index]}">
							        <img class="imgBig" src="${path}/businessM/download?img=${fn:substringAfter(storeImgList[status.index].store_img_root, 'C:\\tablehub_image\\businessM\\')}" alt="Store Image">  
							    	<!-- <img class="imgBig" src="C:\\tablehub_image\\businessM\\${storeImgList[status.index].store_img_root}" alt="Store Image">-->
							    </c:if>
							</div>
							<div class="menu-detail-imgSmall">
								<c:forEach var="smallImg" items="${storeSmallImgLists[status.index]}" begin="0" end="2">
							        <c:if test="${not empty smallImg}">
							            <div class="imgSmall1${status.index }">
							                <img class="imgSmall" src="${path}/businessM/download?img=${fn:substringAfter(smallImg.store_img_root, 'C:\\tablehub_image\\businessM\\')}" alt="Store Menu Image">
							            	<!-- <img class="imgSmall" src="C:\\tablehub_image\\businessM\\${smallImg.store_img_root}" alt="Store Menu Image"> -->
							            </div>
							        </c:if>
							  	</c:forEach>
							</div>
		                </div>
                               <div class="detail-container-right">
                                   <c:if test="${not empty store.store_name}">
                                       <span>가게 이름 : ${store.store_name}</span><br>
                                   </c:if>
                                   <c:if test="${not empty store.store_phone}">
                                       <span>전화번호 : ${store.store_phone}</span><br>
                                   </c:if>
                                   <c:if test="${not empty store.store_main_phone}">
                                       <span>대표 전화번호 : ${store.store_main_phone}</span><br>
                                   </c:if>
                                   <c:if test="${not empty store.store_add}">
                                       <span>주소 : ${store.store_add}</span><br>
                                   </c:if>
                                   <c:if test="${not empty store.store_add_info}">
                                       <span>상세 주소 : ${store.store_add_info}</span><br>
                                   </c:if>
                                   <c:if test="${not empty store.store_category}">
		                        <span>카테고리 : 
		                        <c:set var="seenCategories" value="" />
		                        
		                        <!-- 특정 카테고리로 검색 시 -->
		                        <c:forEach var="category" items="${fn:split(store.store_category, '/')}">
		                            <c:if test="${fn:contains(category, param.keyword)}">
		                                <c:if test="${not fn:contains(seenCategories, category)}">
		                                    <c:if test="${!empty seenCategories}">
		                                        /
		                                    </c:if>
		                                    ${category}
		                                    <c:set var="seenCategories" value="${seenCategories}${category}/" />
		                                </c:if>
		                            </c:if>
		                        </c:forEach>
		                        
		                        <!-- "ALL" 또는  메뉴 이름으로 검색 시 모든 카테고리 출력 -->
		                        <c:if test="${param.searchType == 'menu_name' || param.searchType == 'all' || param.searchType == null}">
		                            <c:forEach var="category" items="${fn:split(store.store_category, '/')}">
		                                <c:if test="${not fn:contains(seenCategories, category)}">
		                                    <c:if test="${!empty seenCategories}">
		                                        /
		                                    </c:if>
		                                    ${category}
		                                    <c:set var="seenCategories" value="${seenCategories}${category}/" />
		                                </c:if>
		                            </c:forEach>
		                        </c:if>
		                        </span><br>
		                 	    </c:if>
                                   <c:if test="${not empty store.store_note}">
                                       <span>메모 : ${store.store_note}</span><br>
                                   </c:if>
                                   <c:if test="${not empty store.store_introduce}">
                                       <span>소개 : ${store.store_introduce}</span><br>
                                   </c:if>
                                   <c:if test="${not empty store.store_business_hours}">
                                       <span>영업 시간 : ${store.store_business_hours}</span><br>
                                   </c:if>
                                   <a href="${path}/store?store_id=${store.store_id}" class="detail-link">상세 페이지로 이동</a>
                               </div>
                           </div>
                       </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <br><br><p>검색 결과가 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
			
			<!-- ===== right side ===== -->
	        <div class="main-items right-itme">
	            <div class="map_wrap">
	                <div id="map"></div>
	            </div> 
            </div>
	    </div>
	</div>
<%@ include file="./footer.jsp" %> 
</body>
</html>



<script>

document.addEventListener("DOMContentLoaded", function() {
    const mapContainer = document.getElementById('map'); // 지도를 표시할 div
    const mapOption = { 
        center: new kakao.maps.LatLng(37.5665, 126.9780), // 초기 중심좌표 (서울 중심으로 설정)
        level: 3 // 지도의 확대 레벨
    };  

    // 지도를 생성합니다
    const map = new kakao.maps.Map(mapContainer, mapOption); 

    // 마커를 생성합니다
    const userMarker = new kakao.maps.Marker({
        position: map.getCenter(), // 마커의 위치를 지도 중심으로 설정합니다
        //map: map // 마커를 지도 위에 표시합니다
    });

    // 기본 위치 마커를 숨깁니다
    userMarker.setMap(null);
    
    // 현재 위치 가져오기 버튼 이벤트
    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                const lat = position.coords.latitude;
                const lon = position.coords.longitude;
                const locPosition = new kakao.maps.LatLng(lat, lon);
                
                // 마커 위치를 현재 위치로 변경합니다
                userMarker.setPosition(locPosition);
           		// 마커를 지도에 표시합니다
                userMarker.setMap(map); 
                // 지도 중심을 현재 위치로 변경합니다
                map.setCenter(locPosition);

                // 인포윈도우를 현재 위치로 표시합니다
                const message = '<div style="padding:5px;">현재 위치</div>';
                displayMarker(locPosition, message);
            }, function(error) {
                console.error("Error occurred. Error code: " + error.code);
                const locPosition = new kakao.maps.LatLng(37.5665, 126.9780); // 기본 위치 (서울 중심)
                const message = '현재 위치를 알 수 없어 기본 위치로 이동합니다.';
                displayMarker(locPosition, message);
            },{
            	enableHighAccuracy: false, // 정확도 높이기 옵션
                timeout: Infinity, // 위치 요청 타임아웃 설정 (5초)
                maximumAge: 0 // 캐시된 위치 정보를 사용하지 않도록 설정
            });
        } else {
            const locPosition = new kakao.maps.LatLng(37.5665, 126.9780); // 기본 위치 (서울 중심)
            const message = 'GeoLocation을 사용할 수 없습니다.';
            displayMarker(locPosition, message);
        }
    }

    // 기본 위치를 표시하는 함수 정의
    function displayMarker(locPosition, message) {
        // 마커 위치를 설정합니다
        userMarker.setPosition(locPosition);
  	    // 마커를 지도에 표시합니다
        userMarker.setMap(map); 
        map.setCenter(locPosition);
    }

    // 버튼 클릭 이벤트와 getLocation 함수 연결
    document.querySelector('.loc_btn').addEventListener('click', getLocation);

    // 마커와 지도 초기화 관련 코드를 marker 함수로 이동
    marker();
    
    function marker() {
        const key = '${keyword}'; 
        const ser = '${searchType}';
        const cat = '${category}';
        
        //키워드, 검색 유형 및 카테고리에 따라 상점 목록을 가져옴
        fetch("http://localhost:8080/root/mainAPI/storeList?keyword=" + key + "&searchType=" + ser + "&category=" + cat, {
            headers: { "Content-Type": "application/json" },
        })
        .then((response) => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then((res) => {
            console.log("Store List: ", res);

            // 지도 경계 객체 생성
            const bounds = new kakao.maps.LatLngBounds();

            // 각 상점 주소에 대한 좌표를 가져오기 위한 프로미스 배열
            const promises = res.map((store, index) => {
                return fetch("https://dapi.kakao.com/v2/local/search/address.json?query=" + store.store_add, {
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "KakaoAK a3c83c3855b79edaedc0687b23adb436"
                    }
                })
                .then((response) => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok ' + response.statusText);
                    }
                    return response.json();
                })
                .then((data) => {
                    console.log("Address Data for store: ", store.store_name, data);
                    if (data.documents.length > 0) {
                        const roadAddress = data.documents[0].road_address || data.documents[0].address;
                        const x = roadAddress.x;
                        const y = roadAddress.y;

                        return {
                            position: new kakao.maps.LatLng(y, x), // LatLng 객체 생성
                            name: store.store_name,
                            address: store.store_add // 주소 추가
                        };
                    }
                })
                .catch((error) => {
                    console.error("Error fetching address data for store: ", store.store_name, error);
                });
            });

            // 모든 프로미스가 해결될 때까지 기다림
            Promise.all(promises).then(locations => {
                locations.forEach((loc, index) => { // index추가
                    if (loc) {
                        console.log("Adding marker: ", loc);
                        const marker = new kakao.maps.Marker({
                            map: map,
                            position: loc.position // 마커 위치 설정
                        });

                        const infowindow = new kakao.maps.InfoWindow({
                            content: '<div>' + loc.name + '<br>' + loc.address + '</div>' // 주소 추가
                        });

                        // 마커에 마우스를 올렸을 때 정보 창을 표시하는 이벤트
                        kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
                        kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
                        // 마커에 마우스를 올렸을 때 지도를 마커 위치로 이동시키는 이벤트
                        kakao.maps.event.addListener(marker, 'mouseover', function(){
                            map.panTo(loc.position);
                        });
                        
                        // listItem과 상호작용하여 지도를 이동시키는 이벤트
                        const listItem = document.getElementById('listItem' + index);
                        if (listItem) {
                            listItem.addEventListener('mousemove', function() {
                                map.panTo(loc.position);
                                infowindow.open(map, marker);
                            });
                            listItem.addEventListener('mousemove', function() {
                                map.panTo(loc.position);
                                infowindow.close();
                            });
                        }
                            
                        // 지도 경계에 마커의 위치를 포함시킴
                        bounds.extend(loc.position);
                        // 모든 마커를 포함하는 경계로 지도 범위 설정
                        map.setBounds(bounds);
                    }
                });
                
            }).catch((error) => {
                console.error("Error in Promise.all: ", error);
            });
        })
        .catch((error) => {
            console.error("Error fetching store list: ", error);
        });
    }

    function makeOverListener(map, marker, infowindow) {
        return function() {
            infowindow.open(map, marker);
        };
    }

    function makeOutListener(infowindow) {
        return function() {
            infowindow.close();
        };
    }
});


</script>