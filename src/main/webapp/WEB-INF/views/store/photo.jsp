<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/store/storePhoto.css?after">
<script src="${path}/resources/js/store/storePhoto.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>

<div class="image-container">
  <c:forEach var="Simg" items="${storeImg}">
      <img src="/root/businessM/download?img=${Simg}" alt="Store Image" onclick="openModal(this.src)">
  </c:forEach>
  <c:forEach var="Rimg" items="${reviewImg}">
      <img src="/root/businessM/download?img=${Rimg}" alt="Review Image" onclick="openModal(this.src)">
  </c:forEach>
</div>

<!-- Modal -->
<div id="myModal" class="modal">
  <span class="close" onclick="closeModal()">&times;</span>
  <img class="modal-content" id="modalImg">
</div>

</body>
</html>