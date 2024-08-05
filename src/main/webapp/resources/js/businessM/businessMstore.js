window.onload = function(){
	if(storeAdd != null) {
		showMap(storeAdd)
	}
		 
}

function daumPost() {
    new daum.Postcode({
        oncomplete: function(data) {
            let addr = "";
            if (data.userSelectedType == 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }
            document.getElementById("addr1").value = data.zonecode;
            document.getElementById("addr2").value = addr;
            document.getElementById("addr3").focus();

            if (addr.trim() !== '') {
                showMap(addr);
            } else {
                document.getElementById('map').style.display = 'none';
            }
        }
    }).open();
}

let map;
let marker;

function showMap(address) {
    const geocoder = new kakao.maps.services.Geocoder();

    geocoder.addressSearch(address, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            const coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 지도가 생성되지 않았으면 새로 생성, 이미 생성된 경우 기존 지도 사용
            if (!map) {
                const mapContainer = document.getElementById('map');
                const mapOption = {
                    center: coords,
                    level: 3
                };
                map = new kakao.maps.Map(mapContainer, mapOption);

            } else {
                // 이미 생성된 지도가 있는 경우, 중심 위치 변경
                map.setCenter(coords);
            }

            // 마커가 없으면 새로 생성, 이미 있는 경우 위치만 업데이트
            if (!marker) {
                marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });
            } else {
                marker.setPosition(coords);
            }

            // 지도를 보여줄 때 display 속성 변경
            document.getElementById('map').style.display = 'block';
            map.relayout();
            map.setCenter(coords);
         	
		    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
		    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
		    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
			  
        }else if(storeZip == "") {
        	console.log("로그를 생활화");
        
        }else {
            alert('주소를 찾을 수 없습니다.');
            document.getElementById('map').style.display = 'none';
        }
    });
}


function sendHeight(n) {
		console.log("sendHeight 실행")
		parent.postMessage({ height: n}, '*');
    }


function inputcheck00() {
    // 입력값 가져오기
    var store_name = document.getElementById('store_name').value;

    // 입력값이 비어있는지 확인
    if (store_name === '') {
        alert('가게이름을 직접 입력해주세요!'); // 경고 메시지 표시
        return false; // 폼 제출을 막기 위해 false 반환
    }

    return true; // 폼 제출을 허용
}

function inputcheck01() {
    // 입력값 가져오기
    var store_zip = document.getElementById('addr1').value;
	var store_add_info = document.getElementById('addr3').value;

    // 입력값이 비어있는지 확인
    if (store_zip === '') {
        alert('우편번호를 검색해주세요!'); // 경고 메시지 표시
        return false; // 폼 제출을 막기 위해 false 반환
    }
    else if (store_add_info === '') {
        alert('상세주소를 입력해주세요.\n 예) 505호, 3층, 단독건물 등'); // 경고 메시지 표시
        return false; // 폼 제출을 막기 위해 false 반환
    }

    return true; // 폼 제출을 허용
}


//카테고리 최대 3개 선택가능하게 하는것
document.addEventListener('DOMContentLoaded', (event) => {
    const checkboxes = document.querySelectorAll('input[name="store_category"]');
    const maxAllowed = 3;
    const checkedCheckboxes = [];

    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', (event) => {
            if (checkbox.checked) {
                if (checkedCheckboxes.length >= maxAllowed) {
                    // 마지막 체크한 체크박스를 해제
                    const lastChecked = checkedCheckboxes.shift();
                    lastChecked.checked = false;
                }
                // 새로 체크한 체크박스를 배열에 추가
                checkedCheckboxes.push(checkbox);
            } else {
                // 체크 해제된 체크박스를 배열에서 제거
                const index = checkedCheckboxes.indexOf(checkbox);
                if (index > -1) {
                    checkedCheckboxes.splice(index, 1);
                }
            }
        });
    });
});


function inputcheck02() {
    var store_introduce = document.getElementById('store_introduce').value;
    
	var storeCategory = document.getElementById('storeCategory');
	var checkboxes = store_category.querySelectorAll('input[type="checkbox"]');
    var isChecked = Array.from(checkboxes).some(function(checkbox) {
        return checkbox.checked;
    });
	
	var store_max_person = document.getElementById('store_max_person').value;
	var store_booking_rule = document.getElementById('store_booking_rule').value;


    if (store_introduce === '') {
        alert('간단한 소개글을 입력해주세요!');
        return false;
    }
    else if (!isChecked) {
        alert('하나 이상의 카테고리를 선택해주세요');
        return false;
    }
    else if (store_max_person === '') {
        alert('최대 수용인원을 입력해주세요');
        return false;
    }
    
    else if (store_booking_rule === '') {
        alert('예약규정을 입력해주세요');
        return false;
    }
    

    return true;
}