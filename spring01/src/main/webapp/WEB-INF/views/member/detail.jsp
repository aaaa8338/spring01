<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<%@ include file ="../include/header.jsp" %>
<script type="text/javascript">

</script>
</head>
<body>
<%-- <%@ include file ="../include/adminmenu.jsp" %> --%>
	<div class="container">
	<form name="form1" method="post">
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>User Profile</h4>
				</div>
				<div class="panel-body">
					<div class="col-md-4 col-xs-12 col-sm-6 col-lg-4">
						<img alt="User Pic" src="https://x1.xingassets.com/assets/frontend_minified/img/users/nobody_m.original.jpg"
							id="profile-image1" class="img-circle img-responsive">


					</div>
					<div class="col-md-8 col-xs-12 col-sm-6 col-lg-8">
						<div class="container">
							<h2>${dto.userid}</h2>
							<p>${dto.name}(${dto.gender})</p>

						</div>
						<hr>
						<ul class="container details">
							<li>
							<p><span class="glyphicon glyphicon-phone" style="width: 50px;"></span>${dto.tel}</p>
							</li>
							<li>
							<p><span class="glyphicon glyphicon-envelope one" style="width: 50px;"></span>${dto.email}</p>
							</li>
							<li>
							<p><span class="glyphicon glyphicon-home" style="width: 50px;"></span>${dto.address1}</p>
							</li>
							<li>
							<p><span class="glyphicon glyphicon-home" style="width: 50px;"></span>${dto.address2}</p>
							</li>
						</ul>
						<hr>
						<div class="col-sm-5 col-xs-6 tital">Date Of Joining: <fmt:formatDate value="${dto.regdate}"/></div>
					</div>
				</div>
						<div style="margin: 3% 0; text-align: center;">
							<!-- <input type="button" class="btn btn-default" value="수정" id="btnUpdate"> -->
							<a class="btn btn-default" id="btnDelete" href="javascript:deleted('${dto.userid}')">삭제</a>
							<script type="text/javascript">
							function deleted(userid) {
								if(confirm("삭제하시겠습니까?")){
									$.ajax({
									    type: "post",
									    url: "${path}/member/deleted.do?userid=${dto.userid}",  
									    success: function () {
										    window.opener.location.reload(); 
										    window.close();
								       }
									});	
								}   
							}
							</script>
							<a class="btn btn-default" id="btnUpdate" href="${path}/member/userinfo.do?userid=${dto.userid}">수정</a>
						</div>
			</div>
		</div>
		</form>
	</div>

	<%-- <h2>회원정보</h2>
	<form name="form1" method="post">
		<table width ="600px">
			<tr>
				<td>아이디</td>
				<td><input type="text" id="userid" name="userid" value="${dto.userid}" readonly="readonly"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" id="userpwd" name="userpwd"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" id="name" name="name" value="${dto.name}"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" id="email" name="email" value="${dto.email}"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" id="tel" name="tel" value="${dto.tel}"></td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td>
					<input type="text" id="zipcode" name="zipcode" readonly value="${dto.zipcode}">
					<input type="button" onclick="daumZipCode()" value="우편번호 찾기">
				</td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" id="address1"name="address1" value="${dto.address1}" size="60"></td>
			</tr>
			<tr>
				<td>상세주소</td>
				<td><input type="text" id="address2" name="address2" value="${dto.address2}"></td>
			</tr>
			<tr>
				<td>성별</td>
				<td>${dto.gender}</td>
			</tr>
			<tr>
				<td>가입일자</td>
				<td><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="수정" id="btnUpdate" >
					<input type="button" value="삭제" id="btnDelete" >
					<div style="color: red;">${message}</div>
				</td>
			</tr>
		</table>
	</form> --%>

</body>
</html>