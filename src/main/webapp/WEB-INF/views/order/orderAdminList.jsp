<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
.pic{
	width: 100px;
	height: 70px;
}
</style>
<script type="text/javascript">
	function product() {
		location.href="${pageContext.request.contextPath}/product/allList.do";
		
	}
</script>
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
</head>
<body>
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
								<h5><i class="fas fa-receipt"></i>&nbsp; Order</h5>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-body">
				<c:forEach var="row" items="${map.list}" varStatus="status">
					<div class="row">
						<div class="col-xs-4">
							<h4 class="product-name">
							<script type="text/javascript">
								function detail(userid,orderid) {
									location.href="${path}/order/adminDetailList.do?userid="+userid+"&orderid="+orderid;
									
								}
							</script>
							<strong><a style="cursor: pointer;" onclick="detail('${row.userid}','${row.orderid}');">${row.orderid}</a></strong>
							<input type="hidden" id="userid" name="userid" value="${row.userid}">
							<input type="hidden" id="orderid" name="orderid" value="${row.orderid}">
							</h4>
							<h4><small><fmt:formatDate value="${row.orderdate}" pattern="yyyy-MM-dd HH:mm"/></small></h4>
						</div>
						<div class="col-xs-3">
							<div class="col-xs-6 ">
								<h4><strong>
								<fmt:formatNumber value="${row.totalprice}" pattern="#,###,###"></fmt:formatNumber>
								</strong></h4>
							</div>
						</div>
						<div class="col-xs-3">
							<div class="col-xs-10">
								<h4><strong>
								${row.name}
								</strong></h4>
							</div>
						</div>
					</div>
					<hr>
				</c:forEach>
				</div>
				<div class="panel-footer">
					<div class="row text-center">
						<div class="col-xs-9">
							<h4 class="text-right"><strong></strong></h4>
						</div>
						<div class="col-xs-3">
							<button type="button" class="btn btn-primary btn-sm btn-block" onclick="product();">
									<span class="glyphicon glyphicon-share-alt"></span> Continue shopping
							</button>
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
<%-- <c:choose>
	<c:when test="${map.count == 0}">
		구매한 상품이 없습니다.
	</c:when>
	<c:otherwise>
		 <table border="1" width="400px;">
			<tr>
				<th>구매번호</th>
				<th>주문자</th>
				<th>주문일자</th>
			</tr>
			<c:forEach var="row" items="${map.list}">
				<tr align="center">
					<td><a href="${path}/order/orderDetailList.do?orderid=${row.orderid}">${row.orderid}</a>
					<input type="hidden" name="orderid" id="orderid" value="${row.orderid}">
					</td>
					<td>${row.name}</td>
					<td><fmt:formatDate value="${row.orderdate}"/></td>
				</tr>
			</c:forEach>
		</table> 
	</c:otherwise>
</c:choose> --%>

</body>
</html>