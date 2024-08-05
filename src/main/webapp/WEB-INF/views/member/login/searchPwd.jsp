<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[테이블허브] 패스워드 찾기</title>
<link href="<%= request.getContextPath() %>/resources/css/member/login/searchCommon.css?after" rel="stylesheet"/>
<link href="<%= request.getContextPath() %>/resources/css/member/login/searchPwd.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>

	var idPass = false;
	var emailPass = false;
	$(document).ready( () => {
		
		
		
		// 이메일과 메일의 입력 여부를 확인하는 함수
		$("#inputId").on("input", function () {
			
			var inputId = document.getElementById("inputId").value;

			if (inputId.length < 3) {
				$("#idInfoMsg").val("아이디는 3자 이상 입력해주세요");
				idPass = false;
			} else {
				idPass = true;
			}
			idEmailChk();
			
		})// inputId oninput event end
		
		$("#inputEmailLocal").on("input", function () {
			
			var inputEmailLocal = document.getElementById("inputEmailLocal").value;
			
			if (inputEmailLocal.length != 0) {
				$("#emailInfoMsg").val("이메일주소를 입력해주세요");
				emailPass = true;
			} else {
				emailPass = false;
			}
			idEmailChk();
		})// inputEmailLocal oninput event end

		
		// 위에서 아이디 메일의 입력 여부를 확인 후 둘다 입력이 되었으면 버튼을 활성화시킨다.
		function idEmailChk () {
			if (idPass == true && emailPass == true) {
				$("#emailCheckBtn").prop("disabled", false);
			} else {
				$("#emailCheckBtn").prop("disabled", true);				
			}
		}
		
		
		// 입력시 엔터를 클릭할 경우 버튼이 동작된다.
		$("#inputId").keydown(function ( event ) {
			if ($("#emailCheckBtn").prop("disabled") == false) {
				if (event.key === "Enter" || event.keyCode === 13) {
					$("#emailCheckBtn").click();
				}				
			}
		})
		$("#inputEmailLocal").keydown(function ( event ) {
			if ($("#emailCheckBtn").prop("disabled") == false) {
				if (event.key === "Enter" || event.keyCode === 13) {
					$("#emailCheckBtn").click();
				}
			}
		})
		
		
		
		
		
		
		// 버튼을 클릭하면 입력된 내용이 서버로 전달되어서 값을 리턴받는다.
		$("#emailCheckBtn").on("click", function () {
			
			var inputId = document.getElementById("inputId").value;
			var inputEmailLocal = document.getElementById("inputEmailLocal").value;
			var inputEmailDomain = document.getElementById("inputEmailDomain").value;
			var inputEmail =  inputEmailLocal + "@" + inputEmailDomain; 
			
			$("#emailCheckInfoMsg").html("잠시 후 이메일이 전송됩니다.");
			$("#emailCheckInfoMsg").css("color", "#6262ff")
			//지속적인 요청을 방지하기위해 잠시 비활성화
			$("#emailCheckBtn").prop("disabled", true);
			
			$.ajax({
				url : "/root/member/sendMail/pwd",
				type : "post",
				data : JSON.stringify({
					inputId : inputId,
					inputEmail : inputEmail
				}),
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					console.log("result : " , result)
					
					$("#emailCheckInfoMsg").html(result.msg);
					
					if (result.result == 1) {
						
						//5초 뒤에 버튼이 활성화됨
						setTimeout(checkBtnEnable, 5000);
						
						$("#emailCheckInfoMsg").css("color", "#6262ff")
						
					} else {
						$("#emailCheckBtn").prop("disabled", false);
						$("#emailCheckInfoMsg").css("color", "#ff6868")
					}
					
					
					
					
				},
				error : function ( error ) {
					console.log("error : ", error)
				}
			})	
		})
		
		
		function checkBtnEnable () {
			$("#emailCheckBtn").prop("disabled", false);
			$("#emailCheckInfoMsg").html("")
			
		}
		
		
	})


</script>

<%@ include file="../../main/header.jsp" %>
</head>
<body>
	<div id="myPageWrapper">
		<div id="myPageIdMailCheckWrapper">
			<label class="idMailCheckInfo">고객님의 정보를 안전하게 지키기위해 아이디와 이메일 주소를 입력해주세요<br>
			아이디, 이메일 주소가 기억이 나지 않으면 <a href="/root/member/login/searchId" id="searchIdLink">아이디 찾기</a> 를 통해 아이디를 먼저 찾아주세요</label>
			
			<table id="idMailCheckTable" border="1px">
				<tr>
					<th class="tableContent title">아이디 입력</th>
					<td class="tableContent content">
						<input type="text" id="inputId" placeholder="아이디 입력"><br>
						<label id="idInfoMsg"></label>
					</td>
				</tr>
				<tr>
					<th class="tableContent title">이메일 입력</th>
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
				<label id="emailCheckInfoMsg"></label><br>
				<input id="emailCheckBtn" type="button" value="이메일 전송" disabled>
				<input id="loginPageBtn" type="button" onclick="location.href='/root/member/login'" value="로그인 하러 가기">
					
			
		</div>
	</div>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>