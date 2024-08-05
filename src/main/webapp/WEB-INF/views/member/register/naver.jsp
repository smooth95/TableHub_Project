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
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<%@ include file="../../main/header.jsp" %>
</head>
<body>
<script type="text/javascript">
	
	

	let idPass = true;
	let pwdPass = true;
	let nickPass = false;
	let phonePass = false;
	
	let inputId, inputNick, inputPwd, inputPhone, inputGender, inputYear, inputMonth, inputDay;

	
	let accessToken = null;


	var naver_id_login = new naver_id_login("NY8JwdpMRrDBs7eqhg8A", "http://localhost:8080/root/member/registerNaver");
  // 접근 토큰 값 출력
//   alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
	console.log(naver_id_login)
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
  
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
		inputId = "N="+naver_id_login.getProfileData("id");
		let nick = naver_id_login.getProfileData("nickname");
		let email = naver_id_login.getProfileData("email");
		let phone = naver_id_login.getProfileData("mobile");
		let gender = naver_id_login.getProfileData("gender");
// 		alert(naver_id_login.oauthParams.access_token);
		accessToken = naver_id_login.oauthParams.access_token;
		let form = {id : inputId}
		$.ajax({
			url : "idChk",
			type : "post",
			dataType : "text",
			data : JSON.stringify(form),
			contentType : "application/json; charset=utf-8",
			success : function ( result ) {
				if (result == 1) {
// 					alert("이미 가입된 계정입니다.\n로그인 후 메인페이지로 이동합니다.")
					let form = {id : inputId,
								token : accessToken}
						$.ajax({
							url : "/root/member/loginChk",
							type : "post",
							dataType : "text",
							data : JSON.stringify(form),
							contentType : "application/json; charset=utf-8",
							success : function ( result ) {
								location.href="/root/main/mainPage1";
							},
							error : function (e) {
								console.log("문제 발생!!!")
								console.log(e)
							}
						})
				} else {
					$("#registerInputWrapper").removeAttr("hidden")
					$("#inputId").val("N:"+naver_id_login.getProfileData("id"));
					$("#inputNick").val(naver_id_login.getProfileData("nickname"));
					$("#inputEmail").val(naver_id_login.getProfileData("email"));
					$("#mobile").val(naver_id_login.getProfileData("mobile"));
					$("#gender").val(naver_id_login.getProfileData("gender"));
					
					if (phone == null) {
						$("#phoneCol").removeAttr("hidden")
						$("#phoneCodeCol").removeAttr("hidden")
					}
					if (email == null) {
						$("#phoneCol").removeAttr("hidden")
					}
					if (nick == null) {
						$("#nickCol").removeAttr("hidden")
					} else {
						nickChk();
						inputNick = nick;
					}
					if (gender == null) {
						console.log("asdf")
						$("#genderCol").removeAttr("hidden")
						$("#genderMan").click();			
					} else {
						console.log(gender)
						if (gender == "M") {
							inputGender = 0;
						} else if (gender == "Y") {
							inputGender = 1;
						} else {
							inputGender = 2;
						}
					}
				}
			},
			error : function (e) {
				console.log("문제 발생!!!")
				console.log(e)
			}
		})
		
  }
  
  function test () {
	  
	  console.log("token : ", testToken)
// 	  $.ajax({
// 		  url : "https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id=NY8JwdpMRrDBs7eqhg8A&client_secret=4_1nA0P4RP&access_token="+testToken,
// 		  type : "post",
// 		  data : {
// 			  grant_type : "delete",
// 			  client_id : "NY8JwdpMRrDBs7eqhg8A",
// 			  client_secret : "4_1nA0P4RP",
// 			  access_token : testToken
// 		  },
// 		  success : function (result ) {
// 			  console.log("result : ", result);
// 		  },
// 		  error : function ( error ) {
// 			  console.log("error : ", error)
// 		  }
		  
							  
// 	  })
	  
	  location.href='/root/member/myPage/test?token='+testToken
  }

	
</script>

	<div id="bodyWrapper">
		<div id="registerInputWrapper" hidden="true">
			<h1>추가 정보 입력</h1>
			<form action="register" id="registerForm" method="post">
				<table>
				
					<tr id="idCol" hidden="true">
						<th>아이디</th>
						<td>
							<input type="text" name="id" id="inputId">
						</td>		
					</tr>
					
					<tr id="nickCol" hidden="true">
						<th>닉네임</th>
						<td>
							<input type="text" name="nick" oninput="nickChk()" id="inputNick">
							<p id="nickInfoMsg"></p>
						</td>		
					</tr>
					
					<tr id="emailCol" hidden="true">
						<th>이메일</th>
						<td>
							<input type="text" id="inputEmail" name="email">
						</td>
					</tr>
					
					<tr id="phoneCol" hidden="true">
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
					<tr id="phoneCodeCol" hidden="true">
						<th>전화번호 인증</th>
						<td>
							<input type="number" placeholder="인증번호를 입력해주세요" id="inputCode">
							<input type="button" disabled id="codeChkBtn" value="인증" onclick="codeChk()">
							<p id="phoneChkInfoMsg"></p>
						</td>		
					</tr>
					<tr>
						<th>생년월일</th>
						<td>
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
					<tr id="genderCol" hidden="true">
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
		<input type="button" onclick="test()" value="test">
	</div>
	<script type="text/javascript">
		
		
		
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
		
		sendMessage = () => {
			const phoneCode = $("#phoneCode").val()
			const phone1 = $("#phone1").val()
			const phone2 = $("#phone2").val()
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
		
		$("#genderMan").click( () => {
			var man = document.getElementById("genderMan");
			var woman = document.getElementById("genderWoman");
			$("#radioMan").click();
			man.style.backgroundColor = "#8d8d8d";
			woman.style.backgroundColor = "#c0c0c0";
			inputGender = 0;
		})
		$("#genderWoman").click( () => {
			var man = document.getElementById("genderMan");
			var woman = document.getElementById("genderWoman");
			$("#radioWoman").click();
			man.style.backgroundColor = "#c0c0c0";
			woman.style.backgroundColor = "#8d8d8d";
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
			console.log(idPass)
			console.log(pwdPass)
			console.log(nickPass)
			console.log(phonePass)
			
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

	</script>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>