<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>	
	<script>
	function CatetoggleECT() {
		    var checkbox = document.getElementById('category_etc_checkbox');
		    var textInput = document.getElementById('category_ect');
		    textInput.disabled = !checkbox.checked;
	}
	function AmenitoggleECT() {
		    var checkbox2 = document.getElementById('amenities_ect_checkbox');
		    var textInput2 = document.getElementById('amenities_ect');
		    textInput2.disabled = !checkbox2.checked;
		}
	</script>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/businessM/businessMstore.css?after">
<script src="${path}/resources/js/businessM/businessMstore.js"></script>
</head>
<body>
<div class="header">
<%@ include file="../../main/header.jsp" %>
</div>

<div class="center-box">
<div class="skill-box">
	<div class="skill-bar">
		<span class="per03">
			<span class="tooltip03">75%</span>
		</span>
	</div>
</div>
	<form action="register04" method="post" onsubmit="return inputcheck02()">
	<div class="white_box">
<h1>상세정보 입력하기</h1><br>
<h5>*표시 항목은 필수항목입니다</h5><br>
<div class="text_leftAlign2">

	<c:choose>
	<c:when test="${dto != null }">
	<table>
		<tr>
			<td><strong>*소개글</strong></td>
			<td><textarea id="store_introduce" name="store_introduce">${dto.store_introduce}</textarea></td>
		</tr>
		<tr>
			<td><strong>*가게 종류</strong></td>
			<td>
				<label><input type="checkbox" name="store_category" 
				<c:if test="${fn:contains(dto.store_category, '한식')}">checked</c:if>
				value="한식"> 한식</label>&nbsp;
		        <label><input type="checkbox" name="store_category" 
				<c:if test="${fn:contains(dto.store_category, '양식')}">checked</c:if>
		        value="양식"> 양식</label>&nbsp;
		        <label><input type="checkbox" name="store_category" 
				<c:if test="${fn:contains(dto.store_category, '중식')}">checked</c:if>
		        value="중식"> 중식</label>&nbsp;
		        <label><input type="checkbox" name="store_category" 
				<c:if test="${fn:contains(dto.store_category, '일식')}">checked</c:if>
		        value="일식"> 일식</label>&nbsp;
		        <label><input type="checkbox" name="store_category" 
				<c:if test="${fn:contains(dto.store_category, '뷔페')}">checked</c:if>
		        value="뷔페"> 뷔페</label>&nbsp;
		        <label><input type="checkbox" name="store_category" 
				<c:if test="${fn:contains(dto.store_category, '카페')}">checked</c:if>
		        value="카페"> 카페</label>
			</td>
		</tr>	
		<tr style="height:30px">
			<td></td>
			<td>
				<label><input type="checkbox" name="store_category" 
				<c:if test="${fn:contains(dto.store_category, '디저트')}">checked</c:if>
				value="디저트"> 디저트</label>&nbsp;
				<label>
			    <input type="checkbox" name="store_category" id="category_etc_checkbox" 
			        <c:if test="${fn:contains(dto.store_category, '기타')}">checked</c:if>
			        value="기타" onclick="CatetoggleECT()">
				    기타
				</label>
				
				<input type="text" name="store_category" id="category_ect" 
				    value="${otherCategory}" disabled><br>
			</td>
		</tr>
		<tr>
			<td><strong>편의 시설</strong></td>
			<td>
				<label><input type="checkbox" name="store_amenities" 
				<c:if test="${fn:contains(dto.store_amenities, '포장')}">checked</c:if>
				value="포장"> 포장</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" 
				<c:if test="${fn:contains(dto.store_amenities, '주차')}">checked</c:if>
		        value="주차"> 주차</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" 
				<c:if test="${fn:contains(dto.store_amenities, '화장실')}">checked</c:if>
		        value="화장실"> 남/녀 화장실 구분</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" 
				<c:if test="${fn:contains(dto.store_amenities, '인터넷')}">checked</c:if>
		        value="인터넷"> 무선 인터넷</label>&nbsp;
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<label><input type="checkbox" name="store_amenities" 
				<c:if test="${fn:contains(dto.store_amenities, '아기의자')}">checked</c:if>
				value="아기의자"> 아기의자</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" 
				<c:if test="${fn:contains(dto.store_amenities, '장애인')}">checked</c:if>
		        value="장애인"> 장애인 시설</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" 
				<c:if test="${fn:contains(dto.store_amenities, '수유방')}">checked</c:if>
		        value="수유방"> 수유방</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" 
				<c:if test="${fn:contains(dto.store_amenities, '놀이시설')}">checked</c:if>
		        value="놀이시설"> 놀이시설</label>&nbsp;
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<label>
					 <input type="checkbox" name="store_amenities" id="amenities_ect_checkbox" 
			        <c:if test="${fn:contains(dto.store_category, '기타')}">checked</c:if>
			        value="기타" onclick="AmenitoggleECT()">
				    기타
				</label>
				
				<input type="text" name="store_category" id="amenities_ect" 
				    value="${otherAmenities}" disabled><br>
			</td>
		</tr>
		<tr>
			<td><strong>특이사항</strong></td>
			<td><textarea name="store_note">${dto.store_note}</textarea></td>
		</tr>
		<tr>
			<td><strong>*최대 수용 인원</strong></td>
			<td><input type="text" id="store_max_person" name="store_max_person"
				value="${dto.store_max_person }"></td>
		</tr>
		<tr>
			<td><strong>*예약 규정	</strong></td>
			<td><textarea id="store_booking_rule" 
				name="store_booking_rule">${dto.store_booking_rule }</textarea></td>
		</tr>
		</table>
	</c:when>
	<c:otherwise>
	
	<table>
		<tr>
			<td><strong>*소개글</strong></td>
			<td><textarea id="store_introduce" name="store_introduce" placeholder="소개글을 입력해주세요"></textarea></td>
		</tr>
		<tr>
			<td><strong>*가게 종류</strong></td>
			<td>
				<label><input type="checkbox" name="store_category" value="한식"> 한식</label>&nbsp;
		        <label><input type="checkbox" name="store_category" value="양식"> 양식</label>&nbsp;
		        <label><input type="checkbox" name="store_category" value="중식"> 중식</label>&nbsp;
		        <label><input type="checkbox" name="store_category" value="일식"> 일식</label>&nbsp;
		        <label><input type="checkbox" name="store_category" value="뷔페"> 뷔페</label>&nbsp;
		        <label><input type="checkbox" name="store_category" value="카페"> 카페</label>
			</td>
		</tr>	
		<tr style="height:30px">
			<td></td>
			<td>
				<label><input type="checkbox" name="store_category" value="디저트"> 디저트</label>&nbsp;
		        <label for="category_ect"> 기타</label>
				<input type="text" name="store_category" id="category_ect"><br>
			</td>
		</tr>
		<tr>
			<td><strong>편의 시설</strong></td>
			<td>
				<label><input type="checkbox" name="store_amenities" value="포장"> 포장</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" value="주차"> 주차</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" value="화장실"> 남/녀 화장실 구분</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" value="인터넷"> 무선 인터넷</label>&nbsp;
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<label><input type="checkbox" name="store_amenities" value="아기의자"> 아기의자</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" value="장애인"> 장애인 시설</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" value="수유방"> 수유방</label>&nbsp;
		        <label><input type="checkbox" name="store_amenities" value="놀이시설"> 놀이시설</label>&nbsp;
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<label for="amenities_ect">기타</label>
				<input type="text" name="store_amenities" id="amenities_ect"><br>
			</td>
		</tr>
		<tr>
			<td><strong>특이사항</strong></td>
			<td><textarea name="store_note" 
			placeholder="예) 주차장이 협소합니다. 8인 이상예약은 전화 부탁트립니다"></textarea></td>
		</tr>
		<tr>
			<td><strong>*최대 수용 인원</strong></td>
			<td><input type="text" id="store_max_person" name="store_max_person"></td>
		</tr>
		<tr>
			<td><strong>*예약 규정	</strong></td>
			<td><textarea id="store_booking_rule" name="store_booking_rule" 
				placeholder="예) 예약시간 10분 지각 시 예약이 취소됩니다"></textarea></td>
		</tr>
		</table>
	</c:otherwise>
	</c:choose>
		<br>
		<hr>
		<br>
		</div>
		</div>
		<div style="display: flex; justify-content: space-between;">
			<button type="button" class="button1 btn1Fade" onclick=" window.history.back()">이전</button>
			<button type="submit" class="button1 btn1Fade">다음</button>
		</div>

	</form>
</div>
	<div class="div_footer">
		<%@ include file="../../main/footer.jsp" %>
	</div>

</body>
</html>