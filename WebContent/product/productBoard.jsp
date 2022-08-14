<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<div class="board">
	<div class="board_wrap">
	<br>
	<!-- QnA -->
		<div class="boardTitle">
			<div class="titleName" style="float: left; font-size: 10pt;">Q&A</div>
			<div class="titleButton" style="float: right; text-align: right;">
				<a href="<%=cp%>/shop/boards/qnaWrite.do">Write</a>
				<a href="<%=cp%>/shop/boards/qna.do" style="margin-left: 15px">View all</a>
			</div>
		</div>

		<table class="boardContent">
			<colgroup>
				<col style="width: 5%;">
				<col style="width: 5%;">
				<col style="width: 10%;">
				<col style="width: 5%;">
				<col style="width: 5%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">PRODUCT</th>
					<th scope="col">SUBJECT</th>
					<th scope="col">ID</th>
					<th scope="col">DATE</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty qnaList }">
					<tr>
						<td colspan="5" class="empty">등록된 상품 문의가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="qnaDTO" items="${qnaList }">
					<tr style="margin: 10pt 0pt 10pt;">
						<td>${qnaDTO.boardNum }</td>
						<!-- number -->
						<td>${qnaDTO.productName }</td>
						<!-- product -->
						<td><!-- subject -->
							<a href="javascript:qnaView('${qnaDTO.boardNum }');">${qnaDTO.subject }</a> 
						<!-- <img src="https://www.lememe.co.kr/_skin/lememe_220520/img/shop/i_new.gif" border="0" alt="최신"> -->
						</td>
						<td>${qnaDTO.userId }</td>
						<td>${qnaDTO.postDate }</td>
					</tr>
					<tr id="qnaContent${qnaDTO.boardNum }" style="display: none;">
						<td colspan="5" class="qnarev_cnt">
							<div style="padding: 10px 0px 10px 0px;">
								${qnaDTO.content }
								<div class="btn" align="right">
									<c:if test="${qnaDTO.userId.equals(userId) || userId == 'KRISTAL' }">
										<span class="box_btn w100 white">
											<a href="javascript:editRev(311)">수정</a>
										</span>
										<span class="box_btn w100 white">
											<a href="javascript:delRev(311)">삭제</a>
										</span>
									</c:if>
								</div>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table><br><br>
		<!-- Review -->
		<div class="boardTitle">
			<div class="titleName" style="float: left; font-size: 10pt;">Review</div>
			<div class="titleButton" style="float: right; text-align: right;">
				<a href="<%=cp%>/shop/boards/reviewWrite.do">Write</a>
				<a href="<%=cp%>/shop/boards/review.do" style="margin-left: 15px">View all</a>
			</div>
		</div>
		
		<table class="boardContent">
			<colgroup>
				<col style="width: 5%;">
				<col style="width: 5%;">
				<col style="width: 10%;">
				<col style="width: 5%;">
				<col style="width: 5%;">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">PRODUCT</th>
					<th scope="col">SUBJECT</th>
					<th scope="col">ID</th>
					<th scope="col">DATE</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty reviewList }">
					<tr>
						<td colspan="5" class="empty">등록된 상품 후기가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="reviewDTO" items="${reviewList }">
					<tr style="margin: 10pt 0pt 10pt;">
						<td>${reviewDTO.boardNum }</td>
						<!-- number -->
						<td>${reviewDTO.productName } [${reviewDTO.ordersDTO.getOrderColor() }/${reviewDTO.ordersDTO.getOrderSize() }]</td>
						<!-- product -->
						<td><!-- subject -->
							<a href="javascript:reviewView('${reviewDTO.boardNum }');">${reviewDTO.subject }</a> 
						<!-- <img src="https://www.lememe.co.kr/_skin/lememe_220520/img/shop/i_new.gif" border="0" alt="최신"> -->
						</td>
						<td>${reviewDTO.userId }</td>
						<td>${reviewDTO.postDate }</td>
					</tr>
					<tr id="reviewContent${reviewDTO.boardNum }" style="display: none;">
						<td colspan="5" class="qnarev_cnt">
							<div style="padding: 10px 0px 10px 0px;">
								${reviewDTO.content }
								<div class="btn" align="right">
									<c:if test="${reviewDTO.userId.equals(userId) || userId == 'KRISTAL' }">
										<span class="box_btn w100 white">
											<a href="javascript:editRev(311)">수정</a>
										</span>
										<span class="box_btn w100 white">
											<a href="javascript:delRev(311)">삭제</a>
										</span>
									</c:if>
								</div>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		
	</div>
</div>