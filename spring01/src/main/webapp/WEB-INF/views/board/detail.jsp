<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- views/board/view.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>

<script src="${path}/ckeditor/ckeditor.js"></script>

<script>
$(function(){ //자동으로 실행되는 코드
/* listReply("1");
    
    //댓글 쓰기
    $("#btnReply").click(function(){
        var replytext=$("#replytext").val(); //댓글 내용
        var bno="${dto.bno}"; //게시물 번호
        var param={ "replytext": replytext, "bno": bno};
        //var param="replytext="+replytext+"&bno="+bno;
        $.ajax({
            type: "post",
            url: "${path}/reply/insert.do",
            data: param,
            success: function(){
                alert("댓글이 등록되었습니다.");
                listReply("1");
            }
        });
    });
    
 
  	//댓글 목록 출력 함수
    function listReply(num){
        $.ajax({
            type: "post",
            url: "${path}/reply/list.do?bno=${dto.bno}&curPage="+num,
            success: function(result){
                //result : responseText 응답텍스트(html)
                $("#listReply").html(result);
            }
        });
    } */
	 listReply();
	 
     
	    $("#btnReply").click(function(){
	        
	    var replytext=$("#replytext").val(); //댓글 내용
	    var bno="${dto.bno}"; //게시물 번호
	    var params = {"replytext" : replytext, "bno" : bno};
	    
	    
	    $.ajax({
	        type: "post", //데이터를 보낼 방식
	        url: "reply_insert.do", //데이터를 보낼 url
	        data: params, //보낼 데이터
	        success: function(data){//데이터를 보내는 것이 성공했을 시 출력되는 메시지
	            alert("댓글이 등록되었습니다.");
	            listReply2();
	                }
	            });
	        });
	    
	    
	 
	    
	//댓글 목록을 출력하는 함수
	function listReply(){
	    $.ajax({
	        type: "get",    //get방식으로 자료를 전달
	        /* url: "reply_list.do?bno=${dto.bno}&curPage="+num+"&search_option=${search_option}&keyword=${keyword}", */ 
	        url: "reply_list.do?bno=${dto.bno}&curPage=${curPage}&search_option=${search_option}&keyword=${keyword}", 
	        success: function(result){   
				$("#listReply").html(result);
	        }
	    });
	}
  
	
	
       	function listReply2(){
        $.ajax({
            type: "get",
            contentType: "application/json",
            url: "reply_list_json.do?bno=${dto.bno}",
            success: function(result){
                console.log(result);
                var output="<table>";
                for (var i in result) {
                    var repl = result[i].replytext;
                    repl = repl.replace(/  /gi,"&nbsp;&nbsp;");//공백처리
                    repl = repl.replace(/</gi,"&lt;"); //태그문자 처리
                    repl = repl.replace(/>/gi,"&gt;");
                    repl = repl.replace(/\n/gi,"<br>"); //줄바꿈 처리
                    
                    output += "<tr><td>"+result[i].name;
  
                    output += "<br>"+repl+"</td></tr>";
                    
                }

                    output+="</table>";
                    $("#listReply").html(output);
            }
        });
    }
	//목록 버튼
	$("#btnList").click(function(){
	    location.href="${path}/board/list.do";
	});
		
	//수정 버튼
	$("#btnUpdate").click(function(){
	    var str="";
	    document.form1.action="${path}/board/update.do";
	    document.form1.submit();
	});
	
	//삭제 버튼
	$("#btnDelete").click(function(){
	    if (confirm("삭제하시겠습니까?")) {
	        document.form1.action="${path}/board/delete.do";
	        document.form1.submit();
	    }
	});
    
}); 
</script>
 
<style>
.text-center{
	padding-top: 30px;
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
<div class="text-center">
<h2>view</h2>
</div>
<br>
<br>
<!-- 게시물을 작성하기 위해 컨트롤러의 insert.do로 맵핑 -->
<form id="form1" name="form1" method="post" action="${path}/board/insert.do">
    <div><label for="regdate">작성일자</label> : <fmt:formatDate value="${dto.regdate}"/></div>
    <div><label for="viewcnt">조회수</label> : ${dto.viewcnt} </div>
    <div><label for="name">이름</label> : ${dto.name}</div>
    <div class="form-inline">
	<div class="form-group" >
		<label for="title">title : </label>
		<input name="title" id="title" placeholder="제목을 입력하세요" class="form-control" value="${dto.title}">
	</div>
	</div>
    <div style="width:80%;">
    <label for="title">content</label>
    <textarea id="content" name="content" rows="3" cols="80" placeholder="내용을 입력하세요">${dto.content}</textarea>
 
<!-- 마찬가지로 내용을 입력하도록 도움말을 출력함 -->
<script>
// ckeditor 적용
//id가 content인 태그 (글의 내용을 입력하는 태그)를 ck에디터를 적용한다는 의미
CKEDITOR.replace("content",{
    filebrowserUploadUrl: "${path}/imageUpload.do",
    height: "150px"
});
</script>

    </div>
    <div>
        <div id="uploadedList"></div>
        <div class="fileDrop"></div>
    </div>

    <div class="text-center">
<!-- 수정,삭제에 필요한 글번호를 hidden 태그에 저장 -->    
        <input type="hidden" name="bno" value="${dto.bno}">
        <c:if test="${sessionScope.userid == dto.writer || sessionScope.userid=='admin'}">
            <button type="button" id="btnUpdate" class="btn btn-default">수정</button>
            <button type="button" id="btnDelete" class="btn btn-default">삭제</button>
        </c:if>
        <button type="button" id="btnList" class="btn btn-default">목록</button>
    </div>
</form>
<hr style=" border-color: lightgray;">


<!-- 댓글 작성 -->
<div class="text-center">
     <div class="col-xs-6 col-xs-6 col-xs-offset-3">
     <c:if test="${sessionScope.userid != null}">
         <textarea rows="5" cols="80" id="replytext" placeholder="댓글을 작성하세요" class="form-control"></textarea>
         <br>
         <button type="button" id="btnReply" class="btn btn-default">댓글쓰기</button>
     </c:if>
     </div>
</div>
<!-- 댓글 목록 -->
<div id="listReply"></div>
</div>
</body>
</html>
