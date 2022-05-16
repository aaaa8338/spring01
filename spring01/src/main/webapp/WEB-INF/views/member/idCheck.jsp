<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
function idok(userid){
	var cnt = ${result}
	if(cnt == 0){
		 // opener => 부모창		  document => 새로 열린창
		opener.form1.userid.value = document.form1.userid.value;
		opener.form1.reid.value = document.form1.userid.value;
		self.close(); // 새로 열린창 종료
	}else{
		opener.form1.userid.value = "";
		opener.form1.reid.value = "";
		self.close(); // 새로 열린창 종료
	}

}
</script>
</head>
<body>
 <form method="get" action="idCheck.do" name="form1">
		<div class="col-lg-1" style="margin-top: 30px;">
	    <div class="input-group">
	      <input type="text" id="userid" name="userid" value="${userid}" class="form-control">
	      <span class="input-group-btn">
	        <input type="submit" class="btn btn-default" value="check">
	      </span>
	    </div>
	  </div>
  	
	
	<c:if test="${result == 1}"> <!-- 중복된 아이디가 존재 -->
		<div style="text-align: center;" class="text-danger" role="alert" >${userid}는 이미 사용중인 아이디 입니다.</div>
	</c:if>	
	
	<c:if test="${result == 0}"> <!-- 중복된 아이디가 존재하지 x -->
		<div style="text-align: center;" class="text-success" role="alert" >사용 가능한 아이디 입니다.</div>
	</c:if>	
		<div style="text-align: center; margin-top: 15px;">
			<input style="text-align: center;" type="button" value="확인" class="btn btn-default" onclick="idok('${userid}')">
		</div>
</form> 
</body>
</html>