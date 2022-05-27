<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<%-- <script src="${path}/ckeditor/ckeditor.js"></script>
<script src="//cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script> --%>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<script type="text/javascript">
$(function(){
	$("#productname").blur(function() {
		var productname = $("#productname").val()
		 /* 한글,영어,숫자만 */
		var param = {"productname": productname};
		var regexp = new RegExp("^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|]{1,10}$");
		
		$.ajax({
			url: '${path}/product/productCheck.do?productname='+productname,
			type: "get",
			success: function(data) {
				if (data == 1) {
					$("#productCheck").text("exist");
					$("#productCheck").css("color","red");
					$("#insertBtn").attr("disabled",true);
					
				} else if (productname == "") {
					$("#productCheck").text("inputname");
					$("#productCheck").css("color","red");
					$("#insertBtn").attr("disabled",true);
					
				} else if (!regexp.test(productname)) {
					$("#productCheck").text("1-10자까지 가능");
					$("#productCheck").css("color","black");
					$("#insertBtn").attr("disabled",true);
					
				} else {
					$("#productCheck").text("");
					$("#insertBtn").attr("disabled",false);
				}
				
			},
			error : function() {
				alert('error');
			}
			
		});
	});
	
	$("#price").blur(function() {
		var price = $("#price").val()
		var regexp = new RegExp("^[0-9]{0,10}$");
		
		if (!regexp.test(price)) {
			$("#number").text("only number");
			$("#number").css("color","red");
			$("#insertBtn").attr("disabled",true);
			
		}else if (price == "") {
			$("#number").text("input number");
			$("#number").css("color","red");
			$("#insertBtn").attr("disabled",true);
			
		} else {
			$("#number").text("");
			$("#number").css("color","black");
			$("#insertBtn").attr("disabled",false);
		}
	});

});
	function product_write() {
		/* var productname = document.form1.productname.value;
		var price = document.form1.price.value;
		var description = document.form1.description.value;
		
		if(productname == ""){
			alert("상품명을 입력하세요");
			document.form1.product_name.focus();
			return;
		}
		if(price == ""){
			alert("가격을 입력하세요");
			document.form1.price.focus();
			return;
		}
		if(isNaN(document.form1.price.value)){
			alert("숫자를 입력하세요");
			document.form1.price.focus();
			return;
		}
		if(description == ""){
			alert("상품설명을 입력하세요");
			document.form1.description.focus();
			return;
		} */
		document.form1.action = "${path}/product/insert.do";
		document.form1.submit();
	}

</script>
<style type="text/css">
.btn1{
	text-align: center;
}
</style>
</head>
<body>
<%@ include file ="../include/adminmenu.jsp" %>
<div class="container">
	<div>
		<h2 style="text-align: center; padding: 10px 0px 30px 0px; ">product register</h2>
	</div>
	<div class="col-md-6 col-md-offset-3">
	<form name="form1" id="form1" method="post" enctype="Multipart/form-data">
		<table>
			<tr>
				<td>종류</td>
				<td>
				<select name="kind">	
					<option value="반지">반지</option>
					<option value="목걸이">목걸이</option>
				</select>
				</td>
			<tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>상품명</td>
				<td><input type="text" id="productname" name="productname" class="form-control"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<div id="productCheck"></div>
				</td>
			<tr>
				<td>가격</td>
				<td><input type="text" id="price" name="price" class="form-control"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<div id="number"></div>
				</td>
			<tr>
			<tr>
			<tr>
				<td>상품설명</td>
				<td><textarea rows="5" cols="50" name="description" id="description"
				class="form-control"></textarea></td>
			</tr>
			<!-- <script type="text/javascript">
			//id가 description인 태그에 ckeditor를 적용시킴
			CKEDITOR.replace("description",{filebrowserUploadUrl : "${path}/imageUpload.do"}); 
			//이미지 업로드 기능을 추가하기위한 코드
			</script>  -->
			<tr>
				<td>이미지</td>
				<td><input type="file" name="file1"></td>
			</tr>
		</table>
	</form>
	<br>
	<br>
	<div class="btn1">
		<input type="button" class="btn btn-default" value="등록" id="insertBtn" onclick="product_write()">
		<input type="button" class="btn btn-default" value="상품목록" 
		onclick="location.href='${path}/product/allList.do'">
	</div>
	</div>
</div>
<br>
<br>

<%-- <form id="form1" name="form1" method="post" enctype="Multipart/form-data">
	<table>
		<tr>
			<td>종류</td>
			<td>
			<select name="kind">
				<option value="반지">반지</option>
				<option value="목걸이">목걸이</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>상품명</td>
			<td><input type="text" name="productname"></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="text" name="price"></td>
		</tr>
		<tr>
			<td>상품설명</td>
			<td><textarea rows="5" cols="50" name="description" id="description"></textarea></td>
		</tr>
	 	<!-- <script type="text/javascript">
		//id가 description인 태그에 ckeditor를 적용시킴
			CKEDITOR.replace("description",{filebrowserUploadUrl : "${path}/imageUpload.do"}); 
		//이미지 업로드 기능을 추가하기위한 코드
		</script> -->
		
		<tr>
			<td>이미지</td>
			<td><input type="file" name="file1"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="등록" onclick="product_write()">
				<input type="button" value="상품목록" 
				onclick="location.href='${path}/product/allList.do'">
			</td>
		</tr>
	</table>
</form> --%>
 <%@ include file ="../include/footer.jsp" %>
</body>
</html>