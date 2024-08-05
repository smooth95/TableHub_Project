<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="<%= request.getContextPath() %>" />
    <c:set var="storeAdd" value="${storeAdd}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
let storeAdd = '${storeAdd}';
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=f96a93ad7623e257e539c299c4c8fcb6&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f96a93ad7623e257e539c299c4c8fcb6"></script>
<script type="text/javascript" src="${path}/resources/js/store/storeMap.js"></script>

<style>
  body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    flex-direction: column;
  }
  #map {
    width: 900px;
    height: 600px;
  }
</style>
</head>
<body>
<h3 style="text-align : center;">${storeAdd}</h3>
<br>
<div id="map"></div>

</body>
</html>