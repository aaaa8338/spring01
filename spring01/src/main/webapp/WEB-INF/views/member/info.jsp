<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<%@ include file ="../include/header.jsp" %>

<script src="https://kit.fontawesome.com/d438fba670.js" crossorigin="anonymous"></script>
<script type="text/javascript">
$(function() { 
	// 수정버튼
	$("#btnUpdate").click(function() { 
        var userpwd = $.trim($("#userpwd").val());
        var name = $.trim($("#name").val());
        var email = $.trim($("#email").val());;
        var tel = $.trim($("#tel").val());
        var zipcode = $.trim($("#zipcode").val());
        var address1 = $.trim($("#address1").val());
        var address2 = $("#address2").val();
        
        if (userpwd == "") {
            alert("비밀번호를 입력하세요.");
            $("#userpwd").focus();
            return;
        }
        
        if (name == "") {
            alert("이름을 입력하세요.");
            $("#name").focus();
            return;
        }
        
        if (email == "") {
            alert("이메일을 입력하세요.");
            $("#email").focus();
            return;
        }
        
        if (tel == "") {
            alert("전화번호를 입력하세요.");
            $("#tel").focus();
            return;
        }
        
        if (zipcode == "") {
            alert("우편번호를 입력하세요.");
            $("#zipcode").focus();
            return;
        }
        
        if (address1 == "") {
            alert("주소를 입력하세요.");
            $("#address1").focus();
            return;
        }
        
        if (address2 == "") {
            alert("상세주소를 입력하세요.");
            $("#address2").focus();
            return;
        } 
        
        if (confirm("수정하시겠습니까?")) {
        	document.form1.action = "${path}/member/userUpdate.do";
    		document.form1.submit();	
		}
	
	});
	// 삭제버튼
	$("#btnDelete").click(function() {
		if (confirm("삭제하시겠습니까?")) {
			var userpwd=$("#userpwd").val();
			
			if (userpwd == "") {
				alert('비밀번호를 입력하세요');
				$("#userpwd").focus();
	            return;
			}
			document.form1.action = "${path}/member/userDelete.do";
			document.form1.submit();	
		}
	});
	
	//비밀번호수정버튼
	$("#btnChangePwd").click(function() {
		
		document.form1.action = "${path}/member/changePwdForm.do";
		document.form1.submit();	
	});
});


function daumZipCode() {
	 new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		 	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, /이를 참고하여 분기 한다.

	         var fullAddr = ''; // 최종 주소 변수
	         var extraAddr = ''; // 조합형 주소 변수
	 
	         // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	         // 사용자가 도로명 주소를 선택했을 경우         
	         if (data.userSelectedType == 'R') { 
	             fullAddr = data.roadAddress;
	 
	         } else { // 사용자가 지번 주소를 선택했을 경우(J)
	             fullAddr = data.jibunAddress;
	         }
	 
	         // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	         if (data.userSelectedType == 'R') {
	             //법정동명이 있을 경우 추가한다.
	             if (data.bname !== '') {
	                 extraAddr += data.bname;
	             }
	             // 건물명이 있을 경우 추가한다.
	             if (data.buildingName !== '') {
	                 extraAddr += (extraAddr != '' ? ', ' + data.buildingName : data.buildingName);
	             }
	             // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	             fullAddr += (extraAddr != '' ? ' (' + extraAddr + ')' : '');
	         }
	 
	         // 우편번호와 주소 정보를 해당 필드에 넣는다.
	         document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
	         document.getElementById('address1').value = fullAddr;
	 
	         // 커서를 상세주소 필드로 이동한다.
	         document.getElementById('address2').focus();
	     }
	 }).open();
}
</script>
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
	<div class="container">
	 <div id="signupbox" style="margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
     <div class="panel panel-primary">
         <div class="panel-heading">
             <div class="panel-title" style="text-align: center;">Info</div>
         </div>  
         <div style="padding-top:30px" class="panel-body" >
         	<form id="form1" name="form1" method="post" Class="form-horizontal">            
            	<div style="" class="form-group">
                	<div class="col-md-12">
                    	<div class="input-group" >
	                        <span class="input-group-addon"><i class="glyphicon glyphicon-info-sign"></i></span>
	                        <input type="text" id="name" name="name" value="${dto.name}" class="form-control">
						</div>
                    </div>
                </div>
                      
                <div class="form-group">
                	<div class="col-md-12">
		                <div class="input-group">
			                <span class="input-group-addon"><i class="fas fa-user"></i></span>
			                <input type="text" id="userid" name="userid" value="${dto.userid}" class="form-control" readonly="readonly">    
						</div>
                    </div>
                </div>
                  
                  
                <div class="form-group">
                	<div class="col-md-12">
                    	<div class="input-group">
                     		<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                         	<input type="password" id="userpwd" name="userpwd" Class="form-control"/>
                     	</div>
                 	</div>
                </div>
                             
                <div class="form-group">
                    <div class="col-md-12">
                    	<div class="input-group">
                			<span class="input-group-addon"><i class="fas fa-envelope"></i></span>
                        	<input type="text" id="email" name="email" value="${dto.email}" Class="form-control"/>
                   		</div>
               		</div>
              	</div>
                 
                 
                <div class="form-group">
                    <div class="col-md-12">
                    	<div class="input-group">
                      		<span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
                        	<input type="text" id="tel" name="tel" value="${dto.tel}" Class="form-control"/>
                      	</div>
                  	</div>
                </div>                        


                 <div class="form-group">
                 	<div class="col-md-12">
                         <div class="input-group">
                         	<span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                         	<input type="text" id="zipcode" name="zipcode" readonly value="${dto.zipcode}" Class="form-control">
							<span class="input-group-btn">
						  	<input type="button" value="우편번호찾기" class="btn btn-success btn-sm" onclick="daumZipCode()">
							</span>
						 </div>
                	 </div>
                 </div>
                   
                   
                 <div class="form-group">
                     <div class="col-md-12">
                         <div class="input-group">
                         <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                         <input type="text" id="address1" name="address1" value="${dto.address1}" Class="form-control">
                         </div>
                     </div>
                 </div>
                   
                   
                 <div class="form-group">
                     <div class="col-md-12">
                         <div class="input-group">
                         <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                         <input type="text" id="address2" name="address2" value="${dto.address2}" Class="form-control">
                         </div>
                     </div>
                 </div>
                       

				 <div class="form-group">
				 	<div class="col-md-12">
						<div class="input-group">
							<span class="input-group-addon"><i class="fas fa-venus-mars"></i></span>
							<input type="text" id="gender" readonly="readonly" name="gender" value="${dto.gender}" Class="form-control">
						</div>
					</div>
				</div>

				<c:if test="${message == 'notMatching'}">
					<div style="text-align: center;" class="alert alert-danger" role="alert" >비밀번호가 일치하지 않습니다.</div>
				</c:if>    
                  
                <div class="form-group" style="text-align: center;">
			     	<div class="col-md-12 control">
				      	<div style="border-top: 1px solid#888; padding-top:15px; ">
		          			<input type="button" class="btn btn-default" value="수정" id="btnUpdate" >
							<input type="button" class="btn btn-default"  value="비밀번호 변경" id="btnChangePwd">
							<input type="button" class="btn btn-default" value="회원탈퇴" id="btnDelete" >
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
<%@ include file ="../include/footer.jsp" %>

</body>
</html>