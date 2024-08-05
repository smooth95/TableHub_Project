<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/info/common.css?after" rel="stylesheet"/>
<link href="<%= request.getContextPath() %>/resources/css/member/info/myBoard.css?after" rel="stylesheet"/>
</head>
<body>
	<div id="myPageMenuWrapper">
		<div id="myPageMenu">
			<h3>마이페이지</h3>
			<hr>
			<b class="title">회원정보 관리</b><br>
			<a class="content" id="detail" href="detail">내 정보 확인 및 수정</a><br>
			<a class="content" id="myBooking" href="myBooking">예약 정보 확인</a><br>
			<a class="content" id="deleteUser" href="deleteUser">회원 탈퇴</a>
			<br>
			<br>
			<hr>
			<b class="title">내 활동 관리</b><br>
			<a class="content" id="myBoard" href="myBoard">내가 작성한 게시글</a><br>
			<a class="content" id="myReply" href="myReply">내가 남긴 댓글</a><br>
			<a class="content" id="myReview" href="myReview">내가 작성한 리뷰</a><br>
		</div>
	</div>

</body>
</html>