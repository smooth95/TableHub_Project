console.log("JavaScript 파일이 연결되었습니다.");

     

function category(n, store_id) {
		const cateNum = n;
	    let cateVal="";
	    
	    if(cateNum == 2)
	    	cateVal = "http://localhost:8080/root/store/menu?store_id=" + store_id;
	    else if(cateNum == 3)
	    	cateVal = "http://localhost:8080/root/store/review?store_id=" + store_id;
	    else if(cateNum == 4)
	    	cateVal = "http://localhost:8080/root/store/photo?store_id=" + store_id;
	    else if(cateNum == 5)
	    	cateVal = "http://localhost:8080/root/store/map?store_id=" + store_id;
	    else
	    	cateVal = "http://localhost:8080/root/store/info?store_id=" + store_id;
		 const myIframe = document.getElementById("myIframe");
	     myIframe.src = cateVal;

		console.log("cateVal 주소는? : ", cateVal);
	}


function iHeight(){
	var iHeight = document.getElementById('myIframe').contentWindow.document.body.scrollHeight;
	document.getElementById('myIframe').height = iHeight;
	console.log("카테고리 높이? : ",iHeight);

}

window.addEventListener('message', function(event) {
	console.log("event : ", event)
    const iframe = document.getElementById('myIframe');
    if (event.data.height) {
        iframe.style.height = event.data.height + 'px';
    }
});

        

function Jjim(store_id){
	console.log("찜하기js");
	console.log(store_id);
	
    $.ajax({
        url: '/root/store/jjim?store_id=' + store_id,
        type: 'GET',
        dataType: 'json',
        success: function(response) {
        	if(response.result == 0) {
	            alert(response.msg);
	            location.href = response.url;
	       }else{
	       		alert(response.msg);
	       		}
            
        },
        error: function(error) {
            alert('오류발생: ' + error);
        }
    });
    location.reload();
}
