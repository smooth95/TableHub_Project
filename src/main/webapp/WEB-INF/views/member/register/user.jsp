<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/register/registerUser.css?after" rel="stylesheet"/>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<%@ include file="../../main/header.jsp" %>
</head>
<body>
	<div id="bodyWrapper">
		<div id="registerInputWrapper"><br>
			<h1>회원 정보 입력</h1>
			<form action="register" id="registerForm" method="post">
				<table>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" name="id" oninput="idChk()" id="inputId" placeholder="아이디를 입력해주세요">
							<p id="idInfoMsg"></p>
						</td>		
					</tr>
					<tr>
						<th>닉네임</th>
						<td>
							<input type="text" name="nick" oninput="nickChk()" id="inputNick" placeholder="닉네임을 입력해주세요">
							<p id="nickInfoMsg"></p>
						</td>		
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" name="pwd" oninput="pwdChk()" id="inputPwd" placeholder="패스워드를 입력해주세요">
							<p id="pwdInfoMsg"></p>
						</td>		
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<input type="password" name="pwdCheck" oninput="pwdChk()" id="inputPwdChk" placeholder="패스워드를 다시 한번 입력해주세요">
							<p id="pwdChkInfoMsg"></p>
						</td>		
					</tr>
					<tr>
						<th hidden="true">이메일</th>
						<td hidden="true">
							<input hidden="true" type="text" id="inputEmail" value="${email }" name="email" disabled>
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<select id="phoneCode">
								<option>010
							</select>
							<b>-</b>
							<input type="number" name="phone1" id="phone1">
							<b>-</b>
							<input type="number" name="phone2" id="phone2">
							<input type="button" value="인증코드 전송" id="sendCodeBtn" onclick="sendMessage()">
							<p id="phoneInfoMsg"></p>
						</td>
					</tr>
					<tr>
						<th>전화번호 인증</th>
						<td>
							<input type="number" placeholder="인증번호를 입력해주세요" id="inputCode">
							<input type="button" disabled id="codeChkBtn" value="인증" onclick="codeChk()">
							<p id="phoneChkInfoMsg"></p>
						</td>		
					</tr>
					<tr>
						<th>생년월일</th>
						<td style="padding-bottom: 20px;">
							<select id="year">
								<% 
								int year = Calendar.getInstance().get(Calendar.YEAR);
								for (int i = year; i >= 1900; i--) { %> 
										<option><% out.println(i); %>
								<% } %>		
							</select>
							<b>년</b>
							
							<select id="month">
								<% for (int i = 1; i <= 12; i++) { %>
										<option><% out.println(i); %>
								<% } %>
							</select>
							
							<b>월</b>
							
							<select id="day">
								<% int day = Calendar.getInstance().getActualMaximum(Calendar.DAY_OF_MONTH); 
									for (int i = 1; i <= 31; i++) { %>
										<option><% out.println(i); %>
								<% } %>
							</select>
							<b>일</b><br>
						</td>		
					</tr>
					<tr>
						<th>성별</th>
						<td>	
							<input type="radio" name="gender" value="남" id="radioMan" hidden="true">
							<input type="radio" name="gender" value="여" id="radioWoman" hidden="true">
							<input type="button" name="gender" value="남" id="genderMan">
							<input type="button" name="gender" value="여" id="genderWoman">
						</td>		
					</tr>
					<tr>
						<td colspan="2"><input type="button" value="회원가입" id="registerBtn" onclick="register()" disabled>
					</tr>
				</table>
			</form>
		</div>
	</div>


	

	
	
	
	
	
	<script type="text/javascript">
		console.log("email : " , '${email}')
		if('${email}' == "") {
			alert("잘못된 접근입니다. \n이메일 인증을 다시 진행해주세요")
			location.href="/root/member/login"
		} else {
			console.log("이메일 있음")
		}
		let idPass = false;
		let pwdPass = false;
		let nickPass = false;
		let phonePass = false;
		
		let inputId, inputNick, inputPwd, inputPhone, inputGender, inputYear, inputMonth, inputDay;
		
		
		idChk = () => {
			inputId = $("#inputId").val();
			let form = {id : inputId};
			
			const regex = /[^a-zA-Z0-9]/;
			
			// 영문 소,대문자 숫자를 제외한 나머지 문자가 들어가 있을 경우
			if (regex.test(inputId)) {
				$("#idInfoMsg").html("영문자 및 숫자만 입력할 수 있습니다.")
				$("#idInfoMsg").css("color", "#ff6868")
				idPass = false;
			} else if (inputId.length < 3) {
				$("#idInfoMsg").html("3자 이상 입력해주세요")
				$("#idInfoMsg").css("color", "#ff6868")
				idPass = false;
			} else if (inputId.length > 20) {
				$("#inputId").val($("#inputId").val().substring(0, 20));
				$("#idInfoMsg").html("20자 이내로 입력해주세요")
				$("#idInfoMsg").css("color", "#ff6868")
				idPass = false;
			} 
			else {
				console.log("inputId : ", inputId)
				$.ajax({
					url : "idChk",
					type : "post",
					dataType : "text",
					data : JSON.stringify(form),
					contentType : "application/json; charset=utf-8",
					success : function ( result ) {
						if (result == 0) {
							$("#idInfoMsg").html("사용 가능한 아이디 입니다.");
							$("#idInfoMsg").css("color", "#6262ff")
							idPass = true;
						} else {
							$("#idInfoMsg").html("중복되는 아이디 입니다. 다른 아이디를 입력해주세요");
							$("#idInfoMsg").css("color", "#ff6868")
							idPass = false;
						}
					},
					error : function (e) {
						console.log("문제 발생!!!")
						console.log(e)
					}
				}).then( () => {
					registerChk();
				})
				return;
			}
			registerChk();
		}
		
		nickChk = () => {
			inputNick = $("#inputNick").val();
			let form = {nick : inputNick};
			if (inputNick.length < 2) {
				$("#nickInfoMsg").html("2자 이상 입력해주세요")
				$("#nickInfoMsg").css("color", "#ff6868")
				nickPass = false;
			} else {
				$.ajax({
					url : "nickChk?nick="+inputNick,
					type : "get",
					dataType : "text",
					contentType : "application/json; charset=utf-8",
					success : function ( result ) {
						if (result == 0) {
							$("#nickInfoMsg").html("사용 가능한 닉네임 입니다.");
							$("#nickInfoMsg").css("color", "#6262ff")
							nickPass = true;
						} else {
							$("#nickInfoMsg").html("중복되는 닉네임 입니다. 다른 닉네임을 입력해주세요");
							$("#nickInfoMsg").css("color", "#ff6868")
							nickPass = false;
						}
					},
					error : function (e) {
						console.log("문제 발생!!!")
						console.log(e)
					}
				}).then( () => {
					registerChk();				
				})
				return;
			}
			registerChk();
		}
		
		pwdChk = () => {
			inputPwd = $("#inputPwd").val();
			const pwdChk = $("#inputPwdChk").val();
			const regex1 = /[^a-zA-Z0-9\s]/;
			const regex2 = /[A-Z]/;
			if (inputPwd.length < 6 && inputPwd.length > 1) {
				$("#pwdInfoMsg").html("6자 이상 입력하세요")
				$("#pwdInfoMsg").css("color", "#ff6868")
				pwdPass = false;
			} else if ( inputPwd.length == 0) {
				$("#pwdChkInfoMsg").html("비밀번호를 입력해주세요")
				$("#pwdChkInfoMsg").css("color", "#ff6868")
			} else {
				if (regex1.test(inputPwd) && regex2.test(inputPwd)) {
					$("#pwdInfoMsg").html("사용 가능한 패스워드 입니다.")
					$("#pwdInfoMsg").css("color", "#6262ff")
					if (inputPwd == pwdChk) {
						$("#pwdChkInfoMsg").html("일치합니다.")
						$("#pwdChkInfoMsg").css("color", "#6262ff")
						pwdPass = true;
					} else {
						$("#pwdChkInfoMsg").html("비밀번호를 확인해주세요")
						$("#pwdChkInfoMsg").css("color", "#ff6868")
						pwdPass = false;
					}
				} else {
					if (regex1.test(inputPwd)) {
						$("#pwdInfoMsg").html("대문자가 하나 이상 필요합니다.")
						pwdPass = false;
					} else if (regex2.test(inputPwd)){
						$("#pwdInfoMsg").html("특수문자가 하나 이상 필요합니다.")
						pwdPass = false;
					} else if (!regex1.test(inputPwd) || !regex2.test(inputPwd)){
						$("#pwdInfoMsg").html("특수문자 또는 대문자가 하나 이상씩 필요합니다.")
						pwdPass = false;
					}
					$("#pwdInfoMsg").css("color", "#ff6868")
				}
			}
			registerChk();
		}
		
		sendMessage = () => {
			const phoneCode = $("#phoneCode").val()
			const phone1 = $("#phone1").val()
			const phone2 = $("#phone2").val()
			console.log(phone1.length)
			if (phone1.length < 4) {
				$("#phoneInfoMsg").html("휴대폰 번호를 입력해주세요");
				$("#phoneInfoMsg").css("color", "#ff6868");
				$("#phone1").focus();
			} else if (phone2.length < 4) {
				$("#phoneInfoMsg").html("휴대폰 번호를 입력해주세요");
				$("#phoneInfoMsg").css("color", "#ff6868");
				$("#phone2").focus();
			}
				else {
				inputPhone = phoneCode + phone1 + phone2
				let form = {phoneNumber : inputPhone}
				$.ajax({
					url : "/root/member/sendMessage",
					type : "post",
					data : JSON.stringify(form),
					dataType : "text",
					contentType : "application/json; charset=utf-8",
					success : function ( result ) {
						$("#phoneInfoMsg").html(result);
						$("#phoneInfoMsg").css("color", "#6262ff")
						$("#codeChkBtn").prop("disabled", false)
						
					},
					error : function (e) {
						console.log("문제 발생!!!")
					}
				})				
			}
		}
		
		$("#phone1").on("input", function() {
			let phone1 = $("#phone1").val();
			if (phone1.length >= 4) {
				$("#phone2").focus();
				$(this).val($(this).val().substring(0, 4));
			}
		});
		$("#phone2").on("input", function() {
			let phone2 = $("#phone2").val();
			if (phone2.length >= 4) {
				$("#sendCodeBtn").focus();
				$(this).val($(this).val().substring(0, 4));
			}
		});
		$("#inputCode").on("input", function() {
			let inputCode = $("#inputCode").val();
			if (inputCode.length >= 4) {
				$("#codeChkBtn").focus();
				$(this).val($(this).val().substring(0, 4));
			}
		});
		
		codeChk = () => {
			let inputCode = $("#inputCode").val()
			if (inputCode.length < 4) {
				$("#phoneChkInfoMsg").html("인증코드를 정확히 입력해주세요");
				$("#phoneChkInfoMsg").css("color", "#ff6868")
				$("#inputCode").focus();
			} else {
				let form = {inputCode : inputCode}
				$.ajax({
					url : "/root/member/codeChk",
					type : "post",
					data : JSON.stringify(form),
					dataType : "text",
					contentType : "application/json; charset=utf-8",
					success : function ( result ) {
						if (result == 1) {
							$("#phoneChkInfoMsg").html("인증되었습니다.");
							$("#phoneChkInfoMsg").css("color", "#6262ff")
							phonePass = true;
						} else {
							$("#phoneChkInfoMsg").html("인증코드를 확인해주세요");
							$("#phoneChkInfoMsg").css("color", "#ff6868")
							phonePass = false;
						}
					},
					error : function (e) {
						console.log("문제 발생!!!")
					}
				}).then( () => {
					registerChk();				
				})				
			}
		}
		
		$("#genderMan").click( () => {
			var man = document.getElementById("genderMan");
			var woman = document.getElementById("genderWoman");
			$("#radioMan").click();
			man.style.backgroundColor = "#7596ec";
			woman.style.backgroundColor = "#b6c8f5";
			inputGender = 0;
		})
		$("#genderWoman").click( () => {
			var man = document.getElementById("genderMan");
			var woman = document.getElementById("genderWoman");
			$("#radioWoman").click();
			man.style.backgroundColor = "#b6c8f5";
			woman.style.backgroundColor = "#7596ec";
			inputGender = 1;
		})
	
		$("#month").change( () => {
			inputMonth = $("#month").val();
			inputYear = $("#year").val();
			console.log(new Date(new Date(inputYear, inputMonth) - 1))
			inputDay = new Date(new Date(inputYear, inputMonth, 1) - 1).getDate()
			var html = null;
			
			for (let i = 1; i <= inputDay; i++) {
				html += "<option>" + i;
			}
			$("#day").html(html);
			
		})
		$("#year").change( () => {
			inputMonth = $("#month").val();
			inputYear = $("#year").val();
			console.log(new Date(new Date(inputYear, inputMonth) - 1))
			inputDay = new Date(new Date(inputYear, inputMonth, 1) - 1).getDate()
			var html = null;
			
			for (let i = 1; i <= inputDay; i++) {
				html += "<option>" + i;
			}
			$("#day").html(html);
			
		})
		
		registerChk = () => {
			if (idPass && pwdPass && nickPass && phonePass) {
				$("#registerBtn").prop("disabled", false)
			} else {
				$("#registerBtn").prop("disabled", true)
			}
			
		}
		

		
		register = () => {
			let inputEmail = $("#inputEmail").val();
			let inputBirth = $("#year").val()+"-"+$("#month").val()+"-"+$("#day").val();
			console.log(inputId)
			let form = {id : inputId, pwd : inputPwd, nick : inputNick, phone : inputPhone,
					email : inputEmail, birth : inputBirth, gender : inputGender};
			$.ajax({
				url : "registerChk",
				type : "post",
				data : JSON.stringify(form),
				dataType : "text",
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					alert(`회원가입이 완료되었습니다.\n로그인을 진행해주세요`)
					location.href="/root/member/login"
					
				},
				error : function (e) {
					console.log("문제 발생!!!")
				}
			})
		}
		
		$("#genderMan").click();
	</script>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>