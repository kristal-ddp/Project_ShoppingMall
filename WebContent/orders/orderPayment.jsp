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
<title>Insert title here</title>

<link rel="stylesheet" type="text/css"href="<%=cp%>/css/shopStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/orders/css/cartListStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/orders/css/orderPaymentStyle.css" />

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    
    function sendItPayment_ok() {
		var f = document.paymentForm;

		if(!f.deliveryName.value) {
			alert('이름을 입력해주세요');
			f.deliveryName.focus();
			return;
		}
		if(!f.deliveryAddr[0].value) {
			alert('우편번호를 입력해주세요');
			f.deliveryAddr[0].focus();
			return;
		}
		if(!f.deliveryAddr[1].value) {
			alert('주소를 입력해주세요');
			f.deliveryAddr[1].focus();
			return;
		}
		if(!f.deliveryTel.value) {
			alert('전화번호를 입력해주세요');
			f.deliveryTel.focus();
			return;
		}
		
		f.action = "<%=cp%>/shop/orders/orderPayment_ok.do";
		f.submit();
	}
    
    function copyData() {
		var f = document.paymentForm;

		f.deliveryName.value = '${memberDTO.userName }';
		f.deliveryAddr[0].value = '${memberDTO.userAddr[0] }';
		f.deliveryAddr[1].value = '${memberDTO.userAddr[1] }';
		f.deliveryAddr[2].value = '${memberDTO.userAddr[2] }';
		f.deliveryAddr[3].value = '${memberDTO.userAddr[3] }';
		f.deliveryTel.value = '${memberDTO.userTel }';
		f.deliveryEmail.value = '${memberDTO.userEmail }';
		
	}
    
    function resetData() {
		var f = document.paymentForm;
		
    	f.reset();
    	cal() 
    	
	}
	
	function cal() {
		var f = document.paymentForm;
		var sum = 0;
		var shippng = 0;
		var tot = 0;
		var i = 0;
		
		if (${list.size() } > 1) {
			for (i = 0; i < ${list.size() }; i++) {
				sum += f.price[i].value * 1;
				tot += f.totalPrice[i].value * 1;
			}
		} else if (${list.size() } == 1){
			sum += f.price.value * 1;
			tot += f.totalPrice.value * 1;
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
	<div id="content" align="center">
		<div align="center" style="font-weight: 700; padding-top: 15px; font: 10pt;"><h3>ORDER PAYMENT</h3></div>
		<form action="<%=cp%>/shop/orders/orderPayment_ok.do" method="post" name="paymentForm">

			<!-- 주문할 목록 -->
			<table id="cartList" style="border-top: 1px solid #DBDBDB; border-bottom: 1px solid #DBDBDB; padding: 20px 0px 20px 0px; margin-bottom: 50px;">
				<thead>
					<tr>
						<th colspan="2">PRODUCT</th>
						<th>PRICE</th>
						<th>QUANTITY</th>
						<th>TOTTAL PRICE</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="tot" value="0"/>
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
								${dto.orderQuantity }
							</td>
							<td id="totalProductPrice">
								<input type="hidden" name="orderNum" value="${dto.orderNum }">
								<input type="hidden" name="price" value="${dto.productPrice * dto.orderQuantity }">
								<input type="hidden" name="totalPrice" value="${dto.productPrice * 0.9 * dto.orderQuantity }">
								<fmt:formatNumber value="${dto.productPrice * 0.9 * dto.orderQuantity}"  type="number"/>KRW
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${empty list }">
					<tfoot>
						<tr id="listBox" class="item" style="list-style: none;width: 300px;display: inline-block;">
							<td class="box_wrap" style="display: inline-block;font-size: 10pt;color: #555555;">
								등록된 상품이 없음
							</td>
						</tr>
					</tfoot>
				</c:if>
			</table>

			<div id="left_area" style="display: inline-block; float: left; padding-left: 40px;">
				<!-- 주문자 정보 -->
				<div id="info_area" style="width: 500px; margin-bottom: 30px;" align="left">
					<div class="box row">
						<h3 style="margin: 0px;">회원정보</h3>
					</div>
					<div class="box row">
						<div class="box label">
							<label for="userName"><span>NAME</span></label>
						</div>
						<div class="box text" align="left">
							${memberDTO.userName }
						</div>
					</div>
					<div class="box row" style="height: 120px;">
						<div class="box label" style="height: 80px;">
							<label for="userAddr"><span>ADDRESS</span></label>
						</div>
						<div class="box text" style="padding: 0px;" align="left">
							<div class="box text" style="padding: 5px 10px 5px 10px;">
								${memberDTO.userAddr[0] }
							</div>
							<div class="box text" style="padding: 5px 10px 5px 10px;">
								${memberDTO.userAddr[1] }
							</div>
							<div class="box text" style="padding: 5px 10px 5px 10px;">
								${memberDTO.userAddr[2] }
							</div>
							<div class="box text" style="padding: 5px 10px 5px 10px;">
								${memberDTO.userAddr[3] }
							</div>
						</div>
					</div>
					<div class="box row">
						<div class="box label">
							<label for="userTel"><span>TEL</span></label>
						</div>
						<div class="box text">
							${memberDTO.userTel }
						</div>
					</div>
					<div class="box row">
						<div class="box label">
							<label for="userEmail"><span>E-MAIL</span></label>
						</div>
						<div class="box text">
							${memberDTO.userEmail }
						</div>
					</div>
				</div>

				<!-- 배송지 정보 -->
				<div id="info_area" style="width: 500px;" align="left">
					<div class="box row">
						<h3 style="margin: 0px; display: inline-block;">배송정보</h3>
						<span style="float: right; padding-right: 30px;">
							<input type="radio" name="deliveryDTO" id="copyDataBtn" onclick="copyData()"/>
							<label for="copyDataBtn">주문자 정보와 동일</label>
							<input type="radio" name="deliveryDTO" id="resetDataBtn" checked="checked" onclick="resetData()"/>
							<label for="resetDataBtn">새로운 배송지</label>
						</span>
					</div>
					<div class="box row">
						<div class="box label">
							<label for="deliveryName"><span>NAME</span></label>
						</div>
						<div class="box input" align="left">
							<input type="text" name="deliveryName" class="inputStyle" placeholder="이름" maxlength="20"/>
						</div>
					</div>
					<div class="box row" style="height: 120px;">
						<div class="box label" style="height: 80px;">
							<label for="deliveryAddr"><span>ADDRESS</span></label>
						</div>
						<div class="box input" style="padding: 0px;" align="left">
							<div class="box input" style="padding: 5px 0px 5px 0px; width: 370px">
								<input type="text" name="deliveryAddr" class="input-2 inputStyle" id="sample6_postcode" placeholder="우편번호" maxlength="33"/>
								<input type="button" onclick="sample6_execDaumPostcode()" class="join_button" style="float: right;" value="우편번호 찾기">
							</div>
							<div class="box input" style="padding: 5px 0px 5px 0px;">
								<input type="text" name="deliveryAddr" class="inputStyle" id="sample6_address" placeholder="주소" maxlength="33"/>
							</div>
							<div class="box input" style="padding: 5px 0px 5px 0px;">
								<input type="text" name="deliveryAddr" class="inputStyle" id="sample6_detailAddress" placeholder="상세주소" maxlength="33"/>
							</div>
							<div class="box input" style="padding: 5px 0px 5px 0px;">
								<input type="text" name="deliveryAddr" class="inputStyle" id="sample6_extraAddress" placeholder="참고항목" maxlength="33"/>
							</div>
						</div>
					</div>
					<div class="box row">
						<div class="box label">
							<label for="deliveryTel"><span>TEL</span></label>
						</div>
						<div class="box input">
							<input type="text" name="deliveryTel" class="inputStyle" placeholder="전화번호 (-)없이 숫자만 입력해주세요." maxlength="11"/>
						</div>
					</div>
					<div class="box row">
						<div class="box label">
							<label for="deliveryEmail"><span>E-MAIL</span></label>
						</div>
						<div class="box input">
							<input type="text" name="deliveryEmail" class="inputStyle" placeholder="이메일" maxlength="33"/>
						</div>
					</div>
				</div>
			</div>

			<!-- 결제정보 -->
			<div  id="right_area" style="display: inline-block; width: 350px; float: right; padding-right: 60px;">
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
							<a href="javascript:sendItPayment_ok();">ORDER</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>