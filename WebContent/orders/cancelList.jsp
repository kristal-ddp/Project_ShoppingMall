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
</head>
<link rel="stylesheet" type="text/css"href="<%=cp%>/css/shopStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/orders/css/cartListStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/orders/css/orderPaymentStyle.css" />
<body>
<jsp:include page="../main/header.jsp"/>
	<div id="content" align="center">
		<div align="center" style="font-weight: 700; padding-top: 15px; font: 10pt;"><h3>CANCEL LIST</h3></div>
		<form action="" method="post" name="paymentForm">
			<c:forEach var="ddto" items="${list }">
				<div class="box row" style="width: 900px;">
					<h3 style="float: left; padding-left: 30px;">${ddto.deliveryDate } 주문</h3>
					<h3 style="float: left; padding-left: 30px; color: red;">주문취소일 : ${ddto.arriveDate }</h3>
				</div>
				<table id="cartList">
					<thead>
						<tr>
							<th colspan="2">PRODUCT</th>
							<th>PRICE</th>
							<th>QUANTITY</th>
							<th>TOTTAL PRICE</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${ddto.orderList }">
							<tr align="center">
								<td id="saveFileName">
									<a href="<%=cp %>/shop/product/detail.do?productNum=${dto.productNum }">
										<img src="<%=cp %>/product/image/${dto.productCategory }/${dto.saveFileName[0] }" height="100px;">
									</a>
								</td>
								<td id="productName">
									<a href="<%=cp %>/shop/product/detail.do?productNum=${dto.productNum }">
										${dto.productName }
									</a><br/>
									<span class="productOption">[옵션 : ${dto.orderColor }/${dto.orderSize }]</span>
								</td>
								<td id="productPrice">
									<span style="text-decoration: line-through;">${dto.productPrice }KRW</span><br/>
									<span>${dto.productPrice }KRW</span>
								</td>
								<td id="productQuantity">
									${dto.orderQuantity }
								</td>
								<td id="totalProductPrice">
									${dto.productPrice * dto.orderQuantity }KRW
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="box row" style="width: 900px; margin-bottom: 50px;">
					<h4 style="float: right; padding-right: 30px;">TOTAL : ${ddto.totalPrice }</h4>
				</div>
			</c:forEach>
			<c:if test="${empty list }">
				<div class="box row" style="font-size: 10pt;color: #555555; width: 900px; margin-bottom: 30px;">
				</div>
				<div class="box row" style="font-size: 10pt;color: #555555; width: 900px; padding-bottom: 50px;">
					구입한 상품이 없습니다.
				</div>
			</c:if>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>