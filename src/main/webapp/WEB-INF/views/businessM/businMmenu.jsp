<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/businessM/businMinfo.css?after">
<script src="${path}/resources/js/businessM/businMmenu.js"></script>
<style>
*{
	user-select: none;
}

.center-box{
	width: 1500px;
	display: flex;
 	flex-direction: column;
  	align-items: center;
	margin: 150px auto;
	
}

.content{
 cursor : pointer;
}
</style>
</head>
<body onload="category('${cateNum}')">

<header class="header">
<%@ include file="../main/header.jsp" %>
</header>

<div class="fixed-scroll">
	<div id="businMmenu">
		<div id="myPageMenuWrapper">
			<div id="myPageMenu">
				<h3>마이페이지</h3>
				<hr>
				<b class="title">가게정보 관리</b><br>
				<div class="content" onclick="category(0)">정보 확인 및 수정</div>
				<div class="content" onclick="category(2)">메뉴 정보 확인</div>
				<div class="content" onclick="category(3)">사진 정보 확인</div>
				<div class="content" onclick="category(4)">고객 후기 보기</div><br>
				<div class="content" onclick="category(5)">예약 관리</div>
				<br><br><br>
				<img src="resources/img/Boseon/보정/로고.png" style="width:100px"
					onclick="window.location.href='/root'">
			</div>
		</div>
		
			<div class="iframe" id="iframe">
			<iframe frameborder="0" scrolling="no" id="myIframe" onload="iHeight();" 
				style="width:785px; min-height:500px;" ></iframe>
			</div>
	</div>
	<div class="div_footer">
		<%@ include file="../main/footer.jsp" %>
	</div>
</div>
</body>
	</html>
