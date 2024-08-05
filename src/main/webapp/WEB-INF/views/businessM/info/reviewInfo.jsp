<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/businessM/reviewInfo.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	var currentPage = 1;
	var totalReview = 0;
	var totalPage = 0;
	
    
	
	$(document).ready ( () => {
		getReview(currentPage);
		
		var height = "";
		
		
	})
	
	function sendHeight() {
    	console.log("sendHeight 실행")
    	parent.postMessage({ height: height }, '*');
    }
	
	

	// getReview function start
	function getReview(currentPage) {
		this.currentPage = currentPage
		console.log("currentPage : ", currentPage)
		var count = 0;

		var html = "";
		
		// 내 스토어 리뷰 전체 불러오기
		$.ajax({
			url : "/root/businessM/review?curPage="+currentPage,
			type : "get",
			dataType : "json",
			async : false,
			success : function ( data ) {
				/*
					data  // map으로 전달받음
						curPage 	// 현재 페이지
						endNum 		// db요청시 rownum end값
						startNum	// db요청시 rownum start값
						list		// db에 요청한 데이터(dto값으로 저장)
						totalReview	// 총 리뷰 수량
						viewCont	// 한 페이지에 표시될 리뷰 갯수 (6개)
				*/

				console.log("비교 : " , data != null)
				console.log("비교 : " , data == null)
					console.log("data : ", data);
				console.log("test11111: " , data.list.length)
				if (data.list.length != 0) {
					
					totalReview = data.totalReview;
					totalPage = data.totalPage;
					count = data.list.length;
					
					// forEach 실행
					data.list.forEach(function (result) {
						
						// 불러온 데이터에서 다른db를 참조하는 다른 값들 불러오기
						$.ajax({
							url : "/root/businessM/reviewDetail",
							type : "get",
							data : {
								memId : result.memberId,
								reviewNum : result.storeReviewNum
							},
							async : false,
							contentType : "application/json; charset=utf-8",
							dataType : "json",
							success : function ( result1 ) {
								
								// reviewContent div start
								html += `<div class="reviewContent">`
								
									// reviewLeft div start
									html += `<div class="reviewLeft">`
										
										// reviewLeftTop div start
										// 리뷰어 이미지, 닉네임 표시 구역
										html += `<div class="reviewLeftTop">`
											html += `<img class="reviewerImg" alt="" src="/root/member/myPage/download?img=` + result.memberId + `_` + result1.MEMBER_IMG + `">`
										
											// reviewerNick div start
											html += `<div class="reviewerNick">`
												html += result1.MEMBER_NICK
												html += `<label class="reviewNum">` + result.storeReviewNum + `</label>`
											
											// reviewerNick div end
											html += `</div>`
							
										// reviewLeftTop div end
										html += `</div>`
									
										// reviewLeftBottom div start
										// 리뷰 내용 표시 구역
										html += `<div class="reviewLeftBottom">`
	// 										html += `<label class="reviewText" title="` + result.storeReviewBody + `">`
											html += `<label class="reviewText" title="asdfasdf">`
												html += result.storeReviewBody
											html += `</label>`
										
										// reviewLeftBottom div end
										html += `</div>`
											
									// reviewLeft div end
									html += `</div>`
									
									// reviewRight div start
									// 리뷰 이미지 표시 구역
									html += `<div class="reviewRight">`
										html += `<img class="reviewImg" alt="" src="/root/businessM/download?img=` + result1.STORE_REVIEW_IMG_IMAGE + `">`
									
									// reviewRight div end
									html += `</div>`
									
									//reviewDelete div start
									html += `<div class="reviewDelete">`
										html += `<label class="reviewDeleteBtn" onclick="reviewDeleteOne(`+result.storeReviewNum+`)">X</label>`
									html += `</div>`
					
								// reviewContent div end
								html += `</div>`
								
								html += `<hr>`
									
								// iframe 높이 조절을 위한 코드, 컨텐츠 수량에 맞춰서 늘어난다.
								height = ((count * 138) + 200);
								console.log("height : ", height)
								sendHeight();
								
								reviews = [];
								
								
							}, // ajax success end
							error : function ( error ) {
								console.log("error : ", error)
							}
						}) // ajax end
						
					// forEach 실행 종료
					})
				// if 문 종료
				} else {
					console.log("test")
					html += `<div class="center-box">`
					html += `<img src="/root/businessM/download?img=../BoSeon/보정/리뷰정보.png" width="350px">`
					html += `<br><br>`
					html += `<b>등록된 리뷰가 없습니다</b>`
					html += `<br><br><br>`
					html += `</div>`
					
					$("#reviewContainer").html(html);
					
					height = 700;
					sendHeight();
					
				}
				
				
				
			},
			error : function ( error ) {
				console.log("error : ", error)
			}
			
		}).then(() => {
			
			// 페이징 처리
			
			// 한 라인에 1~10번까지 페이징 번호 표시
			const oneLinePage = 10;
			
			// 반복문의 조건을 만족시키기 위한 시작 페이지 설정
			var startPageNum = Math.floor((currentPage-1) / oneLinePage) * oneLinePage + 1
			var endPageNum = Math.floor(totalPage / oneLinePage) * oneLinePage + 1 == startPageNum ? totalPage : (startPageNum + oneLinePage)-1
			
			// 페이징 div start
			html += `<div id="reviewPaging">`
			
			// 현재 페이지가 1페이지면 < 화살표 비활성화
			if (currentPage == 1) {
				html += `<a class="reviewPageBefore pageBtnDisabled">&lt;</a>`
			} else {
				html += `<a class="reviewPageBefore" onclick = "getReview(`+ (currentPage - 1) + `)">&lt;</a>`
			}
			
			// 페이지 번호간 구분을 위한 기호
			html += `<a class="reviewPageSpacing">│</a>`
			
			// 페이징 번호 표시를 위한 반복문
			for (let i = startPageNum ; i <= endPageNum ; i++ ) {
				
				html += `<a class="reviewPage" onclick="getReview(`+ i + `)">` + i + `</a>`

				// 페이지 번호간 구분을 위한 기호
				html += `<a class="reviewPageSpacing">│</a>`
			}
			
			// 현재 페이지가 마지막 페이지면 > 화살표 비활성화
			if (currentPage == totalPage) {
				html += `<a class="reviewPageBefore pageBtnDisabled">&gt;</a>`
			} else {
				html += `<a class="reviewPageBefore" onclick = "getReview(`+ (currentPage + 1) + `)">&gt;</a>`
			}
			
			// 페이징 div end
			html += `</div>`
			
			// 전체 삭제 버튼 코드 작성
			html += `<div id="reviewDeleteAllBtn">`
				html += `<input type="button" value="전체 삭제" onclick="reviewDeleteAll()">`
			html += `</div>`
			
			
			
			// wrapper에 작성된 html태그 적용
			$("#reviewContentWrapper").html(html);
			
			// 현재 페이지 css 강조 코드
			console.log("pageTest : ", Math.floor((currentPage-1) / 10) + (currentPage % 10))
			console.log("test1 : ", (currentPage-1) % 10)
			$(".reviewPage").eq((currentPage-1) % 10).css("color", "blue")
		})
		
	} // getReview function end
	
	var reviews = [];
	
	function reviewDeleteOne(reviewNum) {
		reviews.push(reviewNum)
		reviewDelete(1);
	}
	
	function reviewDeleteAll() {
		var length = $(".reviewNum").length;
		for (let i = 0; i < length; i++) {
			reviews.push(parseInt($(".reviewNum").eq(i).text(), 10));
		}
		reviewDelete(2);
	}
	
	
	// deleteReview function start
	function reviewDelete(type) {
		console.log("currentPagetest : ", currentPage)
		
		console.log("reviews : " , reviews)
		$.ajax({
			url : "/root/businessM/review",
			type : "delete",
			data : JSON.stringify ({
				reviews : reviews
			}),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function ( data ) {
				console.log("data : ", data)
				alert(data.msg)
				console.log("totalReview : ", totalReview)
				
				if (type == 1) {
					if ((totalReview % 6) == 1) {
						console.log("if문실행")
						getReview(currentPage - 1);
					} else {
						console.log("else문실행")
						getReview(currentPage);					
					}
				} else {
					getReview(currentPage - 1);
				}
			},
			error : function ( error ) {
				console.log("error : ", error)
			}
			
		})
		
		
		reviews = [];
	} // deleteReview function end
	
	
</script>
</head>
<body>
	<div id="reviewContainer" class="white_box">
		<div id="reviewTitleWrapper">
			<hr>
		</div>
		<div id="reviewContentWrapper">
			
			
		</div>
	</div>
</body>
</html>