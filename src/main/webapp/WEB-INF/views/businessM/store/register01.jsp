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
<script type="text/javascript" src="${path}/resources/js/businessM/businessMstore.js"></script>
</head>
<body>
<div class="header">
<%@ include file="../../main/header.jsp" %>
</div>

<div class="center-box">
	<div class="skill-box">
		<div class="skill-bar">
			<span class="per01">
				<span class="tooltip01">25%</span>
			</span>
		</div>
	</div>
	<form action="register02" method="post" onsubmit="return inputcheck00()">
	<div class="white_box">
	<h1 class="top_title">회원정보 확인하기</h1><br>
		<div class="text_leftAlign">
			<table>
				<tr>
					 <td><strong>가게 이름</strong></td>
                    <td>
                    <input type="text" id="store_name" name="store_name" 
                    	placeholder="${storeName}"></td>
				</tr>
				<tr>
				 <td><strong>사업자번호</strong></td>
                  <td>${storeId}</td>
				</tr>
			</table>
			<hr>
		</div>
			<div>
				회원정보가 올바르다면 다음 버튼을,<br>
				틀리다면 <b>회원정보 수정을 위해 <a href="">여기</a></b>를 눌러주세요.
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