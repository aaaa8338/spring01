<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/d438fba670.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
<script src='http://code.jquery.com/jquery-3.3.1.js'></script>
<script type="text/javascript">
function emailCheck() {
	document.form.action = "${pageContext.request.contextPath}/member/send.do";
	document.form.submit(); 
	
	/* var userid = $("#userid").val();
	var email = $("#email").val();
	var param={"userid":userid, "email": email};
	$.ajax({
	    type: "post",
	    url: "${pageContext.request.contextPath}/member/send.do",
		data: form,
	    success: function () {
			window.opener.location.reload(); 
			window.close();
			alert('메일발송이 완료되었습니다.');
       }
	});	  */
}
</script>
</head>
<body>
	<div class="container">
		<div class="" style="text-align: center; margin-bottom: 20px;">
			<h3>비밀번호찾기</h3>
		</div>
		<form:form id="form" name="form" commandName="memberDto" method="post" cssClass="form-horizontal" role="form">
			<div class="col-md-2 col-md-offset-5">
				<div class="input-group">
					<span class="input-group-addon"><i class="fas fa-user"></i></span>
					<form:input path="userid" placeholder="id" cssClass="form-control" aria-describedby="sizing-addon2"/>
				</div>
			</div>
			<div class="col-md-2 col-md-offset-5" style="margin: 15px 0;"><form:errors path="userid" cssStyle="color:red;"/></div>
			<div class="col-md-2 col-md-offset-5">
				<div class="input-group">
					<span class="input-group-addon"><i class="fas fa-envelope"></i></span>
					<form:input path="email" placeholder="email" cssClass="form-control" aria-describedby="sizing-addon2"/>
				</div>
			</div>
			<div class="col-md-2 col-md-offset-5"style="margin: 15px 0;" ><form:errors path="email" cssStyle="color:red;"/><form:errors/></div>
			<div class="col-md-2 col-md-offset-5" style="color: red; text-align: center;">${msg}</div>
			<div style="text-align: center; margin-top: 10px;"><input type="button" class="btn btn-default" value="확인" onclick="emailCheck()" ></div>
		</form:form>
	</div>
</body>
</html>