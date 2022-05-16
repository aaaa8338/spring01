<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<script type="text/javascript">
function changeCheck() {
 	if(document.form1.userpwd.value == ""){
		alert('비밀번호를 입력해 주세요.');
		form1.userpwd.focus();
		return; 
	}
	if(document.form1.newuserpwd.value == ""){
		alert('새비밀번호를 입력해 주세요.');
		form1.newuserpwd.focus();
		return; 
	}
	if(document.form1.confirmPassword.value == ""){
		alert('비밀번호확인을 입력해 주세요.');
		form1.confirmPassword.focus();
		return; 
	} 
	document.form1.action = "${path}/member/change.do";
	document.form1.submit();	
	
}
</script>
</head>
<body>
<%@ include file ="../include/menu.jsp" %>
	<div class="container">
		<div id="signupbox" style="margin-top: 50px; margin-bottom: 11%;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<div class="panel-title" style="text-align: center;">Change Password</div>
				</div>
				<div style="padding-top: 30px" class="panel-body">
					<form id="form1" name="form1" method="post" Class="form-horizontal">
						<div style="" class="form-group">
							<div class="col-md-12">
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> 
									<input type="password" id="userpwd" name="userpwd" class="form-control" placeholder="old password">
								</div>
							</div>
						</div>


						<div class="form-group">
							<div class="col-md-12">
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
									<input type="password" id="newuserpwd" name="newuserpwd" class="form-control" placeholder="new password">
								</div>
							</div>
						</div>


						<div class="form-group">
							<div class="col-md-12">
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> 
									<input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="confirm">
								</div>
							</div>
						</div>
						
					<c:if test="${message == 'required'}">
						<div style="text-align: center;" class="alert alert-danger" role="alert" >비밀번호가 일치하지 않습니다</div>
					</c:if>
					<c:if test="${message == 'error'}">
						<div style="text-align: center;" class="alert alert-danger" role="alert" >비밀번호 확인이 일치하지 않습니다.</div>
					</c:if>
					<c:if test="${message == 'error1'}">
						<div style="text-align: center;" class="alert alert-danger" role="alert" >기존 비밀번호가 일치하지 않습니다.</div>
					</c:if>
					<c:if test="${message == 'error2'}">
						<div style="text-align: center;" class="alert alert-danger" role="alert" >기존 비밀번호와 동일합니다.</div>
					</c:if>
					<div style="text-align: center;">
						<input type="button" style="text-align: center;" class="btn btn-default" value="확인" onclick="changeCheck()">
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	


	<%-- <form name="form1" method="post">
	<table style="width: 400px;">
		<tr>
 			<td>기존비밀번호</td>
			<td><input type="password" id="userpwd" name="userpwd"></td>
 		</tr>
 		<tr>
 			<td>새비밀번호</td>
 			<td><input type="password" id="newuserpwd" name="newuserpwd"></td>
 		</tr>
 		<tr>
 			<td>비밀번호확인</td>
 			<td><input type="password" id="confirmPassword" name="confirmPassword"></td>
 		</tr>
		<tr>
 			<td colspan="2">
 				<input type="button" value="확인" onclick="changeCheck()" >
 			</td>
 		</tr>
	</table>  
	<c:if test="${param.message == 'required'}">
		<div style="color: red;">아이디나 비밀번호가 일치하지 않습니다.</div>
	</c:if>
	<c:if test="${param.message == 'error'}">
		<div style="color: red;">비밀번호 확인이 일치하지 않습니다.</div>
	</c:if>
	<c:if test="${param.message == 'error1'}">
		<div style="color: red;">기존 비밀번호가 일치하지 않습니다.</div>
	</c:if>
	</form> --%>
<%@ include file ="../include/footer.jsp" %>
</body>
</html>