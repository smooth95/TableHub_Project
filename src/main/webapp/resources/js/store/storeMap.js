window.onload = function(){
		 showMap(storeAdd)
		 
}


//--------------------------
	function sendHeight(n) {
		console.log("sendHeight 실행")
		parent.postMessage({ height: n}, '*');
    }
//---------------------------

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
			  
        } else {
            alert('주소를 찾을 수 없습니다.');
            document.getElementById('map').style.display = 'none';
        }
        sendHeight(700)
    });
}
