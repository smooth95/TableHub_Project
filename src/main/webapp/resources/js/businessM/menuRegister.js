console.log("자바스크립트 가동 ");

 function addRow() {
		console.log("행 추가 함수 가동 ");
            var table = document.getElementById("menuBody");
            var newRow = table.insertRow();
        
            var cell00 = newRow.insertCell(0);
            var cell01 = newRow.insertCell(1);
            var cell02 = newRow.insertCell(2);
            var cell03 = newRow.insertCell(3);
            var cell04 = newRow.insertCell(4);
           
            cell00.innerHTML = '<select name="menu_category' + rowIndex + '">' +
	                              '<option value="에피타이저">에피타이저</option>' +
	                              '<option value="메인">메인</option>' +
	                              '<option value="사이드">사이드</option>' +
	                              '<option value="음료">음료</option>' +
	                              '<option value="술">술</option>' +
	                              '<option value="디저트">디저트</option>' +
	                              '</select>';
            cell01.innerHTML = '<input type="text" name="menu_name' + rowIndex + '">';
            cell02.innerHTML = '<input type="number" name="menu_price' + rowIndex + '">';
            cell03.innerHTML = '<input type="file" name="menu_photo' + rowIndex + '">';    
            cell04.innerHTML = '<input type="text" name="menu_note' + rowIndex + '">';
            
             rowIndex++; // 다음 행의 인덱스 증가
        }
        
    function submitForm() {
            // 추가된 행의 수를 계산
            var rowCount = rowIndex; //document.querySelectorAll('#menuBody tr').length;
			
            // hidden input을 통해 rowCount 값을 폼 데이터로 추가
            var form = document.getElementById('menuForm');
            var rowCountInput = document.createElement('input');
            rowCountInput.type = 'hidden';
            rowCountInput.name = 'rowCount';
            rowCountInput.value = rowCount;
            form.appendChild(rowCountInput);

            // 폼 전송
            form.submit();
        }