<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/businessM/businMphoto.css?after">
<script src="${path}/resources/js/businessM/businMphoto.js"></script>
</head>
<body>
	<c:choose>
			<c:when test="${PMap == null}">
			<div class="center-box2">
				<img src="/root/businessM/download?img=../BoSeon/보정/사진정보.png" width="350px">
				<br><br>
					<b>등록된 사진이 없습니다</b>
				<br><br><br>
			<button type="button" class="button1 btn1Fade"
				onclick="parent.changeParentUrl('http://localhost:8080/root/businessM/photo/photoRegister')">사진 등록 하기</button>
			</div>
			</c:when>
			
			<c:otherwise>
				<div class="center-box2">
				    <div class="photo01">
					    <div class="preview-box01">
					    	<label class="mainphoto-text">대표</label>
						    	<div class="preview-container01">
									<img id="preview-image01" src="/root/businessM/download?img=${PMap.storeMainImage}">
								</div>
					    </div>
				</div>
				    <c:choose>
					    <c:when test="${PMap.dto != null}">
						    <c:forEach var="item" items="${PMap.dto}" varStatus="status">
								<div class="photo01">
							    	<div class="preview-box01">
							    		<div class="preview-container01">
								        	<img id="preview-image02" src="/root/businessM/download?img=${item.store_img_root}">
								    	</div>
							    	</div>
							    </div> 
							</c:forEach>
						</c:when>
					</c:choose>
					<br><br>
					<button type="button" class="button1 btn1Fade" 
						onclick="parent.changeParentUrl('http://localhost:8080/root/businessM/photo/photoRegister')">사진 수정하기</button>
					<br>
				</div>
			</c:otherwise>
	</c:choose>

</body>
</html>