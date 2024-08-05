<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/info/myContentMyInfo.css?after" rel="stylesheet"/>
<script>
	$(document).ready( () => {
		console.log("asdf")
		getMyInfo()
	})
	function getMyInfo () {
		$.ajax({
			url : "/root/member/myPage/myContentMyInfo",
			type : "get",
			dataType : "json",
			success : function (result) {
				console.log("inforesult : ", result)
				var html = ""
				html += `<tr>`
				html += `<td>`
				html += `<img id="myContentmyImg" alt="" src="/root/member/myPage/download?img=`+result.MEMBER_IMG+`">`
				html += `</td>`
				html += `<td>`
				html += `<b id="myContentmyId">` + result.userNick + `</b><br>`
				html += `<label class="myCount">작성 게시글 <b>` + result.BOARD_COUNT + `</b> · </label>`
				html += `<label class="myCount">작성 댓글 <b>` + result.REPLY_COUNT + `</b> · </label>`
				html += `<label class="myCount">작성 리뷰 <b>` + result.REVIEW_COUNT + `</b> · </label>`
				console.log("리뷰평ㅈ머 : ", result.REVIEW_SCORE)
				html += `<label class="myCount">리뷰 평점 <b>` + result.REVIEW_SCORE + `</b></label>`
				html += `</td>`
				html += `</tr>` 
				$("#myContentmyInfo").html(html)
			} ,
			error : function ( error ) {
				console.log ("error : ", error)
			}
		})
	}
</script>
</head>
<body>
	<h3 class="myContentTitle">내 활동 내역</h3>
	<table id="myContentmyInfo">
	
	</table>
	<a class="myContentMenu" href="myBoard" id="myContentMyBoard">작성글</a>
	<a class="myContentMenu" href="myReply" id="myContentMyReply">작성댓글</a>
	<a class="myContentMenu" href="myReview" id="myContentMyReview">작성리뷰</a>
	<hr class="myContentHr">
</body>
</html>