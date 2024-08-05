<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.modal {
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

</style>

</head>
<body class="body">
	<button type="button" onclick="reservation()">예약하기</button>
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
					<p class="check_name"></p>
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
			<div class="last_page">
				
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	const body = document.querySelector(".body");
	
	body.addEventListener("click", function(event) {
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
			console.log(data);
			
			makePersonButton(data.store_max_team);
			makeTime(data.store_business_hours);
			makeCheckPage(data.store_add, data.store_add_info, data.store_name);
		})	 	
	}
	function makeCheckPage(store_add, store_add_info, store_name)
	{
		console.log(store_name);	
		const check_store_name = document.querySelector('.check_store_name');
		check_store_name.innerText = "예약 가게 : " + store_name;
		
		const check_add = document.querySelector('.check_add');
		const add =  store_add.split(' ');
		check_add.innerText = "예약 위치 : " + add[1];
		
		console.log(add);
		
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
</html>
