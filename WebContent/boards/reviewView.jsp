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
<title>REVIEW VIEW</title>

<link rel="stylesheet" type="text/css"href="<%=cp%>/css/shopStyle.css" />
<link rel="stylesheet" type="text/css" href="<%=cp %>/boards/css/view.css"/>
<script type="text/javascript">

	function sendIt() {
		var f = document.searchForm;
		
		f.action = "<%=cp %>/shop/boards/reviewView.do";
		f.submit();
	}

</script>
</head>
<body>

<jsp:include page="../main/header.jsp"/>

<div id="content" align="center">
	<!-- board -->
	<div class="boardList">
		<!-- title -->
		<div class="boardTitle" align="center">REVIEW</div>
		<!-- content -->
		<div class="boardContent" align="center">
			<div class="">
				<div class="box" style="width: 150px; float: left;">
					<a href="<%=cp %>/shop/product/detail.do?productNum=${ordersDTO.productNum }">
						<img src="<%=cp %>/product/image/${ordersDTO.productCategory }/${ordersDTO.saveFileName[0] }" width="100px" style="margin: 10px; display: inline;">
					</a>
				</div>
				<div class="box">
					<div class="box text">${ordersDTO.productName } / ${ordersDTO.productPrice }KRW</div>
					<div class="box text">[옵션 : ${ordersDTO.orderColor }/${ordersDTO.orderSize }]</div>
					<div class="box">
						<div style="border: 1px solid; width: 80px; padding: 5px; display: inline-block;">
							<a href="<%=cp %>/shop/product/detail.do?productNum=${ordersDTO.productNum }">상품정보 보기</a>
						</div>
						<div style="border: 1px solid; width: 80px; padding: 5px; display: inline-block;">
							<a href="javascript:window.open('<%=cp %>/shop/boards/reviewSearchList.do','상품정보 선택','width=600, height=500, status=yes, top=100, left=100')">상품정보 선택</a>
						</div>
					</div>
				</div>
				<table border="0">
					<colgroup>
						<col style="width: 130px;">
						<col style="width: auto;">
					</colgroup>
					<tbody>
						<tr class="viewTitle">
							<td colspan="3">
								<!-- SUBJECT -->
								<div class="name">SUBJECT
									<p>${dto.subject }</p>
								</div>
								<!-- userID -->
								<div class="name">ID
									<p>${dto.userId }</p>
								</div>
								<!-- POSTDATE -->
								<div class="name">DATE
									<p>${dto.postDate }</p>
								</div>
							</td>
						</tr>
						<tr class="viewContents">
							<td colspan="3">
								<div class="">
									<!-- CONTENT -->
									<div class="viewContent">${dto.content }</div>
								</div>
							</td>
						</tr>
						<!-- <tr class="attach displaynone">
							<th scope="row">첨부파일</th>
							<td></td>
						</tr> -->
						<!-- <tr class="displaynone ">
							<th scope="row">비밀번호</th>
							<td><input id="password" name="password"
								onkeydown="if (event.keyCode == 13 || event.which == 13) { return false; }"
								value="" type="password">
								<span class="">수정 및 삭제하려면 비밀번호를 입력하세요.</span></td>
						</tr> -->
					</tbody>
				</table>
			</div>
			<div class="button">
				<div class="elementLeft">
						<a href="<%=cp %>/shop/boards/review.do">LIST</a>
				</div>
				<c:if test="${dto.userId == userId }">
					<div class="elementRight">
						<a href="<%=cp %>/shop/boards/reviewUpdate.do?boardNum=${dto.boardNum }&${params }';"
						class="element">EDIT</a>
						<a href="<%=cp %>/shop/boards/reviewDelete_ok.do?boardNum=${dto.boardNum }&${params }';"
						class="element">DELETE</a>
					</div>
				</c:if>
			</div>
		</div>
		<br/>
		<div class="boardContent" align="center">
			<table border="0">
				<colgroup>
					<col style="width: 130px;">
					<col style="width: auto;">
				</colgroup>
				<tbody>
					<c:if test="${!empty commentsDTO }">
						<tr class="viewTitle">
							<td colspan="3">
								<div class="name">
									<p>${commentsDTO.userId } | ${commentsDTO.postDate }</p>
								</div>
							</td>
						</tr>
						<tr class="viewContents">
							<td colspan="3">
								<div class="">
									<!-- CONTENT -->
									<div class="viewContent" style="min-height: auto;">${commentsDTO.content }</div>
								</div>
							</td>
						</tr>
					</c:if>
				</tbody>
				<tfoot>
					<tr class="viewTitle">
						<td colspan="3">
							<form action="" method="post" name="myForm">
								<c:if test="${empty commentsDTO }">
									<div class="name" id="msg">
										<p>댓글이 존재하지 않습니다.</p>
									</div>
								</c:if>
								<c:if test="${userId == 'KRISTAL'}">
									<div class="name" id="textarea" style="display: none;">CONTENT
										<textarea name="content" style="width: 600px; height: 130px; resize: none; border-color: #dfdfdf;">${commentsDTO.content }</textarea>
									</div>
									<div class="elementRight">
										<c:if test="${empty commentsDTO }">
											<a href="javascript:write()" class="element" id="write-bnt">WRITE</a>
											<a href="javascript:sendItWrite()" class="element" id="register-bnt1" style="display: none;">REGISTER</a>
											<a href="javascript:cancel1()" class="element" id="cancel-bnt1" style="display: none;">CANCEL</a>
										</c:if>
										<c:if test="${!empty commentsDTO }">
											<a href="javascript:edit()" class="element" id="edit-bnt">EDIT</a>
											<a href="javascript:sendItEdit)" class="element" id="delete-bnt">DELETE</a>
											<a href="javascript:sendItDelete()" class="element" id="register-bnt2" style="display: none;">REGISTER</a>
											<a href="javascript:cancel2()" class="element" id="cancel-bnt2" style="display: none;">CANCEL</a>
										</c:if>
									</div>
								</c:if>
								<input type="hidden" name="boardNum" value="${dto.boardNum }"/>
								<input type="hidden" name="community" value="review"/>
							</form>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>

<jsp:include page="../main/footer.jsp"/>

</body>
<script type="text/javascript">
	function write() {
		document.getElementById('msg').style.display = "none";
		document.getElementById('textarea').style.display = "inline-block";
		document.getElementById('write-bnt').style.display = "none";
		document.getElementById('register-bnt1').style.display = "inline-block";
		document.getElementById('cancel-bnt1').style.display = "inline-block";
	}
	function cancel1() {
		document.getElementById('msg').style.display = "inline-block";
		document.getElementById('textarea').style.display = "none";
		document.getElementById('write-bnt').style.display = "inline-block";
		document.getElementById('register-bnt1').style.display = "none";
		document.getElementById('cancel-bnt1').style.display = "none";
	}
	function edit() {
		document.getElementById('msg').style.display = "none";
		document.getElementById('textarea').style.display = "inline-block";
		document.getElementById('edit-bnt').style.display = "none";
		document.getElementById('delete-bnt').style.display = "none";
		document.getElementById('register-bnt2').style.display = "inline-block";
		document.getElementById('cancel-bnt2').style.display = "inline-block";
	}
	function cancel2() {
		document.getElementById('msg').style.display = "inline-block";
		document.getElementById('textarea').style.display = "none";
		document.getElementById('edit-bnt').style.display = "inline-block";
		document.getElementById('delete-bnt').style.display = "inline-block";
		document.getElementById('register-bnt2').style.display = "none";
		document.getElementById('cancel-bnt2').style.display = "none";
	}
	function sendItWrite() {
		var f = document.myForm;
		f.action="<%=cp %>/shop/comments/write_ok.do";
		f.submit();
	}
	function sendItEdit() {
		var f = document.myForm;
		f.action="<%=cp %>/shop/comments/upadte_ok.do";
		f.submit();
	}
	function sendItDelete() {
		var f = document.myForm;
		f.action="<%=cp %>/shop/comments/delete_ok.do";
		f.submit();
	}
</script>
</html>