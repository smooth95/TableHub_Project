<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/default/header.css?after"/>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'>
<script  type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
    var contextPath = '<%= request.getContextPath() %>';
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/default/header.js"></script>

</head>
<body>
	<div class="flex-container">
	
		<!-- ===== item1 ===== -->
		<div class="flex-sub-container-1">
			<div class="flex-item">
				<c:if test="${userId != null }">
					<a href="/root/member/myPage/detail" class="a-item">Profile</a>
				</c:if>
				<c:if test="${storeId != null }">
					<a href="/root/businMmenu?category=0" class="a-item">Profile</a>
					
				</c:if>
			</div>
			
			<div class="flex-item">
				<c:if test="${storeId != null }">
					<a href="/root/store?store_id=${storeId}" class="a-item">MyStore</a>
				</c:if>
			</div>
			<div class="flex-item">
				<a href="#" class="a-item">Board</a>
			</div>
		</div>
		
		<!-- ===== Title 부분 ===== -->
		<div class="flex-item-title">
			<a href="/root/main/mainPage1" class="a-title">Table HUB</a>
		</div>
		
		<!-- ===== item2 ===== -->
		<div class="flex-sub-container-2">
			<div class="flex-item">
				<c:choose>
					<c:when test="${userId != null || storeId != null }">
						<a href="/root/member/logout" class="a-item">LOGOUT</a>
					</c:when>
					<c:otherwise>
						<a href="/root/member/login" class="a-item">LOGIN</a>
					</c:otherwise>
				</c:choose>	
			</div>
			
			<!-- ===== 검색부분 ===== -->
			<div class="search">
	            <form id="searchForm" action="${path}/main/mainPage2" method="get">
	                <select id="search_category" name="searchType">
	                    <option value="all" class="search_option">ALL</option>
	                    <option value="menu_name" class="search_option">Store Name</option>
	                    <option value="menu_category" class="search_option">Menu Category</option>
	                </select>
	                <input type="text" id="search_keyword" name="keyword" placeholder="search for..">
	                <input type="hidden" id="search_category_hidden" name="category" value="">
	                <div type="button" class="search-icon" onclick="submitSearch()">
	                    <img class="icon" 
	                    src="https://media.istockphoto.com/id/663931836/ko/%EB%B2%A1%ED%84%B0/%EB%8F%8B%EB%B3%B4%EA%B8%B0-%EB%AA%A8%EC%96%91%EC%9D%98-%EA%B2%80%EC%83%89-%EC%95%84%EC%9D%B4%EC%BD%98-%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8-%EB%A0%88%EC%9D%B4-%EC%85%98-%EB%94%94%EC%9E%90%EC%9D%B8.jpg?s=612x612&w=0&k=20&c=UyX-bsNA_IZZBjNFzoCHqLSRZqV5O6XgVJ9icR1LtlY=">
	                </div>
	            </form>
	        </div>
		</div>
	</div>
</body>
</html>


