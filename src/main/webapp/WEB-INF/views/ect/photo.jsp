<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file ="../include/header.jsp" %>
<script src="https://kit.fontawesome.com/d438fba670.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/css/header.css"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="${path}/css/photo.css"/>
</head>
<body>
<c:choose>
	<c:when test="${sessionScope.power == 'admin'}">
		<%@ include file ="../include/adminmenu.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file ="../include/menu.jsp" %>
	</c:otherwise>
</c:choose>
 <h2 class="mar3">photography</h2>
        <div class="location">
            <div class="animation_canvas">
                <div class="slider_panal">
                    <!--이미지가 들어올 공간-->
                    <img src="${path}/images/11.jpg" alt="" class="slider_image" />
                    <img src="${path}/images/2.jpg" alt="" class="slider_image" />
                    <img src="${path}/images/3.jpg" alt="" class="slider_image" />
                    <img src="${path}/images/4.jpg" alt="" class="slider_image" />
                    <img src="${path}/images/5.jpg" alt="" class="slider_image" />
                    <img src="${path}/images/6.jpg" alt="" class="slider_image" />    
                </div>
                <div class="slider_text_panal">
                    <!--텍스트가 들어올 공간-->
                    <div class="slider_text">
                        <h1></h1>
                    </div>
                    <div class="slider_text">
                        <h1></h1>
                    </div>
                    <div class="slider_text">
                        <h1></h1>
                    </div>
                    <div class="slider_text">
                        <h1></h1>
                    </div>
                    <div class="slider_text">
                        <h1></h1>
                    </div>
                    <div class="slider_text">
                        <h1></h1>
                    </div>
                </div>
                 <div class="slide_move" id="leftMove"><img class="direction" alt="" src="${path}/images/left.png"></div>
                <div class="slide_move" id="rightMove"><img class="direction" alt="" src="${path}/images/right.png"></div>
            </div>
            
            <div class="contain3">
                <div class="rig2" style="width: 100%">
                    <img class="size aa color1" id="btn1" src="${path}/images/11.jpg" alt="" />
                    <img class="size aa color2" id="btn2" src="${path}/images/2.jpg" alt="" />
                    <img class="size aa color3" id="btn3" src="${path}/images/3.jpg" alt="" />
                    <img class="size aa color4" id="btn4" src="${path}/images/4.jpg" alt="" />
                    <img class="size aa color5" id="btn5" src="${path}/images/5.jpg" alt="" />
                    <img class="size aa color6" id="btn6" src="${path}/images/6.jpg" alt="" />
                </div>
            </div>
        </div>

<script type="text/javascript">
$("#btn1").hover(
        function () {
          $("#btn1").addClass("black1", 1000);
          $(".white1").removeClass("white1", 500);
        },
        function () {
          $(".black1").addClass("color1", 1000);
          $(".color1").removeClass("black1", 500);
        }
      );
      $("#btn2").hover(
        function () {
          $("#btn2").addClass("black1", 1000);
          $(".white1").removeClass("white1", 500);
        },
        function () {
          $(".black1").addClass("color1", 1000);
          $(".color1").removeClass("black1", 500);
        }
      );
      $("#btn3").hover(
        function () {
          $("#btn3").addClass("black1", 1000);
          $(".white1").removeClass("white1", 500);
        },
        function () {
          $(".black1").addClass("color1", 1000);
          $(".color1").removeClass("black1", 500);
        }
      );
      $("#btn4").hover(
        function () {
          $("#btn4").addClass("black1", 1000);
          $(".white1").removeClass("white1", 500);
        },
        function () {
          $(".black1").addClass("color1", 1000);
          $(".color1").removeClass("black1", 500);
        }
      );
      $("#btn5").hover(
        function () {
          $("#btn5").addClass("black1", 1000);
          $(".white1").removeClass("white1", 500);
        },
        function () {
          $(".black1").addClass("color1", 1000);
          $(".color1").removeClass("black1", 500);
        }
      );
      $("#btn6").hover(
        function () {
          $("#btn6").addClass("black1", 1000);
          $(".white1").removeClass("white1", 500);
        },
        function () {
          $(".black1").addClass("color1", 1000);
          $(".color1").removeClass("black1", 500);
        }
      );
</script>

<script type="text/javascript">
  $(document).ready(function () {
    
      $(".slider_text")
      .css("left", -400)
      .each(function (index) {
          $(this).attr("data-index", index);
          
      });
	
      function leftmove(index) {
  	    index = $(".active").index();
  	    index--;
  	    if (index < 0) {
  	        index = 5;
  	    }
  	    if (index > 5) {
  	        index = 0;
  	    }
  	    moveSlider(index); 
  	}

  	function rightmove(index) {
  	    index = $(".active").index();
  	    index++;
  	    if (index < 0) {
  	        index = 5;
  	    }
  	    if (index > 5) {
  	        index = 0;
  	    }
  	    moveSlider(index); 
  	}

  	$("#leftMove").on("click", function () {
  	    leftmove(1);
  	});

  	$("#rightMove").on("click", function () {
  	    rightmove(-1);
  	});

    var auto = setInterval(function () {
       rightmove(1);
   }, 7000);   
  
  $(".aa")
    .each(function (index) {
      $(this).attr("data-index", index);
    })
    .click(function () {
      var index = $(this).attr("data-index");
      moveSlider(index);
    });

  
  function moveSlider(index) {
    
    var willMoveLeft = -(index * 800);
    $(".slider_panal").animate({ left: willMoveLeft }, "slow");

    $(".aa[data-index=" + index + "]").addClass("active");
    $(".aa[data-index!=" + index + "]").removeClass("active");

    $(".slider_text[data-index=" + index + "]")
      .show()
      .animate({ left: 0 }, "slow");
    $(".slider_text[data-index!=" + index + "]").hide("slow", function () {
      $(this).css("left", -400);
    });
  }

 
  var randomNum = Math.round(Math.random() * 5);
  moveSlider(randomNum);
});
  
</script>
<%@ include file ="../include/footer.jsp" %>
</body>
</html>