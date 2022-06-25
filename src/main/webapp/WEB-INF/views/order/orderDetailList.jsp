<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> 
<style type="text/css">
	.pic{
		width: 100px;
		height: 70px;
	}
</style>
<title>Insert title here</title>
</head>
<body>
<%@ include file ="../include/header.jsp" %>
<c:choose>
	<c:when test="${sessionScope.power == 'admin'}">
		<%@ include file ="../include/adminmenu.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file ="../include/menu.jsp" %>
	</c:otherwise>
</c:choose>
<div class="container">
	<div class="row">
		<div class="col-xs-10 col-xs-offset-1" style="margin-top: 40px;">
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">
						<div class="row">
							<div class="col-xs-6">
								<h5><i class="fas fa-receipt"></i>&nbsp; OrderDetail</h5>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-body">
				<c:forEach items="${orderDto}" var="row" varStatus="status">
					<div class="row">
						<div class="col-xs-2"><img class="pic" src="${path}/images/${row.pictureurl}"></div>
						<div class="col-xs-3 col-xs-offset-1">
							<h4 class="product-name" style="margin-top: 25px;">
							<strong>${row.productname}</strong>
							</h4>
						</div>
						<div class="col-xs-2 text-center">
							<h5>amount</h5>
							<h4><strong>${row.amount}</strong></h4>
						</div>
						<div class="col-xs-3">
							<div class="col-xs-6 col-xs-offset-3">
								<h5>price</h5>
								<h4><strong>
								<fmt:formatNumber value="${row.price}" pattern="#,###,###"></fmt:formatNumber>
								</strong></h4>
							</div>
						</div>
					</div>
					<hr>
				</c:forEach>
				</div>
				<div class="panel-footer">
					<div class="row text-center">
						<div class="col-xs-6 col-xs-offset-1">
							<c:forEach items="${orderDto}" var="row" varStatus="status">
								<c:if test="${status.first}">
								<h5 class="text-left"><strong>name : ${row.name}</strong></h5>
								<h5 class="text-left"><strong>address : ${row.address1}&nbsp; ${row.address2}</strong></h5>
								<h5 class="text-left"><strong>tel : ${row.tel}</strong></h5>
								<h5 class="text-left"><strong>total : <fmt:formatNumber pattern="###,###,###" value="${row.totalprice}" /></strong></h5>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>
<br>
<br>
<br>
<%@ include file ="../include/footer.jsp" %>
<%-- <div class="container">
 <div class="row">
 	<div>
 		<c:forEach items="${orderDto}" var="row" varStatus="status">
		   <c:if test="${status.first}">
		    <p><span>수령인</span>${row.name}</p>
		    <p><span>주소</span>(${row.zipcode}) ${row.address1} ${row.address2}</p>
		    <p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${row.totalprice}" /> 원</p>
		   </c:if>
  		</c:forEach>
 	</div>
 	<table class="table table-striped">
 		<thead>
 			<tr>
 				<th>상품명</th>
 				<th>개당 가격</th>
 				<th>구입 수량</th>
 			</tr>
 		</thead>
 		<c:forEach items="${orderDto}" var="row" >

 		<tr>
 			<td>${row.productname}</td>
 			<td>${row.price}</td>
 			<td>${row.amount}</td>
 		</tr>
 		</c:forEach>
 	</table>
</div>
</div> --%>
 
 

</body>
</html>