<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/store/storeInfo.css?after">
</head>
<body>
<div class="container">
        <div class="store-header">
            <img class="store-main-img" src="/root/businessM/download?img=${Map.mainImg}" alt="Store Image">
            <p class="store-introduce">${ Map.dto.store_introduce }</p>
        </div>
        <div class="store-details">
        
            <table>
                <tr>
                    <td><strong>가게 이름</strong></td>
                    <td>${ Map.dto.store_name }</td>
                </tr>
                <tr>
                    <td><strong>가게 종류</strong></td>
                    <td>${ Map.dto.store_category }</td>
                </tr>
                <tr>
                    <td><strong>가게 전화번호</strong></td>
                    <td>${ Map.dto.store_phone }</td>
                </tr>
                <tr>
                    <td><strong>주소</strong></td>
                    <td>${ Map.dto.store_add }${ Map.dto.store_add_info }</td>
                </tr>
                <tr>
                    <td><strong>예약 가능시간</strong></td>
                    <td>${ Map.dto.store_business_hours }</td>
                </tr>
                <tr>
                    <td><strong>편의 시설</strong></td>
                    <td>${ Map.dto.store_amenities }</td>
                </tr>
                <tr>
                    <td><strong>특이 사항</strong></td>
                    <td>${ Map.dto.store_note }</td>
                </tr>
                <tr>
                    <td><strong>최대 수용 인원</strong></td>
                    <td>${ Map.dto.store_max_person }</td>
                </tr>
                <tr>
                    <td><strong>예약 규정</strong></td>
                    <td>${ Map.dto.store_booking_rule }</td>
                </tr>
                <tr>
                    <td><strong>사업자번호</strong></td>
                    <td>${ Map.dto.store_id }</td>
                </tr>
                <tr>
                    <td><strong>이메일</strong></td>
                    <td>${ Map.dto.store_email }</td>
                </tr>
            </table>
            
            <p style="display:none;"><strong>우편번호:</strong> ${ Map.dto.store_zip }</p>
            <p style="display:none;"><strong>사장님 전화번호:</strong> ${ Map.dto.store_main_phone }</p>
        </div>
    </div>
    
	<br>
</body>
</html>