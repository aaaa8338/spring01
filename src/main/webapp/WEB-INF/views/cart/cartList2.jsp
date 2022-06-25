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
	$(function() {
		$("#btnDelete").click(function() {
			if(confirm("장바구니를 비우시겠습니까?")){
				location.href="${path}/cart/deleteAll.do";
			}
		});
		
		$(".buyBtn").click(function() {
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
				itemSum();
				
			} else {
				$(".chBox").prop("checked", false);
				itemSum();
			}
		});

		$(".chBox").click(function() {
			$("#allCheck").prop("checked", false);
		});
		
		   
		var tt = "${cart}";
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
			var checkedArr = new Array();

			$("input[class='chBox']:checked").each(function() {
				checkedArr.push($(this).attr("data-cartid"));
			});

			$("#chk").val(checkedArr);

			$("#form3").submit();

		});

	});



	function deleted() {
		var cartid = document.getElementById("cartid").value;
		if (confirm("삭제하시겠습니까?")) {
			location.href = "${path}/cart/deleted.do?cartid=" + cartid;
		}
	}

	function updated() {
		document.form1.action = "${path}/cart/update.do";
		document.form1.submit();
		alert("수정되었습니다");
	}

	function daumZipCode() {
		new daum.Postcode({
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
						extraAddr += (extraAddr != '' ? ', ' + data.buildingName : data.buildingName);
					}
					
					fullAddr += (extraAddr != '' ? ' (' + extraAddr + ')' : '');
				}

				document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('address1').value = fullAddr;

				document.getElementById('address2').focus();
			}
		}).open();
	}
</script>
</head>
<body>
<%@ include file ="../include/menu.jsp" %>
<h2>장바구니</h2>
<c:choose>
	<c:when test="${map.count == 0}">
		장바구니가 비었습니다.
	</c:when>
	<c:otherwise>
		<div class="allCheck">
		   <input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label> 
		</div>
		<div class="delBtn">
			<button type="button" class="selectDelete_btn">선택 삭제</button>
		</div>
			<form id="form1" name="form1" method="post" action="${path}/cart/update.do">
			<table border="1" width="400px;">
				<tr>
					<th>&nbsp;</th>
					<th>상품명</th>
					<th>단가</th>
					<th>수량</th>
					<th>금액</th>
				</tr>
				<c:forEach var="row" items="${map.list}">
					<tr align="center">
						<td><a href="javascript:deleted()">[삭제]</a>
							<input type="hidden" name="cartid" id="cartid" value="${row.cartid}">
						 <div class="checkBox">
						   <input type="checkbox" name="chBox" onclick="itemSum()" class="chBox" data-cartid="${row.cartid}"/>
						  </div>
						</td> 
						<td>${row.productname}</td>
						<td><fmt:formatNumber value="${row.price}" pattern="#,###,###"/>
						<input type="hidden" name="price" id="price" value="${row.price}">
						</td>
						<td>
							<input type="number" name="amount" style= "width: 30px;" 
							value='<fmt:formatNumber value="${row.amount}" pattern="#,###,###"/>'>
						</td>
						<td><fmt:formatNumber value="${row.money}" pattern="#,###,###"/></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5" align="right">
					장바구니 금액 합계 : 
						<fmt:formatNumber value="${map.sumMoney}" pattern="#,###,###"/><br>
					배송료 : ${map.fee}<br>
					총금액 : <fmt:formatNumber value="${map.sum}" pattern="#,###,###"/>
					</td>
					 <td id="sum"></td>
				</tr>
			</table>
			<input type="button" value="수정" id="btnUpdate" onclick="updated()">
			<input type="button" value="장바구니비우기" id="btnDelete">
			<span class="orderbuy"> 
				<input type="button" value="결제" class="buyBtn">
			</span>
		</form>
		<div class="order">
			<form method="post" name="form3" id="form3" action="${path}/order/insert.do">
				<input type="hidden" name="chk[]" id="chk" value="" />
				<input type="hidden" name="amount" id="amount" value="" />
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
	</c:otherwise>
	
</c:choose>

</body>
</html>