<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<c:set var="path" value="<%= request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/businessM/businMphoto.css?after">
<script src="${path}/resources/js/businessM/businMphoto.js"></script>
</head>
<body style="background:#e8e8e8;">
<header class="header">
<%@ include file="../../main/header.jsp" %>
</header>

<div class="center-box">


    
<form action="storeImgSave" method="post" enctype="multipart/form-data" onsubmit="return inputcheck00()">
    <div class="white-box">
		<h1>내 가게 사진 등록</h1>
	    <div class="photo01">
		    <div class="preview-box01">
		    	<label class="mainphoto-text">대표</label>
			    <div class="custom-file-upload01">
			        <label for="file-upload01"> + </label>
			    	<input id="file-upload01" type="file" accept="image/*" name="storeImage01"
			    		onchange="previewFile('file-upload01', 'preview-image01', 'file-delete01')" />
			    </div>
			    <div class="custom-file-delete01">
			     	<button id="file-delete01" type="button"
			     		onclick="resetPreview('file-upload01', 'preview-image01', 'file-delete01')" > - </button>
			    </div>
			    <div class="preview-container01">
		        	<img id="preview-image01" src="#" alt="">
		    	</div>
		    </div>
			 <div class="photo02">
				 <div class="photo01">
				    <div class="preview-box">
					    <div class="custom-file-upload">
					        <label for="file-upload02"> + </label>
					    	<input id="file-upload02" type="file" accept="image/*" name="storeImage02"
					    	onchange="previewFile('file-upload02', 'preview-image02', 'file-delete02')" />
					    </div>
					    <div class="custom-file-delete">
					     	<button id="file-delete02" type="button"
					     		onclick="resetPreview('file-upload02', 'preview-image02', 'file-delete02')" > - </button>
					    </div>
					    <div class="preview-container">
				        	<img id="preview-image02" src="#" alt="">
				    	</div>
				    </div>
			    
				    <div class="preview-box">
					    <div class="custom-file-upload">
					        <label for="file-upload03"> + </label>
					    	<input id="file-upload03" type="file" accept="image/*" name="storeImage03"
					    	onchange="previewFile('file-upload03', 'preview-image03', 'file-delete03')" />
					    </div>
					    <div class="custom-file-delete">
					     	<button id="file-delete03" type="button"
					     		onclick="resetPreview('file-upload03', 'preview-image03', 'file-delete03')" > - </button>
					     </div>
					    <div class="preview-container">
				        	<img id="preview-image03" src="#" alt="">
				    	</div>
				    </div>	    
				</div>
			
				<div class="photo01">
				    <div class="preview-box">
					    <div class="custom-file-upload">
					        <label for="file-upload04"> + </label>
					    	<input id="file-upload04" type="file" accept="image/*" name="storeImage04"
					    	onchange="previewFile('file-upload04', 'preview-image04', 'file-delete04')" />
					    </div>
					    <div class="custom-file-delete">
					     	<button id="file-delete04" type="button"
					     		onclick="resetPreview('file-upload04', 'preview-image04', 'file-delete04')" > - </button>
					     </div>
					    <div class="preview-container">
				        	<img id="preview-image04" src="#" alt="">
				    	</div>
				    </div>
				    
				    <div class="preview-box">
					    <div class="custom-file-upload">
					        <label for="file-upload05"> + </label>
					    	<input id="file-upload05" type="file" accept="image/*" name="storeImage05"
					    	onchange="previewFile('file-upload05', 'preview-image05', 'file-delete05')" />
					    </div>
					    <div class="custom-file-delete">
					     	<button id="file-delete05" type="button"
					     		onclick="resetPreview('file-upload05', 'preview-image05', 'file-delete05')" > - </button>
					     </div>
					    <div class="preview-container">
				        	<img id="preview-image05" src="#" alt="">
				    	</div>
				    </div>
				</div>
			</div>
		</div>
		<br>
	    <button type="submit">업로드</button>
	</div>
</form>
    
</div>
<div class="div_footer">
		<%@ include file="../../main/footer.jsp" %>
	</div>
</body>
</html>