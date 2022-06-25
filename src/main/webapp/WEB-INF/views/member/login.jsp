<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<link rel="stylesheet" href="${path}/css/login.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function loginCheck() {
		if (document.form1.userid.value.trim() == "") {
			alert('아이디를 입력하세요');
			form1.userid.focus();
			return;
		}
		
		if (document.form1.userpwd.value.trim() == ""){
			alert('비밀번호를 입력하세요');
			form1.userpwd.focus();
			return;
		}
		
		document.form1.action = "${path}/member/loginCheck.do";
		document.form1.submit();
	}
	
	function findPassword() {
		var url = "${path}/member/findPwd.do";  
		window.open(url,"_blank_1","toolbar=no, menubar=no, scrollbars=no, resizable=no, width=500, height=300");
	}
</script>
</head>
<body>
<%@ include file ="../include/menu.jsp" %>
<div class="container">    
	<div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
		<div class="panel panel-info" >
        	<div class="panel-heading">
                <div class="panel-title" style="text-align: center;">Sign In</div>
            </div>     

           	<div style="padding-top:30px" class="panel-body" >             
		            <form id="loginform" class="form-horizontal" role="form" method="post" name="form1">
		                                    
				        <div style="margin-bottom: 25px; width: 100%;" class="input-group" >
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
							<input id="login-username" type="text" class="form-control" name="userid" 
							placeholder="id" >                                   
				        </div>
			                                
			            <div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
							<input id="login-password" type="password" class="form-control" name="userpwd" 
							placeholder="password">
			            </div>
						
						<div style="margin-top:10px; text-align: center;" class="form-group">
				            <div class="col-dm-12 controls">
				            	<a id="btn-login" href="#" class="btn btn-primary" onclick="loginCheck()">Login</a>
				            </div>
			            </div>
		            	<div style="text-align: center;">
			            	<c:if test="${param.message == 'nologin'}">
								<div class="alert alert-warning" role="alert">로그인 하세요</div>
							</c:if>
							<c:if test="${message == 'error'}">
								<div class="alert alert-danger" role="alert">아이디나 비밀번호가 일치하지 않습니다.</div>
							</c:if>
							<c:if test="${message == 'logout'}">
								<div class="alert alert-success" role="alert">로그아웃 되었습니다.</div>
							</c:if>
							<c:if test="${param.message == 'change'}">
								<div class="alert alert-success" role="alert">비밀번호가 변경되었습니다 다시 로그인해주세요</div>
							</c:if>
							<c:if test="${param.message == 'signup'}">
								<div class="alert alert-success" role="alert" >회원가입이 완료되었습니다 로그인 하세요</div>
							</c:if> 
							<c:if test="${param.message == 'delete'}">
								<div class="alert alert-success" role="alert" >회원탈퇴완료</div>
							</c:if>                   
		            	</div>
			            <div class="form-group">
		                	<div class="col-md-12 control">
		                		<div style="border-top: 1px solid#888; padding-top:15px; font-size:85%" >
		                            Don't have an account!
		         				<a href="${path}/member/write.do">Sign Up</a>
		                        <a href="javascript:findPassword()" style="float:right;" >Forgot password?</a>
		                        </div>
		                   </div>
		               </div>                  
		           </form>     	
	         </div>                     
	     </div>  
	</div>
</div>
<br>
<br>
<br>
<br>
<br>
 <%@ include file ="../include/footer.jsp" %>
</body>
</html>