<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="${path}/resources/css/default/footer.css"/>

</head>
<body>
	<footer>
		<div class="footer-image">
			<img src="${path}/resources/img/main/info_icon_01.png">
		</div>
		<div class="footer-info">
			<span>(주)Table HUB</span> <span> | </span>
			<span>대표 : 윤가영</span> <span> | </span>
			<span>사업자등록번호 : 000-11-22222</span> <span> | </span>
			<p>주소 : 서울시 마포구 종로 KG</p>
			<img src="https://img.freepik.com/premium-vector/facebook-logo-vector-icon-logotype-vector-eps_901408-408.jpg?w=826">
			<img src="https://e7.pngegg.com/pngimages/425/610/png-clipart-social-media-computer-icons-youtube-twitter-company-logo.png">
			<img src="https://mblogthumb-phinf.pstatic.net/MjAyMDAxMDlfMjIg/MDAxNTc4NTQ0MTMwODI3.W5pMwGQb22xW8hYGIBgF4Y2DheotJCj0dc_MZLiVhGQg.4I9ekROurF7sjus0WC1GbV-B4N_Qtrm3vIdaFoolBYsg.PNG.kmj070444/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1_%ED%88%AC%EB%AA%85_png.png?type=w800">
			<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/LINE_New_App_Icon_%282020-12%29.png/600px-LINE_New_App_Icon_%282020-12%29.png">
		</div>
	</footer>
</body>
</html>