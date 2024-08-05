<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/businessM/menuInfo.css?after">
</head>
<body>
	
	<c:choose>
		<c:when test="${Mdto == null}">
		<div class="center-box2">
		<img src="/root/businessM/download?img=../BoSeon/보정/메뉴정보.png" width="350px">
		<br><br>
			<b>등록된 메뉴가 없습니다</b>
		<br><br><br>
			<button type="button" class="button1 btn1Fade"
				onclick="parent.changeParentUrl('http://localhost:8080/root/businessM/menu/menuRegister')">메뉴 등록하기</button>
		</div>
		</c:when>
		<c:otherwise>
				<table class="menu-form" id="menuTable" border="1">
		        <thead>
		            <tr>
		                <th>카테고리</th>
		                <th>메뉴 이름</th>
		                <th>가격</th>
		                <th>사진</th>
		                <th>설명</th>
		            </tr>
		        </thead>
			<c:forEach var="item" items="${Mdto}" varStatus="status">
		        <tbody id="menuBody">
					 <tr>
	                	<td>${item.store_menu_category}</td>
	                    <td>${item.store_menu_name}</td>
	                    <td>${item.store_menu_price}</td>
	                    <td><img src="/root/businessM/download?img=${item.store_menu_img}"
	                    	style="width:100px;"></td>
	                    <td>${item.store_menu_detail}</td>
	                </tr>
	          	 </tbody>
			</c:forEach>		
	           </table>
	           <div class="center-box2">
		<button type="button" class="button1 btn1Fade"
			onclick="parent.changeParentUrl('http://localhost:8080/root/businessM/menu/menuRegister')">메뉴 수정하기</button>
		</div>
		<br>
		</c:otherwise>
		</c:choose>
<br>
</body>
</html>