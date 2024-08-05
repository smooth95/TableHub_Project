<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/info/common.css?after" rel="stylesheet"/>
<link href="<%= request.getContextPath() %>/resources/css/member/info/myReview.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(document).ready( () => {
		$("#myReview").css("font-weight", "bold");
		$("#myReview").css("border-bottom", "2px solid #006ad5")
		$("#myReview").css("margin-bottom", "6px")
		
		$("#myContentMyReview").css("font-weight", "bold");
		$("#myContentMyReview").css("border-bottom", "2px solid #006ad5");
		$("#myContentMyReview").css("margin-bottom", "6px")
		
		let currentPage = 1;
		
		reviewPage(1);
	})

	var pageViewContent = 5; // 한 페이지에 몇개씩 보여줄지 기준
	
	lastPage = 1;
	totalContent = 0;
	function reviewPage(page) {
		getMyInfo();
		currentPage = page;
		console.log("currentPage : " , currentPage)
		$.ajax({
			url : "/root/member/myPage/review?page="+page,
			type : "get",
			dataType : "json",
			success : function ( data ) {
				lastPage = data.totalPage
				totalContent = data.count
				let html = "";
				console.log("data : ", data)
                if (data.list != null) { // 불러온 데이터가 존재할 경우 실행
                	console.log("123123")
//     				
    				
					data.list.forEach(function (item, index) { // list값을 반복하여 꺼내온다.
						var scoreStar = "";
						var score = item.score;
						for (let i = 1; i <= 5; i++) {
							if (score != 0) {
								scoreStar += "★"
								score = score - 1;
							} else {
								scoreStar += "☆"
							}
						}
						//가게 이름 및 이미지를 불러오기위한 ajax
						$.ajax( {
							url : "/root/member/myPage/review/reviewInfo?storeId="+item.storeId+"&reviewNum="+item.num,
							type : "get",
							dataType : "json",
							async : false,
							success : function ( result ) {
								console.log("resultsdfsdf : ", result)
								// 불러온 시간형식을 표시할 수 있도록 형변환을 한다.
				                let date = new Date(item.create);
				                let createDate = (date.getFullYear() + '.') +
				                    ('0' + (date.getMonth() + 1)).slice(-2) + "." +
				                    ('0' + (date.getDate())).slice(-2) 
				                    
				                //리뷰항목에서 가게 정보 부분을 표시

    							html += `<div class="reviewWrapper">`
				   					html += `<div class="storeInfo">`
				    					
				     					// 가게정보부분에서 왼쪽 이미지를 나타내는 영역
										html += `<div class="storeInfoLeft">`
					 						html += `<img class="storeImg" alt="" src="/root/businessM/download?img=` + result.STORE_IMG_ROOT + `">`				
					 					html += `</div>`
				    						
				     					//가운데 가게이름과 평점을 나타내는 영역
					    				html += `<div class="storeInfoMiddle">`
						    				html += `<label class="storeInfoTitle">`+result.STORE_NAME+`</label><br>`
						    				html += `<label class="storeInfoScoreStar">`+scoreStar+`</label>`
						    				html += `<label class="storeInfoScore">`+item.score+`점</label>`
						    				html += `<label class="storeInfoCreate">작성일 : `+createDate+`</label>`
					    				html += `</div>`
				    						
				     					//오른쪽 삭제부분을 표시할 영역
					    				html += `<div class="storeInfoRight">`
					    					html += `<label class="storeInfoDelete" onclick="deleteReview(`+item.num+`)">X</label>`
					    				html += `</div>`
				    						
				     				//storeInfo div end
				    				html += `</div>`
				    					
				     				//리뷰의 실제 내용을 나타낼 영역
				    				html += `<div class="reviewInfo">`
				     				
					    				html += `<div class="reviewInfoLeft">`
					    				console.log("test1 : ", result.reviewImg)
					    				console.log("test2 : ", result.reviewImg != null)
					    					if (result.reviewImg != null) {
						    					html += `<img class="reviewInfoImg" alt="" src="download?img=` + result.reviewImg + `">`					    						
					    					}
					   					html += `</div>`
				   					
					  					html += `<div class="reviewInfoMiddle">`
					 						html += `<textarea class="reviewInfoContent" rows="4" cols="50" disabled>`+item.body+`</textarea>`
					    				html += `</div>`
				    				
				    				// reviewInfo div end
				    				html += `</div>`
		        				html += `</div>`
	            				html += `<hr class="myContentHr">`
								
							}, error : function ( error ) {
								console.log("error : ", error)
							}
						})
						
					})
					
					let i = Math.floor((currentPage-1)/pageViewContent)*pageViewContent + 1;
					let endNum = i + (pageViewContent-1);
					

//     				reviewWrapper div end
					
					// 테이블 페이징 표시하는 부분
					html += `<div id="divBottomLeft">`
					html += `</div>`
					html += `<div id="divBottomMiddle">`
					
					//현재 페이지 라인이 마지막 페이지라인인지 확인
					if (Math.floor((currentPage-1) / pageViewContent) == Math.floor(data.totalPage/pageViewContent)) {
						console.log("마지막 페이지 라인")
						// 현재 페이지가 스타트 페이지이면 < 화살표 비활성화
						if (currentPage == data.startNum) {
							html += `<a class="reviewContentPageB pageDisabledA"><</a>`
						} else {
							html += `<a class="reviewContentPageB" onclick="reviewPage(`+(currentPage-1)+`)"><</a>`
						}
						// 1~마지막 페이지까지 페이지 표시
						for ( ; i <= data.totalPage; i++) {
							html += `<a class="reviewContentPage" onclick="reviewPage(`+i+`)">`+i+`</a>`
						}
						//현재페이지가 마지막페이지이면 > 화살표 비활성화
						if (currentPage == data.totalPage) {
							html += `<a class="reviewContentPageA pageDisabledA">></a>`							
						} else {
							html += `<a class="reviewContentPageA" onclick="reviewPage(`+(currentPage+1)+`)">></a>`														
						}
					} else { // 현재 페이지 라인이 마지막 페이지 아니면 실행
						console.log("1")
						// 현재 페이지가 1페이지이면 < 화살표 비활성화
						if (currentPage == 1) {
							html += `<a class="reviewContentPageB pageDisabled"><</a>`							
						} else {
							html += `<a class="reviewContentPageB" onclick="reviewPage(`+(currentPage-1)+`)"><</a>`														
						}
						// 시작페이지~ 시작페이지+10 페이지까지 페이지 표시
						for ( ; i <= endNum; i++) {
							html += `<a class="reviewContentPage" onclick="reviewPage(`+i+`)">`+i+`</a>`
						}
						//현재페이지가 마지막 페이지일경우 > 화살표 비활성화
						if (currentPage == data.totalPage) {
							html += `<a class="reviewContentPageA pageDisabled">></a>`
						} else {
							html += `<a class="reviewContentPageA" onclick="reviewPage(`+(currentPage+1)+`)">></a>`								
						}
					} //페이징 if end
					html += `</div>`
					html += `<div id="divBottomRight">`
					html += `</div>`
                } else {
                	html = "작성한 리뷰가 없습니다.";
                }// if end
				$("#myReviewContentWrapper").html( html );
                
                // 현재 페이지 버튼에 하이라이트하기위한 수식과 jquery를 사용하여 css옵션 주기
                var curPageBold = currentPage - Math.floor((currentPage-1) / pageViewContent)*pageViewContent
				$(".reviewContentPage").eq(curPageBold-1).css("color", "black")
			}, // success end
			error : function ( error ) {
				console.log("에러 발생")
				console.log(error)
			} // error end
		}) // ajax end
	} //reviewPage function end
	
	
	function deleteReview(storeNum) {
		$.ajax({
			url : "/root/member/myPage/review",
			type : "delete",
			dataType : "json",
			data : JSON.stringify ({
				storeNum : storeNum
			}),
			contentType : "application/json; charset=utf-8",
			success : function ( result ) {
				console.log("result : ", result)
				alert(result.msg)
				console.log("totalContent : " + totalContent)
				console.log("currentpage : ", currentPage)
				if (currentPage == lastPage && (totalContent-1) % 5 == 0 ) {
					reviewPage(currentPage-1);					
				} else {
					reviewPage(currentPage);
				}
			},
			error : function ( error ) {
				console.log("error : ", error)
			}
		})
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
			<div id="myReviewWrapper">
				<%@ include file="./myContentMyInfo.jsp" %>
				<div id="myReviewContentWrapper">
				
				</div>
				
			</div>
		</div>
	</div>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>