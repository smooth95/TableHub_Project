<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/businessM/businessMstore.css?after">
<script src="${path}/resources/js/businessM/businMmenu.js"></script>
</head>
<body>
<div class="header">
<%@ include file="../../main/header.jsp" %>
</div>
<div class="center-box">
<div class="white_box">
	<div style="display:flex; flex-direction: row; align-items: center;">
		<img src="/root/businessM/download?img=../BoSeon/폭죽.png" width="80px">
		<h1>사진이 등록 되었습니다!</h1>
		<img src="/root/businessM/download?img=../BoSeon/폭죽.png" width="80px">
	</div>
	<br>
	<div style="display:grid; justify-items: center;">
		<button type="button" class="button2 btn2Fade" onclick="window.location.href='http://localhost:8080/root/businMmenu?category=2'">메뉴 보기</button><br>
		<button type="button" class="button2 btn2Fade" onclick="window.location.href='http://localhost:8080/root/businMmenu?category=3'">사진 보기</button><br>
		<button type="button" class="button2 btn2Fade" onclick="window.location.href='http://localhost:8080/root/main/mainPage1'">메인 화면</button><br>
		<button type="button" class="button2 btn2Fade" onclick="window.location.href='http://localhost:8080/root/businMmenu?category=0'">내 가게 정보 보기</button>
	</div>
</div>
</div>
	<div class="div_footer">
		<%@ include file="../../main/footer.jsp" %>
	</div>
</body>
</html>