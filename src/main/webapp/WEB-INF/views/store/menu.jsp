<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/store/storeMenu.css">
<script src="${path}/resources/js/store/storePhoto.js"></script>
</head>
<body>
<script>
	console.log("${dto}");
</script>
  <c:choose>
        <c:when test="${dto == null}">
        <div class="center-box">
			<img src="/root/businessM/download?img=../BoSeon/보정/메뉴정보.png" width="350px">
			<br><br>
				<b>등록된 메뉴가 없습니다</b>
			<br><br><br>
		</div>
        </c:when>
        <c:otherwise>
            <div class="menu-container">
                <c:forEach var="item" items="${dto}">
                    <div class="menu-item">
                            <p class="menu-category">${item.store_menu_category}</p>
                        <img src="/root/businessM/download?img=${item.store_menu_img}" alt="${item.store_menu_name}" class="menu-image">
                        <div class="menu-details">
                            <h2 class="menu-name">${item.store_menu_name}</h2>
                            <p class="menu-price">${item.store_menu_price}원</p>
                            <p class="menu-description"><strong>${item.store_menu_detail}</strong></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
<br><br>
</body>
</html>