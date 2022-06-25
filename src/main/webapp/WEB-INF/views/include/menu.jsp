<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/d438fba670.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${path}/css/header.css"/> 
  <!--  <script type="text/javascript">
        var tooglebBtn = document.querySelector(".navbar_toogleBtn");
        var menu = document.querySelector(".navbar_menu");
        var icons = document.querySelector(".navbar_icons");

        tooglebBtn.addEventListener('click',() => {
            menu.classList.toggle('active');
            icons.classList.toggle('active');
        });
   </script> -->
</head>
<body>
<%@ include file ="../include/header.jsp" %>
	<div class="bar">
        <div class="bar_logo">
            <i class="fas fa-gem"></i>
            <a href="${path}">Jewelry</a>
        </div>
        
        <div class="bar_menu">
            <li><a href="${path}/member/info.do">Info</a></li>
            <li><a href="${path}/product/allList.do">product</a></li>
            <%-- <li><a href="${path}/product/ringList.do">Ring</a></li>
            <li><a href="${path}/product/necklaceList.do">Necklace</a></li> --%>
            <li><a href="${path}/board/list.do">Board</a></li>
            <li><a href="${path}/order/list.do">Order</a></li>
            <li><a href="${path}/ect/photo.do">Photo</a></li>
        </div>

        <ul class="bar_icons">
            <li><a href="${path}/cart/list.do"><i class="fas fa-shopping-cart"></i></a></li>
            <c:choose>
                <c:when test="${sessionScope.userid == null}">
                    <li><a href="${path}/member/login.do"><i class="fas fa-lock-open"></i></a></li>
                </c:when>
                <c:otherwise>
                    <!-- <li>${sessionScope.name} (${sessionScope.userid})님 로그인 중입니다.</li> -->
                    <li><a href="${path}/member/logout.do"><i class="fas fa-user-lock"></i></a></a></li>
                </c:otherwise>
            </c:choose>
        </ul>

        <a href="#" class="bar_toogleBtn">
            <i class="fas fa-bars"></i>
        </a>
    </div>
</body>
</html>