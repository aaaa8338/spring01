<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
</head>
<body>
<%@ include file ="../include/adminmenu.jsp" %>

<c:if test="${message == 'success'}">
</c:if>

	<h2>${sessionScope.name} (${sessionScope.userid})페이지 입니다.</h2>
</body>
</html>