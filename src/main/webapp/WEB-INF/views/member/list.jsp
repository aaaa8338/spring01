<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<style type="text/css">
	.table table-striped tr th,td{
		text-align: center;
	}
	.boardtop td{
		font-weight: bold; 
		border-bottom: 2px solid lightgray; 
		background-color: white;
		border-top: 0px;
	}
	.had{
		text-align: center;
		margin-bottom: 20px;
	}
	.ser{
		text-align:center;
		margin: 2% 0px;
	}
	.sel{
		height: 26px;
		border-radius: 4px;
	}
	.a:hover {
		color: orange;
		
	}
</style>
<script type="text/javascript">
	function list(page){ //현재 페이지의 조건을 넘겨준다. +뒤에있는 것들은 검색 
	    location.href="${path}/member/list.do?curPage="+page+"&search_option=${map.search_option}"+"&keyword=${map.keyword}";
	}
</script>
</head>
<body>
<%@ include file ="../include/adminmenu.jsp" %>
<div class="container">
	<div class="had">
		<h2>memberList</h2>
		<span>${map.count}명이 있습니다.</span>
	</div>
	<table class="table table-striped">
		<thead>
		<tr class="boardtop">
			<td>아이디</td>
			<td>이름</td>
			<td>성별</td>
			<td>가입일자</td>
		</tr>
		</thead>
		<c:forEach var="row" items="${map.list}">
			<tr>
				<td>
					<script type="text/javascript">
						function detail(userid) {   	
							var url = "${path}/member/detail.do?userid=" + userid;
							window.open(url,"_blank_1","toolbar=no, menubar=no, scrollbars=no, resizable=no, width=773, height=550");
							
						}
					</script>
					<a class="a" style="cursor: pointer;" onclick="detail('${row.userid}')">${row.userid}</a>
					<input type="hidden" id="userid" name="userid" value="${row.userid}">
				</td>
				<td>${row.name}</td>
				<td>${row.gender}</td>
				<td><fmt:formatDate value="${row.regdate}"/></td>
			</tr>
		</c:forEach>
	</table>
	<div class="row" style="text-align: center;">
		<div class="col">
			<ul class="pagination">
			  	<li>
			   	<c:if test="${map.pager.curBlock >= 1}">
		    		<a aria-label="Previous" href="javascript:list('${map.pager.prevPage}')"><span aria-hidden="true">&laquo;</span></a>
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
			  	<c:if test="${map.pager.curBlock <= map.pager.totBlock}">
					<a aria-label="Next" href="javascript:list('${map.pager.nextPage}')" ><span aria-hidden="true">&raquo;</span></a>
			  	</c:if>
			  </li>
			</ul>
		</div>
	</div>
		
</div>
	<div class="ser">
	<form name="form1" method="post" action="${path}/member/list.do"> 
			<select name="search_option" class="sel">
				<c:choose>
					<c:when test="${map.search_option == 'name'}">
						<option value="name" selected="selected">이름</option>
						<option value="userid">아이디</option>
					</c:when>
					<c:when test="${map.search_option == 'userid'}">
						<option value="name" >이름</option>
						<option value="userid" selected="selected">아이디</option>
					</c:when>
				</c:choose>
			</select> 
			<span style="margin: 0; padding: 0;"><input name="keyword" value="${map.keyword}"></span>
	    <input type="submit" value="조회">
	</form>
	</div>
<br>
<br>
<br>
<%@ include file ="../include/footer.jsp" %>
</body>
</html>