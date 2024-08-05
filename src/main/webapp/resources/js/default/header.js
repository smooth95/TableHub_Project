function submitSearch() {

		console.log("submitsearch함수");
        var category = document.getElementById('search_category').value;
        var keyword = document.getElementById('search_keyword').value.trim();
        var searchForm = document.getElementById('searchForm');

		console.log("검색어: " , keyword);
		
        // 검색어가 유효한 경우에만 검색 실행
        if (keyword !== '') {
            document.getElementById('search_category_hidden').value = category;
            searchForm.submit();
        } else {
            alert('검색어를 입력하세요.');
        }
    }
    
  