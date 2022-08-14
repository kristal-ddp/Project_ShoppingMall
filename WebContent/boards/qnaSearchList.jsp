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
<title>상품정보 선택</title>

<link rel="stylesheet" type="text/css"href="<%=cp%>/css/shopStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/boards/css/writeStyle.css" />
<style type="text/css">

td {
	width: 50px;
}

</style>

<script type="text/javascript" src="<%=cp%>/boards/js/util.js"></script>
<script type="text/javascript">
	function select(productNum) {
		window.opener.location.href = "<%=cp%>/shop/boards/qnaWrite.do?productNum=" + productNum;
		window.close();
	}
</script>

</head>
<body>
	<div id="content" align="center" style="display: block; width: auto;">
		<div align="center" style="font-weight: 700; padding-top: 15px; font: 10pt;"><h3>SEARCH LIST</h3></div>
		<form action="" method="post" name="searchListForm">
			<div class="search" style="border-top: 1px solid #AAAAAA; padding: 20px 0px 20px 0px; width: 500px;">
				PRODUCT NAME
				<input type="hidden" name="searchKey" value="productName"/>
				<input type="text" name="searchValue" class="textField">
				<input type="button" value="SEARCH" class="button" onclick="submit();"/>
			</div>
			<table style="width: 500px;">
				<thead>
					<tr align="center" style="border-bottom: 1px solid #AAAAAA;">
						<th id="saveFileName" colspan="2">
							PRODUCT
						</th>
						<th id="select">
							SELECT
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="dto" items="${lists }">
						<tr align="center" style="border-bottom: 1px solid #AAAAAA;">
							<td id="saveFileName" width="80px">
								<img src="<%=cp %>/product/image/${dto.productCategory }/${dto.saveFileName[0] }" height="100px;">
							</td>
							<td id="productName">
								${dto.productName }<br/>
							</td>
							<td id="select">
								<div style="border: 1px solid; width: 50px; padding: 5px;">
									<a href="javascript:select(${dto.productNum })">선택</a>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- paging -->
			<div id="paging">
				<p>
					<c:if test="${dataCount!=0 }">${pageIndexList }</c:if>
				</p>
			</div>
		</form>
	</div>
</body>
</html>