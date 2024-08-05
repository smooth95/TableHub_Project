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
</head>
<body>
	<form action="storeSave" method="post" enctype="multipart/form-data">
		<input type="text" name="store_id" value="${login }" placeholder="사업자아이디" />
		<input type="text" name="store_pwd" placeholder="비밀번호" />
		<input type="text" name="store_email" placeholder="이메일" />
		<input type="text" name="store_phone" placeholder="가게번호" />
		<input type="text" name="store_main_phone" placeholder="대표번호" />
		<input type="text" name="store_name" placeholder="가게이름" />
		<input type="text" name="store_add" placeholder="주소" />
		<input type="text" name="store_add_info" placeholder="상세주소" />
		<input type="text" name="store_category" placeholder="가게종류" />
		<input type="text" name="store_note" placeholder="특이사항" />
		<input type="text" name="store_introduce" placeholder="소개글" />
		<input type="text" name="store_business_hours" placeholder="영업시간" />
		<input type="submit" value="등록"/>
		<input type=button value="메인"
			onClick="location.href='${path}/main/mainPage2'">
	</form>
</body>
</html>