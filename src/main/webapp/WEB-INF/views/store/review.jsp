<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/store/storeReview.css">
<script src="${path}/resources/js/store/storePhoto.js"></script>
</head>
<body>
<div class="container">
  <c:choose>
    <c:when test="${dto == null}">
      	<div class="center-box">
			<img src="/root/businessM/download?img=../BoSeon/보정/리뷰정보.png" width="350px">
			<br><br>
				<b>등록된 리뷰가 없습니다</b>
			<br><br><br>
		</div>
    </c:when>
    <c:otherwise>
      <c:forEach var="item" items="${dto}">
        <div class="review">
          
          <div class="review-content">
          
          <div class ="memImg">
          <div>
          	<p><img src="/root/member/myPage/download?img=${item.member_img}" 
          	alt="사용자 사진">
            ${item.member_id}</p>
            <p class="review-body">${item.store_review_body}</p>
          </div>
          
            <p class="review-date">${item.store_review_date_create}
            &nbsp;${item.store_review_score}</p>
            </div>
            
            <div>
            <p class="review-image">
            <img src="/root/businessM/download?img=${item.store_review_img_image}" 
            	alt="리뷰 사진"></p>
            </div>
            
          </div>
        </div>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>