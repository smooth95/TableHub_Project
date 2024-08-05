<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/login/common.css?after" rel="stylesheet"/>
<link href="<%= request.getContextPath() %>/resources/css/member/login/modifyPwd.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(document).ready( () => {


		console.log("test : ", '${id}')
		
		var inputPwd = "";
		var inputPwdChk = "";
		
		
		pwdChk = () => {
			
			// 입력된 비밀번호 값 두개를 불러온다.
			inputPwd = $("#inputPwd").val();
			inputPwdChk = $("#inputPwdChk").val();
			
			const regex1 = /[^a-zA-Z0-9\s]/;
			const regex2 = /[A-Z]/;
			
			//길이 및 패스워드 작성 조건을 비교하여 메세지를 표시한다.
			if (inputPwd.length < 6 && inputPwd.length > 1) {
				$("#pwdInfoMsg").html("6자 이상 입력하세요")
				$("#pwdInfoMsg").css("color", "#ff6868")
				$("#pwdModifyBtn").prop("disabled", true);
			} else if ( inputPwd.length == 0) {
				$("#pwdChkInfoMsg").html("비밀번호를 입력해주세요")
				$("#pwdChkInfoMsg").css("color", "#ff6868")
				$("#pwdModifyBtn").prop("disabled", true);
			} else {
				if (regex1.test(inputPwd) && regex2.test(inputPwd)) {
					$("#pwdInfoMsg").html("사용 가능한 패스워드 입니다.")
					$("#pwdInfoMsg").css("color", "#6262ff")
					if (inputPwd == inputPwdChk) {
						$("#pwdChkInfoMsg").html("일치합니다.")
						$("#pwdChkInfoMsg").css("color", "#6262ff")
						$("#pwdModifyBtn").prop("disabled", false);
					} else {
						if (pwdChk.length > 0) {
							$("#pwdChkInfoMsg").html("비밀번호를 확인해주세요")
							$("#pwdChkInfoMsg").css("color", "#ff6868")
							$("#pwdModifyBtn").prop("disabled", true);
						}
					}
				} else {
					if (regex1.test(inputPwd)) {
						$("#pwdInfoMsg").html("대문자가 하나 이상 필요합니다.")
					} else if (regex2.test(inputPwd)){
						$("#pwdInfoMsg").html("특수문자가 하나 이상 필요합니다.")
					} else if (!regex1.test(inputPwd) || !regex2.test(inputPwd)){
						$("#pwdInfoMsg").html("특수문자 또는 대문자가 하나 이상씩 필요합니다.")
					}
					$("#pwdInfoMsg").css("color", "#ff6868")
					$("#pwdModifyBtn").prop("disabled", true);
				}
			}
		}

		

		$("#pwdModifyBtn").on("click", function () {
			
// 			pwdChk();
			
			$.ajax({
				url : "/root/member/login/searchPwd/modifyPwd",
				data : JSON.stringify({
					pwd : inputPwd
				}),
				type : "post",
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					if (result.result == 1) {
						alert(result.msg);
						location.href=result.url;						
					} else {
						alert(result.msg);
						location.href=result.url;
					}
					
				},
				error : function ( error ) {
					console.log("error : ", error)
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
			<label class="myPwdCheckInfo">변경하실 패스워드를 입력해주세요</label>
			<table id="pwdCheckTable" border="1px">
				<tr>
					<th class="tableContent title">비밀번호 입력</th>
					<td class="tableContent content">
						<input type="password" oninput="pwdChk()" id="inputPwd" placeholder="패스워드 입력"><br>
						<label id="pwdInfoMsg"></label><br>
						<input type="password" oninput="pwdChk()" id="inputPwdChk" placeholder="패스워드를 다시 한번 입력해주세요"><br>
						<label id="pwdChkInfoMsg"></label>
					</td>
				</tr>
			</table>
			<input id="pwdModifyBtn" type="button" value="비밀번호 변경" disabled>
			
		</div>
	</div>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>