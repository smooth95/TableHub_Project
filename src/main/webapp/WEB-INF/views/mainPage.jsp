<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function goMainPage(){
		window.location.href='/root/main/mainPage1'
	}
</script>
</head>
<body>
	<h1>
	Hello world! main 페이지 입니다!
</h1>
<button type="button" onclick="goMainPage()">main</button><br>
<a href="/root/store">store</a><br>
<a href="/root/register01">사업자 가게 등록 1단계</a><br>
<a href="/root/businMmenu">사업자 마이페이지</a><br>
	<c:choose>
		<c:when test="${userId != null }">
			<a href="/root/member/logout">로그아웃</a>
			<a href="/root/member/myPage/info">마이 페이지</a>
		</c:when>
		<c:when test="${ storeId != null }">
			<a href="/root/member/logout">로그아웃</a>
			<a href="/root/store/myPage">스토어 관리</a>
		</c:when>
		<c:otherwise>
			<a href="/root/member/login">로그인</a>
		</c:otherwise>
	</c:choose>	
	<hr>
<br>
</body>
</html>