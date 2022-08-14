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
<link rel="stylesheet" type="text/css"href="<%=cp%>/orders/css/cartListStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/orders/css/orderPaymentStyle.css" />

</head>
<body>
<jsp:include page="../main/header.jsp"/>
	<div id="content" align="center">
		<div align="center" style="font-weight: 700; padding-top: 15px; font: 10pt;"><h3>ORDER COMPLETE</h3></div>
		<form action="<%=cp%>/shop/orders/orderPayment_ok.do" method="post" name="paymentForm">
			
			<!-- 결제완료 -->
			<div class="box row" align="center" style="width: 1000px; margin-bottom: 50px;">
				<div class="box row" style="width: 1000px;" align="center"></div>
				<div style="padding: 50px;">
					주문이 완료되었습니다.<br/>
					주문 시간 : ${ddto.deliveryDate }<br/>
					예상 도착일 : ${ddto.arriveDate }
				</div>
			</div>

			<!-- 배송정보 -->
			<div id="left_area" style="display: inline-block; float: left; padding-left: 40px;" >
				<div id="info_area" style="width: 500px;" align="left">
					<div class="box row">
						<h3 style="margin: 0px;">배송정보</h3>
					</div>
					<div class="box row">
						<div class="box label">
							<label for="deliveryName"><span>NAME</span></label>
						</div>
						<div class="box input" align="left">
							${ddto.deliveryName }
						</div>
					</div>
					<div class="box row" style="height: 120px;">
						<div class="box label" style="height: 80px;">
							<label for="deliveryAddr"><span>ADDRESS</span></label>
						</div>
						<div class="box input" style="padding: 0px;" align="left">
							<div class="box input" style="padding: 5px 10px 5px 10px;">
								${ddto.deliveryAddr[0] }
							</div>
							<div class="box input" style="padding: 5px 10px 5px 10px;">
								${ddto.deliveryAddr[1] }
							</div>
							<div class="box input" style="padding: 5px 10px 5px 10px;">
								${ddto.deliveryAddr[2] }
							</div>
							<div class="box input" style="padding: 5px 10px 5px 10px;">
								${ddto.deliveryAddr[3] }
							</div>
						</div>
					</div>
					<div class="box row">
						<div class="box label">
							<label for="deliveryTel"><span>TEL</span></label>
						</div>
						<div class="box input">
							${ddto.deliveryTel }
						</div>
					</div>
					<div class="box row">
						<div class="box label">
							<label for="deliveryEmail"><span>E-MAIL</span></label>
						</div>
						<div class="box input">
							${ddto.deliveryEmail }
						</div>
					</div>
				</div>
			</div>

			<!-- 결제정보 -->
			<div  id="right_area" style="display: inline-block; width: 350px; float: right; padding-right: 60px;">
				<div class="box row" style="width: 350px;" align="left" >
					<h3 style="margin: 0px;">결제정보</h3>
				</div>
				<div class="box row payment" align="right" style="height: 40px;">
					<div style="width: 230px;">
						<div>TOTAL</div><div>${ddto.totalPrice }KRW</div><br/>
					</div>
				</div>
			</div>
			
			<div class="box row" align="center" style="width: 1000px; margin-bottom: 50px; padding: 0px; display: inline-block;">
				<div class="box row" style="width: 1000px;" align="left"></div>
				<div style="padding: 50px;">
					<div align="center" style="display: inline-block; margin-right: 50px;">
						<div style="border: 1px solid; width: 150px; height: 30px; padding-top: 15px;">
							<a href="<%=cp %>/shop/orders/orderList.do">ORDER LIST</a>
						</div>
					</div>
					<div align="center" style="display: inline-block;">
						<div style="border: 1px solid; width: 150px; height: 30px; padding-top: 15px;">
							<a href="<%=cp %>/shop/product/list.do">KEEP SHOPPING</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>