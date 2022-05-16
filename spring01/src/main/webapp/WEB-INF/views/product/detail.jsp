<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<link rel="stylesheet" href="${path}/css/order.css"/>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

var price;
var amount;
var total;
var totalprice;

function init () {
	price = document.getElementById("price").value;
	amount = document.getElementById("amount").value;
	total = document.getElementById("total").value;
	totalprice = document.getElementById("totalprice").value;
	
	change();
}

function add () {
	amount = document.getElementById("amount");
	total = document.getElementById("total");
	totalprice = document.getElementById("totalprice");
	amount.value ++;
	if(amount.value > 5){
		alert('5개까지 구입 가능합니다');
		amount.value = 5;
	}
	$("#total").html(parseInt(amount.value) * price);
	total.value= parseInt(amount.value) * price;
	totalprice.value = total.value
	console.log(totalprice);
	
}

function del () {
	amount = document.getElementById("amount");
	total = document.getElementById("total");
	totalprice = document.getElementById("totalprice");
	if(amount.value < 2){
		alert('1개이상 구입 가능합니다');
		amount.value = 1;
	}else{
		amount.value --;
	}
	/* sum.value = ; */
	$("#total").html(parseInt(amount.value) * price);
	total.value= parseInt(amount.value) * price;
	totalprice.value = total.value
	console.log(totalprice);

}

function change() {
	amount = document.getElementById("amount");
	total = document.getElementById("total");
	totalprice = document.getElementById("totalprice");
		if (amount.value < 0) {
			amount.value = 0;
		}
	$("#total").html(parseInt(amount.value) * price);
	total.value= parseInt(amount.value) * price;
	totalprice.value = total.value
	console.log(totalprice);
}  

function cart() {
	document.form1.action="${path}/cart/insert.do";
	document.form1.submit();
}

$(function () {
	$(".buyBtn").click(function() {
		   
	   /*  var fee = document.getElementById("fee");
	   	var totalprice = document.getElementById("totalprice");
	   	
	   	if(totalprice > 100000){
	   		fee.value = 0;
	   	}else{
	   		fee.value = 2500;
	   	}

	   	totalprice.value = parseInt(fee.value) + parseInt(totalprice.value);
	   	$("#totalprice").val(totalprice.value); */
		$(".order").slideDown();
		$(".buyBtn").slideUp();
	});
	
	
	$(".cancelBtn").click(function() {
		$(".order").slideUp();
		$(".buyBtn").slideDown();
	});
	
	$(".orderBtn").click(function() {
        var name=$("#name").val();
        var tel=$("#tel").val();
        var zipcode=$("#zipcode").val();
        var address1=$("#address1").val();
        var address2=$("#address2").val(); 

        if(name==""){
            alert("이름을 입력하세요.");
            $("#name").focus();
            return;
        }
      
        if(tel==""){
            alert("전화번호를 입력하세요.");
            $("#tel").focus();
            return;
        }
        if(zipcode==""){
            alert("우편번호를 입력하세요.");
            $("#zipcode").focus();
            return;
        }
        if(address1==""){
            alert("주소를 입력하세요.");
            $("#address1").focus();
            return;
        }
        if(address2==""){
            alert("상세주소를 입력하세요.");
            $("#address2").focus();
            return;
        }     
	
		$("#form3").submit();
		
		alert('주문이 완료되었습니다');
		
	});
});

function daumZipCode() {
	new daum.Postcode(
			{
				oncomplete : function(data) {

					var fullAddr = '';
					var extraAddr = '';

					if (data.userSelectedType == 'R') {
						fullAddr = data.roadAddress;

					} else {
						fullAddr = data.jibunAddress;
					}

					if (data.userSelectedType == 'R') {

						if (data.bname !== '') {
							extraAddr += data.bname;
						}
						if (data.buildingName !== '') {
							extraAddr += (extraAddr != '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						fullAddr += (extraAddr != '' ? ' (' + extraAddr
								+ ')' : '');
					}

					document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
					document.getElementById('address1').value = fullAddr;

					document.getElementById('address2').focus();
				}
			}).open();
}
</script>


<style type="text/css">

img{
	width: 550px;
	height: 360px;
}
.row1{
	display: flex;
	flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
}
.col-md-6{
	padding: 0 15px;
}
.top{
	text-align: center;
	padding: 2.5% 0;
}
.qty{
	display: flex;
}
.addbtn{
    border-radius: 4px;
    width: 180px;
    height: 40px;
    text-align: center;
    font-size: medium;
    background: black;
    color: white;
    padding: 7px 45px;
    display: block;
    margin-top: 20px;
    border: solid 2px #212529;
}
.buyBtn{
	border-radius: 4px;
    width: 180px;
    height: 40px;
    text-align: center;
    font-size: medium;
    background: black;
    color: white;
    padding: 7px 45px;
    display: block;
    margin-top: 20px;
    border: solid 2px #212529;
    margin-left: 15px;
}
.buyBtn:hover{
	color: black;
	text-decoration: none;
	background-color: white;
}
.addbtn:hover{
	color: black;
	text-decoration: none;
	background-color: white;
}
.btn-dark:hover{
	color: white;
	text-decoration: none;
}
</style>
</head>
<body onload="init();">
<%@ include file ="../include/menu.jsp" %>
 <div class="container">
 	<div class="top">
 		<h2>Product Details</h2>
 	</div>	
 	<div class="row1">
	 	<div class="col-md-6">
	 		<img src="${path}/images/${dto.pictureurl}">
	 	</div>
	 	<div class="col-md-6">
	 		<p style="font-weight: bold; font-size: 22px;">${dto.productname}</p>
	 		<form name="form1" method="post">
				<input type="hidden" name="productid" value="${dto.productid}">
				<input type="hidden" id="price" name="price" value="${dto.price}">
				<p id="total" class="" style="font-size: 22px;" ></p>
				<p>${dto.kind}</p>
				<!-- <input type="text" id="sum" name="sum" size="6" readonly>원 -->
				<p class="text-secondary">${dto.description}</p>
				<div class="qty">
					<div>
					<input type="button" class="btn btn-dark" value=" - " onclick="del();">
					</div>
					<div>
					<input type="text" class="form-control" name="amount" id="amount" value="1" size="1" 
					style="text-align: center;" onchange="change('${totalprice}')">
					</div>
					<div>
					<input type="button" class="btn btn-dark" value=" + " onclick="add();">
					</div>
				</div>
				<br>
				<div style="display: flex;">
				<a class="addbtn" href="javascript:cart()">Add to Cart</a>
				<!-- a class="buyBtn" id="" style="margin-left: 20px;" href="">purchase</a> -->
				<span class="orderbuy"> 
						<input type="hidden" id="fee" name="fee" value="0"> 
						<input type="button" value="purchase" class="buyBtn">
				</span>
				</div>
			</form>
	 	</div>
 	</div>
</div>
<div class="container">
<div class="order">
	<form method="post" name="form3" id="form3" action="${path}/order/inserted.do">
		<input type="hidden" id="totalprice" name="totalprice" value="">
		<input type="hidden" id="productid" name="productid" value="${dto.productid}">
		<!-- <input type="hidden" name="amount" id="amount" value="1" onchange="change();"> -->
		<div class="inputArea">
			<label for="name">수령인</label> 
			<input type="text" name="name" id="name" required="required" />
		</div>
		<div class="inputArea">
			<label for="tel">수령인 연락처</label> 
			<input type="text" name="tel" id="tel" required="required" />
		</div>
		<div class="inputArea">
			<label for="zipcode">우편번호</label> 
			<input type="text" name="zipcode" id="zipcode" readonly="readonly" />
			<input type="button" onclick="daumZipCode()" value="우편번호 찾기">
		</div>
		<div class="inputArea">
			<label for="address1">주소</label> 
			<input type="text" name="address1" id="address1" size="60" required="required" />
		</div>
		<div class="inputArea">
			<label for="address2">상세주소</label> 
			<input type="text" name="address2" id="address2" required="required" />
		</div>
		<div class="inputArea">
			<input type="button" value="주문" class="orderBtn" /> 
			<input type="button" value="취소" class="cancelBtn">
		</div>
	</form>
</div>
</div>
<br>
<br>
<br> 
<%@ include file ="../include/footer.jsp" %>
</body>
</html>