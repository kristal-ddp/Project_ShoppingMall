<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product detail</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/product/data/style.css"/>
<script type="text/javascript" src="<%=cp%>/product/script.js"></script>

<script type="text/javascript">
	function sendItCartList() {
		var f = document.detailForm;
		
		
		if(f.option1.value=="*"){
			alert("컬러를 입력해 주세요.");
			f.option1.focus();
			return;
		}
		
		if(f.option2.value=="*"){
			alert("사이즈를 입력해 주세요.");
			f.option2.focus();
			return;
		
		}
		
		
		f.productNum
		
		f.action = "<%=cp%>/shop/orders/addOrder_ok.do?progress=cartList";
		f.submit();
	}
	
	function sendItWishList() {
		var f = document.detailForm;

		if(f.option1.value=="*"){
			alert("컬러를 입력해 주세요.");
			f.option1.focus();
			return;
		}
		
		if(f.option2.value=="*"){
			alert("사이즈를 입력해 주세요.");
			f.option2.focus();
			return;
		
		}
		
		f.productNum
		
		f.action = "<%=cp%>/shop/orders/addOrder_ok.do?progress=wishList";
		f.submit();
	}
</script>

</head>
<body onload="initial();">

<jsp:include page="../main/header.jsp"/>

	<div id="content" align="center">
		<div class="detail_wrap">
			<div class="detail">
				<!-- product image -->
				<div class="productImage">
					<div>
						<c:forEach var="i" begin="0" end="${saveLength-1}" step="1">
							<img src="<%=cp %>/product/image/${dto.productCategory }/${dto.saveFileName[i] }"
							width="600px" style="margin-bottom: 22px;"/>
						</c:forEach>
					</div>
				</div>
				
				<!-- product detail -->
				<div class="productMenu" align="center">
				
					<div class="productInfo">
					<img alt="wishlist" src="<%=cp %>/product/image/wishlist/wishlistSc.PNG"  name="progress" onclick="sendItWishList()"
				style="float: right; width:30px; height:25px; margin-top: -5px;"/>
						<!-- product name, price  -->
						<div class="productName">
							<span>${dto.productName }</span> 
						</div>
						<div>
							<h3>${dto.productPrice }KRW</h3>
						</div>
						<!-- choose option(color,size) -->
						<form name="detailForm" method="post">
						<table border="0" class="option" id="option">
							<tbody class="optionColor" id="optionColor">
								<tr>
									<td>
										<select name="option1" id="option1" class="options" onchange="select('case1')">
												<option value="*" id="initial1" selected="selected">[필수] COLOR 선택</option>
												<option value="**" disabled="disabled">-------------------</option>
												<c:forEach var="i" begin="0" end="${colorLength-1}" step="1">
													<option value="${dto.productColor[i] }">${dto.productColor[i] }</option>
												</c:forEach>
										</select>
									</td>
								</tr>
							</tbody>

							<tbody class="optionSize" id="optionSize">
								<tr>
									<td><select name="option2" id="option2" class="options" onchange="select('case2')">
											<option value="*" id="initial2" selected="selected">[필수] SIZE 선택</option>
											<option value="**" disabled="disabled">-------------------</option>
											<c:forEach var="i" begin="0" end="${sizeLength-1}" step="1">
												<option value="${dto.productSize[i] }">${dto.productSize[i] }</option>
											</c:forEach>
									</select></td>
								</tr>
							</tbody>
						</table>
						
						<!-- selected option(color,size) -->
						<div>
						<!-- 	<form name="detailForm" method="post"> -->
							<input type="hidden" name="productNum" value="${dto.productNum }">
							 
								<table class="totalProduct" border="1" summary="">
									<colgroup>
										<col style="width: 20%;">
										<col style="width: 20%;">
										<col style="width: 10%;">
									</colgroup>
									<thead>
									<tbody class="selectedOptions" id="selectedOptions">
										<tr id="selectedOption">
											<td>
												<p class="product">
													${dto.productName }
												<span>
													<input type="text" id="orderColor" name="orderColor"
													class="selected" readonly="readonly">
													<input type="text" id="orderSize" name="orderSize"
													class="selected" readonly="readonly">
												</span>
												</p>
											</td>
											<!-- choose quantity -->
											<td>
												<span>
													<input type=hidden name="productPrice"  value="${dto.productPrice }">
													<input type="text" name="orderQuantity" class="orderQuantity" value="1" size="3" >
													<a>
														<img src="//img.echosting.cafe24.com/design/skin/default/product/btn_count_up.gif"
														onclick='count("plus")'>
													</a>
													<a>
														<img src="//img.echosting.cafe24.com/design/skin/default/product/btn_count_down.gif"
														onclick='count("minus")'>
													</a>
													<a>
														<img src="//img.echosting.cafe24.com/design/skin/default/product/btn_price_delete.gif"
														onclick='count("delete")'>
													</a>
												</span>
											</td>
											<!-- price -->
											<td>
												<span>
													<input type="text" name="sum" class="sum" size="10" readonly="readonly">
												</span>
											</td>
										</tr>
									</tbody>
								</table>
								<!-- total price, selected quantity -->
								<div id="totalSum" class="totalSum">
								TOTAL :
								<span class="total">
									<input type="text" id="totalPrice" class="totalPrice" value="0" size="10" readonly="readonly">
									<input type="text" id="amount" class="amount" value="1" size="3" readonly="readonly">
								</span>
								</div>
							</div>
						</form>

						<!-- add bag -->
						<div class="addBag">
							<div>
								<a href="#none" class="add_button"  onclick="sendItCartList();">ADD TO BAG</a>
							</div>
							
							<div>
							<br/>
							<br/>
					<%-- 		<p>${dto.description }</p> --%>
							<p align="left">${fn:replace(dto.description, replaceChar, "<br/>")}</p>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		
		<jsp:include page="./productBoard.jsp"/>
		
	</div>
</div>

	<jsp:include page="../main/footer.jsp"/>

 
 	<!-- bag box (new window) -->
	<%-- <div class="bagBox">
		<div class="">
			<h3>BAG (1) ITEM</h3><!-- countItem -->
		</div>
		<div class="">
			<ul class="">
				<li class="">
					<div class="box">
						<a href="<%=cp %>/shop/product/detail.do?productNum=${dto.productNum }" >
							<img src="<%=cp %>/product/image/top/${dto.saveFileName[0] }" class="bagImage" >
						</a>
						<p class="name">
							<a href="<%=cp %>/shop/product/detail.do?productNum=${dto.productNum }"
							class="ec-product-name">DAVID ECO LEATHER CROP JUMPER [KHAKI]</a>
						</p>
						<p class="option">[옵션: KHAKI/MEDIUM]</p>
						<ul>
							<li class="price strike">348,000 KRW</li>
							<li class="strike displaynone"><strong></strong></li>
							<li><strong>243,600 KRW</strong></li>
							<li><strong></strong></li>
							<li>수량 : 1</li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
		<div class="ec-base-button" style="border-top: 1px solid #000;">
			<a href="#none" class="btnNormalFix sizeS" onclick="Basket.orderLayerAll(this)"
			link-order="/order/orderform.html?basket_type=all_buy"
			link-login="/member/login.html">바로 구매하기</a>
			<a href="/order/basket.html" class="btnNormalFix sizeS">장바구니 이동</a>
			<a href="#none" onclick="$('#confirmLayer').remove();" class="btnNormalFix sizeS">쇼핑계속하기</a>
		</div>
		<a class="close" onclick="$('#confirmLayer').remove();">
			<img src="//img.echosting.cafe24.com/skin/base/common/btn_close.gif" alt="닫기">
		</a>
	</div> --%>


</body>
</html>

