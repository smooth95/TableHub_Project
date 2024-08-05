<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
let storeAdd = '${dto.store_add}';
let storeZip = '${dto.store_zip}';
console.log("우편번호? : ",storeZip == null,"\n 쌍따옴표 : ",storeZip == "");
</script>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/businessM/businessMstore.css?after">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=f96a93ad7623e257e539c299c4c8fcb6&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f96a93ad7623e257e539c299c4c8fcb6"></script>
<script type="text/javascript" src="${path}/resources/js/businessM/businessMstore.js"></script>

</head>
<body>
<div class="header">
<%@ include file="../../main/header.jsp" %>
</div>

<div class="center-box">
<div class="skill-box">
	<div class="skill-bar">
		<span class="per02">
			<span class="tooltip02">50%</span>
		</span>
	</div>
</div>
    <form action="register03" method="post" onsubmit="return inputcheck01()">
		
	<div class="white_box">
    <h1 class="top_title">주소 등록하기</h1><br>
    <h5>*표시 항목은 필수항목입니다</h5>
    
	<c:choose>
		<c:when test="${dto.store_zip == null }">
	    		<div class="text_leftAlign1">
			<table>
			    <tr>
			    	<td><strong>*우편번호 </strong></td>
			        <td>  <input type="text" id="addr1" name="store_zip" readonly placeholder="우편번호를 검색해주세요"></td>
		        	<td><button type="button" onclick="daumPost()">우편번호 검색</button></td>
			    </tr>
			    <tr>
			    	<td><strong>&nbsp;&nbsp;주&nbsp;&nbsp;소</strong></td>
			    	<td><input type="text" id="addr2" name="store_add" readonly placeholder="주소"></td>
			    </tr>
		   		<tr>
		   			<td><strong>*상세주소</strong></td>
		   			<td><input type="text" id="addr3" name="store_add_info" placeholder="상세주소를 입력해주세요"></td>
		   		</tr>
	   		</table>
	        </div>
	        <div id="map"></div>
	        <hr>
		</c:when>
		<c:otherwise>
		<div class="text_leftAlign1">
		    	<table>
				    <tr>
				    	<td><strong>*우편번호 </strong></td>
				        <td>  <input type="text" id="addr1" name="store_zip" value="${dto.store_zip }"></td>
			        	<td><button type="button" onclick="daumPost()">우편번호 검색</button></td>
				    </tr>
				    <tr>
				    	<td><strong>&nbsp;&nbsp;주&nbsp;&nbsp;소</strong></td>
				    	<td><input type="text" id="addr2" name="store_add" value="${dto.store_add }"></td>
				    </tr>
			   		<tr>
			   			<td><strong>*상세주소</strong></td>
			   			<td><input type="text" id="addr3" name="store_add_info" value="${dto.store_add_info}"></td>
			   		</tr>
		   		</table>
	        </div>
	        <div id="map"></div>
	        <hr>
		</c:otherwise>
    </c:choose>
		</div>
        <div style="display: flex; justify-content: space-between;">
            <button type="button" class="button1 btn1Fade" onclick="window.history.back()">이전</button>
            <button type="submit" class="button1 btn1Fade">다음</button>
        </div>
    </form>
</div>
  
<!--  


<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB161hCdLVomILxElHuHMspIMH-bcnQ0Lc&callback=initMap"></script>
<img src="https://maps.googleapis.com/maps/api/staticmap?center=37.5665,126.9780&zoom=14&size=400x400&key=AIzaSyB161hCdLVomILxElHuHMspIMH-bcnQ0Lc" alt="Map">

<script>
// initMap 함수: 지도를 초기화하고 표시하는 함수
function initMap() {
  // 초기 위치와 줌 레벨 설정
  const myLatLng = { lat: 37.5665, lng: 126.978 }; // 서울의 위도와 경도
  const mapOptions = {
    center: myLatLng,  // 초기 위치를 서울로 설정
    zoom: 13  // 줌 레벨 (0: 전세계, 20: 건물 수준)
  };

  // 지도 객체 생성
  const map = new google.maps.Map(document.getElementById("map"), mapOptions);

  // 마커 추가 예시
  const marker = new google.maps.Marker({
    position: myLatLng,
    map: map,
    title: "서울 시청"  // 마커에 마우스를 올렸을 때 표시될 툴팁
  });
}


    
       document.getElementById('addr2').addEventListener('input', function() {
            const address = document.getElementById('addr2').value;
            if (address.trim() !== '') {
                showMap(address);
            } else {
                document.getElementById('map').style.display = 'none';
            }
        });
</script>
-->

	<div class="div_footer">
		<%@ include file="../../main/footer.jsp" %>
	</div>
</body>
</html>