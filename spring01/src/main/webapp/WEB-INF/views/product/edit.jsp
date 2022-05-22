<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="${path}/ckeditor/ckeditor.js"></script>
<script src="//cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>
<script type="text/javascript">
	function product_update() {
		var price = document.form1.price.value;
		
		if (isNaN(document.form1.price.value)) {
			alert("숫자를 입력하세요");
			document.form1.price.focus();
			return;
		}
		
		document.form1.action="${path}/product/update.do";
		document.form1.submit();
	}
	
	function product_delete() {
		if (confirm("삭제하시겠습니까?")) {
			document.form1.action="${path}/product/delete.do";
			document.form1.submit();
		}
	}
</script>
<style type="text/css">
table tr {
	margin-bottom: 30px;
}
.btn1{
	text-align: center;
}
</style>
</head>
<body>
<%@ include file ="../include/adminmenu.jsp" %>
<div class="container">
	<div>
		<h2 style="text-align: center; padding: 10px 0px 30px 0px; ">product edit</h2>
	</div>
	<div class="col-md-6 col-md-offset-3">
	<form name="form1" id="form1" method="post" enctype="Multipart/form-data" >
		<table>
			<tr>
				<td>종류</td>
				<td>
				<select name="kind">	
				<c:choose>
					<c:when test="${dto.kind=='반지'}">
						<option value="반지" selected="selected">반지</option>
						<option value="목걸이">목걸이</option>
					</c:when>
					<c:when test="${dto.kind=='목걸이'}">
						<option value="반지" >반지</option>
						<option value="목걸이" selected="selected">목걸이</option>
					</c:when>
				</c:choose>
				</select>
				</td>
			<tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>상품명</td>
				<td><input type="text" name="productname" value="${dto.productname}"></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="price" value="${dto.price}"></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
			<tr>
				<td>상품설명</td>
				<td><textarea rows="5" cols="50" name="description" id="description">
					${dto.description}
				</textarea></td>
			</tr>
			<!-- <script type="text/javascript">
			//id가 description인 태그에 ckeditor를 적용시킴
			CKEDITOR.replace("description",{filebrowserUploadUrl : "${path}/imageUpload.do"}); 
			//이미지 업로드 기능을 추가하기위한 코드
			</script>  -->
			<tr>
				<td>이미지</td>
				<td>
				<img src="${path}/images/${dto.pictureurl}" width="200px" height="200px">
				<br>
				<input type="file" name="file1">
				</td>
			</tr>
		</table>
	<br>
	<br>
	<div class="btn1">
		<input type="hidden" name="productid" value="${dto.productid}">
		<input type="button" class="btn btn-default" value="수정" onclick="product_update()">
		<input type="button" class="btn btn-default" value="삭제" onclick="product_delete()">
		<input type="button" class="btn btn-default" value="상품목록" 
		onclick="location.href='${path}/product/allList.do'">
	</div>
	</form>
	</div>
</div>
<br>
<br>
 <%@ include file ="../include/footer.jsp" %>
</body>
</html>