<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"href="<%=cp%>/css/shopStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/member/css/memberListStyle.css" />
<style type="text/css">
button.add_button {
	width: 325px;
	display: inline-block;
	margin: 5px;
	height: 98px;
	padding-bottom: 9px;
	line-height: 26px;
}
.add_button span {
	font-size: 8px;
	color: #484848;"
	
}
.add_button b {
	font-size: 17px;
	color: black;
		
}



</style>
<%-- <script type="text/javascript" src="<%=cp%>/member/js/checkBox.js"> --%>
<script type="text/javascript">

function sendItCartList() {
	var f = document.myPageForm;
	
	
	f.action = "<%=cp%>/shop/orders/cartList.do?progress=cartList";
	f.submit();
}


function sendItWishList() {
	var f = document.myPageForm;
	
	
	f.action = "<%=cp%>/shop/orders/wishList.do";
	f.submit();
}

function sendItOrder() {
	var f = document.myPageForm;
	
	
	f.action = "<%=cp%>/shop/orders/orderList.do";
	f.submit();
}

function sendItCancle() {
	var f = document.myPageForm;
	
	
	f.action = "<%=cp%>/shop/orders/cancelList.do?progress=cancelList";
	f.submit();
}

function sendProfile() {
	var f = document.myPageForm;
	
	
	f.action = "<%=cp%>/shop/member/update.do";
	f.submit();
}

function sendItMain() {
	var f = document.myPageForm;
	
	
	f.action = "<%=cp%>/shop/main/main.do";
	f.submit();
}




</script>






</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<form name="myPageForm" method="post">
	<div id="content" align="center">
		<div style="margin-top: 100px;">
			<button class="add_button" type="button" onclick="sendItCartList()();"> 
				<b >CART</b> 
				<span>
					<br>구매하고자하는 상품이 담긴 목록을 보여드립니다.
				</span>
			</button>	
			<button class="add_button" type="button" onclick="sendItWishList();">
				<b>WISH</b>
				<span>
					<br>관심상품으로 등록하신 상품의 목록을 보여드립니다.
				</span>
			</button>	
		</div>
		<div>
			<button class="add_button" type="button" onclick="sendItOrder();">
				<span>
					<b>ORDER</b><br>고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.
				</span>
			</button>	
			<button class="add_button" type="button" onclick="sendItCancle();">
				<span>
					<b>CANCLE</b>
					<br>고객님께서 주문하신 상품의 주문을 취소하실 수 있습니다

				</span>
			</button>	
		</div>
		
		<div>
			<button class="add_button" type="button" onclick="sendProfile();">
				<span>
					<b>PROFILE</b><br>고객님의 개인정보를 관리하는 공간입니다.
						<!-- 개인정보를 최신정보로 유지하시면 보다 간편히 쇼핑을 즐기실수 있습니다. -->
				</span>
			</button>	
			<button class="add_button" type="button" onclick="sendItMain();">
				<span>
					<b>MAIN</b>
					<br>초기 메인화면으로 이동합니다.
				</span>
				
			</button>	
		</div>
		
		
	</div>
	</form>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>