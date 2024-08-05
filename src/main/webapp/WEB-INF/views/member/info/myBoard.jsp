<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/info/common.css?after" rel="stylesheet"/>
<link href="<%= request.getContextPath() %>/resources/css/member/info/myBoard.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script>
	$(document).ready( () => {
		$("#myBoard").css("font-weight", "bold");
		$("#myBoard").css("border-bottom", "2px solid #006ad5")
		$("#myBoard").css("margin-bottom", "6px")
		$("#myContentMyBoard").css("font-weight", "bold");
		$("#myContentMyBoard").css("border-bottom", "2px solid #006ad5")
		$("#myContentMyBoard").css("margin-bottom", "6px")
		
		let currentPage = 1;
		
		boardPage(1);
		
	})

	var pageViewContent = 10; // 한 페이지에 몇개씩 보여줄지 기준
	
	lastPage = 1;
	totalContent = 0;
	function boardPage(page) {
		getMyInfo();
		deleteBoards = [];
		currentPage = page;
		
		// 보드 정보를 불러오기 위한 ajax요청
		$.ajax({
			url : "/root/member/myPage/board?page="+page,
			type : "get",
			dataType : "json",
			success : function ( data ) {
				console.log("data : ", data)
				lastPage = data.totalPage
				totalContent = data.count
				let html = "";
                if (data.list != null) { // 불러온 데이터가 존재할 경우 실행
	                html += `<tr>`
	                html += `<th class="boardTitle">선택</th>`
	                html += `<th class="boardTitle">번호</th>`
	                html += `<th class="boardTitle">게시판</th>`
	                html += `<th class="boardTitle">제목</th>`
	                html += `<th class="boardTitle">작성일</th>`
	                html += `<th class="boardTitle">조회</th>`
	                html += `</tr>`
					data.list.forEach(function (item, index) { // list값을 반복하여 꺼내온다.
						// 게시글에 달린 댓글 수량 확인을 위한 ajax요청
						$.ajax({
							url : "/root/member/myPage/board/replyCount?boardId="+item.id,
							type : "get",
							dataType : "json",
							async : false,
							success : function (result) {
								
								console.log("result : ", result)
								
								// 불러온 시간형식을 표시할 수 있도록 형변환을 한다.
				                let date = new Date(item.create);
				                let createDate = (date.getFullYear() + '.') +
				                    ('0' + (date.getMonth() + 1)).slice(-2) + "." +
				                    ('0' + (date.getDate())).slice(-2) 
			
				                // 테이블 값을 표현한다.
								html += `<tr>`
								html += `<td class="boardContent">`
								html += `<input class="boardContentSelect" onchange="boardCheck(this,+`+ item.id+`)" type="checkbox">`
								html += `</td>`
								html += `<td class="boardContent">`
								html += `<label class="boardContentNum" onclick="location.href='/root/board/`+item.id+`'">`+item.id+`</label>`
								html += `</td>`
								html += `<td class="boardContent">`
								html += `<label class="boardContentCategory">db값 없음</label>`
								html += `</td>`
								html += `<td class="boardContent">`
								if (result.boardReplyCount != 0) {
									html += `<label class="boardContentTitle" title="`+item.title+`" onclick="location.href='/root/board/`+item.id+`'">` + item.title + `</label>`
									html += `<label class="myBoardContentCount">[`+ result.boardReplyCount +`]</label>`
								} else {
									html += `<label class="boardContentTitle" title="`+item.title+`" onclick="location.href='/root/board/`+item.id+`'">` + item.title + `</label>`									
								}
								html += `</td>`
								html += `<td class="boardContent">`
								html += `<label class="boardContentDate">`+createDate+`</label>`
								html += `</td>`
								html += `<td class="boardContent">`
								html += `<label class="boardContentView">`+item.view+`</label>`
								html += `</td>`
								html += `</tr>`
							}, 
							error : function ( error ) {
								console.log("error : ", error)
							}
						})
						
					})
					html += `<tr>`
					html += `<td class="boardContent" colspan="6">`
					let i = Math.floor((currentPage-1)/pageViewContent)*pageViewContent + 1;
					let endNum = i + (pageViewContent-1);
					html += `<div id="tableBottomLeft">`
					html += `<input type="checkbox" id="boardSelectAll" onclick="boardAllCheck()">`
					html += `<label id="boardSelectAllMsg" for="boardSelectAll">&nbsp;전체 선택</label>`
					html += `</div>`
					html += `<div id="tableBottomMiddle">`
					//현재 페이지 라인이 마지막 페이지라인인지 확인
					
					console.log("start : ", data.startNum)
					
					// 현재 페이지가 스타트 페이지이면 < 화살표 비활성화
					if (currentPage == 1) {
						html += `<a class="boardContentPageB pageDisabledA"><</a>`
					} else {
						html += `<a class="boardContentPageB" onclick="boardPage(`+(currentPage-1)+`)"><</a>`
					}
					
					// 페이지의 마지막 라인에서 빈 버튼을 만들지 않기 위한 제어문
					// 마지막 페이지일 경우 전달받은 최종페이지까지 버튼을 생성
					if (Math.floor((currentPage-1) / pageViewContent) == Math.floor(data.totalPage/pageViewContent)) {
						console.log("마지막 페이지 라인")
						
						// 1~마지막 페이지까지 페이지 표시
						for ( ; i <= data.totalPage; i++) {
							html += `<a class="boardContentPage" onclick="boardPage(`+i+`)">`+i+`</a>`
						}
					} else { // 현재 페이지 라인이 마지막 페이지 아니면 실행
						console.log("1")
						
						// 1~마지막 페이지까지 페이지 표시
						for ( ; i <= endNum; i++) {
							html += `<a class="boardContentPage" onclick="boardPage(`+i+`)">`+i+`</a>`
						} //페이징 if end
					}
					
					//현재페이지가 마지막페이지이면 > 화살표 비활성화
					if (currentPage == data.totalPage) {
						html += `<a class="boardContentPageA pageDisabled">></a>`
					} else {
						html += `<a class="boardContentPageA" onclick="boardPage(`+(currentPage+1)+`)">></a>`								
					}
					
					html += `</div>`
					html += `<div id="tableBottomRight">`
					html += `<input type="button" onclick="deleteBoard()" value="삭제">`
					html += `</div>`
					html += `</td>`
					html += `</tr>`
                } else {
                	html = "작성한 게시글이 없습니다.";
                }// if end
				
				$("#myBoardTable").html( html );
                var curPageBold = currentPage - Math.floor((currentPage-1) / pageViewContent)*pageViewContent
				$(".boardContentPage").eq(curPageBold-1).css("color", "black")
			}, // success end
			error : function ( error ) {
				console.log("에러 발생")
				console.log(error)
			} // error end
		}) // ajax end
	} //boardPage function end
	var deleteBoards = [];
	function boardCheck(item, num) {
		console.log("item : " , item)
		console.log("num : " , num)
		console.log("selected : ", item.checked)
		if (item.checked) {
			deleteBoards.push(num);
		} else {
			deleteBoards = deleteBoards.filter(function(item) {
			    return item !== num;
			});
		}
		console.log("checked : ", deleteBoards)
	}
	
	function boardAllCheck() {
		var content = document.getElementsByClassName("boardContentSelect")
		$("#boardSelectAll").checked = true;
		Array.from(content).forEach(function(item, index) {
			if ($("#boardSelectAll").prop("checked") == !item.checked) {
				item.click();
			}
		})
	}
	
	function deleteBoard() {
		if (deleteBoards == "") {
			alert("삭제할 항목을 선택해주세요")
		} else {
			var lastPageBefore = lastPage;
			$.ajax({
				url : "/root/member/myPage/board",
				type : "delete",
				dataType : "json",
				data : JSON.stringify ({
					content : deleteBoards
				}),
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					console.log("result : ", result)
					alert(result.msg);
					console.log("lastPageBefore : " , lastPageBefore)
					console.log("lastPage : " , lastPage)
					console.log("length : ", deleteBoards.length)
					totalContent = totalContent - deleteBoards.length;
					console.log("asdf : ", (lastPage-1)*pageViewContent);
					console.log("fdsa : ", totalContent);
					var test = ((lastPage-1) * pageViewContent) - totalContent;
					console.log("test : ", test)
					if (currentPage == lastPage && test == 0 ) {
						console.log("11")
						boardPage(currentPage-1);
					} else {
						console.log("22")
						boardPage(currentPage);					
					}
				},
				error : function ( error ) {
					console.log("error : ", error)
				}
			})			
		}
	}

</script>

<%@ include file="../../main/header.jsp" %>
</head>
<body>
	<div id="myPageWrapper">
	
		<!-- 좌측 메뉴 불러오기 -->
		<%@ include file="./myPageMenu.jsp" %>
		
		<!-- 실질적인 페이지 컨텐츠 내용 표시 -->
		<div id="myPageContentWrapper">
			<div id="myBoardWrapper">
				<%@ include file="./myContentMyInfo.jsp" %>
				<table id="myBoardTable">
				</table>
			</div>
		</div>
	</div>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>