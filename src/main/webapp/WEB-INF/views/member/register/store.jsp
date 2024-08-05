<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/register/store.css?after" rel="stylesheet"/>

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
						<th>사업자번호</th>
						<td>
							<input type="number" name="storeId1" oninput="storeIdChk()" id="inputStoreId1" disabled>
							<b>-</b>
							<input type="number" name="storeId2" oninput="storeIdChk()" id="inputStoreId2" disabled>
							<b>-</b>
							<input type="number" name="storeId3" oninput="storeIdChk()" id="inputStoreId3" disabled>
							<p id="storeIdInfoMsg"></p>
						</td>		
					</tr>
					<tr>
						<th>가게이름</th>
						<td>
							<input type="text" name="name" oninput="nameChk()" id="inputName" placeholder="가게명을 입력해주세요">
							<p id="nameInfoMsg"></p>
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
					<tr hidden="true">
						<th hidden="true">이메일</th>
						<td hidden="true">
							<input hidden="true" type="text" id="inputEmail" value="${storeEmail }" name="email" disabled>
						</td>
					</tr>
					<tr>
						<th>가게 전화번호</th>
						<td >
							<select id="storePhoneCode">
								<option>02
								<option>031
								<option>070
							</select>
							<b>-</b>
							<input type="number" name="storePhone1" id="storePhone1">
							<b>-</b>
							<input type="number" name="storePhone2" id="storePhone2">
							<p id="storePhoneInfoMsg"></p>
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
						<td colspan="2"><input type="button" value="회원가입" id="registerBtn" onclick="register()" disabled>
					</tr>
				</table>
			</form>
		</div>
	</div>


	

	
	
	
	
	
	<script type="text/javascript">
		let pwdPass = false;
		let namePass = false;
		let phonePass = false;
		
		let inputName, inputPwd, inputPhone, inputStorePhone;
		
		document.addEventListener("DOMContentLoaded", function() {
			var storeNum = '${storeNum}';
			var storeNum1 = storeNum.substring(0,3);
			var storeNum2 = storeNum.substring(3,5);
			var storeNum3 = storeNum.substring(5,10);
			$("#inputStoreId1").val(storeNum1);
			$("#inputStoreId2").val(storeNum2);
			$("#inputStoreId3").val(storeNum3);
			
		});
		
		nameChk = () => {
			inputName = $("#inputName").val();
			var koreanPattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			if (inputName == "") {
				$("#nameInfoMsg").html("가게 이름을 입력해주세요")
				$("#nameInfoMsg").css("color", "#ff6868")
				namePass = false;
			} else {
				$("#nameInfoMsg").html("")
				namePass = true;
			}
		}
		
		pwdChk = () => {
			inputPwd = $("#inputPwd").val();
			const pwdChk = $("#inputPwdChk").val();
			const regex1 = /[^a-zA-Z0-9\s]/;
			const regex2 = /[A-Z]/;
			if (inputPwd.length < 6 && inputPwd.length >= 1) {
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
		
		$("#storePhone1").on("input", function() {
			let storePhone1 = $("#storePhone1").val();
			if (storePhone1.length >= 4) {
				$("#storePhone2").focus();
				$(this).val($(this).val().substring(0, 4));
			}
		})
		$("#storePhone2").on("input", function() {
			let storePhone2 = $("#storePhone2").val();
			if (storePhone2.length >= 4) {
				$("#phone1").focus();
				$(this).val($(this).val().substring(0, 4));
			}
		})
		
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
		
		registerChk = () => {
			if (pwdPass && namePass && phonePass) {
				$("#registerBtn").prop("disabled", false)
			} else {
				$("#registerBtn").prop("disabled", true)
			}
			
		}
		

		
		register = () => {
			let inputEmail = $("#inputEmail").val();
			let storePhone = $("#storePhoneCode").val() + $("#storePhone1").val() + 
							$("#storePhone2").val();
			console.log(storePhone);
			let inputId = '${storeNum}';
			console.log("id : ", inputId);
			let form = {id : inputId, pwd : inputPwd, name : inputName, mainPhone : inputPhone,
					email : inputEmail, phone : storePhone};
			$.ajax({
				url : "/root/member/register/storeRegisterChk",
				type : "post",
				data : JSON.stringify(form),
				dataType : "text",
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					alert(result)
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