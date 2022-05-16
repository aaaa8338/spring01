<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>Home</title>
<script src="https://kit.fontawesome.com/d438fba670.js" crossorigin="anonymous"></script>
<script type="text/javascript">
	function btn() {
		location.href="${pageContext.request.contextPath}/product/allList.do";

	}
</script>
<%-- <link rel="stylesheet" href="${path}/css/header3.css"/>  --%>
<%@ include file ="include/header.jsp" %>
<style type="text/css">
.main {
	background-image: url("${path}/images/main.jpg");
	background-repeat: no-repeat;
	border: 0;
    padding: 0; 
    width:100%;
    height:100%;
    background-position: top;
    background-attachment: fixed;
   	background-size: cover;
}
	
body {
	margin: 0;
}

a {
	text-decoration: none;
	color: black;
}

.bar {
	height: auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 1% 5%;
}

.bar_logo i {
	font-size: 30px;
	color: black;
}

.bar_logo a {
	font-size: 20px;
}

.bar_menu {
	display: flex;
	list-style-type: none;
	padding-left: 35px;
	
}

.bar_menu li {
	padding: 8px 15px;
}

.bar_menu li:hover {
	background-color: orange;
	border-radius: 5px;
} 

.bar_menu a:hover {
	text-decoration: none;
	color: black;
}

.bar_logo a:hover {
	text-decoration: none;
	color: black;
}

.bar_icons a:hover {
	text-decoration: none;
	color: black;
}

.bar_icons {
	list-style: none;
	color: black;
	display: flex;
	padding-left: 0;
	font-size: 30px;
}

.bar_icons li {
	padding: 10px 20px;
}

.bar_toogleBtn {
	display: none;
	position: absolute;
	right: 32px;
	font-size: 20px;
	color: black;
}

@media screen and (max-width: 800px) {
	.bar {
		flex-direction: column;
		align-items: flex-start;
		padding: 10px 15px;
	}
	.bar_menu {
		flex-direction: column;
		align-items: center;
		width: 100%;
		padding-top: 10px;
	}
	.bar_menu li {
		width: 100%;
		text-align: center;
		padding: 10px 0px;
	}
	.bar_icons {
		justify-content: center;
		width: 100%;
	}
	.bar_toogleBtn {
		display: block;
	}
}

@media screen and (max-width: 800px) {
	.navbar {
		flex-direction: column;
		align-items: flex-start;
		padding: 10px 15px;
	}
	.navbar_menu {
		flex-direction: column;
		align-items: center;
		width: 100%;
		padding-top: 10px;
	}
	.navbar_menu li {
		width: 100%;
		text-align: center;
		padding: 10px 0px;
	}
	.navbar_icons {
		justify-content: center;
		width: 100%;
	}
	.navbar_toogleBtn {
		display: block;
	}
}

.shopbtn{
    border-radius: 4px;
    width: 180px;
    height: 40px;
    text-align: center;
    font-size: medium;
    color: black;
    padding: 7px 45px;
    display: block;
    margin-top: 20px;
    border: solid 2px lightgray;
}

.shopbtn:hover{
	color: white;
	text-decoration: none;
	background-color: black;
	border: solid 2px black;
	
}
.text{
	margin-top: 20%;
	margin-bottom: 20%;
}
</style>
</head>
<body>
<div class="main">
<div class="bar">
        <div class="bar_logo">
            <i class="fas fa-gem"></i>
            <a href="${path}">Jewelry</a>
        </div>
        
        <div class="bar_menu">
            <li><a href="${path}/member/info.do">Info</a></li>
            <li><a href="${path}/product/allList.do">product</a></li>
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
                    <li><a href="${path}/member/logout.do"><i class="fas fa-user-lock"></i></a></a></li>
                </c:otherwise>
            </c:choose>
        </ul>

        <a href="#" class="bar_toogleBtn">
            <i class="fas fa-bars"></i>
        </a>
    </div>
	<div class="container">
		<div class="text">
			<p style="">New Collection</p>
			<p style="font-size: xx-large; font-weight: 600;">For Hidden Beauty</p>
			<p><a class="shopbtn" href="javascript:btn();" >Shop Now</a></p>
		</div>
	</div>
</div>

<%@ include file ="include/footer.jsp" %>
</body>
</html>
