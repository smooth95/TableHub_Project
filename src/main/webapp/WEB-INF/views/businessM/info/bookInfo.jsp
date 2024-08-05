<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.book_header {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.nowTime {
	width: 70%;
	display: flex;
	justify-content: center;
	align-items: center;	
}

.nowTime > span {
	margin: 5px;
	font-size: x-large;
	font-weight: bold;
}

.past_book {
	display: hidden;
}

.now_book {
	display: hidden;
}

.book_button {
	width: 300px;
	height: 100px;
	border-radius: 10px;
	cursor: pointer;
}

.div_book {
	margin-top: 50px;
	display: flex;
	justify-content: space-around;
	height: 500px;
}

.table_wrapper{
	display: inline-block;
	width: 80%;
	
	height: 30px;
	flex-direction: row;
	display: flex;
	justify-content: space-around;
	padding: 4px 0 4px 0;
	margin: 4px 0 4px 0;
	
	border-radius: 10px;
	background-color: #e8e8e8;
}

.past_book {
	margin-top: 40px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.now_book {
	margin-top: 40px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}
.center {
	display: flex;
	justify-content: center;
	align-items: center;
}
.table_date {
	width: 150px;
}
.table_num {
	width: 50px;
}
.table_name {
	width: 100px;
}
.table_person {
	width: 20px;
}
.talbe_phone {
	width: 120px;
}
.table_review {
	width: 100px;
}
.book_footer {
	display: none;
	
	justify-content: center;
}
.footer_left {
	background-image: url('https://cdn-icons-png.flaticon.com/512/271/271220.png');
	background-size: cover;
	cursor : pointer;
	width: 30px;
	height: 30px;
}
.footer_middle {
	display: flex;
	align-items: center;
}
.footer_right {
	background-image: url('https://cdn-icons-png.flaticon.com/512/271/271228.png');
	background-size: cover;
	cursor : pointer;
	width: 30px;
	height: 30px;
}
.pageNumber {
	padding: 5px;
}
.bold {
	font-weight: bold; 
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	let nowPage;
	let totalPage;
	let type;
	$(document).ready(function() {
		const body = document.querySelector('.body');
		
		setTime();
		nowPage = 1;
		
		
		body.addEventListener("click", function(event) { 
			// 지난 예약보기 버튼을 누르면
			if(event.target.classList.contains('past_reservation')) 
			{
				const div_book = document.querySelector('.div_book');
				const past_book= document.querySelector('.past_book');
				const now_book = document.querySelector('.now_book');
				const book_footer = document.querySelector('.book_footer');
				
				div_book.style.display = "none";
				past_book.style.display = "flex";
				now_book.style.display = "none";
				
				deletePageNum();
				deletePastTable();
				deleteNowTable();
				
				type = "past";
				
				getBook(1, type);
				book_footer.style.display = "flex";
				setPage(type);
			}
			// 현재 대기 예약 버튼을 클릭하면
			else if(event.target.classList.contains('waiting_reservation'))
			{
				const div_book = document.querySelector('.div_book');
				const past_book= document.querySelector('.past_book');
				const now_book = document.querySelector('.now_book');	
				const book_footer = document.querySelector('.book_footer');
				
				deletePageNum();
				deletePastTable();	
				deleteNowTable();
				
				div_book.style.display = "none";
				past_book.style.display = "none";
				now_book.style.display = "flex";
				
				type = "now";
				
				getBook(1, type);
				book_footer.style.display = "flex";
				setPage(type);
			}
			// 번호를 클릭하면
			else if(event.target.classList.contains('pageNumber')) 
			{
				makeFontBold(false);
				// 현재 페이지를 갱신
				nowPage = event.target.innerText;
				event.target.classList.add('bold');
				
				const book_footer = document.querySelector('.book_footer');
				book_footer.style.display='none';
				
				if(type == "past")
					deletePastTable();
				else 
					deleteNowTable();
				
				getBook(event.target.innerText, type);
				book_footer.style.display='flex';
			}
			// 좌측 화살표를 누르면
			else if(event.target.classList.contains('footer_left'))
			{
					
				if(nowPage == 1) {
					return ;
				}
				makeFontBold('left');
				if(Number(nowPage) % 10 == 1)
				{
					deletePageNum();
					makePageNum(Math.floor(nowPage / 10) - 1, true);
				}
				// 현재 페이지를 갱신
				if(nowPage != 1)
					nowPage = nowPage - 1;
				
				if(type == "past")
					deletePastTable();
				else 
					deleteNowTable();
				
				getBook(nowPage, type);
			}
			// 우측 화살표를 누르면
			else if(event.target.classList.contains('footer_right'))
			{
				if(nowPage == Math.floor( totalPage / 8 )+ 1)
					return;
				if(nowPage % 10 == 0)
				{
					deletePageNum();
					makePageNum(Math.floor(nowPage / 10), false);
				}
				
				makeFontBold('right');
				if(nowPage <= Math.floor(totalPage / 8) + 1)
					nowPage = Number(nowPage) + 1;
				
				if(type == "past")
					deletePastTable();
				else 
					deleteNowTable();
					
				getBook(nowPage, type);	
			}
		})
	})
	
	function deletePageNum() {
		const footer_middle = document.querySelector(".footer_middle");
		while(footer_middle.firstChild)
		{
			footer_middle.removeChild(footer_middle.firstChild);	
		}
	}
	
	function deletePastTable() {
		const past_book = document.querySelector(".past_book");
		while(past_book.firstChild)
		{
			past_book.removeChild(past_book.firstChild);	
		}
	}
	
	function deleteNowTable() {
		const now_book = document.querySelector(".now_book");
		while(now_book.firstChild)
		{
			now_book.removeChild(now_book.firstChild);	
		}
	}
	
	function setPage(type) {
		fetch("http://localhost:8080/root/store/api/totalPage", {
			headers : {
				"Content-Type": "application/json",
				"store_id" : '${storeId}',
				"type" : type,
			},
		})
		.then((response) => response.json())
		.then((data) => {
			if(data == 0)
				return;
			totalPage = data;
			makePageNum(0, false);
		})	 
		
	}
	
	function makeFontBold(chk) {
		const pageNumber = document.querySelectorAll('.pageNumber');
		
		for(let i = 0; i < pageNumber.length; i ++)
		{
			if(nowPage == pageNumber[i].innerText) 
			{
				pageNumber[i].classList.remove('bold');
				if(chk == false)
					return;
			}	
		}
		if(chk == 'left') 
		{
			for(let i = 0; i < pageNumber.length; i ++)
			{
				if(nowPage == pageNumber[0].innerText && nowPage == 1)
					return;
				
				else if( ( nowPage - 1 ) == pageNumber[i].innerText) 
				{
					pageNumber[i].classList.add('bold');
					return ;
				}
			}
		}
		else if(chk == 'right')
		{
			for(let i = 0; i < pageNumber.length; i ++)
			{
				if( ( nowPage + 1 ) == pageNumber[i].innerText) 
				{
					pageNumber[i].classList.add('bold');
					return ;
				}
			}	
		}
	}
	
	function makePageNum(num, chk) {
		const footer_middle = document.querySelector('.footer_middle');
		for(let i = 10 * num + 1; i <= 10 * num + 10 && Math.floor(totalPage / 8) >= i - 1; i++)
		{
			const span = document.createElement('span');
			// 페이지가 처음 보여질때 왼쪽 끝에 위치할때
			if(i == 10 * num + 1 && chk == false)
			{
				span.classList.add('bold');
			}
			// 페이지가 처음 보여질때 오른쪽 끝에 위치할때
			else if(i== 10 * num + 10 && chk == true)
			{
				span.classList.add('bold');	
			}
			span.innerText = i;
			span.classList.add('pageNumber');
				
			footer_middle.appendChild(span);
		}	
	}
	
	function setTime() {
		const year = document.querySelector('.year');
		const month = document.querySelector('.month');
		const day = document.querySelector('.day');
		const hour = document.querySelector('.hour');
		const min = document.querySelector('.min');
		const sec = document.querySelector('.sec');

		let today = new Date();

		year.innerText = today.getFullYear() + "년";
		month.innerText = today.getMonth() + 1 + "월";
		day.innerText = today.getDate() + "일";

		hour.innerText = today.getHours() + "시";
		min.innerText = today.getMinutes() + "분";
		sec.innerText = today.getSeconds() + "초";
	}

	setInterval(function() {
		setTime();
	}, 1000);
	
	function getBook(page, type) 
	{
		fetch("http://localhost:8080/root/store/api/book?page=" + page , {
			headers : {
				"Content-Type": "application/json",
				"store_id" : '${storeId}',
				"type" : type,
			},
		})
		.then((response) => response.json())
		.then((data) => {
				
			for(let i = 0; i < data.length; i++)
			{
				makeTable(data[i]);	
			}
		})	 
	}
	
	function makeTable(data, chk) {
		const past_book = document.querySelector(".past_book");
		const now_book = document.querySelector(".now_book");
		
		// 테이블 감싸는 div 생성 (이름 나중에 수정하기 (헷갈림))
		const past_table_wrapper = document.createElement('div');
		past_table_wrapper.classList.add('table_wrapper');
			
		// 시간 
		const div_date = document.createElement('div');
		div_date.classList.add('center');
		div_date.classList.add('table_date');
		const span_date = document.createElement('span');		
		const date = data.booking_date_booking.split(' ');
		span_date.innerText = date[0] + " "+ data.booking_time;
		div_date.appendChild(span_date);
		
		//예약 번호
		const div_booking_num = document.createElement('div');
		div_booking_num.classList.add('center');
		div_booking_num.classList.add('table_num');
		const span_booking_num = document.createElement('span');
		span_booking_num.innerText = data.booking_id;
		div_booking_num.appendChild(span_booking_num);
		
		//이름
		const div_name = document.createElement('div');
		div_name.classList.add('center');
		div_name.classList.add('table_name');
		const span_name = document.createElement('span');
		span_name.innerText =  data.member_nick;
		div_name.appendChild(span_name);
		
		//인원
		const div_person = document.createElement('div');
		div_person.classList.add('center');
		div_person.classList.add('table_person');
		const span_person = document.createElement('span');
		span_person.innerText = data.booking_person;
		div_person.appendChild(span_person);
		
		//전화번호
		const div_phone = document.createElement('div');
		div_phone.classList.add('center');
		div_phone.classList.add('table_phone');
		const span_phone = document.createElement('span');
		span_phone.innerText = data.member_phone;
		div_phone.appendChild(span_phone);
		
		//후기
		const div_review = document.createElement('div');
		div_review.classList.add('center');
		div_review.classList.add('table_review');
		const span_review = document.createElement('span');
		
		if(data.booking_status == 0)
		{
			span_review.innerText = "수락 대기중";	
		}
		else if(data.booking_status == 1)
		{
			span_review.innerText = "작성 대기중";	
		}
		else if(data.booking_status == 2)
		{
			span_review.innerText = "작성 완료";	
		}
		else if(data.booking_status == 3)
		{
			span_review.innerText = "가게 예약 취소";	
		}
		else if(data.booking_status == 4)
		{
			span_review.innerText = "예약 수락";	
		}
		div_review.appendChild(span_review);
		
		past_table_wrapper.appendChild(div_date);
		past_table_wrapper.appendChild(div_booking_num);
		past_table_wrapper.appendChild(div_name);
		past_table_wrapper.appendChild(div_person);
		past_table_wrapper.appendChild(div_phone);
		past_table_wrapper.appendChild(div_review);
		
		if(type == "past")
			past_book.appendChild(past_table_wrapper);
		else 
			now_book.appendChild(past_table_wrapper);
	}
	
</script>

</head>
<body class="body">
	<div class="book_header">
		<p>현재 시간</p>
		<div class="nowTime">
			<span class="year"></span>
			<span class="month"></span>
			<span class="day"></span>
			<span class="hour"></span>
			<span class="min"></span>
			<span class="sec"></span>
		</div>		
	</div>
	<div class="book_body">
		<div class="div_book">
			<button type="button" class="book_button past_reservation">지난 예약 보기</button>
			<button type="button" class="book_button waiting_reservation">대기 예약 보기</button>
		</div>
		<div class="past_book">
		
		</div>
		<div class="now_book">
		
		</div>
	</div>
	<div class="book_footer">
		<div class="footer_left"></div>
		<div class="footer_middle"></div>
		<div class="footer_right"></div>
	</div>
</body>
</html>