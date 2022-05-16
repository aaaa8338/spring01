<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<%-- <link rel="stylesheet" href="${path}/css/board.css"/>  --%>
<script type="text/javascript">
$(function(){ //아이디가 btnWrite인 버튼을 누르게 되면 write.do 컨트롤러로 맵핑
    $("#btnWrite").click(function(){
        location.href="${path}/board/write.do";
    });
});
 
function list(page){ //현재 페이지의 조건을 넘겨준다. +뒤에있는 것들은 검색 
    location.href="${path}/board/list.do?curPage="+page+"&search_option=${map.search_option}"+"&keyword=${map.keyword}";
}

</script>
<style type="text/css">
.top {
	text-align:center;
}
.ser {
	text-align:center;
	margin: 2% 0px;
	padding: 0px;
}
.table tr td a:hover {
	text-decoration: underline;
	color: orange;
}
#btnWrite {
	margin-bottom: 1%;
}
tr th{
	text-align: center;
}
.sel{
	height: 26px;
	
}
.boardtop td{
		font-weight: bold; 
		border-bottom: 2px solid lightgray; 
		background-color: white;
		border-top: 0px;
}

</style>
</head>
<body>
<c:if test="${sessionScope.userid == 'admin'}">
<%@ include file ="../include/adminmenu.jsp" %>
</c:if>
<c:if test="${sessionScope.userid != 'admin'}">
<%@ include file ="../include/menu.jsp" %>
</c:if>
<div class="container">
<div class="top">
<h1>Board</h1>
${map.count}개의 게시글이 있습니다.
</div>
<br>
<div>
<button type="button" id="btnWrite" class="btn btn-default btn-sm">글쓰기</button>
</div>
<div id="wrap">
<table class="table table-striped">
    <thead class="boardtop">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>이름</th>
        <th>날짜</th>
        <th>조회수</th>
    </tr>
    </thead>
	<c:forEach var="row" items="${map.list}">
	   <tr>
	       <td style="text-align: center;">${row.bno}</td>
	       <td>
				<a class="title" href="${path}/board/detail.do?bno=${row.bno}&curPage=${map.pager.curPage}
				&search_option=${map.search_option} &keyword=${map.keyword}">${row.title}
				</a>
		        <c:if test="${row.cnt > 0}">
		            <span style="color:red;">(${row.cnt})</span>
		        </c:if>   
	  		</td>
	       <td style="text-align: center;">${row.name}</td>
	       <td style="text-align: center;"><fmt:formatDate value="${row.regdate}"/> </td>
	       <td style="text-align: center;">${row.viewcnt}</td>
	   </tr>
	</c:forEach>    
</table>
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
			  	<c:if test="${map.pager.curBlock <= map.pager.totBlock}">
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
	<form name="form1" method="post" action="${path}/board/list.do"> 
			<select name="search_option" class="sel">
				<c:choose>
					<c:when test="${map.search_option == 'all'}">
						<option value="all" selected="selected">이름+내용+제목</option>
						<option value="name">이름</option>
						<option value="content">내용</option>
						<option value="title">제목</option>
					</c:when>
					<c:when test="${map.search_option == 'writer'}">
						<option value="all">이름+내용+제목</option>
						<option value="name" selected="selected">이름</option>
						<option value="content">내용</option>
						<option value="title">제목</option>
					</c:when>
					<c:when test="${map.search_option == 'content'}">
						<option value="all" selected="selected">이름+내용+제목</option>
						<option value="name">이름</option>
						<option value="content" selected="selected">내용</option>
						<option value="title">제목</option>
					</c:when>
					<c:when test="${map.search_option == 'title'}">
						<option value="all" selected="selected">이름+내용+제목</option>
						<option value="name">이름</option>
						<option value="content">내용</option>
						<option value="title" selected="selected">제목</option>
					</c:when>
				</c:choose>
			</select> 
			<span style="margin: 0; padding: 0;"><input name="keyword" value="${map.keyword}"></span>
	    <input type="submit" value="조회">
	</form>
	</div>
			
</div>
</div>
 <%@ include file ="../include/footer.jsp" %>
</body>
</html>