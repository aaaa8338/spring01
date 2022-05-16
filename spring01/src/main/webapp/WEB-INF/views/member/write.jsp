<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<link rel="stylesheet" href="${path}/css/sign.css"/> 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> 
<script src="https://kit.fontawesome.com/d438fba670.js" crossorigin="anonymous"></script>
<script>
function daumZipCode() {
 new daum.Postcode({
     oncomplete: function(data) {
// 팝업에서 검색결과 항목을 클릭했을때 
//실행할 코드를 작성하는 부분.
 
         // 각 주소의 노출 규칙에 따라 주소를 조합한다.
// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 
//이를 참고하여 분기 한다.
         var fullAddr = ''; // 최종 주소 변수
         var extraAddr = ''; // 조합형 주소 변수
 
         // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 
         //가져온다.
// 사용자가 도로명 주소를 선택했을 경우         
         if (data.userSelectedType == 'R') { 
             fullAddr = data.roadAddress;
 
         } else { // 사용자가 지번 주소를 선택했을 경우(J)
             fullAddr = data.jibunAddress;
         }
 
         // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
         if(data.userSelectedType == 'R'){
             //법정동명이 있을 경우 추가한다.
             if(data.bname !== ''){
                 extraAddr += data.bname;
             }
             // 건물명이 있을 경우 추가한다.
             if(data.buildingName !== ''){
                 extraAddr += (extraAddr != '' ? ', ' + data.buildingName : data.buildingName);
             }
             // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
             fullAddr += (extraAddr != '' ? 
                     ' ('+ extraAddr +')' : '');
         }
 
         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         document.getElementById('zipcode').value 
             = data.zonecode; //5자리 새우편번호 사용
         document.getElementById('address1').value 
             = fullAddr;
 
         // 커서를 상세주소 필드로 이동한다.
         document.getElementById('address2').focus();
     }
 }).open();
}

function idCheck(){
	if(document.form1.userid.value == ""){
		alert('아이디를 입력해 주세요.');
		form1.userid.focus();
		return; 
	}
	var url = "idCheck.do?userid="+document.form1.userid.value;  
	window.open(url,"_blank_1","toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=450, height=200");
}

function insertCheck(){
	
	// 아이디 중복 체크 여부 (reid = ??) 
	if(document.form1.reid.value.length == 0){
		alert("중복체크를 확인 하세요");
		form1.userid.focus();
		return;
	}
	
	
    document.form1.action = "${path}/member/insert.do";
	document.form1.submit(); 
}
function hyphen(phone){

	var result = "";
	var number = phone.value.trim();   

	/*
	if(number.length < 3) { 
		return number;
		
	} else if(number.length < 8) { 
		result += number.substring(0,3); 
		result += "-"; 
		result += number.substring(4,7);
		
	} else if(number.length > 7 && number.length < 13) {
		result += number.substring(0,3); 
		result += "-"; 
		result += number.substring(4,8); 
		result += "-"; 
		result += number.substring(9,12); 
		
	} else { 
		result += number.substring(0,3); 
		result += "-"; 
		result += number.substring(4,8); 
		result += "-"; 
		result += number.substring(9,13); 
		
	}
	*/

	//result = number.replace(/([0-9]{3})-?([0-9]{4})-?([0-9]{4})$/,"$1-$2-$3");
	result = number.replace(/(\d{3})(\d{4})(\d{4})/,"$1-$2-$3");
	phone.value = result;
	
}


</script>
<style type="text/css">
	.input-group{
		margin-bottom: 25px; 
		width: 100%;	
	}
</style>
</head>
<body>
<%@ include file ="../include/menu.jsp" %>
	<div class="container">
	 <div id="signupbox" style="margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="panel-title" style="text-align: center;">Sign Up</div>
                        </div>  
                        <div style="padding-top:30px" class="panel-body" >
                             <form:form id="form1" name="form1"  commandName="memberDto" method="post" cssClass="form-horizontal" role="form">            
                                <div style="" class="form-group">
                                    <div class="col-md-12">
                                        <div class="input-group" >
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-info-sign"></i></span>
                                        <form:input path="name" placeholder="name" cssClass="form-control"/>
 									</div>
                                    </div>
                                </div>
                                <div><form:errors path="name" element="div" cssClass="alert alert-danger"/></div>
                                
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                        <span class="input-group-addon"><i class="fas fa-user"></i></span>
                                        <form:input path="userid" placeholder="id" cssClass="form-control"  />
 										<input type="hidden" id="reid" name="reid" >
 										<span class="input-group-btn">
									    	<input type="button" value="중복체크" class="btn btn-success btn-sm" onclick="idCheck(${userid})">
									    </span>
									    </div>
                                    </div>
                                </div>
                               <div><form:errors path="userid" element="div" cssClass="alert alert-danger"/></div>
                               
                                <div class="form-group">
                                    <div class="col-md-12">
                                    	<div class="input-group">
	                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
	                                        <form:password path="userpwd" placeholder="password" cssClass="form-control"/>
	                                    </div>
	                                </div>
                                </div>
                                <div><form:errors path="userpwd" element="div" cssClass="alert alert-danger"/></div>
                                
                               	<div class="form-group">
                                    <div class="col-md-12">
                                    	<div class="input-group">
	                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
	                                        <form:password path="confirmPassword" placeholder="confirmPassword" cssClass="form-control"/>
	                                    </div>
	                                </div>
                                </div>
                                <div><form:errors path="confirmPassword" element="div" cssClass="alert alert-danger"/></div>
                                
                                <div class="form-group">
                                    <div class="col-md-12">
                                    	<div class="input-group">
	                                    <span class="input-group-addon"><i class="fas fa-envelope"></i></span>
	                                        <form:input path="email" placeholder="email" cssClass="form-control"/>
	                                    </div>
	                                </div>
                                </div>
                                <div><form:errors path="email" element="div" cssClass="alert alert-danger"/></div>
                                
                                <div class="form-group">
                                    <div class="col-md-12">
                                    	<div class="input-group">
	                                    <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
	                                        <form:input path="tel" placeholder="phone" cssClass="form-control" maxlength="13" 
	                                        onkeyup="hyphen(this)" />
	                                    </div>
	                                </div>
                                </div>                        
								<div><form:errors path="tel" element="div" cssClass="alert alert-danger"/></div>
								
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                        <form:input path="zipcode" readonly="readonly" cssClass="form-control" />
 										<span class="input-group-btn">
									    	<input type="button" value="우편번호찾기" class="btn btn-success btn-sm" onclick="daumZipCode()">
									    </span>
									    </div>
                                    </div>
                                </div>
                                <div><form:errors path="zipcode" element="div" cssClass="alert alert-danger"/></div>
                                
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                        <form:input path="address1" placeholder="address" cssClass="form-control"  />
									    </div>
                                    </div>
                                </div>
                                <div><form:errors path="address1" element="div" cssClass="alert alert-danger"/></div>
                                
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                        <form:input path="address2" placeholder="detail address" cssClass="form-control"  />
									    </div>
                                    </div>
                                </div>
                                <div><form:errors path="address2" element="div" cssClass="alert alert-danger"/></div>
								
								<div class="form-group">
                                    <div class="col-md-12">
                                        <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                       	 <form:input path="power" placeholder="admin code" cssClass="form-control"  />
                                       	<!-- <input type="text" name="power" id="power" placeholder="admin code" class="form-control"> -->
									    </div>
									    <span style="color: red;">* 관리자 코드를 입력하지 않거나 일치하지 않는 경우 회원으로 가입</span>
                                    </div>
                                </div>
								<%-- <div><form:errors path="power" element="div" cssClass="alert alert-danger"/></div> --%>
								
								<div class="form-group">
									<div class="col-md-12">
									<div class="input-group">
										<form:radiobutton path="gender" cssStyle="margin-left:2%;" value="male" label="male"/> &nbsp; 
										<form:radiobutton path="gender" value="female" label="female"/>
									</div>
									</div>
								</div>
								<div><form:errors path="gender" element="div" cssClass="alert alert-danger"/></div>
 								
 	
                                <div style="margin-top:10px; text-align: center;" class="form-group">
						            <div class="col-dm-12 controls">
						            	<button id="btn-signup" type="button" class="btn btn-primary" onclick="insertCheck()">
						            	<i class="icon-hand-right"></i>Sign Up
						            	</button>
						            </div>
					            </div>
                                
                                <div class="form-group">
				                	<div class="col-md-12 control">
				                		<div style="border-top: 1px solid#888; padding-top:15px; font-size:85%" >
				                            you have an account?
				         				<a href="${path}/member/login.do">Sign In</a>
				                        </div>
				                   </div>
				               </div> 
                            </form:form>
                         </div>
                    </div>
         </div>
         </div>
  
<%@ include file ="../include/footer.jsp" %>
</body>
</html>