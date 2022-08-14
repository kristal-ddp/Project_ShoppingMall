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
<title>wish list</title>

<link rel="stylesheet" type="text/css"href="<%=cp%>/css/shopStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/orders/css/cartListStyle.css" />

</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content" align="center" style="display: block;">
		<div align="center" style="font-weight: 700; padding-top: 15px; font: 10pt;"><h3>WISH LIST</h3></div>
		<form action="" method="post" name="cartListForm">
			<table id="cartList" style="border-top: 1px solid #DBDBDB; border-bottom: 1px solid #DBDBDB; padding: 20px 0px 20px 0px; margin-bottom: 50px;">
				<thead>
					<tr>
						<th colspan="2">PRODUCT</th>
						<th>PRICE</th>
						<th>QUANTITY</th>
						<th>TOTTAL PRICE</th>
						<th>ADD / DEL</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${list }">
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
								<span style="text-decoration: line-through;">
									<fmt:formatNumber value="${dto.productPrice }" type="number"/>KRW
								</span><br/>
								<fmt:formatNumber value="${dto.productPrice * 0.9 }" type="number"/>KRW
							</td>
							<td id="productQuantity">
								${dto.orderQuantity }&nbsp;&nbsp;&nbsp;
								<a href="<%=cp%>/shop/orders/changeOrder_ok.do?orderNum=${dto.orderNum }&orderQuantity=${dto.orderQuantity + 1 }">
									+</a>&nbsp;
								<c:if test="${dto.orderQuantity > 1 }">
									<a href="<%=cp%>/shop/orders/changeOrder_ok.do?orderNum=${dto.orderNum }&orderQuantity=${dto.orderQuantity - 1 }">
										-</a>
								</c:if>
								<c:if test="${dto.orderQuantity == 1 }">
									<a href="<%=cp%>/shop/orders/changeOrder_ok.do?orderNum=${dto.orderNum }&orderQuantity=${dto.orderQuantity - 1 }"
										onclick="if(!confirm('찜리스트에서 삭제 하시겠습니까?')){return false;}">
										-</a>
								</c:if>
							</td>
							<td id="totalProductPrice">
								<fmt:formatNumber value="${dto.productPrice * 0.9 * dto.orderQuantity }" type="number"/>KRW
							</td>
							<td id="delete">
							<a href="<%=cp%>/shop/orders/changeOrder_ok.do?orderNum=${dto.orderNum }&progress=cartList"
								onclick="if(!confirm('장바구니에 추가 하시겠습니까?')){return false;}">담기</a>&nbsp;/&nbsp;
							<a href="<%=cp%>/shop/orders/deleteOrder_ok.do?orderNum=${dto.orderNum }"
								onclick="if(!confirm('찜리스트에서 삭제 하시겠습니까?')){return false;}">X</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${empty list }">
					<tfoot>
						<tr align="center">
							<td colspan="6" style="font-size: 10pt;color: #555555;">
								찜한 상품이 없습니다.
							</td>
						</tr>
					</tfoot>
				</c:if>
			</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>