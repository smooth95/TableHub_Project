<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/info/common.css?after" rel="stylesheet"/>
<link href="<%= request.getContextPath() %>/resources/css/member/info/detail.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(document).ready( () => {
		
		let originImgName = '${dto.img}'
		
		$("#detail").css("font-weight", "bold");
		$("#detail").css("border-bottom", "2px solid #006ad5")
		$("#detail").css("margin-bottom", "6px")
		let email = '${dto.email}'.split("@");
		let emailLocal = email[0]
		let emailDomain = email[1]
		$("#infoEmailLocal").val(emailLocal);
		$("#infoEmailDomain").val(emailDomain);
		
		let phone = '${dto.phone}';
		$("#infoPhoneArea").val('${dto.phone}'.substring(0,3));
		$("#infoPhone1").val('${dto.phone}'.substring(3,7));
		$("#infoPhone2").val('${dto.phone}'.substring(7,11));
		let originPhoneArea = $("#infoPhoneArea").val();
		let originPhone1 = $("#infoPhone1").val();
		let originPhone2 = $("#infoPhone2").val();
		
		var status = $("#infoStatus").val();
		var byteLength = new TextEncoder().encode(status).length;
		$("#infoStatusByte").html(byteLength + " / 100 Byte");
		
		
		$("#infoFileModifyBtn").click( () => {
			$("#infoFile").click();
		})
		
		changeImg = (input) => {
			var reader = new FileReader();
			var imgName = input.files[0].name.split(".");
			imgSize(input.files[0]);
			const regex = /[^a-zA-Z0-9\s가-힣]/;
			if (input.files.length == 1 && !regex.test(imgName[0])) {
				reader.readAsDataURL(input.files[0]);
				reader.onload = function (e) {
					$("#imgInfoMsg").html("이미지 선택 후 저장버튼을 클릭해주셔야 적용이 됩니다.")
					$("#imgInfoMsg").css("color", "#ff6868")
					$("#viewImg").attr('src', e.target.result);
				}
				$("#infoFileSaveBtn").prop("disabled", false);
			} else if (regex.test(imgName[0])) {
				$("#imgInfoMsg").html("파일명에 특수기호가 포함될 수 없습니다.")
				$("#imgInfoMsg").css("color", "#ff6868")
				$("#infoFileSaveBtn").prop("disabled", true);
				$("#viewImg").attr('src', "download?img=${dto.img}");
			} else {
				$("#imgInfoMsg").html("다른 사용자들에게 보여질 이미지를 선택해주세요")
				$("#imgInfoMsg").css("color", "#b9b9b9")
				$("#infoFileSaveBtn").prop("disabled", true);
				$("#viewImg").attr('src', "download?img=${dto.img}");
				
			}
		}
		
		
		imgSize = (img) => {
			if (img) {
				var reader = new FileReader();
				reader.onload = function(e) {
					var image = new Image(reader);
					image.onload = function() {
						var width = image.naturalWidth;
						var height = image.naturalHeight;
						console.log("width : ", width)
						console.log("height : ", height)
						if (width > height) {
							console.log("가로가 큼")
							$("#viewImg").css("width", "auto")
							$("#viewImg").css("max-width", "130px")
							$("#viewImg").css("height", "auto")
						} else {
							console.log("세로가 큼")
							$("#viewImg").css("width", "auto")
							$("#viewImg").css("height", "auto")
							$("#viewImg").css("max-height", "130px")
						}
					}
					image.src = e.target.result;
				}
				reader.readAsDataURL(img);
			}
		}

		$("#infoFileSaveBtn").click( () => {
			var formData = new FormData();
			var infoFile = $("#infoFile")[0].files[0];
			formData.append("file", infoFile)
			formData.append("imgName", originImgName)
			console.log("infofile : ", infoFile)
			$.ajax({
				url: "memberImgModify",
				enctype: "multipart/form-data",
				type: "post",
				data : formData,
			    dataType:'text',
				contentType: false,
				processData: false,
				success : function ( result ) {
					$("#imgInfoMsg").html(result)
					$("#imgInfoMsg").css("color", "#6262ff")
					originImgName = infoFile.name
					$("#infoFileSaveBtn").prop("disabled", true);
					$("#infoFileDeleteBtn").prop("disabled", false);
				},
				error: function (error) {
					console.log("ModifyImg Failed : ", error)
				}
			});
		});
		
		imgDelete = () => {
			var imgName = '${dto.img}';
			var id = '${dto.id}';
			var result = confirm("초기 프로필 이미지로 되돌리시겠습니까?\n확인을 누르면 기본 이미지로 변환됩니다.")
			let form = {imgName : imgName, id : id};
			console.log("imgName : ", imgName)
			console.log("id : ", id)
			console.log(result)
			if (result) {
				$.ajax({
					url : "memberImgDelete",
					type : "post",
					dataType : "text",
					data : JSON.stringify(form),
					contentType : "application/json; charset=utf-8",
					success : function ( result ) {
						$("#imgInfoMsg").html(result)
						$("#imgInfoMsg").css("color", "#6262ff")
						$("#viewImg").attr('src', "download?img=default.jpg");
						$("#infoFileDeleteBtn").prop("disabled", true);
						
					},
					error : function (e) {
						console.log("문제 발생!!!")
						console.log(e)
					}
				})
			}
		}
		
		$("#infoNick").on("input", function() {
			var infoNick = $("#infoNick").val();
			console.log(infoNick.length)
			if (infoNick == '${dto.nick}') {
				$("#infoNickMsg").html("현재 사용중인 닉네임입니다.");
				$("#infoNickMsg").css("color", "#ff6868")
				$("#infoNickBtn").prop("disabled", true);
			} else {
				if (infoNick.length > 10) {
					console.log("2 : ", infoNick.length)
					$("#infoNickMsg").html("10자 이내로 입력해주세요");
					$("#infoNickMsg").css("color", "#ff6868")
					$("#infoNickBtn").prop("disabled", false);
					$(this).val($(this).val().substring(0, 10));
					console.log($(this).val())
				} 
				else if (infoNick.length < 2) {
					$("#infoNickMsg").html("2자 이상 입력해주세요")
					$("#infoNickMsg").css("color", "#ff6868")
					$("#infoNickBtn").prop("disabled", true);
				} 
				else {
					console.log("1 : ", infoNick.length)
					$.ajax({
						url : "/root/member/register/nickChk?nick="+infoNick,
						type : "get",
						dataType : "text",
						contentType : "application/json; charset=utf-8",
						success : function ( result ) {
							if (result == 0) {
								$("#infoNickMsg").html("사용 가능한 닉네임 입니다.");
								$("#infoNickMsg").css("color", "#6262ff")
								$("#infoNickBtn").prop("disabled", false);
							} else {
								$("#infoNickMsg").html("중복되는 닉네임 입니다. 다른 닉네임을 입력해주세요");
								$("#infoNickMsg").css("color", "#ff6868")
								$("#infoNickBtn").prop("disabled", true);
							}
						},
						error : function (e) {
							console.log("문제 발생!!!")
							console.log(e)
						}
					})
				}
			}
		});
		
		$("#infoNickBtn").on("click", function() {
			console.log("asdf")
			let infoNick = $("#infoNick").val();
			console.log("nick : ", infoNick)
			let form = {nick : infoNick}
			$.ajax({
				url : "memberNickModify",
				type : "put",
				dataType : "text",
				data : JSON.stringify(form),
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					$("#infoNickMsg").html("닉네임 수정이 완료되었습니다.");
					$("#infoNickMsg").css("color", "#6262ff")
					$("#infoNickBtn").prop("disabled", false);
				},
				error : function (e) {
					$("#infoNickMsg").html("닉네임 수정중 문제가 발생했습니다. 새로고침 후 다시 시도해주세요.");
					$("#infoNickMsg").css("color", "#ff6868")
					$("#infoNickBtn").prop("disabled", false);
				}
			})
		})
		
		$("#infoStatus").on("input", function() {
			console.log('asdf')
			var status = $(this).val();
			var byteLength = new TextEncoder().encode(status).length;
			if (byteLength > 100) {
				$("#infoStatusMsg").html("100Byte 를 초과할 수 없습니다.");
				$("#infoStatusBtn").prop("disabled", true);
				$("#infoStatusMsg").css("color", "#ff6868")
			} else {
				$("#infoStatusMsg").html("저장을 눌러야 내용이 변경됩니다.")
				$("#infoStatusBtn").prop("disabled", false);
				$("#infoStatusMsg").css("color", "#6262ff")
			}
			$("#infoStatusByte").html(byteLength + " / 100 Byte");
			
		})
		
		$("#infoStatusBtn").on("click", function() {
			var status = $("#infoStatus").val();
			let form = {status : status}
			$.ajax( {
				url : "memberStatusModify",
				type : "put",
				dataType : "text",
				data : JSON.stringify(form),
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {	
					$("#infoStatusMsg").html(result);
					$("#infoStatusMsg").css("color", "#6262ff")
				},
				error : function ( e ) {
					console.log("문제 발생 !!!!")
					console.log(e);
				}
			})
		})
		$("#infoPhoneArea").on("change", function () {
			$("#infoPhoneBtn").prop("disabled", false);
			
		})
		$("#infoPhone1").on("input", function() {
			let phone1 = $(this).val();
			if (phone1.length >= 4) {
				if (originPhone1 == phone1.substring(0,4)) {
					console.log("같은 번호");					
					$("#infoPhone2").focus();
					$(this).val($(this).val().substring(0, 4));
					$("#infoPhoneBtn").prop("disabled", true);
				} else {
					console.log("다른번호")
					$("#infoPhone2").focus();
					$(this).val($(this).val().substring(0, 4));
					$("#infoPhoneBtn").prop("disabled", false);
				}
			} else {
				$("#infoPhoneBtn").prop("disabled", true);
			}
		});
		$("#infoPhone2").on("input", function() {
			let phone2 = $(this).val();
			if (phone2.length >= 4) {
				if (originPhone2 == phone2.substring(0,4)) {
					console.log("같은 번호");					
					$("#infoPhoneBtn").prop("disabled", true);
					$(this).val($(this).val().substring(0, 4));
				} else {
					console.log("다른번호")
					$("#infoPhoneBtn").prop("disabled", false);
					$("#infoPhoneBtn").focus();
					$(this).val($(this).val().substring(0, 4));
				}
			} else {
				$("#infoPhoneBtn").prop("disabled", true);				
			}
		});
		$("#infoPhoneCode").on("input", function() {
			let inputCode = $(this).val();
			if (inputCode.length >= 4) {
				$("#infoPhoneCodeBtn").focus();
				$(this).val($(this).val().substring(0, 4));
				$("#infoPhoneCodeBtn").prop("disabled", false);
			}
		});
		
		
		$("#infoPhoneBtn").on("click", function () {
			const phoneCode = $("#infoPhoneCode").val()
			const phoneArea = $("#infoPhoneArea").val()
			const phone1 = $("#infoPhone1").val()
			const phone2 = $("#infoPhone2").val()
			console.log(phone1.length)
			if (phone1.length < 4) {
				$("#infoPhoneMsg").html("휴대폰 번호를 입력해주세요");
				$("#infoPhoneMsg").css("color", "#ff6868");
				$("#infoPhone1").focus();
			} else if (phone2.length < 4) {
				$("#infoPhoneMsg").html("휴대폰 번호를 입력해주세요");
				$("#infoPhoneMsg").css("color", "#ff6868");
				$("#infoPhone2").focus();
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
						$("#infoPhoneMsg").html(result);
						$("#infoPhoneMsg").css("color", "#6262ff")
						$("#infoPhoneCodeBtn").prop("disabled", false)
						
					},
					error : function (e) {
						console.log("문제 발생!!!")
					}
				})				
			}
		})
		
		$("#infoPhoneCodeBtn").on("click", function() {
			let inputCode = $("#infoPhoneCode").val()
			if (inputCode.length < 4) {
				$("#infoPhoneCodeMsg").html("인증코드를 정확히 입력해주세요");
				$("#infoPhoneCodeMsg").css("color", "#ff6868")
				$("#infoPhoneCode").focus();
			} else {
				let form = {inputCode : inputCode}
				$.ajax({
					url : "/root/member/codeChk",
					type : "post",
					data : JSON.stringify(form),
					dataType : "text",
					contentType : "application/json; charset=utf-8",
					success : function ( result ) {
						const phoneArea = $("#infoPhoneArea").val()
						const phone1 = $("#infoPhone1").val()
						const phone2 = $("#infoPhone2").val()
						var phone = phoneArea + phone1 + phone2;
						if (result == 1) {
							$.ajax({
								url : "memberPhone",
								type : "patch",
								data : JSON.stringify({
									phone : phone,
								}),
								dataType : "text",
								contentType : "application/json; charset=utf-8",
								success : function ( result ) {
									$("#infoPhoneCodeMsg").html(result);
									$("#infoPhoneCodeMsg").css("color", "#6262ff")
									$("#infoPhoneCodeBtn").prop("disabled", true);
									$("#infoPhoneMsg").html(" ");
									$("#infoPhoneBtn").prop("disabled", true);
									$("#infoPhoneCode").val("");
								}, 
								error : function (e) {
									
								}
							})
						} else {
							$("#infoPhoneCodeMsg").html("인증코드가 올바르지 않습니다. 확인 후 입력해주세요");
							$("#infoPhoneCodeMsg").css("color", "#ff6868")
							$("#infoPhoneCodeBtn").prop("disabled", false);
						}
					},
					error : function (e) {
						console.log("문제 발생!!!")
					}
				}).then( () => {
					registerChk();				
				})				
			}
		})
		
		$("#infoEmailLocal").on("input", function () {
			console.log('${dto.email}'.split("@")[0])
			console.log($(this).val())
			// 불러온 이메일 값과 현재 작성한 이메일 주소값이 같으면 disable상태로 만든다.
			if ('${dto.email}'.split("@")[0] == $(this).val()) {
				$("#infoEmailCodeSendBtn").prop("disabled", true);
				
				//입력된 이메일 주소가 영문 20자 이상 넘어갈 경우 메세지 표시 및 버튼 비활성화
			} else if ($(this).val().length > 20) {
				$("#infoEmailMsg").html("이메일주소는 20자 이상을 넘어갈 수 없습니다.");
				$("#infoEmailMsg").css("color", "#ff6868")
				$("#infoEmailCodeSendBtn").prop("disabled", true);
			} else {
				$("#infoEmailCodeSendBtn").prop("disabled", false);
			}
		})
	
		$("#infoEmailCodeSendBtn").on("click", function () {
			let local = $("#infoEmailLocal").val();
			let domain = $("#infoEmailDomain").val();
			$("#codeSendBtn").prop("disabled", true);
			var koreanPattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			if (local == "") {
				$("#infoEmailMsg").html("이메일 주소를 입력해주세요");
				$("#infoEmailMsg").css("color", "#ff6868")
				$("#infoEmailLocal").focus();
				$("#infoEmailCodeSendBtn").prop("disabled", false);
			} else if (koreanPattern.test(local)) {
				$("#infoEmailMsg").html( "한글은 입력할 수 없습니다." );
				$("#infoEmailMsg").css("color", "#ff6868")
				$("#infoEmailCodeSendBtn").prop("disabled", false);
			} else {
				let email = $("#infoEmailLocal").val() + "@" + $("#infoEmailDomain").val(); 
				let form = {email : email};
				$("#infoEmailMsg").html( "인증 코드가 전송되었습니다." );
				$("#infoEmailMsg").css("color", "#6262ff")
				$("#infoEmailCodeSendBtn").prop("disabled", true);
				$.ajax({
					url : "/root/member/sendMail",
					type : "post",
					data : JSON.stringify(form),
					dataType : "json",
					contentType : "application/json; charset=utf-8",
					success : function ( result ) {
						$("#infoEmailMsg").html( result.msg );
						if (result.result == 1) {
							$("#infoEmailMsg").html( "사용중인 이메일 주소입니다. 다른 이메일 주소를 입력해주세요" );
							$("#infoEmailMsg").css("color", "#ff6868")
							$("#infoEmailCodeSendBtn").prop("disabled", false);
						}
					},
					error : function () {
						alert("문제 발생!!!")
					}
				})
			}
		})
		
		
		$("#infoEmailCodeInput").on("input", function() {
			let authCode = $(this).val();
			if (authCode.length >= 4) {
				$("#infoEmailCodeChk").prop("disabled", false);
				$("#infoEmailCodeChk").focus();
				$(this).val($(this).val().substring(0, 4));
			}
		});
		
		
		$("#infoEmailCodeChk").on("click", function () {
			if ($("#infoEmailCodeSendBtn").prop("disabled")) {
				$("#infoEmailCodeChkMsg").html("")
				let code = $("#infoEmailCodeInput").val()
				let email = $("#infoEmailLocal").val() + "@" + $("#infoEmailDomain").val();
				let form = {
					code : code,
					email : email
				};
				$.ajax({
					url : "memberEmail",
					type : "patch",
					data : JSON.stringify(form),
					dataType : "json",
					contentType : "application/json; charset=utf-8",
					success : function ( result ) {
								$("#infoEmailCodeChkMsg").html( result.msg );
							if (result.result == 1) {
								$("#infoEmailCodeChkMsg").css("color", "#6262ff")
								$("#infoEmailCodeInput").val("")
								$("#infoEmailMsg").html("")
								$("#infoEmailCodeChk").prop("disabled", true);
							} else {
								$("#infoEmailCodeChkMsg").css("color", "#ff6868")
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

		})
		
		
		let curPwd = false;
		let chgPwd = false;
		$("#currentPwd").on("input", function() {
			if ($(this).val() != "") {
				curPwd = true;
			} else {
				curPwd = false;
			}
			pwdModify();
		})
		
		
		pwdChk = () => {
			const changePwd = $("#changePwd").val();
			const changePwdAgain = $("#changePwdAgain").val();
			const regex1 = /[^a-zA-Z0-9\s]/;
			const regex2 = /[A-Z]/;
			if (changePwd.length < 6 && changePwd.length > 0) {
				$("#changePwdMsg").html("6자 이상 입력하세요")
				$("#changePwdMsg").css("color", "#ff6868")
				chgPwd = false;
			} else if ( changePwd.length == 0) {
				$("#changePwdMsg").html("비밀번호를 입력해주세요")
				$("#changePwdMsg").css("color", "#ff6868")
			} else {
				if (regex1.test(changePwd) && regex2.test(changePwd)) {
					$("#changePwdMsg").html("사용 가능한 패스워드 입니다.")
					$("#changePwdMsg").css("color", "#6262ff")
					if (changePwd == changePwdAgain) {
						$("#changePwdMsg").html("일치합니다.")
						$("#changePwdMsg").css("color", "#6262ff")
						chgPwd = true;
					} else {
						$("#changePwdMsg").html("비밀번호를 다시 한번 입력해주세요")
						$("#changePwdMsg").css("color", "#ff6868")
						chgPwd = false;
					}
				} else {
					if (regex1.test(changePwd)) {
						$("#changePwdMsg").html("대문자가 하나 이상 필요합니다.")
						chgPwd = false;
					} else if (regex2.test(changePwd)){
						$("#changePwdMsg").html("특수문자가 하나 이상 필요합니다.")
						chgPwd = false;
					} else if (!regex1.test(changePwd) || !regex2.test(changePwd)){
						$("#changePwdMsg").html("특수문자 또는 대문자가 하나 이상씩 필요합니다.")
						chgPwd = false;
					}
					$("#changePwdMsg").css("color", "#ff6868")
				}
			}
			pwdModify();
		}
		
		pwdModify = () => {
			if (curPwd == true && chgPwd == true) {
				$("#changePwdBtn").prop("disabled", false);
			} else {
				$("#changePwdBtn").prop("disabled", true);
			}
		}
		
		
		$("#changePwdBtn").on("click", function () {
			let currentPwd = $("#currentPwd").val();
			let changePwd = $("#changePwd").val();
			let changePwdAgain = $("#changePwdAgain").val();
			
			$.ajax({
				url : "memberPassword",
				type : "patch",
				data : JSON.stringify( {
					currentPwd : currentPwd,
					changePwd : changePwd
				}),
				dataType : 'json',
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					console.log(result.result)
					if (result.result == 1) {
						alert(result.msg)
						location.href="/root/member/login"
					} else if (result.result == 0) {
						$("#changePwdMsg").html(result.msg);
						$("#currentPwdMsg").html("");
						$("#changePwdMsg").css("color", "#ff6868")
					} else if (result.result == -1) {
						$("#currentPwdMsg").html(result.msg);
						$("#changePwdMsg").html("");
						$("#currentPwdMsg").css("color", "#ff6868")
					} else {
						console.log("아뭄ㄴㅇㄹㅁㄴㅇㄹ")
					}
				},
				error : function (e) {
					console.log(e);
				}
			})
			
		})
		
		
		
		var originImgWidth = $("#viewImg").width();
		var originImgHeight = $("#viewImg").height();
		if (originImgWidth > originImgHeight) {
			console.log("가로가 큼")
			$("#viewImg").css("width", "auto")
			$("#viewImg").css("max-width", "130px")
			$("#viewImg").css("height", "auto")
		} else {
			console.log("세로가 큼")
			$("#viewImg").css("width", "auto")
			$("#viewImg").css("height", "auto")
			$("#viewImg").css("max-height", "130px")
		}
		if ('${dto.img}' == "default.jpg") {
			console.log("기본이미지")
			$("#infoFileDeleteBtn").prop("disabled", true);
		} else {
			console.log("사용자이미지")
		}
	});
</script>
<%@ include file="../../main/header.jsp" %>
</head>
<body>
	<div id="myPageWrapper">
		<%@ include file="./myPageMenu.jsp" %>
		<div id="myPageContentWrapper">
			<div id="infoContentWrapper">
			<label id="infoContentTitle">내 정보 확인</label>
			<hr class="contentHr">
				<table id="infoContent">
					<tr>
						<th>프로필 사진</th>
						<td>
							<div id="imgWrapper">
								<img id="viewImg" alt="" src="download?img=${dto.img}"/>
							</div>
							<form id="imgFileForm" style="height:0;">
								<input type="file" name="file" id="infoFile" onchange="changeImg(this)" hidden="true"><br>
							</form>
							<label class="infoMsg" id="imgInfoMsg">다른 사용자들에게 보여질 이미지를 선택해주세요</label><br>
	    					<input type="button" id="infoFileModifyBtn" value="변경">
	    					<input type="button" id="infoFileSaveBtn" value="저장" disabled>
	    					<input type="button" id="infoFileDeleteBtn" onclick="imgDelete()" value="삭제">
						</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" class="inputText" id="infoId" placeholder="${dto.id }" disabled><br>
							<label class="infoMsg">아이디는 변경이 불가능합니다.</label>
						</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>
							<input type="text" class="inputText" id="infoNick" value="${dto.nick }">
							<input type="button" id="infoNickBtn" value="수정" disabled><br>
							<label class="infoMsg" id="infoNickMsg">닉네임은 게시글 또는 리뷰에서 사용됩니다.</label>
						</td>
					</tr>
					<tr>
						<th>상태메세지</th>
						<td>
							<textarea id="infoStatus">${dto.status }</textarea>
							<input type="button" id="infoStatusBtn" value="저장" disabled><br>
							<label class="infoMsg" id="infoStatusMsg">다른사용자에게 보여집니다.</label>
							<label class="infoMsg" id="infoStatusByte">0 / 100 Byte</label>
						</td>
					</tr>
					<tr>
						<th>휴대폰번호</th>
						<td>
							<select id="infoPhoneArea" class="inputText">
								<option>010
								<option>011
							</select><b class="phoneDash">-</b>
							<input type="text" class="inputText" id="infoPhone1"><b class="phoneDash">-</b>
							<input type="text" class="inputText" id="infoPhone2">
							<input type="button" id="infoPhoneBtn" value="인증코드 전송" disabled><br>
							<label class="infoMsg" id="infoPhoneMsg">번호 변경 후 인증코드 전송 버튼을 눌러주세요</label><br>
							<input type="number" class="inputText" id="infoPhoneCode">
							<input type="button" id="infoPhoneCodeBtn" value="번호 수정" disabled><br>
							<label class="infoMsg" id="infoPhoneCodeMsg">전달받은 코드를 입력후 번호 수정을 눌러주세요</label>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input type="text" class="inputText" id="infoEmailLocal" value="${dto.email }">
							<b id="infoEmailAt">@</b>
							<select id="infoEmailDomain" class="inputText">
								<option>naver.com
								<option>gmail.com
								<option>daum.net
							</select>
							<input type="button" id="infoEmailCodeSendBtn" value="인증코드 전송" disabled><br>
							<label class="infoMsg" id="infoEmailMsg">이메일 변경을 위해서는 인증이 필요합니다.</label><br>
							<input type="number" class="inputText" id="infoEmailCodeInput" placeholder="전달 받은 인증코드 입력">
							<input type="button" id="infoEmailCodeChk" value="인증코드 확인" disabled><br>
							<label class="infoMsg" id="infoEmailCodeChkMsg">전달받은 코드를 입력후 번호 수정을 눌러주세요</label>
						</td>
					</tr>
					<c:if test="${userId.split('=')[0] != 'N' }">
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" class="inputText" id="currentPwd" placeholder="현재 비밀번호 입력"><br>
								<label class="infoMsg" id="currentPwdMsg">비밀번호를 변경하면 로그인 페이지로 이동합니다.</label><br><br>
								<input type="password" class="inputText" id="changePwd" oninput="pwdChk()" placeholder="변경할 비밀번호 입력"><br>
								<input type="password" class="inputText" id="changePwdAgain" oninput="pwdChk()" placeholder="변경할 비밀번호 입력 확인">
								<input type="button" id="changePwdBtn" value="비밀번호 변경" disabled><br>
								<label class="infoMsg" id="changePwdMsg"></label>
							</td>
						</tr>					
					</c:if>
				</table>
			</div>
		</div>
	</div>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>