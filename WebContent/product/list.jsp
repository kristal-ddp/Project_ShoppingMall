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
<title>Product list</title>
<link rel="stylesheet" type="text/css"href="<%=cp%>/css/shopStyle.css" />
<link rel="stylesheet" type="text/css" href="<%=cp %>/product/data/style.css"/>

</head>
<body>

<jsp:include page="../main/header.jsp"/>

<div id="content" align="center">
	<div id="productList">
		<ul class="listView">
			<c:forEach var="dto" items="${lists }">
				<li id="listBox" class="item" style="list-style: none;width: 300px;display: inline-block;">
					<div class="box_wrap" style="display: inline-block;font-size: 10pt;color: #555555;">
						<div class="image">
							<a href="<%=cp %>/shop/product/detail.do?productNum=${dto.productNum }">
								<img src="<%=cp %>/product/image/${dto.productCategory }/${dto.saveFileName[0] }" width="300px"/>
							</a>
						</div>
						<div class="productBrief" align="center">
							<div class="productName">
								<a href="<%=cp %>/shop/product/detail.do?productNum=${dto.productNum }">
									<span>${dto.productName }</span>
								</a>
							</div>
							<div class="productPrice">
								<ul>
									<li style="list-style: none; font-size: 10px;">
										<span>${dto.productPrice }KRW</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div id="paging">
		<p>
			<c:if test="${dataCount!=0 }">${pageIndexList }</c:if>
		</p>
	</div>
</div>

<jsp:include page="../main/footer.jsp"/>

</body>
</html>