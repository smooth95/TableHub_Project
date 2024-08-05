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
		<span class="per04">
			<span class="tooltip04">99%</span>
		</span>
	</div>
</div>

<form action="registerFinish" method="post">
<div class="white_box">
<h1>영업시간 선택하기</h1><br>
예약이 가능한 시간을 모두 골라주세요
            <h3>오전</h3>
<div class="time-buttons">
    <div class="checkbox-button">
        <input type="checkbox" id="time0000" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '00:00')}">checked</c:if>
        value="00:00">
        	<label for="time0000">00:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0030" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '00:30')}">checked</c:if>
        value="00:30">
        	<label for="time0030">00:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0100" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '01:00')}">checked</c:if>
        value="01:00">
        	<label for="time0100">01:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0130" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '01:30')}">checked</c:if>
        value="01:30">
        	<label for="time0130">01:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0200" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '02:00')}">checked</c:if>
        value="02:00">
        	<label for="time0200">02:00</label>
    </div>
</div>

<div class="time-buttons">
    <div class="checkbox-button">
        <input type="checkbox" id="time0230" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '02:30')}">checked</c:if>
        value="02:30">
        	<label for="time0230">02:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0300" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '03:00')}">checked</c:if>
        value="03:00">
        	<label for="time0300">03:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0330" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '03:30')}">checked</c:if>
        value="03:30">
        	<label for="time0330">03:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0400" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '04:00')}">checked</c:if>
        value="04:00">
        	<label for="time0400">04:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0430" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '04:30')}">checked</c:if>
        value="04:30">
        	<label for="time0430">04:30</label>
    </div>
</div>

<div class="time-buttons">
    <div class="checkbox-button">
        <input type="checkbox" id="time0500" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '05:00')}">checked</c:if>
        value="05:00">
        	<label for="time0500">05:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0530" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '05:30')}">checked</c:if>
        value="05:30">
        	<label for="time0530">05:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0600" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '06:00')}">checked</c:if>
        value="06:00">
        	<label for="time0600">06:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0630" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '06:30')}">checked</c:if>
        value="06:30">
        	<label for="time0630">06:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0700" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '07:00')}">checked</c:if>
        value="07:00">
        	<label for="time0700">07:00</label>
    </div>
</div>

<div class="time-buttons">
    <div class="checkbox-button">
        <input type="checkbox" id="time0730" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '07:30')}">checked</c:if>
        value="07:30">
        	<label for="time0730">07:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0800" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '08:00')}">checked</c:if>
        value="08:00">
        	<label for="time0800">08:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0830" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '08:30')}">checked</c:if>
        value="08:30">
        	<label for="time0830">08:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0900" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '09:00')}">checked</c:if>
        value="09:00">
        	<label for="time0900">09:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time0930" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '09:30')}">checked</c:if>
        value="09:30">
        	<label for="time0930">09:30</label>
    </div>
</div>

<div class="time-buttons">
    <div class="checkbox-button">
        <input type="checkbox" id="time1000" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '10:00')}">checked</c:if>
        value="10:00">
        	<label for="time1000">10:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1030" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '10:30')}">checked</c:if>
        value="10:30">
        	<label for="time1030">10:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1100" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '11:00')}">checked</c:if>
        value="11:00">
        	<label for="time1100">11:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1130" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '11:30')}">checked</c:if>
        value="11:30">
        	<label for="time1130">11:30</label>
    </div>
</div>
   
<hr>

<h3>오후</h3>
<div class="time-buttons">
    <div class="checkbox-button">
        <input type="checkbox" id="time1200" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '12:00')}">checked</c:if>
        value="12:00">
        	<label for="time1200">12:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1230" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '12:30')}">checked</c:if>
        value="12:30">
        	<label for="time1230">12:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1300" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '13:00')}">checked</c:if>
        value="13:00">
        	<label for="time1300">13:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1330" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '13:30')}">checked</c:if>
        value="13:30">
        	<label for="time1330">13:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1400" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '14:00')}">checked</c:if>
        value="14:00">
        	<label for="time1400">14:00</label>
    </div>
</div>

<div class="time-buttons">
    <div class="checkbox-button">
        <input type="checkbox" id="time1430" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '14:30')}">checked</c:if>
        value="14:30">
        	<label for="time1430">14:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1500" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '15:00')}">checked</c:if>
        value="15:00">
        	<label for="time1500">15:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1530" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '15:30')}">checked</c:if>
        value="15:30">
        	<label for="time1530">15:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1600" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '16:00')}">checked</c:if>
        value="16:00">
        	<label for="time1600">16:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1630" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '16:30')}">checked</c:if>
        value="16:30">
        	<label for="time1630">16:30</label>
    </div>
</div>

<div class="time-buttons">
    <div class="checkbox-button">
        <input type="checkbox" id="time1700" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '17:00')}">checked</c:if>
        value="17:00">
        	<label for="time1700">17:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1730" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '17:30')}">checked</c:if>
        value="17:30">
        	<label for="time1730">17:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1800" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '18:00')}">checked</c:if>
        value="18:00">
        	<label for="time1800">18:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1830" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '18:30')}">checked</c:if>
        value="18:30">
        	<label for="time1830">18:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time1900" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '19:00')}">checked</c:if>
        value="19:00">
        	<label for="time1900">19:00</label>
    </div>
</div>

<div class="time-buttons">
    <div class="checkbox-button">
        <input type="checkbox" id="time1930" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '19:30')}">checked</c:if>
        value="19:30">
        	<label for="time1930">19:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time2000" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '20:00')}">checked</c:if>
        value="20:00">
        	<label for="time2000">20:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time2030" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '20:30')}">checked</c:if>
        value="20:30">
        	<label for="time2030">20:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time2100" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '21:00')}">checked</c:if>
        value="21:00">
        	<label for="time2100">21:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time2130" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '21:30')}">checked</c:if>
        value="21:30">
        	<label for="time2130">21:30</label>
    </div>
</div>

<div class="time-buttons">
    <div class="checkbox-button">
        <input type="checkbox" id="time2200" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '22:00')}">checked</c:if>
        value="22:00">
        	<label for="time2200">22:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time2230" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '22:30')}">checked</c:if>
        value="22:30">
        	<label for="time2230">22:30</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time2300" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '23:00')}">checked</c:if>
        value="23:00">
        	<label for="time2300">23:00</label>
    </div>
    <div class="checkbox-button">
        <input type="checkbox" id="time2430" name="store_business_hours" 
		<c:if test="${fn:contains(dto.store_business_hours, '23:30')}">checked</c:if>
        value="23:30">
        	<label for="time2430">24:30</label>
    </div>
</div>
</div>


        
		<div style="display: flex; justify-content: space-between;">
			<button type="button" class="button1 btn1Fade" onclick=" window.history.back()">이전</button>
			<button type="submit" class="button1 btn1Fade"
				style="width:140px">가게 등록 완료</button>
		</div>
	</form>
</div>
	<div class="div_footer">
		<%@ include file="../../main/footer.jsp" %>
	</div>
</body>
</html>