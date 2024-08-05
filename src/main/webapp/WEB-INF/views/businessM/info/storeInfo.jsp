<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
window.onload = function() {
    console.log('${dto}');
};	     
</script>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/businessM/businMStoreInfo.css?after">
</head>

<body>
	<c:choose>
		<c:when test="${dto.store_zip == null}">
		<div class="center-box">
		<img src="/root/businessM/download?img=../BoSeon/보정/가게정보.png" width="350px">
		<br><br>
			<b>등록된 가게가 없습니다</b>
		<br><br><br>
			<button type="button" class="button1 btn1Fade" 
				onclick="parent.changeParentUrl('http://localhost:8080/root/register01')">가게 등록하기</button>
		</div>
		</c:when>
		<c:otherwise>
		<div class="container">
        <div class="store-details">
        
            <table>
                <tr>
                    <td><strong>소개글</strong></td>
                    <td>${ dto.store_introduce }</td>
                </tr>
                <tr>
                    <td><strong>가게 이름</strong></td>
                    <td>${ dto.store_name }</td>
                </tr>
                <tr>
                    <td><strong>사업자 번호</strong></td>
                    <td>${ dto.store_id }</td>
                </tr>
                <tr>
                    <td><strong>가게 종류</strong></td>
                    <td>${ dto.store_category }</td>
                </tr>
                <tr>
                    <td><strong>가게 전화번호</strong></td>
                    <td>${ dto.store_phone }</td>
                </tr>
                <tr>
                    <td><strong>사장님 전화번호</strong></td>
                    <td>${ dto.store_main_phone}</td>
                </tr>
                <tr>
                    <td><strong>우편번호</strong></td>
                    <td>${ dto.store_zip }</td>
                </tr>
                <tr>
                    <td><strong>주소</strong></td>
                    <td>${dto.store_add} ${dto.store_add_info}</td>
                </tr>
                <tr>
                    <td><strong>예약 가능시간</strong></td>
                    <td>${ dto.store_business_hours }</td>
                </tr>
                <tr>
                    <td><strong>편의 시설</strong></td>
                    <td>${ dto.store_amenities }</td>
                </tr>
                <tr>
                    <td><strong>특이 사항</strong></td>
                    <td>${ dto.store_note }</td>
                </tr>
                <tr>
                    <td><strong>최대 수용 인원</strong></td>
                    <td>${ dto.store_max_person }</td>
                </tr>
                <tr>
                    <td><strong>예약 규정</strong></td>
                    <td>${ dto.store_booking_rule }</td>
                </tr>
                <tr>
                    <td><strong>이메일</strong></td>
                    <td>${ dto.store_email }</td>
                </tr>
            </table>
            <div class="center-box">
			<button type="button" class="button1 btn1Fade"
				onclick="parent.changeParentUrl('http://localhost:8080/root/register01')">가게 정보 수정하기 </button><br>
       		</div>
       		<br>
        </div>
    </div>
		</c:otherwise>
	</c:choose>
	
	<br>		
</body>
</html>