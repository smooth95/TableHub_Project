<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%= request.getContextPath() %>/resources/css/member/info/common.css?after" rel="stylesheet"/>
<link href="<%= request.getContextPath() %>/resources/css/member/info/myBooking.css?after" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script>
	$(document).ready( () => {
		console.log("userId : ", '${userId}')
		if ('${userId}' == "") {
			location.href = "/root";
		} else {
			$("#myBooking").css("font-weight", "bold");
			$("#myBooking").css("border-bottom", "2px solid #006ad5")
			$("#myBooking").css("margin-bottom", "6px")
	
			getBookingReady(1);
			getBookingAlready(1);			
		}
		
		$(".alreadyPageBtnA:disabled").css("color", "red");
	})
	
	var pageViewContent = 6;
	
	var readyCurrentPage = 1;
	function getBookingReady(page) {
		readyCurrentPage = page;
	    $.ajax({
	        url: "bookingReady?page=" + page,
	        type: "get",
	        dataType: "json",
	        success: function(data) {
	            let content = ""; // content 변수를 초기화합니다.
	            let promises = []; // 모든 AJAX 요청을 관리하기 위한 배열을 선언합니다.
				
				if (data.count != 0) {
		            data.list.forEach(function(item, index) {
		                let date = new Date(item.date);
		                let bookingDate = (date.getFullYear() + '년 ') +
		                    ('0' + (date.getMonth() + 1)).slice(-2) + "월 " +
		                    ('0' + (date.getDate())).slice(-2) + "일 " +
		                    item.time;
	
		                // 각 예약 항목에 대한 HTML 생성을 비동기적으로 처리합니다.
		                let promise = $.ajax({
		                    url: "getBookingInfo?storeId=" + item.storeId,
		                    type: "get",
		        			async : false,
		                    dataType: "json"
		                }).then(function(result) {
		                	console.log("result : ", result)
		                    // AJAX 요청이 성공하면 content에 HTML을 추가합니다.
		                    content += `<div class="readyContentInfo">`;
		                    content += `<label class="bookingStoreName" title="`+result.storeName+`">`+result.storeName+`</label>`;
		                    content += `<label class="bookingStatusReady">방문 대기</label>`;
		                    content += `<a class="bookingDelete" onclick="readyBookingDelete(`+item.id+`)">X</a><br>`;
		                    content += `<img class="bookingStoreImg" alt="" src="/root/businessM/download?img=` + result.storeImg + `"><br>`;
// 		                    content += `<img class="bookingStoreImg" alt="" src="https://www.gyeongju.go.kr/upload/content/thumb/20200529/4368708A9CC649CDB1EC5DD0C389804C.jpg"><br>`;

		                    content += `<label class="bookingDate">`+bookingDate+`</label><br>`;
		                    content += `<label class="bookingPerson">성인 `+item.person+`명</label>`;
		                    content += `<hr>`;
		                    content += `<label class="bookingStatusReviewReady">방문 후 리뷰 작성 가능</label>`;
		                    content += `</div>`;
		                }).catch(function(error) {
		                    console.log(error);
		                });
	
		                promises.push(promise); // promises 배열에 각 AJAX 요청을 추가합니다.
		            });
	
		            // 모든 AJAX 요청이 완료된 후에 UI를 업데이트합니다.
		            $.when.apply($, promises).then(function() {
		                $("#readyContent").html(content); // content를 readyContent에 추가합니다.
	
		                let readyWrapper = $("#bookContentReadyWrapper");
		                readyWrapper.find("#totalReadyPageMenu").remove();
	
		                if (data.totalPage != 1) {
							let pageNum = Math.floor((readyCurrentPage-1) / 10);
		                	
		                    let html = `<div id="totalReadyPageMenu">`;
		                    html += `<hr class="contentHr">`
			                    
			                    // 현재 페이지라인이 마지막 페이지라인일경우
			                    if ( pageNum != 0 && pageNum == (Math.floor((data.totalPage) / 10) )) {
				                	console.log("2")
			                    	let i = (pageNum*10 + 1)
			                        html += `<a class="readyPageBtnA" onclick="getBookingReady(`+(readyCurrentPage-1)+`)">&lt;</a>`;
			                        
				                    for ( ; i <= data.totalPage; i++) {
				                    	html += `<a class="readyPageBtn" onclick="getBookingReady(`+i+`)">`+i+`</a>`;
				                    }
				                    
				                    if (data.totalPage == readyCurrentPage) {
					                    html += `<a class="readyPageBtnDisabled">></a>`;			                    	
				                    } else {
				                    	html += `<a class="readyPageBtnB" onclick="getBookingReady(`+(readyCurrentPage+1)+`)">></a>`;		                    				                    	
				                    }
			                    } 
			                    
			                    // 현재 페이지가 첫번째가 아닐경우
			                    else if (pageNum != 0) {
				                	console.log("3")
			                    	let i = (pageNum * 10 + 1)
			                    	console.log("i : ", i)
			                    	console.log("pageNum : ", pageNum)
			                    	console.log("test : ", pageNum * pageViewContent + pageViewContent)
			                        html += `<a class="readyPageBtnA" onclick="getBookingReady(`+(readyCurrentPage-1)+`)"><</a>`;
			                        
				                    for ( ; i <= (pageNum * 10 + 10); i++) {
				                    	html += `<a class="readyPageBtn" onclick="getBookingReady(`+i+`)">`+i+`</a>`;
				                    }
				                    
				                    if (data.totalPage == readyCurrentPage) {
				                    	html += `<a class="readyPageBtnDisabled">></a>`;
				                    } else {
				                    	html += `<a class="readyPageBtnB" onclick="getBookingReady(`+(readyCurrentPage+1)+`)">></a>`;
				                    }
			                    } 
			                    
			                    // 현재 페이지라인이 첫번째일 경우
			                    else {
				                	console.log("4")
			                    	let i = (pageNum + 1)
			                    	
			                    	console.log("readyCurrentPage : ", readyCurrentPage)
			                    	console.log("data : ", data)
			                    	
			                    	if (readyCurrentPage == 1) {
			                    		html += `<a class="readyPageBtnDisabled"><</a>`;		                    				                    		
			                    	} else {
			                    		html += `<a class="readyPageBtnA" onclick="getBookingReady(`+(readyCurrentPage-1)+`)"><</a>`;		                    		
			                    	}
			                        
				                    for ( ; i <= data.totalPage; i++) {
				                    	html += `<a class="readyPageBtn" onclick="getBookingReady(`+i+`)">`+i+`</a>`;
				                        if (i == 10) break;
				                    }
				                    
				                    console.log("data.totalPage : ", data.totalPage)
				                    console.log("pageViewContent", pageViewContent)
				                    
			                    	if (data.totalPage == readyCurrentPage) {
			                    		html += `<a class="readyPageBtnDisabled">></a>`;
			                    	} else {
			                    		html += `<a class="readyPageBtnB" onclick="getBookingReady(`+(readyCurrentPage+1)+`)">></a>`;		                    		
			                    	}
			                    }
		                    
		                    
		                    html += `</div>`;
		                    readyWrapper.append(html);
		                } else {
		                	console.log("???")
							 let pageNum = Math.floor(readyCurrentPage / 10);
		                }
		                $(".readyPageBtn").eq(readyCurrentPage%10-1).css("color", "blue")
		                $(".readyPageBtn").eq(readyCurrentPage%10-1).css("border-bottom", "2px solid #7777ff")
		            });
				} else {
	            	$("#readyContent").html("<label class='contentNothing'>예약 내역이 없습니다</label>"); 
				}
	        },
	        error: function(error) {
	            console.log(error);
	        }
	    });
	}

	var alreadyCurrentPage = 1;
	function getBookingAlready(page) {
		alreadyCurrentPage = page;
		console.log("currentPage : ", alreadyCurrentPage)
		$.ajax({
			url : "bookingAlready?page="+page,
			type : "get",
			dataType : "json",
			success : function ( data ) {
				var content = "";
	            let promises = []; // 모든 AJAX 요청을 관리하기 위한 배열을 선언합니다.
	            console.log("count : ", data.count)
	            if (data.count != 0) {
	            	console.log("1")
					data.list.forEach(function(item, index) {
						let date = new Date( item.date );
						let bookingDate = (date.getFullYear() + '년 ') + 
										('0' + (date.getMonth() + 1)).slice(-2) + "월 " +
										('0' + (date.getDate())).slice(-2) + "일 " +
										item.time;
						let reviewPermitDate = new Date(date.getTime() + (7 * 24 * 60 * 60 * 1000))
						let currentDate = new Date();
						console.log("시간비교 : ", currentDate < reviewPermitDate)
						console.log("시간출력 1 : ", currentDate)
						console.log("시간출력 2 : ", reviewPermitDate)
						
						let promise = $.ajax({
							url : "getBookingInfo?storeId="+item.storeId+"&bookingId="+item.id,
							type : "get",
							async : false, 
							dataType : "json"
						}).then(function (result) {
							console.log("result : ", result)
							content += `<div class="alreadyContentInfo">`
							content += `<label class="bookingStoreName" title="`+result.storeName+`">`+result.storeName+`</label>`;
							content += `<label class="bookingStatusAlready">방문 완료</label>`
							content += `<a class="bookingDelete" onclick="alreadyBookingDelete(`+item.id+`)">X</a><br>`
							content += `<img class="bookingStoreImg" alt="" src="/root/businessM/download?img=` + result.storeImg + `"><br>`;
							content += `<label class="bookingDate">` + bookingDate + `</label><br>`
							content += `<label class="bookingPerson">성인 ` + item.person + `명</label>`
							content += `<hr>`
							
							if (item.status == 1 && currentDate < reviewPermitDate) { // 리뷰 작성 가능 상태
								content += `<label class="bookingStatusReviewReady">후기 작성하기</label>`							
							} else if(item.status == 2) { // 후기 작성 완료된 상태
								content += `<label class="bookingStatusReviewComplete"><a href="review">후기 작성 완료</a></label>`
								content += `<label class="bookingStatusReviewScore">평점 : ` + result.reviewScore + `점</label>`
							} else if (item.status == 3) // 가게에서 예약 거절을 했을때
								content += `<label class="bookingStatusReviewTimeout">예약 취소</label>`
								else if (item.status == 4)
								content += `<label class="bookingStatusReviewReady"><a href="review">예약 대기</a></label>`							
							else { // status가 1인데 시간이 지났을때 ... 후기 작성 기간 만료된 상태
								content += `<label class="bookingStatusReviewTimeout">후기 작성 기간 만료</label>`
							}
							content += `</div>`					
						}).catch(function(error) {
		                    console.log(error);
		                });
						
						promises.push(promise)
					});
	
		            // 모든 AJAX 요청이 완료된 후에 UI를 업데이트합니다.
		            $.when.apply($, promises).then(function() {
		                $("#alreadyContent").html(content); // content를 readyContent에 추가합니다.
	
		                let alreadyWrapper = $("#bookContentAlreadyWrapper");
		                alreadyWrapper.find("#totalAlreadyPageMenu").remove();
		                
		                // 데이터가 존재할때 제어문 실행
		                if (data.totalPage != 1) {
		                	console.log("1")
							let pageNum = Math.floor((alreadyCurrentPage-1) / 10);
		                	
		                    let html = `<div id="totalAlreadyPageMenu">`;
		                    html += `<hr class="contentHr">`
		                    
		                    // 현재 페이지라인이 마지막 페이지라인일경우
		                    if ( pageNum != 0 && pageNum == (Math.floor((data.totalPage) / 10) )) {
			                	console.log("2")
		                    	let i = (pageNum*10 + 1)
		                        html += `<a class="alreadyPageBtnA" onclick="getBookingAlready(`+(alreadyCurrentPage-1)+`)">&lt;</a>`;
		                        
			                    for ( ; i <= data.totalPage; i++) {
			                    	html += `<a class="alreadyPageBtn" onclick="getBookingAlready(`+i+`)">`+i+`</a>`;
			                    }
			                    
			                    if (data.totalPage == alreadyCurrentPage) {
				                    html += `<a class="alreadyPageBtnDisabled">></a>`;			                    	
			                    } else {
			                    	html += `<a class="alreadyPageBtnB" onclick="getBookingAlready(`+(alreadyCurrentPage+1)+`)">></a>`;		                    				                    	
			                    }
		                    } 
		                    
		                    // 현재 페이지가 첫번째가 아닐경우
		                    else if (pageNum != 0) {
			                	console.log("3")
		                    	let i = (pageNum * 10 + 1)
		                    	console.log("i : ", i)
		                    	console.log("pageNum : ", pageNum)
		                    	console.log("test : ", pageNum * pageViewContent + pageViewContent)
		                        html += `<a class="alreadyPageBtnA" onclick="getBookingAlready(`+(alreadyCurrentPage-1)+`)"><</a>`;
		                        
			                    for ( ; i <= (pageNum * 10 + 10); i++) {
			                    	html += `<a class="alreadyPageBtn" onclick="getBookingAlready(`+i+`)">`+i+`</a>`;
			                    }
			                    
			                    if (data.totalPage == alreadyCurrentPage) {
			                    	html += `<a class="alreadyPageBtnDisabled">></a>`;
			                    } else {
			                    	html += `<a class="alreadyPageBtnB" onclick="getBookingAlready(`+(alreadyCurrentPage+1)+`)">></a>`;
			                    }
		                    } 
		                    
		                    // 현재 페이지라인이 첫번째일 경우
		                    else {
			                	console.log("4")
		                    	let i = (pageNum + 1)
		                    	
		                    	console.log("alreadyCurrentPage : ", alreadyCurrentPage)
		                    	console.log("data : ", data)
		                    	
		                    	if (alreadyCurrentPage == 1) {
		                    		html += `<a class="alreadyPageBtnDisabled" disabled="true"><</a>`;		                    				                    		
		                    	} else {
		                    		html += `<a class="alreadyPageBtnA" onclick="getBookingAlready(`+(alreadyCurrentPage-1)+`)"><</a>`;		                    		
		                    	}
		                        
			                    for ( ; i <= data.totalPage; i++) {
			                    	html += `<a class="alreadyPageBtn" onclick="getBookingAlready(`+i+`)">`+i+`</a>`;
			                        if (i == 10) break;
			                    }
			                    
			                    console.log("data.totalPage : ", data.totalPage)
			                    console.log("pageViewContent", pageViewContent)
			                    
		                    	if (data.totalPage == alreadyCurrentPage) {
		                    		html += `<a class="alreadyPageBtnDisabled">></a>`;
		                    	} else {
		                    		html += `<a class="alreadyPageBtnB" onclick="getBookingAlready(`+(alreadyCurrentPage+1)+`)">></a>`;		                    		
		                    	}
		                    }
		                    
		                    
		                    html += `</div>`;
		                    alreadyWrapper.append(html);
		                } else {
		                	console.log("5")
							 let pageNum = Math.floor(alreadyCurrentPage / 10);
		                }
		                $(".alreadyPageBtn").eq(alreadyCurrentPage%10-1).css("color", "blue")
		                $(".alreadyPageBtn").eq(alreadyCurrentPage%10-1).css("border-bottom", "2px solid #7777ff")
		            });
	            } else {
	            	$("#alreadyContent").html("<label class='contentNothing'>예약 기록이 없습니다</label>"); 
	            }
			},
			error : function (error) {
				console.log(error);
			}
		})
	}
	
	function readyBookingDelete(id) {
		let result = confirm("예약을 취소하시겠습니까?\n취소 후에는 재예약이 되지 않습니다.")
		if (result) {
			$.ajax({
				url : "readyBooking?bookId="+id,
				type : "delete",
				dataType : "text",
				success : function () {
					let readyContent = $(".readyContentInfo")
					console.log("readyContent : ", readyContent.length)
					if (readyContent.length == 1) {
						if (readyCurrentPage == 1) {
							getBookingReady(1);							
						} else {
							getBookingReady(readyCurrentPage-1);
						}
					} else {
						getBookingReady(readyCurrentPage);						
					}
				},
				error : function () {
					
				}
			}).then(function () {
				alert("삭제가 완료되었습니다.")
			})
		}
	}
	
	function alreadyBookingDelete(id) {
		let result = confirm("예약 기록을 삭제하시겠습니까?\n예약기록은 복구되지 않습니다.")
		if (result) {
			$.ajax({
				url : "alreadyBooking?bookId="+id,
				type : "delete",
				dataType : "text",
				success : function () {
					let alreadyContent = $(".alreadyContentInfo")
					console.log("alreadyContent : ", alreadyContent.length)
					if (alreadyContent.length == 1) {
						if (alreadyCurrentPage == 1) {
							getBookingAlready(1);							
						} else {
							getBookingAlready(alreadyCurrentPage-1);
						}
					} else {
						getBookingAlready(alreadyCurrentPage);						
					}
				},
				error : function () {
					
				}
			}).then(function () {
				alert("삭제가 완료되었습니다.")
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
			<div id="bookContentReadyWrapper">
				<label class="contentTitle">방문 대기중인 예약</label>
				<hr class="contentHr">
				<div id="readyContent">
				
				</div>
			</div>
			<div id="bookContentAlreadyWrapper">
				<h3 class="contentTitle">방문 완료된 예약</h3>
				<hr class="contentHr">
				<div id="alreadyContent">
					
				</div>
			</div>
		</div>
	</div>
</body>
<%@ include file="../../main/footer.jsp" %>
</html>