window.onload = function() {
for (let i = 1; i <= 6; i++) {
	   var inputId = "file-upload0"+i;
	   var deleteId = "file-delete0"+i;
	   
	    document.getElementById(inputId).parentNode.style.display = 'block'; // 파일 업로드 버튼 보이기
        document.getElementById(deleteId).parentNode.style.display = 'none'; // 사진 삭제 버튼 숨기기
	}
};

function inputcheck00() {
    // 입력값 가져오기
    //var fileInput = document.getElementById('file-upload01');
    //var file01 = fileInput.files[0];
    console.log("대표이미지 체크중");
    var file01 = document.getElementById('file-upload01').value;

    // 입력값이 비어있는지 확인
    if (file01 === '') {
    	console.log("폼 제출 못해!");
        alert('대표 사진은 필수 입력입니다.'); // 경고 메시지 표시
        return false; // 폼 제출을 막기 위해 false 반환
    }
	console.log("폼 제출 허용!");
    return true; // 폼 제출을 허용
}

function previewFile(inputId, imageId, deleteId) {
    var preview = document.getElementById(imageId);
    var file = document.getElementById(inputId).files[0];
    var reader = new FileReader();

    reader.onloadend = function() {
        preview.src = reader.result;
        preview.style.display = 'block';
        document.getElementById(inputId).parentNode.style.display = 'none'; // 파일 업로드 버튼 숨기기
        document.getElementById(deleteId).parentNode.style.display = 'block'; // 사진 삭제 버튼 보이기
    }

    if (file) {
		var maxFileSize = 5 * 1024 * 1024; // 5MB 이하로 설정 예시 (바이트 단위)
	
		if (file.size > maxFileSize) {
            alert('파일 크기는 5MB 이하여야 합니다.');
            fileInput.value = ''; // 파일 선택 취소
        } else {
            reader.readAsDataURL(file);
        }
	        
    } else {
        preview.src = '';
        preview.style.display = 'none';
        document.getElementById(inputId).parentNode.style.display = 'block'; // 파일 업로드 버튼 보이기
        document.getElementById(deleteId).parentNode.style.display = 'none'; // 사진 삭제 버튼 숨기기
    }
}

function resetPreview(inputId, imageId, deleteId) {
    var preview = document.getElementById(imageId);
    preview.src = '';
    preview.style.display = 'none';
    document.getElementById(inputId).value = ''; // 파일 선택 초기화
    document.getElementById(inputId).parentNode.style.display = 'block'; // 파일 업로드 버튼 보이기
    document.getElementById(deleteId).parentNode.style.display = 'none'; // 사진 삭제 버튼 숨기기
}
