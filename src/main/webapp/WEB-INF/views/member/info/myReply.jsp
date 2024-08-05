<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/info/common.css?after" rel="stylesheet"/>
<link href="<%= request.getContextPath() %>/resources/css/member/info/myReply.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script>
	$(document).ready( () => {
		$("#myReply").css("font-weight", "bold");
		$("#myReply").css("border-bottom", "2px solid #006ad5")
		$("#myReply").css("margin-bottom", "6px")
		$("#myContentMyReply").css("font-weight", "bold");
		$("#myContentMyReply").css("border-bottom", "2px solid #006ad5")
		$("#myContentMyReply").css("margin-bottom", "6px")
		
		
		getReply(1);
	})
	
	var currentPage = 1; // 현재 페이지 저장
	var contentCount = 6; // 한 페이지에서 보여줄 리뷰 수
	var lastPage = 1;
	var totalContent = 0;
	var pageContent = 0; // 현재 페이지에서 보여지는 수량
	
	function getReply(page) {
		getMyInfo();
		currentPage = page
		deleteReplys = []
		// 내가 작성한 댓글 불러오기
		$.ajax({
			url : "/root/member/myPage/reply?page="+page,
			type : "get",
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function ( data ) {
				console.log("datadata : ", data)
				var html = "";
				
				
				// 내가 작성한 댓글이 하나 이상 있을때
				if (data.result == 1) {
					
					lastPage = data.totalPage;
					totalContent = data.count;
					pageContent = data.list.length;
					
					//댓글 당산 타이틀 내용 작성
					html += `<div class="myReplyTitle">`
						html += `<b class="myReplyTitleLeft">선택</b>`
						html += `<b class="myReplyTitleMiddle">댓글</b>`
						html += `<b class="myReplyTitleRight">댓글 작성일</b>`
					html += `</div>`
					html += `<hr class="myContentHr">`
					
					// 불러온 댓글 데이터를 반복하여 출력
					data.list.forEach(function (item, index) {

		                let date = new Date(item.COMBINED_DATE+9);
		                let currentDateTime = new Date();
		                
		                // 시간을 비교하여 오늘이면 시:분 으로 표시하고 이전이면 년월일로 표시
		                // 시간의 형식도 변경하여 표시한다.
		                let createDate = "";
		                // 오늘이라면 if문 실행 아니라면 else문 실행
	                    if (date.getFullYear() == currentDateTime.getFullYear()
	                		&& date.getMonth() == currentDateTime.getMonth()
	                		&& date.getDate() == currentDateTime.getDate()) {
	                    	// 시 : 분 으로 표시될 수 있도록 형식변경
		                	createDate = ('0' + (date.getHours())).slice(-2) + ":" +
	                					 ('0' + (date.getMinutes())).slice(-2);
		                } else {
		                	// 년 월 일로 표시될 수 있도록 형식변경
		                	createDate = (date.getFullYear() + '.') +
		                    ('0' + (date.getMonth() + 1)).slice(-2) + "." +
		                    ('0' + (date.getDate())).slice(-2);
		                }
						
		                // 게시판 제목과 해당 게시판의 댓글 수량을 불러오기 위한 ajax요청
		                if (item.BOARD_REVIEW2_ID == null) {
							$.ajax({ //내부 ajax start
								url : "/root/member/myPage/reply/board?boardId="+item.BOARD_ID,
								type : "get",
								dataType : "json",
								async : false,
								contentType : "application/json; charset=utf-8",
								success : function (result) {
									console.log("result : " , result)
									
									html += `<div class="myReplyContent">`
									
									html += `<div class="myReplyContentLeft">`
									html += `<input type="checkbox" class="myReplyContentCheck" onchange="replyCheck(this,+`+item.BOARD_REVIEW_ID+`, 1)">`
									html += `</div>`
									
									html += `<div class="myReplyContentMiddle">`
									html += `<label class="myReplyContentReply"><label class="replyType">[댓&nbsp;&nbsp;&nbsp;글]</label>`+item.BOARD_REVIEW_CONTENT+`</label>`
									html += `<label class="myReplyContentBody">`+result.BOARD_TITLE+`</label> <label class="myReplyContentCount">[`+ result.TOTAL_COUNT +`]</label>`
									html += `</div>`
									
									html += `<div class="myReplyContentRight">`
									html += `<label class="myReplyContentCreate">`+createDate+`</label>`
									html += `</div>`
										
									html += `</div>`
									
									html += `<hr class="myReplyHr">`
									
								},
								error : function (error) {
									console.log("error : ", error);
								}
								
							}) // 내부 ajax end
		                } else {
		                	$.ajax({ //내부 ajax start
								url : "/root/member/myPage/reply2/board?reviewId="+item.BOARD_REVIEW_ID,
								type : "get",
								dataType : "json",
								async : false,
								contentType : "application/json; charset=utf-8",
								success : function (result) {
									
									html += `<div class="myReplyContent">`
									
									html += `<div class="myReplyContentLeft">`
									html += `<input type="checkbox" class="myReplyContentCheck" onchange="replyCheck(this,+`+item.BOARD_REVIEW2_ID+`, 2)">`
									html += `</div>`
									
									html += `<div class="myReplyContentMiddle">`
									html += `<label class="myReplyContentReply"><label class="replyType">[대댓글]</label> `+item.BOARD_REVIEW2_CONTENT+`</label>`
									html += `<label class="myReplyContentBody">`+result.BOARD_TITLE+`</label> <label class="myReplyContentCount">[`+ result.TOTAL_COUNT +`]</label>`
									html += `</div>`
									
									html += `<div class="myReplyContentRight">`
									html += `<label class="myReplyContentCreate">`+createDate+`</label>`
									html += `</div>`
										
									html += `</div>`
									
									html += `<hr class="myReplyHr">`
									
								},
								error : function (error) {
									console.log("error : ", error);
								}
								
							}) // 내부 ajax end
		                }
						
						
					}) // forEach문 end
					
					var i = Math.floor((currentPage-1) / contentCount)*contentCount + 1;
					var endI = i + (contentCount-1);

					//bottom 역역
					html += `<div id="bottomWrapper">`
					
					//체크 버튼 영역
					html += `<div class="myReplyContentBottomLeft">`
						html += `<input type="checkbox" id="selectAll" class="myReplySelectAll" onclick="replyAllCheck()">`
						html += `<label for="selectAll" class="myReplySelectAll">전체선택</label>`
					html += `</div>`
					
					//페이징 영역
					html += `<div class="myReplyContentBottomMiddle">`
					
					//현재 페이지 라인이 마지막 페이지 라인일때 if문 동작
					if (Math.floor(data.totalPage / contentCount) == Math.floor((currentPage-1) / contentCount)) {
						if (currentPage == 1) {
							html += `<a class="pageBtnDisabled"><</a>`																
						} else {
							html += `<a onclick="getReply(`+(currentPage-1)+`)" class="pageBtnA"><</a>`																
						}
						
						for ( ; i <= data.totalPage; i++) {
							console.log("1")
							html += `<a onclick="getReply(`+i+`)" class="pageBtn">`+i+`</a>`								
						}
						
						if (currentPage == data.totalPage) {
							html += `<a class="pageBtnDisabled">></a>`																
						} else {
							html += `<a onclick="getReply(`+(currentPage+1)+`)" class="pageBtnA">></a>`																
						}
					} else { // 현재 페이지 라인이 마지막이 아니라면 else문 동작
						if (currentPage == 1) {
							html += `<a class="pageBtnDisabled"><</a>`																
						} else {
							html += `<a onclick="getReply(`+(currentPage-1)+`)" class="pageBtnA"><</a>`																
						}
						
						for ( ; i <= endI; i++) {
							console.log("2")
							html += `<a onclick="getReply(`+i+`)" class="pageBtn">`+i+`</a>`								
						}
						
						if (currentPage == data.totalPage) {
							html += `<a class="pageBtnDisabled">></a>`																
						} else {
							html += `<a onclick="getReply(`+(currentPage+1)+`)" class="pageBtnA">></a>`																
						}
					}
					
					// bottom middle 영역 end
					html += `</div>`
					
					// 삭제 버튼 영역
					html += `<div class="myReplyContentBottomRight">`
						html += `<input type="button" value="삭제" class="deleteBtn" onclick="deleteReply()"></input>`
					html += `</div>`
	
					//bottom 영역 end
					html += `</div>`
					
					
				} else { // 내가 작성한 댓글이 하나도 없을때
					html += `<label>작성한 댓글이 없습니다.</label>`
				}
				
				$("#myReplyContentWrapper").html(html);
				
				var btnBold = currentPage - Math.floor((currentPage - 1) / contentCount) * contentCount
				$(".pageBtn").eq(btnBold-1).css("color", "black")
				
			},
			error : function ( error ) {
				
			}
		})
		
	}
	var deleteReplys = [];
	
	function replyCheck(item, num, type) {
		
		var test = [];
		test.push(num);
		test.push(type);
		if (item.checked) {
			deleteReplys.push(test);
		} else {
			deleteReplys = deleteReplys.filter(function(item) {
			    return item[0] !== num;
			});
		}
		console.log("checked : ", deleteReplys)
	}
	
	function replyAllCheck() {
		console.log("allcheck실행")
		var content = document.getElementsByClassName("myReplyContentCheck")
		$("#selectAll").checked = true;
		Array.from(content).forEach(function(item, index) {
			if ($("#selectAll").prop("checked") == !item.checked) {
				item.click();
			}
		})
	}
	
	function deleteReply() {
		console.log("deleteReplys : " , deleteReplys)
		if (deleteReplys == "") {
			alert("삭제할 항목을 선택해주세요")
		} else {
			var lastPageBefore = lastPage;
			$.ajax({
				url : "/root/member/myPage/reply",
				type : "delete",
				dataType : "json",
				data : JSON.stringify ({
					content : deleteReplys
				}),
				contentType : "application/json; charset=utf-8",
				success : function ( result ) {
					
					console.log("result123 : ", result)
					
					alert(result.msg);
					
					totalContent = totalContent - deleteReplys.length;
					
					var test = ((lastPage-1) * contentCount) - totalContent;
					
					if (currentPage == lastPage && test == 0 ) {
						getReply(currentPage-1);
					} else {
						getReply(currentPage);					
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
		<%@ include file="./myPageMenu.jsp" %>
		<div id="myPageContentWrapper">
			<div id="myReplyWrapper">
				<%@ include file="./myContentMyInfo.jsp" %>
				
				<div id="myReplyContentWrapper">
				</div>
			</div>
		</div>
	</div>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>