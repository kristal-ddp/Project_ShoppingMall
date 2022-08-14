<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>cart list</title>

<link rel="stylesheet" type="text/css"href="<%=cp%>/css/shopStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/orders/css/cartListStyle.css" />

<script type="text/javascript">
	function sendItPayment() {
		var f = document.cartListForm;
		
		f.action = "<%=cp%>/shop/orders/orderPayment.do";
		f.submit();
	}

	function checkAll() {

		if (${list.size() } > 1) {
			if (document.getElementById("all").checked == true) { //id 를 사용하여 하나의 객체만을 호출
				for (var i = 0; i < orderNum.length; i++)
					document.getElementsByName("orderNum")[i].checked = true; //name 을 사용하여 배열 형태로 담아 호출
			}
			if (document.getElementById("all").checked == false) {
				for (var i = 0; i < orderNum.length; i++)
					document.getElementsByName("orderNum")[i].checked = false;
			}
		} else {
			if (document.getElementById("all").checked == true) {
				document.cartListForm.orderNum.checked = true;
			}
			if (document.getElementById("all").checked == false) {
				document.cartListForm.orderNum.checked = false;
			}
		}
		
		cal();
	}
	
	function cal() {
		var f = document.cartListForm;
		var sum = 0;
		var shippng = 0;
		var tot = 0;
		var i = 0;
		
		if (${list.size() } > 1) {
			for (i = 0; i < ${list.size() }; i++) {
				if (f.orderNum[i].checked) {
					sum += f.price[i].value * 1;
					tot += f.totalPrice[i].value * 1;
				}
			}
		} else if (${list.size() } == 1){
			if (f.orderNum.checked) {
				sum += f.price.value * 1;
				tot += f.totalPrice.value * 1;
			}
		}
		
		if (sum < 200000) {
			shippng = 3000;
		}
		
		f.sum.value = sum;
		f.shippng.value = shippng;
		f.tot.value = tot + shippng;
		
	}
</script>

</head>
<body onload="cal()">
	<jsp:include page="../main/header.jsp"/>
	<div id="content" align="center" style="display: block; padding: 5px;">
		<div align="center" style="font-weight: 700; padding-top: 15px; font: 10pt;"><h3>CART LIST</h3></div>
		<form action="" method="post" name="cartListForm">
			<table id="cartList" style="border-top: 1px solid #DBDBDB; border-bottom: 1px solid #DBDBDB; padding: 20px 0px 20px 0px; margin-bottom: 50px;">
				<thead>
					<tr>
						<th align="center" style="height: 20px;">
							<c:if test="${!empty list }">
								<input type="checkbox" id="all" name="all" onclick="checkAll()" checked="checked">
								<a>전체선택/해제</a>
							</c:if>
						</th>
						<th colspan="2">PRODUCT</th>
						<th>PRICE</th>
						<th>QUANTITY</th>
						<th>TOTTAL PRICE</th>
						<th>DEL</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${list }">
						<tr align="center">
							<td id="orderNum">
								<input type="checkbox" name="orderNum" value="${dto.orderNum }" checked="checked" onclick="cal()" >
							</td>
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
								<span style="text-decoration: line-through;">
									<fmt:formatNumber value="${dto.productPrice }" type="number"/>KRW
								</span><br/>
								<fmt:formatNumber value="${dto.productPrice * 0.9 }" type="number"/>KRW
							</td>
							<td id="productQuantity">
								${dto.orderQuantity }&nbsp;&nbsp;&nbsp;
								<a href="<%=cp%>/shop/orders/changeOrder_ok.do?orderNum=${dto.orderNum }&orderQuantity=${dto.orderQuantity + 1 }">
									+</a>&nbsp;
								<c:if test="${dto.orderQuantity > 1}">
									<a href="<%=cp%>/shop/orders/changeOrder_ok.do?orderNum=${dto.orderNum }&orderQuantity=${dto.orderQuantity - 1 }">
										-</a>
								</c:if>
								<c:if test="${dto.orderQuantity == 1}">
									<a href="<%=cp%>/shop/orders/changeOrder_ok.do?orderNum=${dto.orderNum }&orderQuantity=${dto.orderQuantity - 1 }"
										onclick="if(!confirm('장바구니에서 삭제 하시겠습니까??')){return false;}">
										-</a>
								</c:if>
							</td>
							<td id="totalProductPrice">
								<input type="hidden" name="price" value="${dto.productPrice * dto.orderQuantity }">
								<input type="hidden" name="totalPrice" value="${dto.productPrice * 0.9 * dto.orderQuantity }">
								<fmt:formatNumber value="${dto.productPrice * 0.9 * dto.orderQuantity}"  type="number"/>KRW
							</td>
							<td id="delete">
								<a href="<%=cp%>/shop/orders/deleteOrder_ok.do?orderNum=${dto.orderNum }"
									onclick="if(!confirm('장바구니에서 삭제 하시겠습니까??')){return false;}">X</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${empty list }">
					<tfoot>
						<tr align="center">
							<td colspan="7" style="font-size: 10pt; color: #555555;">
								등록된 상품이 없습니다.
							</td>
						</tr>
					</tfoot>
				</c:if>
			</table>
			<!-- 결제정보 -->
			<div id="right_area" style="display: inline-block; width: 350px; float: right; padding-right: 60px;">
				<div class="box row" style="width: 350px;" align="left" >
					<h3 style="margin: 0px;">결제정보</h3>
				</div>
				<div class="box row payment" align="right">
					<div style="width: 230px;">
						<div>PRICE</div>
						<div>
							<input type="text" name="sum" value="" style="width: 65px; text-align: right; border: none;" readonly="readonly">KRW
						</div><br/>
						<div>SHIPPNG</div>
						<div>
							<input type="text" name="shippng" value="" style="width: 65px; text-align: right; border: none;" readonly="readonly">KRW
						</div><br/>
						<div>TOTAL</div>
						<div>
							<input type="text" name="tot" value="" style="width: 65px; text-align: right; border: none;" readonly="readonly">KRW
						</div><br/>
					</div>
					<div style="float: right;">
						<div style="border: 1px solid; width: 90px; height: 50px; padding-top: 35px;" align="center">
							<a href="javascript:sendItPayment();">ORDER</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>