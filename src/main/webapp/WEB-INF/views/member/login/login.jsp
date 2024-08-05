<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="<%= request.getContextPath() %>/resources/css/member/login/login.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script> -->

<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		
		
		const user = "${userId}";
		const store = "${storeId}";
		if (user != "" || store != "") {
			location.href="/root";
		}
		
		
		
		// 입력시 자리수를 넘어가면 먼저 입력된 값들만 남겨두고 새로 입력되는 내용은 버려진다.
		
		$("#authCode").on("input", function() {
			let authCode = $("#authCode").val();
			if (authCode.length >= 4) {
				$("#registerBtn").focus();
				$(this).val($(this).val().substring(0, 4));
			}
		});
		$("#storeAuthCode").on("input", function() {
			let storeAuthCode = $("#storeAuthCode").val();
			if (storeAuthCode.length >= 4) {
				$("#storeRegisterBtn").focus();
				$(this).val($(this).val().substring(0, 4));
			}
		});
		$("#inputStoreId1").on("input", function () {
			if ($(this).val().length > 2) {
				$("#inputStoreId2").focus();
				$(this).val($(this).val().substring(0, 3));
			}
		})
		$("#inputStoreId2").on("input", function () {
			if ($(this).val().length > 1) {
				$("#inputStoreId3").focus();
				$(this).val($(this).val().substring(0, 2));
			}
		})
		$("#inputStoreId3").on("input", function () {
			if ($(this).val().length > 4) {
				$("#inputStorePwd").focus();
				$(this).val($(this).val().substring(0, 5));
			}
		})
		$("#regisInputStoreId1").on("input", function () {
			if ($(this).val().length > 2) {
				$("#regisInputStoreId2").focus();
				$(this).val($(this).val().substring(0, 3));
			}
		})
		$("#regisInputStoreId2").on("input", function () {
			if ($(this).val().length > 1) {
				$("#regisInputStoreId3").focus();
				$(this).val($(this).val().substring(0, 2));
			}
		})
		$("#regisInputStoreId3").on("input", function () {
			if ($(this).val().length > 4) {
				$("#storeRegisterChkBtn").focus();
				$(this).val($(this).val().substring(0, 5));
			}
		})
		
		
		
		// 아이디, 비밀번호 입력시 엔터키를 누르면 로그인이 될 수 있도록 키 이벤트 설정
		document.getElementById("inputPwd").addEventListener('keydown', function (event) {
			if (event.key === 'Enter') {
				loginChk();
			}
		})
		document.getElementById("inputId").addEventListener('keydown', function (event) {
			if (event.key === 'Enter') {
				loginChk();
			}
		})
		document.getElementById("inputStorePwd").addEventListener('keydown', function (event) {
			if (event.key === 'Enter') {
				storeLoginChk();
			}
		})
		
		
		
		//이메일 입력시 엔터키 누르면 메일 전송
		document.getElementById("emailLocal").addEventListener('keydown', function (event) {
			if (event.key === 'Enter') {
				sendMail();
			}
		})
		document.getElementById("storeEmailLocal").addEventListener('keydown', function (event) {
			if (event.key === 'Enter') {
				sendMail();
			}
		})
		
		
		
	}); // dom loaded end
	
	
	
	
	var storeNumPass = false;

	function loginChk() {
		let inputId = $("#inputId").val();
		let inputPwd = $("#inputPwd").val();
		if (inputId == "") {
			$("#infoMsg").html( "아이디를 입력해주세요" );
			$("#infoMsg").css("color", "#ff6868")
			$("#inputId").focus();
		} else if (inputPwd == "") {
			$("#infoMsg").html( "비밀번호를 입력해주세요" );
			$("#infoMsg").css("color", "#ff6868")
			$("#inputPwd").focus();
		} else {
			let form = {id : inputId, pwd : inputPwd};
			$.ajax({
				url : "loginChk",
				type : "post",
				data : JSON.stringify(form),
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					if (result.result == null) {
						location.href="/root/main/mainPage1"
					} else {
						$("#infoMsg").html( result.result );					
					}
				},
				error : function () {
					alert("문제 발생!!!")
				}
			})			
		}
	}
	

	
	function sendMail() {
		let local = $("#emailLocal").val();
		$("#codeSendBtn").prop("disabled", true);
		const regex = /[^a-zA-Z0-9]/;
		
		// 이메일 주소를 입력하지 않고 버튼을 클릭할 경우
		if (local == "") {
			$("#emailInfoMsg").html("이메일 주소를 입력해주세요");
			$("#emailInfoMsg").css("color", "#ff6868")
			$("#emailLocal").focus();
			$("#codeSendBtn").prop("disabled", false);
		// 이메일 주소에 특수문자가 포함되어있을 경우 메세지 표시
		} else if (regex.test(local)) {
			$("#emailInfoMsg").html( "영문자 또는 숫자만 입력할 수 있습니다." );
			$("#emailInfoMsg").css("color", "#ff6868")
			$("#codeSendBtn").prop("disabled", false);
		// 이메일 주소가 20자 이상 넘어갈경우 메세지 표시
		} else if (local.length > 20) {
			$("#emailInfoMsg").html( "이메일주소의 길이는 20를 초과할 수 없습니다." );
			$("#emailInfoMsg").css("color", "#ff6868")
			$("#codeSendBtn").prop("disabled", false);
			
		//이메일 주소를 입력했을 경우 이메일 주소 검증 및 진행
		} else {
			
			// 메일을 보내는데 2~3초정도 걸려서 그전에 미리 메세지를 표시함
			$("#emailInfoMsg").html( "메시지가 곧 전송됩니다." );
			$("#emailInfoMsg").css("color", "#6262ff")
			$("#codeSendBtn").prop("disabled", true);
			
			let email = $("#emailLocal").val() + "@" + $("#emailDomain").val(); 
			let form = {email : email};
			$.ajax({
				url : "sendMail",
				type : "post",
				data : JSON.stringify(form),
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					$("#emailInfoMsg").html( result.msg );
					
					// 이메일 주소 검색 결과 동일한 이메일이 없을경우 코드가 전송이 됨.
					if (result.result == 0) {
						$("#emailInfoMsg").css("color", "#6262ff")
						$("#codeSendBtn").prop("disabled", true);
					} else {
						$("#emailInfoMsg").css("color", "#ff6868")
						$("#codeSendBtn").prop("disabled", false);
					}
				},
				error : function () {
					alert("문제 발생!!!")
				}
			})
		}
	}
	
	function register() {
		if ($("#codeSendBtn").prop("disabled")) {
			$("#registerBtnInfoMsg").html("")
			let code = $("#authCode").val()
			let form = {code : code};
			$.ajax({
				url : "register",
				type : "post",
				data : JSON.stringify(form),
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					console.log("result : ", result.result)
						if (result.result == 1) {
							location.href="register/user"
						} else {
							$("#registerBtnInfoMsg").html( "코드가 올바르지 않습니다." );
							$("#registerBtnInfoMsg").css("color", "#ff6868")
						}
				},
				error : function () {
					alert("문제 발생!!!")
				}
			})
		} else {
			$("#registerBtnInfoMsg").html("이메일 인증을 진행하여 인증코드를 입력해주세요")
			$("#registerBtnInfoMsg").css("color", "#ff6868")
		}

	}		
	var loginTog = 0;
	
	function loginToggle() {
		if (loginTog == 0) {
			loginTog = 1;
			$("#userLogin").slideUp();
			$("#storeLogin").slideDown();
			$(".loginToggleBtn").html("회원 로그인")
			$("#slideLoginToggle").css("margin-top", "0")
		} else {
			loginTog = 0;
			$("#userLogin").slideDown();
			$("#storeLogin").slideUp();
			$("#slideLoginToggle").css("margin-top", "auto")
			$(".loginToggleBtn").html("사업자 로그인")
		}
	}
	var registerTog = 0;
	function registerToggle() {
		if (registerTog == 0) {
			registerTog = 1;
			$("#userRegister").slideUp();
			$("#storeRegister").slideDown();
			$("#slideRegisterToggle").css("margin-top", "0")
			$(".registerToggleBtn").html("사용자 회원가입")
		} else {
			registerTog = 0;
			$("#userRegister").slideDown();
			$("#storeRegister").slideUp();
			$("#slideRegisterToggle").css("margin-top", "auto")
			$(".registerToggleBtn").html("사업자 가입")
		}
	}
	
	
	
	
	
	

	
	function storeLoginChk() {
		let inputStoreId = $("#inputStoreId1").val();
		inputStoreId += $("#inputStoreId2").val();
		inputStoreId += $("#inputStoreId3").val();
		console.log(inputStoreId);
		let inputStorePwd = $("#inputStorePwd").val();
		if ($("#inputStoreId1").val() == "") {
			$("#infoStoreMsg").html( "아이디를 입력해주세요" );
			$("#infoStoreMsg").css("color", "#ff6868")
			$("#inputStoreId1").focus();
		} else if ($("#inputStoreId2").val() == "") {
			$("#infoStoreMsg").html( "아이디를 입력해주세요" );
			$("#infoStoreMsg").css("color", "#ff6868")
			$("#inputStoreId2").focus();
		} else if ($("#inputStoreId3").val() == "") {
			$("#infoStoreMsg").html( "아이디를 입력해주세요" );
			$("#infoStoreMsg").css("color", "#ff6868")
			$("#inputStoreId3").focus();
		} else if (inputStorePwd == "") {
			$("#infoStoreMsg").html( "비밀번호를 입력해주세요" );
			$("#infoStoreMsg").css("color", "#ff6868")
			$("#inputStorePwd").focus();
		} else {
			let form = {id : inputStoreId, pwd : inputStorePwd};
			$.ajax({
				url : "storeLoginChk",
				type : "post",
				data : JSON.stringify(form),
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					if (result.result == null) {
						location.href="/root/main/mainPage1"
					} else {
						$("#infoStoreMsg").html( result.result );
						$("#infoStoreMsg").css("color", "#ff6868")				
					}
				},
				error : function () {
					alert("문제 발생!!!")
				}
			})			
		}
	}
	
	
	function storeNumChk() {
		if ($("#regisInputStoreId1").val().length < 3) {
			$("#infoStoreRegisterMsg").html("사업자번호를 입력해주세요")
			$("#regisInputStoreId1").focus();
			storeNumPass = false;
		} else if ($("#regisInputStoreId2").val().length < 2) {
			$("#infoStoreRegisterMsg").html("사업자번호를 입력해주세요")
			$("#regisInputStoreId2").focus();
			storeNumPass = false;
		} else if ($("#regisInputStoreId3").val().length < 5) {
			$("#infoStoreRegisterMsg").html("사업자번호를 입력해주세요")
			$("#regisInputStoreId3").focus();
			storeNumPass = false;
		} else {
			var storeId = $("#regisInputStoreId1").val() + 
						$("#regisInputStoreId2").val() + 
						$("#regisInputStoreId3").val();
			console.log("storeId : " , storeId)
			let form = {storeId : storeId};
			$.ajax({
				url : "storeNumChk",
				type : "post",
				data : JSON.stringify(form),
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					console.log("result : ", result)
					if (result.result == 0) {
						$("#infoStoreRegisterMsg").html( result.msg );
						$("#infoStoreRegisterMsg").css("color", "#6262ff")
						$("#storeRegisterChkBtn").prop("disabled", true)
						$("#regisInputStoreId1").prop("disabled", true)
						$("#regisInputStoreId2").prop("disabled", true)
						$("#regisInputStoreId3").prop("disabled", true)
						storeNumPass = true;
						$("#storeEmailLocal").focus();
					} else {
						$("#infoStoreRegisterMsg").html( result.msg );
						$("#infoStoreRegisterMsg").css("color", "#ff6868")
						storeNumPass = false;
					}
				},
				error : function () {
					alert("문제 발생!!!")
				}
			})			
		}

	}	
	
	function storeSendMail() {
		// 사업자번호 인증을 하지 않았을 경우 사업자번호 아이디에 포커스
		if (storeNumPass == false ) {
			$("#regisInputStoreId1").focus();
			$("#infoStoreRegisterMsg").html("사업자 번호 조회를 먼저 진행해주세요")
			$("#storeEmailInfoMsg").css("color", "#ff6868")
		} else { // 사업자 인증을 했을 경우 아래 내용 진행
			$("#infoStoreRegisterMsg").html("")
			$("#storeEmailInfoMsg").css("color", "#6262ff")
			
			let local = $("#storeEmailLocal").val();
			let domain = $("#storeEmailDomain").val();
			$("#storeCodeSendBtn").prop("disabled", true);
			var koreanPattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			const regex = /[^a-zA-Z0-9]/;
			
			console.log("test")
			// 입력된 이메일 내용이 없을경우 if문 실행
			if (local == "") {
				$("#storeEmailInfoMsg").html("이메일 주소를 입력해주세요");
				$("#storeEmailInfoMsg").css("color", "#ff6868")
				$("#storeEmailLocal").focus();
				$("#storeCodeSendBtn").prop("disabled", false);
			// 이메일 주소에 영문자 및 숫자를 제외하고 다른 기호를 입력했을 경우 실행되는 코드
			} else if (regex.test(local)) {
				$("#storeEmailInfoMsg").html("영문자 또는 숫자만 입력할 수 있습니다.");
				$("#storeEmailInfoMsg").css("color", "#ff6868")
				$("#storeCodeSendBtn").prop("disabled", false);
			// 이메일 주소가 일정 길이 이상일 경우 실행되는 코드
			} else if (local.length > 20){ 
				$("#storeEmailInfoMsg").html( "이메일은 20자 이상 입력할 수 없습니다." );
				$("#storeEmailInfoMsg").css("color", "#ff6868")
				$("#storeCodeSendBtn").prop("disabled", false);
			} else {
				$("#storeEmailInfoMsg").html( "메일이 잠시 후 전달됩니다." );
				$("#storeEmailInfoMsg").css("color", "#6262ff")
				let email = local + "@" + domain; 
				let form = {email : email};
				$.ajax({
					url : "storeSendMail",
					type : "post",
					data : JSON.stringify(form),
					dataType : "json",
					contentType : "application/json; charset=utf-8",
					success : function ( result ) {
						$("#storeEmailInfoMsg").html( result.msg );
						if (result.result == 0) {
							$("#storeEmailInfoMsg").css("color", "#6262ff")
							$("#storeRegisterCodeSendBtn").prop("disabled", true);
						} else {
							$("#storeEmailInfoMsg").css("color", "#ff6868")
							$("#storeRegisterCodeSendBtn").prop("disabled", false);
						}
					},
					error : function () {
						alert("문제 발생!!!")
					}
				})
			}
		}
	}
	
	function registerCodeChk() {
		console.log("asdf")
		var storeNum = $("#regisInputStoreId1").val();
		storeNum += $("#regisInputStoreId2").val();
		storeNum += $("#regisInputStoreId3").val();
		if ($("#storeRegisterCodeSendBtn").prop("disabled")) {
			$("#storeRegisterBtnInfoMsg").html("")
			let code = $("#storeAuthCode").val()
			let form = {code : code};
			console.log("1")
			$.ajax({
				url : "/root/member/register/registerCodeChk",
				type : "post",
				data : JSON.stringify(form),
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					console.log("result : ", result.result)
						if (result.result == 1) {
							location.href="register/store?storeNum="+storeNum;
						} else {
							$("#storeRegisterBtnInfoMsg").html( "코드가 올바르지 않습니다." );
							$("#storeRegisterBtnInfoMsg").css("color", "#ff6868")
						}
				},
				error : function () {
					alert("문제 발생!!!")
				}
			})
		} else {
			$("#storeRegisterBtnInfoMsg").html("이메일 인증을 진행하여 인증코드를 입력해주세요")
			$("#storeRegisterBtnInfoMsg").css("color", "#ff6868")
		}

	}	

</script>
<%@ include file="../../main/header.jsp" %>

</head>
<body>

	<div id="bodyWrapper">
	
	
		<div id="loginWrapper">
			<div id="userLogin">
				<h1 class="title">회원 로그인</h1>
				<div class="inputField" id="userLoginWrapper">
					<h2>아이디</h2>
					<input type="text" id="inputId" name="id" placeholder="아이디를 입력하세요">
					<h2>비밀번호</h2>
					<input type="password" id="inputPwd" name="pwd" placeholder="비밀번호를 입력하세요">
					<div id="infoMsg"></div>
					<input id="loginBtn" type="button" onclick="loginChk()" value="로그인">
					<br>
					<a id="searchId" onclick="location.href='/root/member/login/searchId'">아이디 찾기</a>&nbsp;&nbsp;/&nbsp;
					<a id="searchPwd" onclick="location.href='/root/member/login/searchPwd'">비밀번호 찾기</a>
				</div>
				<hr width="350" class="fieldHr"><br>
				<h2>SNS로 시작하기</h2><br><br>
				<div id="naver_id_login">
					
				</div>
				<div id="kakao_id_login">
					<img width="200" alt="" src="">
				</div>
			</div>
			
			<div id="slideLoginToggle">
				<h2 class="loginToggleBtn" onclick="loginToggle()">사업자 로그인</h2>
			</div>
			<div id="storeLogin">
				<h1 class="title">사업자 로그인</h1>
				<div class="inputField" id="storeLoginWrapper">
					<h2>사업자등록번호</h2>
					<input type="number" id="inputStoreId1">-
					<input type="number" id="inputStoreId2">-
					<input type="number" id="inputStoreId3">
					<h2>비밀번호</h2>
					<input type="password" id="inputStorePwd" name="storePwd" placeholder="비밀번호를 입력하세요">
					<div id="infoStoreMsg"></div>
					<input id="storeLoginBtn" type="button" onclick="storeLoginChk()" value="로그인">					<br>
					<a id="searchStorePwd" onclick="location.href='login/searchPwd'">비밀번호 찾기</a>
				</div>
				<hr width="350" class="fieldHr"><br>
			</div>
			
			
		</div>
		
		
		<div id="registerWrapper">
		
		
			<div id="userRegister">
				<h1 class="title">회원가입</h1>
				<div id="registerField">
					<h2>이메일 인증</h2>
					<input type="text" placeholder="이메일 주소 입력" id="emailLocal">
					<b style="font-size:20px;">@</b>
					<select id="emailDomain">
						<option>naver.com
						<option>daum.net
						<option>gmail.com
					</select><br>
					<input type="button" value="인증코드 전송" onclick="sendMail()" id="codeSendBtn">
					<div id="emailInfoMsg"></div>
					<input type="number" id="authCode" placeholder="인증코드 입력">
					<input type="button" value="회원 가입" onclick="register()"  id="registerBtn">
					<p id="registerBtnInfoMsg"></p>
				</div>
			</div>
			
			<div id="slideRegisterToggle">
				<h2 class="registerToggleBtn" onclick="registerToggle()">사업자 가입</h2>
			</div>
			
			
			<div id="storeRegister">
				<h1 class="title">사업자 가입</h1>
				<div class="inputField" id="storeLoginWrapper">
					<h2>사업자번호 확인</h2>
					<input type="number" id="regisInputStoreId1">-
					<input type="number" id="regisInputStoreId2">-
					<input type="number" id="regisInputStoreId3">
					<div id="infoStoreRegisterMsg"></div><br>
					<input id="storeRegisterChkBtn" type="button" onclick="storeNumChk()" value="사업자 번호 조회">
					
					<h2>이메일 인증</h2>
					<input type="text" placeholder="이메일 주소 입력" id="storeEmailLocal">
					<b style="font-size:20px;">@</b>
					<select id="storeEmailDomain">
						<option>naver.com
						<option>daum.net
						<option>gmail.com
					</select><br>
					<input type="button" value="인증코드 전송" onclick="storeSendMail()" id="storeRegisterCodeSendBtn">
					<div id="storeEmailInfoMsg"></div>
					<input type="number" id="storeAuthCode" placeholder="인증코드 입력">
					<input type="button" value="회원 가입" onclick="registerCodeChk()"  id="storeRegisterBtn">
					<p id="storeRegisterBtnInfoMsg"></p>
					<br>
				</div>
			</div>
			
			
		</div>
	</div>
 <script type="text/javascript">
	var naver_id_login = new naver_id_login("NY8JwdpMRrDBs7eqhg8A", "http://localhost:8080/root/member/register/naver");
  	var state = naver_id_login.getUniqState();
//   	naver_id_login.setButton("white", 3,40);
  	naver_id_login.setDomain("http://localhost:8080/root/member/login");
  	naver_id_login.setState(state);
  	naver_id_login.init_naver_id_login();
  	
  	$("#naver_id_login_anchor").find("img").attr("src", "<c:url value='/resources/img/naver.png' />");
  	$("#naver_id_login_anchor").find("img").attr("width", "200");
  	$("#naver_id_login_anchor").find("img").attr("height", "53.33");
//   	$("#kakao_id_login").find("img").attr("src", "<c:url value='/resources/img/kakao.png' />");
  	
</script>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>