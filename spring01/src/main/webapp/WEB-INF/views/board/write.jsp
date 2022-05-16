<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp"%>
<script src = "${path}/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
function boardwrite() {
	var title = document.form1.title.value;
	var content = document.form1.content.value;
	
	if(title == ""){
		alert("제목을 입력하세요");
		document.form1.title.focus();
		return;
	}
	/* if(content == ""){
		alert("내용을 입력하세요");
		document.form1.content.focus();
		return;
	} */

	document.form1.submit();
}
	
</script>
</head>
<body>
<%@ include file="../include/menu.jsp"%>
<div class="container">
	<div class="text-center">
		<h2>write</h2>
	</div>
	<form id="form1" name="form1" method="post" action="${path}/board/insert.do">

	<div class="form-inline">
	<div class="form-group" >
		<label for="title">title</label>
		<input name="title" id="title" placeholder="제목을 입력하세요" class="form-control">
	</div>
	</div>

<br>


<div style="width:800px;">
<label for="title">content</label>
<textarea id="content" name="content" rows="6" cols="80" placeholder="내용을 입력하세요"></textarea>
</div>
<script type="text/javascript">
		//id가 description인 태그에 ckeditor를 적용시킴
		CKEDITOR.replace("content",{filebrowserUploadUrl : "${path}/imageUpload.do"}); 
		//이미지 업로드 기능을 추가하기위한 코드
</script> 
<div>
	<div class="fileDrop"></div>
	<div id="uploadedList"></div>
</div>
<br><br>
<div class="text-center">
<button type="button" class="btn btn-default"  id="btnSave" onclick="boardwrite()">확인</button>
<input type="button" class="btn btn-default" value="글목록보기" onclick="location.href='${path}/board//list.do'">
</div>
<br>
<br>
<br>
<!-- <script>
CKEDITOR.replace("content");
</script> -->
 
</form>

</div>
 <%@ include file ="../include/footer.jsp" %>
</body>
</html>