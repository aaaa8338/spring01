<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<link rel="stylesheet" href="${path}/css/product1.css"/> 
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function product_write() {
		location.href="${path}/product/write.do";
	}
	function list(page){ //현재 페이지의 조건을 넘겨준다. +뒤에있는 것들은 검색 
	    location.href="${path}/product/allList.do?curPage="+page+"&search_option=${map.search_option}"+"&keyword=${map.keyword}";
	    
	}
</script>

<script>
	$(document).ready(function () {
		$(".pad").hover(function() {
				$(this).addClass("sha", 10);
			}, function() {
				$(this).removeClass("sha", 100);
			});
		});
</script>
<style type="text/css">
.had{
	text-align: center;
}
.ser {
	text-align:center;
	margin: 2% 0px;
	padding: 0px;
}
</style>
</head>
<body>
<c:choose>
	<c:when test="${sessionScope.power == '0'}">
		<%@ include file ="../include/adminmenu.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file ="../include/menu.jsp" %>
	</c:otherwise>
</c:choose>
<div class="had">
<h1>product</h1>
<span>${map.count}개의 상품이 있습니다.</span>
</div>

<div class="list">
	<input type="hidden" value="${row.kind}">
	<ul>
		<li><h2>카테고리</h2></li>
		<li class="hover"><a href="${path}/product/allList.do">All</a></li>
		<li class="hover"><a href="${path}/product/ringList.do?kind=반지">Ring</a></li>
	    <li class="hover"><a href="${path}/product/necklaceList.do?kind=목걸이">Necklace</a></li>      
	</ul>
</div>


	<div class="middle">
		<c:forEach var="row" items="${map.list}">
		<input type="hidden" value="${row.kind}">
			<div class="pad">
				<input type="hidden" id="productid" value="${row.productid}">
				<a href="${path}/product/detail.do?productid=${row.productid}&curPage=${map.pager.curPage}&search_option=${map.search_option} 
				&keyword=${map.keyword}"><img class="pic" src="${path}/images/${row.pictureurl}"></a>
				<p>
				<a class="dd" style="font-size: 20px; margin-left: 3%;" 
				href="${path}/product/detail.do?productid=${row.productid}&curPage=${map.pager.curPage}&search_option=${map.search_option} 
				&keyword=${map.keyword}">${row.productname}</a>
				<p>
				<p id="detail1" style="font-size: 20px; margin-top: 2%; margin-left: 3%;"><fmt:formatNumber value="${row.price}" pattern="#,###"/>
					<c:if test="${sessionScope.userid == 'admin' }">
						<a class="btn btn-default" href="${path}/product/edit.do?productid=${row.productid}" style="float: right; margin-right: 3%;">수정</a>
					</c:if>
				</p>
			</div>
		</c:forEach>
	</div>

	
	
	<div class="container">
	<div class="row" style="text-align: center;">
		<div class="col">
			<ul class="pagination">
			  <li>
			   <c:if test="${map.pager.curBlock >= 1}">
			    		<a aria-label="Previous" href="javascript:list('${map.pager.prevPage}')">
			    		<span aria-hidden="true">&laquo;</span>
			    		</a>
			   </c:if> 
			  </li>
			  <li>
			   <c:forEach var="num" begin="${map.pager.blockBegin}" end="${map.pager.blockEnd}">
			      	<c:choose>
			              <c:when test="${num == map.pager.curPage}">  
			                  <span style="color:orange;">${num}</span>&nbsp;
			              </c:when>
			              <c:otherwise>
			                  <a href="javascript:list('${num}')">${num}</a>&nbsp;
			              </c:otherwise>
			          </c:choose>
			     </c:forEach>
			  </li>
			  <li>
			  	<c:if test="${map.pager.curBlock >= map.pager.totBlock}">
				<a aria-label="Next" href="javascript:list('${map.pager.nextPage}')" >
				<span aria-hidden="true">&raquo;</span>
				</a>
			  	</c:if>
			  </li>
			</ul>
		</div>
	</div>
	</div>
	
	<div class="ser">
<form name="form1" method="post" action="${path}/product/allList.do"> 
		<select name="search_option" class="option">
			<c:choose>
				<c:when test="${map.search_option == 'all'}">
					<option value="all" selected="selected">상품명+내용</option>
					<option value="productname">상품명</option>
					<option value="description">내용</option>
				</c:when>
				<c:when test="${map.search_option == 'productname'}">
					<option value="all">상품명+내용</option>
					<option value="productname" selected="selected">상품명</option>
					<option value="description">내용</option>
				</c:when>
				<c:when test="${map.search_option == 'description'}">
					<option value="all">상품명+내용</option>
					<option value="productname">상품명</option>
					<option value="description" selected="selected">내용</option>
				</c:when>
			</c:choose>
		</select> 
			<input class="keyword" name="keyword" value="${map.keyword}">
	    	<input class="check" type="submit" value="조회">
</form>
</div>
 <%@ include file ="../include/footer.jsp" %>
</html>