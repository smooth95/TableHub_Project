<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/login/searchCommon.css?after" rel="stylesheet"/>
<link href="<%= request.getContextPath() %>/resources/css/member/login/searchId.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(document).ready( () => {
		
		$("#emailCheckBtn").on("click", function() {
			let local = $("#inputEmailLocal").val();
			$("#emailCheckBtn").prop("disabled", true);
			var koreanPattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			if (local == "") {
				$("#emailInfoMsg").html("이메일 주소를 입력해주세요");
				$("#emailInfoMsg").css("color", "#ff6868")
				$("#inputEmailLocal").focus();
				$("#codeSendBtn").prop("disabled", false);
			} else if (koreanPattern.test(local)) {
				$("#emailInfoMsg").html( "한글은 입력할 수 없습니다." );
				$("#emailInfoMsg").css("color", "#ff6868")
				$("#codeSendBtn").prop("disabled", false);
			} else {
				$("#emailInfoMsg").html( "잠시 후 이메일이 전송됩니다." );
				$("#emailInfoMsg").css("color", "#ff6868")
				let email = $("#inputEmailLocal").val() + "@" + $("#inputEmailDomain").val(); 
				let form = {email : email};
				$.ajax({
					url : "/root/member/sendMail/id?email="+email,
					type : "post",
					data : JSON.stringify(form),
					dataType : "json",
					contentType : "application/json; charset=utf-8",
					success : function ( result ) {
						$("#emailInfoMsg").html( result.msg );
						if (result.result == 1) {
							$("#emailInfoMsg").css("color", "#6262ff")
						} else {
							$("#emailInfoMsg").css("color", "#ff6868")
						}
					},
					error : function () {
						$("#emailCheckBtn").prop("disabled", false);
						alert("문제 발생!!!")
					}
				})
			}
		}) // emailCheckBtn onclick event end
		
		
		$("#inputEmailLocal").keydown( function ( event ) {
			console.log("test : ", event.key)
			console.log("test : ", event.keyCode)
			if (event.key === "Enter" || event.keyCode === 13) {
				$("#emailCheckBtn").click();
			}
		})
	})


</script>

<%@ include file="../../main/header.jsp" %>
</head>
<body>
	<div id="myPageWrapper">
		<div id="myPageEmailCheckWrapper">
			<label class="myEmailCheckInfo">이메일 주소로 아이디가 전송됩니다. <br>가입시 작성한 이메일 주소를 입력해주세요</label>
			<table id="emailCheckTable" border="1px">
				<tr>
					<th class="tableContent title">이메일 인증</th>
					<td class="tableContent content">
						<input type="text" placeholder="이메일 주소 입력" id="inputEmailLocal">
						<b style="font-size:20px;">@</b>
						<select id="inputEmailDomain">
							<option>naver.com
							<option>daum.net
							<option>gmail.com
						</select><br>
						<label id="emailInfoMsg"></label>
					</td>
				</tr>
			</table>
			<input id="emailCheckBtn" type="button" value="이메일 전송">
			<input id="loginPageBtn" type="button" onclick="location.href='/root/member/login'" value="로그인 하러 가기">
			
		</div>
	</div>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>