<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
     <script src="http://code.jquery.com/jquery-latest.min.js"></script>
     <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
		src="<%=request.getContextPath()%>/resources/js/main/readURL.js">
</script>
</head>
<body>
	<form action="infoSave" method="post" enctype="multipart/form-data">
		<input type="text" name="store_id" value="${login }" placeholder="사업자아이디" />
		<input type="file" name="store_menu_img" onchange="readURL(this)" /><br>
		<img id="preview" src="" width="100" height="100" alt="선택이미지X" /><br>
		<input type="text" name="store_menu_name" placeholder="메뉴이름" />
		<input type="text" name="store_menu_price" placeholder="메뉴가격" />
		<input type="text" name="store_menu_detail" placeholder="상세설명" />
		<input type="text" name="store_menu_category" placeholder="카테고리" />
		<input type="submit" value="등록"/>
		<input type=button value="메인"
			onClick="location.href='${path}/main/mainPage1'">
	</form>
</body>
</html>