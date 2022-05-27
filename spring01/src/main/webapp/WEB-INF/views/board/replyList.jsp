<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">





	
</script>
</head>
<body>

<% pageContext.setAttribute("newLineChar", "\n"); %>

<form name="form2" method="post" id="form2" >
	<c:forEach var="row" items="${map.list}">
		<div class="col-lg-9">
			${row.name}
			( <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd. HH:mm" /> )
		</div>
		<br>
		<input type="hidden" id="curPage" name="curPage" value="${curPage}">
		<input type="hidden" id="search_option" name="search_option" value="${search_option}">
		<input type="hidden" id="keyword" name="keyword" value="${keyword}"> 
		<input type="hidden" id="rno" name="rno" value="${row.rno}">
		<input type="hidden" id="userid" name="userid" value ="${row.userid}">
		<input type="hidden" id="bno" name="bno" value="${row.bno}">

		<div>
			<textarea id="replytext" name="replytext" rows="5" cols="60" class="form-control">${row.replytext}</textarea>
		</div>
   
		<div>
			<c:if test = "${sessionScope.userid == row.userid}">
				<br>
				<div class="text-right">
					<input type="button" value="수정" onclick="updated()" class="btn btn-default">
					<input type="button" value="삭제" onclick="deleted()" class="btn btn-default">
					<!-- <a class="btn btn-default" id="btnDelete" href="javascript:deleted()">삭제</a> -->
					<!-- <input type="button" class="btn btn-default" value="삭제" id="bbtnDelete" > -->
				</div>
			</c:if>
			<script type="text/javascript">
				function deleted() {
					if (confirm("삭제하시겠습니까?")) {
						var rno = $("#rno").val();
				        var bno = $("#bno").val();
				        var replytext = $("#replytext").val();
				        var curPage = $("#curPage").val();
				        var search_option = $("#search_option").val();
				        var keyword = $("#keyword").val();
				        var param = {"rno": rno, "bno": bno, "curPage":curPage, "search_option": search_option, "keyword": keyword };
				       /*  document.form2.action="${path}/board/reply_delete.do?rno="+rno+"&bno="+bno;
				        
				        document.form2.submit(); */
				        $.ajax({
						    type: "post",
						    url: "reply_delete.do?rno=${row.rno}",
						    data: param,
						    success: function () {
						    	alert("댓글이 삭제되었습니다.");
					            location.href = "detail.do?bno=${row.bno}&curPage=${curPage}&search_option=${search_option}&keyword=${keyword}";
					       }
						});	 
					}   
				}
				
				function updated() {
					if (confirm("수정하시겠습니까?")) {
						var bno = document.getElementById('bno').value; 
						var userid = document.getElementById('userid').value; 
						var rno = document.getElementById('rno').value; 
						var curPage = document.getElementById('curPage').value; 
						var search_option = document.getElementById('search_option').value; 
						var keyword = document.getElementById('keyword').value; 
						var replytext = document.getElementById('replytext').value;
						/* var replytext = $("textarea#replytext").text(); */
						var param = {"rno": rno, "bno": bno, "curPage":curPage, "search_option": search_option, "keyword": keyword, "replytext": replytext};
						/* "reply_update.do?rno"+rno+"&bno="+bno+"&replytext="+replytext+"&userid="+userid+"&curPage="+curPage+"&search_option="+search_option+"&keyword="+keyword */
						/* document.form2.action="${path}/board/reply_update.do?rno="+rno+"&bno="+bno+"&userid="+userid+"&replytext="+replytext;
				        
				        document.form2.submit(); */
				    	
				    	$.ajax({
					        type: "post", 
					        url: "reply_update.do?rno"+rno+"&bno="+bno+"&replytext="+replytext+"&userid="+userid+"&curPage="+curPage+"&search_option="+search_option+"&keyword="+keyword, 
					        data: $("#form2").serialize(), 
					        success: function(){
					            alert("댓글이 수정되었습니다.");
					            location.href = "detail.do?bno=${row.bno}&curPage=${curPage}&search_option=${search_option}&keyword=${keyword}";
					        }
					    });
					}
				}
			
			</script>
		</div>

		<hr style=" border-color: lightgray;">
	</c:forEach>
</form>


</body>
</html>
