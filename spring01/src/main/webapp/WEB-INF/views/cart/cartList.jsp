<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<link rel="stylesheet" href="${path}/css/order.css"/> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	$(function() {
		$("#btnDelete").click(function() {
			if(confirm("장바구니를 비우시겠습니까?")){
				location.href="${path}/cart/deleteAll.do";
			}
		});
		
		
		$(".buyBtn").click(function() {
			var str = "";
		    var num = 0;
		    var count = $(".chBox").length;
		    for(var i=0; i<count; i++ ){
		        if($(".chBox")[i].checked == true){
		         	num += parseInt($(".chBox")[i].value);
		        }
		    }
		    $("#sum").val(num);
		    /* $("#amount").val(price); */
		   
		    var fee = document.getElementById("fee");
		   	var totalprice = document.getElementById("totalprice");
		   	
		   	if(num > 100000){
		   		fee.value = 0;
		   	}else{
		   		fee.value = 2500;
		   	}
		   	if(num==0){
		   		fee.value = 0;
		   	}
		   	
		   	totalprice.value = parseInt(fee.value) + parseInt(num);
		   	$("#totalprice").val(totalprice.value);
			$(".order").slideDown();
			$(".buyBtn").slideUp();
			
			
		});
		
		$(".cancelBtn").click(function() {
			$(".order").slideUp();
			$(".buyBtn").slideDown();
		});
		
		$("#allCheck").click(function() {
			var chk = $("#allCheck").prop("checked");
			if (chk) {
				$(".chBox").prop("checked", true);
				$("#btnUpdate").attr("disabled",false);
				$("#btnDelete").attr("disabled",false);
				$(".buyBtn").attr("disabled",false);
				itemSum();
			} else {
				$(".chBox").prop("checked", false);
				$("#btnUpdate").attr("disabled",true);
				$("#btnDelete").attr("disabled",true);
				$(".buyBtn").attr("disabled",true);
				itemSum();
			}
		});

		$(".chBox").click(function() {
			var count = $(".chBox").length;
			var idx = 0;
		    
			for(var i=0; i<count; i++ ){
		    	
		    	if($(".chBox")[i].checked == true){
		    		$("#allCheck").prop("checked", false);
		    		$("#btnUpdate").attr("disabled",false);
					$("#btnDelete").attr("disabled",false);
					$(".buyBtn").attr("disabled",false);	
		    	}
		    	else if($(".chBox")[i].checked == false){
		    		continue;
		    	}
		    	
		    	idx++;
		    }
			
			if(idx == 0){
				$("#btnUpdate").attr("disabled",true);
				$("#btnDelete").attr("disabled",true);
				$(".buyBtn").attr("disabled",true);
				$("#allCheck").prop("checked", false);
			}
			else if (idx == count){
				$("#allCheck").prop("checked", true);
			}
			
		});
		
		// 체크박스 초기화
		var tt = "";
		if (tt == 'false') {
			$("#allCheck").prop("checked", false);
			
		} else {
			$("#allCheck").prop("checked", true);
			$(".chBox").prop("checked", true);
			itemSum();
		}
		
		$(".selectDelete_btn").click(function() {
			if (confirm("삭제하시겠습니까?")) {
				var checkArr = new Array();

				$("input[class='chBox']:checked").each(function() {
					checkArr.push($(this).attr("data-cartid"));
				});

				$.ajax({
					url : "${path}/cart/delete.do",
					type : "post",
					data : {
						chbox : checkArr
					},
					success : function(result) {
						if (result == 1) {
							location.href = "${path}/cart/list.do";
						} else {
							alert("삭제 실패");
						}
					}
				});
			}
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
			var checkedArr = new Array();

			$("input[class='chBox']:checked").each(function() {
				checkedArr.push($(this).attr("data-cartid"));
			});

			$("#chk").val(checkedArr);

			$("#form3").submit();
			
			alert('주문이 완료되었습니다');
			
		});

	});

	function itemSum(){
	    var str = "";
	    var price = 0;
	    var count = $(".chBox").length;
	    for(var i=0; i<count; i++ ){
	        if($(".chBox")[i].checked == true){
	         	price += parseInt($(".chBox")[i].value);
	        }
	    }
	    $("#sum").html(price);
	    /* $("#amount").val(price); */
	   
	    var fee = document.getElementById("fee");
	   	var total = document.getElementById("total");
	   	
	   	if(price > 100000){
	   		fee.value = 0;
	   	}else{
	   		fee.value = 2500;
	   	}
	   	if(price==0){
	   		fee.value = 0;
	   	}
	   	$("#fee").html(fee.value);
	   	total.value = parseInt(fee.value) + parseInt(price);
	   	$("#total").html(total.value);
	 }
	
	

	function updated() {
		document.form1.action = "${path}/cart/update.do";
		document.form1.submit();
		alert("수정되었습니다");
	}

	
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

.title {
	font-size: 19px;
	margin-bottom: 20px;
}
.table-cart table {
    width: 100%;
}
.table-cart thead {
    border-bottom: 1px solid #e5e5e5;
    margin-bottom: 5px;
}
.table-cart thead tr th {
    padding: 8px 0 8px;
    color: #484848;
    font-size: 15px;
    font-weight: 400;
}
.table-cart tr td {
    padding: 40px 0;
    vertical-align: middle;
}

.table-cart tr td .img-product {
    width: 72px;
    float: left;
    margin-left: 8px;
    margin-right: 31px;
    line-height: 63px;
}
.table-cart tr td .img-product img {
	width: 100%;
}
.table-cart tr td .name-product {
    font-size: 15px;
    line-height: 24px;
    width: 100%;
}
.table-cart tr td .price {
    line-height: 50px;
    color: gray;
    font-size: 16px;
    font-family: 'Nunito';
}
.table-cart tr td .quanlity {
    position: relative;
}
.table-cart tr td:nth-child(1) {
    width: 20%;
}
/* .product-count .qtyminus,
.product-count .qtyplus {
	width: 34px;
    height: 34px;
    background: transparent;
    text-align: center;
    font-size: 19px;
    line-height: 34px;
    color: #000;
    cursor: pointer;
    font-weight: 600;
}
.product-count .qtyminus {
    line-height: 32px;
}
.product-count .qtyminus {
	border-radius: 3px 0 0 3px; 
}
.product-count .qtyplus {
	border-radius: 0 3px 3px 0; 
}
.product-count .qty {
	width: 60px;
	text-align: center;
	border: none;
}
.count-inlineflex {
	display: inline-flex;
	border: solid 2px #ccc;
	border-radius: 20px;  
} */
.total {
	font-size: 24px;
	font-weight: 600;
	color: orange;
}
.display-flex {
	display: flex;
}
.align-center {
	align-items: center;
}

input:focus {
	outline: none;
	box-shadow: none;
}
/* .round-black-btn {
	border-radius: 25px;
    background: #212529;
    color: #fff;
    padding: 8px 35px;
    display: inline-block;
    border: solid 2px #212529; 
    transition: all 0.5s ease-in-out 0s;
    cursor: pointer;
}
.round-black-btn:hover,
.round-black-btn:focus {
	background: transparent;
	color: #212529;
	text-decoration: none;
} */
.cart-totals {
	border-radius: 3px;
	background: rgb(245, 245, 245);
	padding: 25px;
	margin-top: 40px;
}
.cart-totals h3 {
	font-size: 19px;
    color: #3c3c3c;
    letter-spacing: 1px;
    font-weight: 500;
}
.cart-totals table {
	width: 100%;
}

.cart-totals table tr td {
    padding: 3px 0;
    vertical-align: middle;
}
.cart-totals table tr td:last-child {
	text-align: right;
}
.cart-totals table tr td.subtotal {
	font-size: 20px;
    color: #6f6f6f;
}
.cart-totals table tr td.fee {
	font-size: 14px;
    color: #6f6f6f;
}
.cart-totals table tr.total-row td {
	padding-top: 25px;
}
.cart-totals table tr td.price-total {   
	font-size: 24px;
    font-weight: 600;
    color: #8660e9;
}
.btn-cart-totals {
	text-align: center;
	margin-top: 60px;
	margin-bottom: 20px;
}
.btn-cart-totals .round-black-btn {
	margin: 10px 0; 
}
#total{
	color: orange;
}
.cart-totals table{
	font-size: large;
}
</style>
</head>
<body onload="init()">
<%@ include file ="../include/menu.jsp" %>
	<c:choose>
		<c:when test="${map.count == 0}">
			<h1>장바구니가 비었습니다.</h1>
		</c:when>
	<c:otherwise>
<div class="cart-wrap" style="padding:40px 0px;">
	<div class="container">
		<div class="row">
		<form id="form1" name="form1" method="post" action="${path}/cart/update.do">
		<div class="col-lg-8">
			<div class="title"><h2>Cart</h2></div>
			<div class="table-cart">
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">&nbsp; AllCheck</label></th>
							<th>Product</th>
							<th>price</th> 
							<th>Quantity</th> 
							<th>Total</th> 
							<th></th> 
						</tr>
					</thead>
					<tbody>
						
						<c:forEach var="row" items="${map.list}" >
						<tr>
	                    	<td>
		                    	<div class="display-flex align-center">
			                    	<div class="checkBox">
									   <input type="checkbox" name="chBox" onclick="itemSum()" class="chBox" 
									   data-cartid="${row.cartid}" value="${row.price * row.amount}"/>
									</div>
									<div class="img-product">
			                            <img class="pic" src="${path}/images/${row.pictureurl}">
			                        </div>
		                    	</div>
							</td>
							<td>
								<div class="name-product">
	                            	${row.productname}     
	                            </div>
							</td>
							<td>
								<div class="price">
	                                <fmt:formatNumber value="${row.price}"  pattern="#,###,###"/>
	                            </div>	
							</td>
	                        <td class="product-count">
	                       		<input type="number" name="amount" min="1" max="5"
	                       		onchange="change(${row.price},this)" style= "width: 40px;" value='<fmt:formatNumber value="${row.amount}" pattern="#,###,###"/>'>
	                       	<script type="text/javascript">
		                       	function change(price,amount) {
		                    		var money = document.getElementById("money").value;
		                    		money = parseInt(price*amount.value);
		                    		$("#money").html(comma(money));
		                       		
		                    	}
		                       	
		                       	function comma(money) {
		                       		money = String(money);
		                       		return money.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		                       		 
		                       	}

	                       	</script>
	                        </td>
                            <td>
                            	<div class="total">
                                	 <fmt:formatNumber value="${row.money}"  pattern="#,###,###"/>
                                </div>
                            </td>
                            <td>
                            	<div class="del">
	                            	<input type="hidden" name="cartid" id="cartid" value="${row.cartid}">
	                                <a id="delcart" href="javascript:deleted(${row.cartid})">
	                                    <i class="glyphicon glyphicon-trash" style="width: 20px; height: 20px;"></i>
	                                </a>
	                                <script type="text/javascript">
	                                
	                                function deleted(flag) {
	                            		if (confirm("삭제하시겠습니까?")) {
	                            			location.href = "${path}/cart/deleted.do?cartid="+flag;
	                            		}
	                            	}
	                                </script>
                            	</div>
                            	
                            </td>
						</tr>
						<%-- <c:set var="total" value="${total + (row.price * row.amount)}" />
						<c:if test="${total>100000}">
							<c:set var="total" value="${total}" />
						</c:if>
						<c:if test="${total<100000}">
							<c:set var="total" value="${total+(fee)}" />
						</c:if> --%>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="col-lg-4">
			<div class="cart-totals">
				<h3 style="margin-top: 0px; margin-bottom: 30px;">Cart Totals</h3>
				<table>
					<tbody>
						<tr>
							<td>Subtotal</td>
							<td id="sum"></td>
						</tr>
						<tr>
							<td>fee</td>
							<td id="fee"></td>
						</tr>
						<tr class="total-row">
							<td>Total</td>
							<td id="total"></td>
						</tr>
					</tbody>
				</table>
				<div class="btn-cart-totals">
					<input type="button" value="수정" id="btnUpdate" onclick="updated()">
					<input type="button" value="장바구니비우기" id="btnDelete">
					<span class="orderbuy"> 
						<input type="button" value="결제" class="buyBtn">
					</span>
					
				</div>
			</div>
		</div>
		</form>
		</div>
	</div>
</div>
<div class="container">
<div class="order">
	<form method="post" name="form3" id="form3" action="${path}/order/insert.do">
		<input type="hidden" name="chk[]" id="chk" value="" />
		<input type="hidden" id="totalprice" name="totalprice" value="${totalprice}">
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

	</c:otherwise>
</c:choose>
	
<%@ include file ="../include/footer.jsp" %>

</body>
</html>