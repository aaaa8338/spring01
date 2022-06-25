<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
</head>
<body>
<%@ include file ="../include/menu.jsp" %>
<h2>상품정보</h2>
	<table>
		<tr>
			<td>
				<img src="${path}/images/${dto.pictureurl}" width="200" height="200">
			</td>
			<td align="center">
				<table>
					<tr>
						<td>종류</td>
						<td>${dto.kind}</td>
					</tr>
					<tr>
						<td>상품명</td>
						<td>${dto.productname}</td>
					</tr>
					<tr>
						<td>가격</td>
						<td>${dto.price}</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>${dto.description}</td>
					</tr>
					<tr>
						<td colspan="2">
							<form name="form1" action="${path}/cart/insert.do" method="post">
								<input type="hidden" name="productid" value="${dto.productid}">
								<select name="amount">
									<c:forEach begin="1" end="10" var="i">
										<option value="${i}">${i}</option>
									</c:forEach>
								</select>&nbsp;개
								<input type="submit" value="장바구니담기">
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>