<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/info/common.css?after" rel="stylesheet"/>
<link href="<%= request.getContextPath() %>/resources/css/member/info/pwdCheck.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(document).ready( () => {
		
		$("#pwdCheckBtn").on("click", function() {
			let inputPwd = $("#inputPwd").val();
			console.log("inputPwd : ", inputPwd)
			$.ajax( {
				url : "pwdCheck",
				type : "get",
				data : {
					inputPwd : inputPwd
				},
				dataType : 'json',
				contentType : "application/json; charset=utf-8",
				success : function ( data ) {
					console.log("data : ", data)
					if (data.result == 1) {
						location.href="/root/member/myPage/detail"
					} else {
						$("#pwdInfoMsg").html(data.msg);
					}
				},
				error : function (error) {
					console.log("asdfasdfasdfasdf")
					
				}
				
			})
		})
	})


</script>

<%@ include file="../../main/header.jsp" %>
</head>
<body>
	<div id="myPageWrapper">
		<div id="myPagePwdCheckWrapper">
			<label class="myPwdCheckInfo">고객님의 정보를 안전하게 지키기위해 <br>패스워드를 입력해주세요</label>
			<table id="pwdCheckTable" border="1px">
				<tr>
					<th class="tableContent">비밀번호 입력</th>
					<td class="tableContent">
						<input type="password" class="inputText" id="inputPwd"><br>
						<label id="pwdInfoMsg"></label>
					</td>
				</tr>
			</table>
			<input id="pwdCheckBtn" type="button" value="비밀번호 확인">
			
		</div>
	</div>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>