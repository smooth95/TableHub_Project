document.addEventListener('DOMContentLoaded', function() {
    var sliders = document.querySelectorAll('.menu-img');
    
    sliders.forEach(function(slider) {
        var index = 0; // 현재 슬라이드의 인덱스 추적
        var li = slider.querySelectorAll('ul.image-slide > li'); // 모든 슬라이드 요소 선택
        var liLength = li.length; // 슬라이드의 총 개수 저장

        if (liLength > 0) { // 슬라이드 요소가 존재하는지 확인
            li[index].classList.add('on'); // 초기 상태 설정: 첫 번째 슬라이드를 보이도록 설정

            function updateSlider() {
                var prevIndex = (index - 1 + liLength) % liLength; 
                // 이전 슬라이드 인덱스 계산, index-1이 음수가 되어도 올바른 인덱스 찾을 수 있도록 liLength 더하고 '%liLength'로 나머지 연산

                li[prevIndex].classList.remove('on');
                li[prevIndex].classList.add('out');
                // 이전 슬라이드의 클래스를 out으로 설정하여 슬라이드 아웃 애니메이션 적용

                li[index].classList.remove('out');
                li[index].classList.add('on');
                // 현재 슬라이드의 클래스를 on으로 설정해여 슬라이드 인 애니메이션 적용

                index = (index + 1) % liLength; // 인덱스 증가, 마지막 슬라이드 이후에 첫 번째 슬라이드로 돌아가도록
            }

            setTimeout(function() {
                setInterval(updateSlider, 3000);
            }, 0);
        } else {
            console.error("No slide elements found for this slider.");
        }
        
        // 버튼 클릭 이벤트 핸들러
//         var buttons = slider.querySelectorAll('.food-tagname button');
        
//         // 각 버튼에 클릭 이벤트를 추가
//         buttons.forEach(function(button, buttonIndex) {
//             button.addEventListener('click', function(event) {
//             	  event.preventDefault(); // 이벤트 디폴트 동작 방지
//                   console.log("Button clicked: " + buttonIndex);
            	
//                 var categoryInput = button.closest('.food-tagname').querySelector('input[name="category"]');
//             	if(categoryInput){
//             		 var category = categoryInput.value;
//             		 console.log("Category found: " + category); 
            		 
//                 var currentUrl = new URL(window.location.href);
//                 var keyword = currentUrl.searchParams.get("keyword");
//                 var searchType = currentUrl.searchParams.get("searchType");
//                 //var url = '/root/main/mainPage2?category=' + encodeURIComponent(category);
                
//                 var baseUrl = '/root/main/mainPage2';
//                     var url = baseUrl + '?category=' + encodeURIComponent(category);
                
//                 if (keyword) {
//                     url += '&keyword=' + encodeURIComponent(keyword);
//                 }
//                 if (searchType) {
//                     url += '&searchType=' + encodeURIComponent(searchType);
//                 }

//                 console.log("redirecting to url :"+url);
                
//                 window.location.href = url;
//             }else{
//             	   console.log("Category input not found.");
//             }
//             });
//         });
    });
});
