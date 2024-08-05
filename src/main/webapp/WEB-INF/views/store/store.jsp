<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	let store_id = '${infoDTO.store_id}';
</script>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/store/storeCSS.css?after">
<script src="${path}/resources/js/store/store.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 민석 추가 -->
<style type="text/css">
.modal {
	z-index: 10005;
	position: absolute;
	display: none;
	justify-content: center;
	top: 0;
	left: 0;
	width: 100vw;
	height: 100vh;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal_body {
	position: absolute;
	top: 50%;
	width: 450px;
	height: 600px;
	padding: 40px;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateY(-50%);
}

.calendar-container {
	width: 300px;
	margin: 15px auto;
	border: 1px solid #ccc;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
	padding: 10px;
	background-color: #fdefde;
}

.calendar-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.calendar-days {
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	font-weight: bold;
	border-bottom: 1px solid #ccc;
	padding-bottom: 5px;
}

.day {
  padding: 5px;
}

.calendar-dates {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  grid-gap: 5px;
}

.date {
  cursor: pointer;
  padding: 5px;
}

.date:hover {
  background-color: #f05650;
}
.reservation_time {
	display: flex;
	overflow-x: scroll;
}
.reservation_person {
	display: flex;
	overflow-x: scroll;
}
.div_button {
	height: 30px;
	width: 65px;
	border-radius: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 1px black solid;
	margin: 5px;
	background-color: #B1CCF0;
}
.focus {
	background-color: #77A5E3;

}
.div_person {
	height: 30px;
	width: 40px;
	border-radius: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 1px black solid;
	margin: 5px;
	background-color: #B1CCF0;
}
.check_page {
	display: none;	
}
.check_page > h2{
	text-align: center;
}
.check_button {
	position: absolute;
	bottom: 0;
	left: 0;
	width: 100%;
	margin-bottom: 35px;
	display: flex;
	justify-content: space-around;
}
.check_button > button {
	width: 70px;
	height: 40px;
	border-radius: 10px;
}

.cancel {
	background-color: #B1CCF0;
}

.conform {
	background-color: #77A5E3;
}
.check_table_wrapper {
	border-radius: 10px;
	border: 1px blue solid;
	margin: 15px; 
}
.check_table_wrapper > p {
	margin-left: 15px;
}
.last_page {
	display: none;
	justify-content: center;
	align-items: center;
}
</style>
<!-- 민석 추가 끝!! -->

<!-- margin 순서 위 왼쪽 아래 오른쪽 --> 
</head>
<body class="_body body">
<header class="header">
<%@ include file="../main/header.jsp" %>
</header>
	<!-- 민석 추가 -->
	<div class="modal">
		<div class="modal_body">
			<div class="first_page">
				<div class="calendar-container">
					<div class="calendar-header">
						<button id="prevBtn">이전</button>
						<h2 id="currentMonth"></h2>
						<button id="nextBtn">다음</button>
					</div>
					<div class="calendar-days">
						<div class="day">일</div>
						<div class="day">월</div>
						<div class="day">화</div>
						<div class="day">수</div>
						<div class="day">목</div>
						<div class="day">금</div>
						<div class="day">토</div>
					</div>
					<div class="calendar-dates" id="calendarDates"></div>
				</div>

				<p>인원 선택</p>
				<div class="reservation_person"></div>

				<p>시간 선택</p>
				<div class="reservation_time"></div>
			</div>

			<div class="check_page">
				<h2>예약 정보를 확인해주세요</h2>

				<div class="check_table_wrapper">
					<p class="check_date"></p>
					<p class="check_time"></p>
					<p class="check_id"></p>
					<p class="check_person"></p>
					<br>
					<p class="check_store_name"></p>
					<p class="check_add"></p>
					<p class="check_add_info"></p>
				</div>
			</div>
			<div class="check_button">
				<button type="button" class="cancle">취소</button>
				<button type="button" class="conform">확인</button>
			</div>
			<div class="last_page"></div>
		</div>
	</div>
	<!-- 민석 추가 끝 -->
	<div class="fixed-scroll">
	<div style="margin: 150px auto;">
		<div class="store_top">
			<div>
				<button class="button1 btn1Fade" style="visibility: hidden;"></button>
				<button class="button1 btn1Fade" style="visibility: hidden;"></button>
			</div>
			<img src="resources\img\Boseon\보정\로고.png" onclick="window.location.href='/root'">
			<div>
				<button class="button1 btn1Fade res" onclick='reservation()'>예약하기</button>
				<button class="button2 btn2Fade" onclick="Jjim(${Map.infoDTO.store_id})">찜하기</button>
			</div>
		</div>
	
		<div class="main-photo">
			<button style="visibility: hidden;">${Map.infoDTO.store_id}</button>
			<img src="/root/businessM/download?img=${Map.mainImg}">
		</div>
		<div class="store_name">
		    <span style="color: gray;">${Map.infoDTO.store_add} | </span>
		    <span style="color: gray;">${Map.infoDTO.store_category} </span><br>
		    <span style="font-size: 50px; font-weight: bold;">${Map.infoDTO.store_name}</span><br>
		    
		    <img src="resources/img/Boseon/보정/별.png" width="15px"> ${Map.scoreAvr} &nbsp;&nbsp;&nbsp;
		    리뷰 <span style="color: #397BE6;">${Map.totalreview}</span> &nbsp;&nbsp;&nbsp;
		    <img src="resources/img/Boseon/보정/하트.png" width="15px"> ${Map.totalBookmark}
		    <br><br>
		    
		    <span style="font-size: 18px; visibility: hidden;">#&nbsp;#&nbsp;#&nbsp;#</span>
		</div>
	
		<div class="review-photo">
		<c:choose>
		
			<c:when test="${Map.reviewImg.size() > 4 }">
				<c:forEach var="Rimg" items="${Map.reviewImg}">
	                <img src="/root/businessM/download?img=${Rimg}">
	            </c:forEach>
	        </c:when>
	            
	        <c:otherwise>
				<c:forEach var="Simg" items="${Map.storeImg}">
	                <img src="/root/businessM/download?img=${Simg}">
	            </c:forEach>
				<c:forEach var="Rimg" items="${Map.reviewImg}">
	                <img src="/root/businessM/download?img=${Rimg}">
	            </c:forEach>
            </c:otherwise>
            
        </c:choose>
		</div>
		
		<div class="categories">
			<button class="catebutton catebtnFade" onclick="category(0, '${Map.infoDTO.store_id}')">정보</button>
			<button class="catebutton catebtnFade" onclick="category(2, '${Map.infoDTO.store_id}')">메뉴</button>
			<button class="catebutton catebtnFade" onclick="category(3, '${Map.infoDTO.store_id}')">리뷰()</button>
			<button class="catebutton catebtnFade" onclick="category(4, '${Map.infoDTO.store_id}')">사진()</button>
			<button class="catebutton catebtnFade" onclick="category(5, '${Map.infoDTO.store_id}')">지도</button>
			<hr>
		</div>
		
		<div class="iframe">
			<iframe frameborder="0" scrolling="no" id="myIframe" onload="iHeight();" 
				style="width:1500px; min-height:100px;" ></iframe>
		</div>
	</div>
	<div class="div_footer">
		<%@ include file="../main/footer.jsp" %>
	</div>
</div>

</body>

<!-- 민석 추가!! -->
<script type="text/javascript">
window.onload = function() {
    category(0,${Map.infoDTO.store_id});
};	

	const body = document.querySelector(".body");
	
	body.addEventListener('click', function(event) {
		let parent = event.target;
		for(let i = 0; i < 3; i++)
		{
			if(parent.classList.contains('modal_body'))
			{
				break;	
			}
			else if(parent.classList.contains('modal')) {
				const modal = document.querySelector(".modal");
				modal.style.display = "none";
				
				const last_page = document.querySelector('.last_page');
				
				while(last_page.firstChild)
					last_page.removeChild(last_page.firstChild);
				break;
			}
			// 달력을 누르면
			else if(parent.classList.contains('date') && !parent.classList.contains('empty'))
			{
				const all_date = document.querySelectorAll('.date');
				console.log
				for(let i = 0; i < all_date.length; i++)
				{
					if(all_date[i].classList.contains('#f05650'))
					{
						all_date[i].classList.remove('#f05650');
						all_date[i].style.background = '#fdefde';
						break;
					}
				}
				parent.classList.add('#f05650');
				parent.style.background = '#f05650'; 
				
				const check_date = document.querySelector('.check_date');
				
				const date = document.getElementById('currentMonth');
				check_date.innerText = date.innerText + " " + parent.innerText + "일";
								
				break;
			}
			else if(parent.classList.contains('div_person'))
			{
				const div_person_arr = document.querySelectorAll('.div_person');
				for(let i = 0; i < div_person_arr.length; i++)
				{
					div_person_arr[i].style.background = '#B1CCF0';
				}
				parent.style.background = '#77A5E3';
				
				const child_span = parent.children;
				
				const check_person = document.querySelector('.check_person');
				check_person.innerText = "인원 수 : " + child_span[0].innerText;
				
				break;
			}
			else if(parent.classList.contains('div_time'))
			{
				const div_time_arr = document.querySelectorAll('.div_time');
				for(let i = 0; i < div_time_arr.length; i++)
				{
					div_time_arr[i].style.background = '#B1CCF0';	
				}
				parent.style.background = '#77A5E3';
				
				const child_span = parent.children;
				
				const check_time = document.querySelector('.check_time');
				check_time.innerText = "예약 시간 : " + child_span[0].innerText;
				break;
			}
			// 취소 버튼을 누르면
			else if(parent.classList.contains('cancle'))
			{
				const modal = document.querySelector(".modal");
				modal.style.display = "none";
				break;
			}
			// 확인 버튼을 누르면
			else if(parent.classList.contains('conform'))
			{
				const first_page = document.querySelector('.first_page');
				const check_page = document.querySelector('.check_page');
				
				if(first_page.style.display == 'block')
				{
					first_page.style.display = 'none';
					check_page.style.display = 'block';	
				}
				else if(check_page.style.display == 'block')
				{
					first_page.style.display = 'none';
					check_page.style.display = 'none';	
					// 년 월 일
					const arr1 = document.querySelector('.check_date').innerText;
					const arr2 = arr1.split(' ');
					const year = arr2[0].split('년');
					const month = arr2[1].split('월');
					const day = arr2[2].split('일');
					// 시간
					const time = document.querySelector('.check_time').innerText;
					const time_arr = time.split(' ');
					
					//인원
					const person = document.querySelector('.check_person').innerText;
					const person_arr = person.split(' ');
					
					
					let phone;
					
					// 전화 번호 가져오기
					fetch("http://localhost:8080/root/store/phone", {
						headers : {"Content-Type": "application/json",
									"user_id" : '${userId}'},
					})
					.then((response) => response.json())
					.then((data) => {
						phone = data.member_phone;
						// 예약 요청 보내기
						fetch("http://34.47.108.10:8080/root/con/book", {
							method : "POST",
							headers : {"Content-Type": "application/json"},
							body : JSON.stringify({
								"store_id" : '${store_id}',
								"member_id" : '${userId}',
								"booking_date_booking" : year[0] + "/" + month[0] + "/" + day[0],
								"booking_time" : time_arr[3],
								"booking_person" : person_arr[3],
								"booking_phone" : phone,
								"booking_status" : 0
							})
						})
						.then((res) => {
							console.log(res);
							
							if(res.status == "200")
							{
								const last_page = document.querySelector('.last_page');
								last_page.style.display = "flex";
								const last_span = document.createElement('span');
								last_span.innerText = "예약 신청이 완료되었습니다!!";
								last_page.appendChild(last_span);
							}
						})
					});
					
					
				} 
				// 추후 보선님 패이지 연동후 패치 만들기
				break;
			}
			else {
				parent = parent.parentElement;
			}
			
		}
	})
	
	function reservation() {
		const check_id = document.querySelector('.check_id');
		if('${userId}' != "")
			check_id.innerText = "예약자 아이디 : " + '${userId}';
		else
		{
			alert("로그인이 필요합니다!");
			return ;	
		}
		
		const modal = document.querySelector(".modal");
		modal.style.display = "flex";
		
		const first_page = document.querySelector('.first_page');
		const check_page = document.querySelector('.check_page');		
		
		
		first_page.style.display = 'block';
		check_page.style.display = 'none';
		
		delete_reservation_time();
		delete_reservation_person();
		
		getRegisterInfo();
	}
	
	function delete_reservation_time() 
	{
		const reservation_time = document.querySelector('.reservation_time');
		while(reservation_time.firstChild)
			reservation_time.removeChild(reservation_time.firstChild);
	}
	function delete_reservation_person() 
	{
		const reservation_person= document.querySelector('.reservation_person');
		while(reservation_person.firstChild)
			reservation_person.removeChild(reservation_person.firstChild);
	}
	
	function getRegisterInfo() {
		fetch("http://localhost:8080/root/store/api/reservationInfo", {
			headers : {
				"Content-Type": "application/json",
				"store_id" : '${store_id}',
			},
		})
		.then((response) => response.json())
		.then((data) => {
			
			makePersonButton(data.store_max_team);
			makeTime(data.store_business_hours);
			makeCheckPage(data.store_add, data.store_add_info, data.store_name);
		})	 	
	}
	function makeCheckPage(store_add, store_add_info, store_name)
	{
		const check_store_name = document.querySelector('.check_store_name');
		check_store_name.innerText = "예약 가게 : " + store_name;
		
		const check_add = document.querySelector('.check_add');
		const add =  store_add.split(' ');
		check_add.innerText = "예약 위치 : " + add[1];
		
		const check_add_info = document.querySelector('.check_add_info');
		check_add_info.innerText = "상세 주소 : " + store_add + " " + store_add_info;
	}
	function makePersonButton(person)
	{
		let i;
		if(person == 0)
			i = 10;
		else
			i = person;	
		
		let count = 1;
		for(;i >0; i-- )
		{
			const reservation_person= document.querySelector('.reservation_person');
			const div_person = document.createElement('div');
			div_person.classList.add('div_person');
			
			const span_person = document.createElement('span');
			span_person.innerText = count++;
			
			div_person.appendChild(span_person);
			
			reservation_person.appendChild(div_person);
		}
	}
	
	function makeTime(data)
	{
		const time =  data.split("/");

		const reservation_time = document.querySelector('.reservation_time');
		for(let i = 0; i < time.length; i++)
		{
			const div_button = document.createElement('div');
			const span_button = document.createElement('span');
			span_button.innerText = time[i];
			div_button.classList.add('div_button');
			div_button.classList.add('div_time');
			div_button.appendChild(span_button);
			reservation_time.appendChild(div_button);
		}
	}
	
</script>


<script type="text/javascript">
//캘린더 부분
const calendarDates = document.getElementById("calendarDates");
const currentMonthElement = document.getElementById("currentMonth");
const prevBtn = document.getElementById("prevBtn");
const nextBtn = document.getElementById("nextBtn");

const today = new Date(); // 현재 날짜를 나타내는 Date 객체를 저장한다.
let currentMonth = today.getMonth();
/* 현재 월을 나타내는 값을 저장한다. getMonth() 메서드는 0부터 시작하는 월을 반환하므로
1월이면 0, 2월이면 1을 반환한다. */
let currentYear = today.getFullYear(); // 변수에 현재 연도를 나타내는 값을 저장한다.

function renderCalendar() {
  /* renderCalendar 함수는 월별 캘랜더를 생성하고 표시하는 함수이다. */
  const firstDayOfMonth = new Date(currentYear, currentMonth, 1);
  /* firstDayOfMonth 변수에 현재 월의 첫 번째 날짜를 나타내는 Date 객체를 저장한다.
해당 월의 첫 번째 날짜에 대한 정보를 얻는다. */
  const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
  /* daysInMonth 변수에 현재 월의 총 일 수를 나타내는 값을 저장한다. 
  해당 월이 몇 일까지 있는지 알 수 있다. */
  const startDayOfWeek = firstDayOfMonth.getDay();
  /* 변수에 현재 월의 첫 번째 날짜의 요일을 나타내는 값을 저장한다.
  해당 월의 첫 번째 날짜가 무슨 요일인지 알 수 있다. */
  currentMonthElement.textContent = currentYear + "년" + " " + (Number(currentMonth) + 1) + "월";
  // 월을 나타내는 요소에 현재 월과 연도를 설정하여 표시한다.

  calendarDates.innerHTML = ""; // 일자를 표시하는 그리드 컨테이너를 비운다.

  // 빈 날짜(이전 달)
  for (let i = 0; i < startDayOfWeek; i++) {
    const emptyDate = document.createElement("div");
    //  빈 날짜를 나타내는 div 요소를 생성한다.
    emptyDate.classList.add("date", "empty");
    // 생성한 div 요소에 "date"와 "empty" 클래스를 추가한다.
    calendarDates.appendChild(emptyDate);
    // 생성한 빈 날짜 요소를 캘린더 그리드에 추가한다.
  }

  // 현재 달의 날짜
  for (let i = 1; i <= daysInMonth; i++) {
    const dateElement = document.createElement("div");
    dateElement.classList.add("date");
    dateElement.textContent = i;
    calendarDates.appendChild(dateElement);
  }
  /* 
  1. for 문을 이용하여 현재 월의 총 일 수만큼 반복하여 월의 날짜를 순서대로 표시한다.
  2. const dateElement = document.createElement("div");를 통해 날짜를 나타내는 div 요소를 생성한다.
  3. dateElement.classList.add("date");를 통해 생성한 div 요소에 "date" 클래스를 추가한다.
  4. dateElement.textContent = i;를 통해 해당 날짜 값을 div 요소의 텍스트로 설정한다.
  5. calendarDates.appendChild(dateElement);를 통해 생성한 날짜 요소를 캘린더 그리드에 추가한다.
  */
}

renderCalendar();
// 페이지가 로드되면 renderCalendar 함수를 실행하여 초기 캘린더를 표시한다.

prevBtn.addEventListener("click", () => {
  currentMonth--;
  if (currentMonth < 0) {
    currentMonth = 11;
    currentYear--;
  }
  renderCalendar();
});
/* 
1. 이전 버튼(prevBtn)을 클릭하면 현재 월을 이전 월로 변경하고, 연도가 바뀌어야 한다면 연도를 변경한다.
2. 변경된 월과 연도를 바탕으로 renderCalendar 함수를 호출하여 이전 월의 캘린더를 표시한다.
*/

nextBtn.addEventListener("click", () => {
  currentMonth++;
  if (currentMonth > 11) {
    currentMonth = 0;
    currentYear++;
  }
  renderCalendar();
});

</script>
<!-- 민석 추가 끝!! -->
</html>

















