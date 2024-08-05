

var menuIframe = "";

function categoryChoose(n) {
	console.log("categoryChoose함수 가동 ");
	const cateNum = n;
	console.log("추즈 함수 현재 cateNum은? : ", cateNum);

	if(cateNum == 2) {
	    menuIframe = "2";
	    window.location.href = 'http://localhost:8080/root/businMmenu?category=menuInfo';
    }else if(cateNum == 3) {
	    menuIframe = "3";
	    window.location.href = 'http://localhost:8080/root/businMmenu?category=photoInfo';
    }else {
	    menuIframe = "1";
	    window.location.href = 'http://localhost:8080/root/businMmenu';
    }
	console.log("추즈함수 현재 menuIframe은? : ", menuIframe);
}


function category(n) {
		console.log("카테고리 함수 현재 menuIframe은? : ", menuIframe);
		const cateNum = n;
	    let cateVal="";
		console.log("카테고리 함수 현재 cateNum은? : ", cateNum);
	    
	    if(menuIframe == "") {
		    if(cateNum == 2) {
		    	cateVal = "http://localhost:8080/root/businessM/menuInfo";
		    }else if(cateNum == 3) {
		    	cateVal = "http://localhost:8080/root/businessM/photoInfo"; 
		    }else if(cateNum == 4) {
		    	cateVal = "http://localhost:8080/root/businessM/reviewInfo";
		    }else if(cateNum == 5) {
		    	cateVal = "http://localhost:8080/root/businessM/bookInfo";
		    }else{
		    	cateVal = "http://localhost:8080/root/businessM/storeInfo";
		    }
		}else if(menuIframe == "2") {
			cateVal = "http://localhost:8080/root/businessM/menuInfo";
		}else if(menuIframe == "3") {
			cateVal = "http://localhost:8080/root/businessM/photoInfo";
		}else{
			cateVal = "http://localhost:8080/root/businessM";	
	    }
	    
		const myIframe = document.getElementById("myIframe");
	    myIframe.src = cateVal;
	    
		console.log("cateVal 주소는? : ", cateVal);
	}

			    /*
			    History API를 사용하여 URL을 업데이트
			    var newUrl = 'http://localhost:8080/root/businMmenu?category='+menuInfo;
			    history.replaceState(null, null, newUrl); 
			    */


function iHeight(){
var iHeight = document.getElementById('myIframe').contentWindow.document.body.scrollHeight;
document.getElementById('myIframe').height = iHeight;
console.log("아이프레임 카테고리 높이? : ",iHeight);
}


function changeParentUrl(newUrl) {
	window.location.href = newUrl;
}



//--------------------------------- 구현 내용 추가
// reviewInfo 높이 조절을 위한 코드
window.addEventListener('message', function(event) {
	console.log("event : ", event)
    const iframe = document.getElementById('myIframe');
    if (event.data.height) {
        document.getElementById('myIframe').height = event.data.height + 'px';
    }
});


//메뉴에서 쓰이는 iframe에서 버튼을 누를때 부모페이지가 바뀌게 하는 이벤트
//보안상으로 안좋아서 막아놓는 웹사이트도 많다. iframe을 안쓰는 다른방법을 찾아보기
/*
메뉴추가 
-사진한장씩 들어감
-상세페이지엔 메뉴카테고리가 가로 스크롤로 넘어감

완료페이지 에서 각 등록 페이지로 넘어가는거 수정
사진등록 파일이 클 경우 오류메세지 띄우기
가게등록, 사진등록, 메뉴등록 수정 페이지 만들기
이미지가 DB에 저장이 안되면 폴더에도 저장하지 않게 하기


-상세페이지 세션에 맞게 뜨도록 수정
*/

