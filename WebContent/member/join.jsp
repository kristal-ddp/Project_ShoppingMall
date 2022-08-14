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
<link rel="stylesheet" type="text/css"href="<%=cp%>/member/css/memberListStyle.css" />
<link rel="stylesheet" type="text/css" href="<%=cp%>/member/css/member.css" />

<script type="text/javascript">

	function sendIt(){
		
		var f = document.myForm;
		
		if(!f.userId.value){
			alert("아이디를 입력해 주세요.");
			f.userId.focus();
			return;
		}
		
		if(!f.userPwd.value){
			alert("패스워드를 입력해 주세요.");
			f.userPwd.focus();
			return;
		}
			
		if(!f.userName.value){
			alert("이름을 입력해 주세요.");
			f.userName.focus();
			return;
		}
		
		if(!f.userGender.value){
			alert("성별을 입력해 주세요.");
			f.userGender.focus();
			return;
		}
		if(!f.userBirth[0].value){
			alert("생년월일을 입력해 주세요.");
			f.userBirth[0].focus();
			return;
		}
		 if(!f.userBirth[1].value){
			alert("월을 입력해 주세요.");
			f.userBirth[1].focus();
			return;
		}
		if(!f.userBirth[2].value){
			alert("일을 입력해 주세요.");
			f.userBirth[2].focus();
			return;
		}
		
		if(!f.userTel.value){
			alert("전화번호를 입력해 주세요.");
			f.userTel.focus();
			return;
		}
		
		/* if(!f.userEmail.value){
			alert("E-Mail 입력해 주세요.");
			f.userEmail.focus();
			return;
		} */
		f.action = "<%=cp%>/shop/member/join_ok.do"
		f.submit();
		
		
		
	}
	
	
function checkid(){
		
		var f = document.myForm;
		
		f.action = "<%=cp%>/shop/member/idcheck.do"
			f.submit();
		
		
		}
		
function idCheck(){
	
	
 window.open("<%=cp%>/shop/member/idcheck.do","_blank","width=300px height=200px left=800px top=350px"); 
	
	
	
}


</script>
    

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
</script>
</head>
<body >
 <jsp:include page="../main/header.jsp"/>
   
<div id="content" align="center">
	<div class="join_wrap">
		<div class="joinTitle" align="center" style="font-weight: 700;padding-top: 15px;font: 10pt;">회원가입</div>
		
		<form action="" method="post" name="myForm">
		 
		  
		<div id="left_area" style="display: inline-block; width: 400px;padding-bottom: 25px;">
	               <div id="update_area">
	                  <div class="box row">
	                  <div class="joinLabel">
	                        <label for="userId"><span>ID</span></label>
	                     </div>
	                   <div class="box input">
	                        <input autofocus onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');" type="text" name="userId" class="inputStyle" placeholder="아이디"/>
	                     	<input type="button" value="중복확인" class="inputStyle"  onclick="idCheck()"/> 
	                     </div>
	                   </div>
	                   <div class="box row">
		                     <div class="joinLabel">
		                        <label for="userName"><span>PASSWORD</span></label>
		                     </div>
		                     <div class="box input">
		                        <input type="password" name="userPwd" class="inputStyle" placeholder="비밀번호"/>
		                     </div>
	             		</div>
	                   
	                    <div class="box row">
		                     <div class="joinLabel">
		                        <label for="userName"><span>NAME</span></label>
		                     </div>
		                     <div class="box input">
		                        <input type="text" name="userName" class="inputStyle" placeholder="이름"/>
		                     </div>
	             		</div>
	                  
	                    
	                  	  <div class="box row">
		                     <div class="joinLabel">
		                        <label for="userGender"><span>GENDER</span></label>
		                     </div>
		                     <div class="box input">
		                     <!--  <input type="text" name="userGender" id="userGender"/> -->
		                        <select style="border: none; width: 80; height: 30; font-size: 8pt;font-style: italic;"name="userGender">
		                       		<option value="">선택</option>
		                        	<option value="선택안함">선택안함</option>
		                        	<option value="남자">남자</option>
		                        	<option value="여자">여자</option>	                        
		                        </select>
		                     </div>
	             		</div>
	                   <div class="box row">
		                     <div class="joinLabel">
		                        <label for="userName"><span>BIRTH</span></label>
		                     </div>
		                     <div class="box input">
		                     <span style="float: left;vertical-align: middle;">
		                  		<input onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4" style="width: 50px;" 
		                  		type="text" name="userBirth" class="inputStyle" placeholder="년도"/> 
			                 </span>
			                 <span style="float: left;vertical-align: middle;">
			                    <select style="border: none; width: 80; height: 30; font-size: 8pt;font-style: italic;" name="userBirth">
								<option value="">월</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option></select>
							</span>
							<span style="float: left;vertical-align: middle;padding-left: 20px;">
								<input maxlength="2" style="width: 50px;margin-bottom: 5px;font-style: italic; vertical-align: middle;" type="text" name="userBirth" id="userBirth" placeholder="일"/> 
	                    	</span>
		                    </div>
	             		</div>

						<div class="box row" style="height: 110px;">
							<div class="joinLabel" style="height: 80px;">
								<label style="" for="userAddress"><span>ADDRESS</span></label>
							</div>
							<div class="box input"
								style="margin-top: 10px; margin-bottom: 15px; height: 80px;">
								<div style="padding-bottom: 8px;">
									<input maxlength="6" type="text" name="userAddr" id="sample6_postcode"
									style="float: left; padding-right: 0; padding-bottom:10pt; display: block;vertical-align: middle;font-size: 9pt;"
									class="input-2" placeholder="우편번호">
									<input class="join_button" type="button" onclick="sample6_execDaumPostcode()"
									style="display: block;vertical-align: middle; height: 15pt;font-size: 9pt;float: left;line-height: 4px;" value="우편번호 찾기">
								</div>
								<div class="box input" style="display:block; padding-bottom: 15px;">
									<input type="text" name="userAddr" id="sample6_address" placeholder="주소" style="padding-bottom:8pt;font-size: 9pt;">
								</div>
								<div class="box input"
									style="display: block; padding-bottom: 15px;">
									<input type="text" name="userAddr" id="sample6_detailAddress" placeholder="상세주소" style="padding-bottom: 8pt;font-size: 9pt;">

									<div class="box input">
										<input type="text" maxlength="50" name="userAddr" id="sample6_extraAddress" placeholder="참고항목">
									</div>
								</div>
							</div>
						</div>
					</div>
	                <div class="box row">
	                     <div class="joinLabel">
	                        <label for="userTel"><span>TEL</span></label>
	                     </div>
	                     <div class="box input">
	                        <input onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="11" type="text" name="userTel" id="userTel" placeholder="(-)없이 숫자만 입력해주세요."/>
	                     </div>
	                  </div>
	                  <div class="box row">
	                     <div class="joinLabel">
	                        <label for="userEmail"><span>E-MAIL</span></label>
	                     </div>
	                     <div class="box input">
	                        <input type="text" name="userEmail" id="userEmail" placeholder="이메일 (선택사항)"/>
	                     </div>
	                  </div>
	                </div>
	            </div>
		</form>
		
		
		
		<div align="center">
			<div style="float: left; padding-left: 370px; padding-right: 10px;">	
				<button class="add_button" type="button" style="width: 170px;" onclick="javascript:history.back();">
					<a style=" font-size: 8px; color: #484848;">BACK</a>
				</button>
			</div>
			
			<div style="float: left;">
				<button class="add_button" type="button" style="width: 170px;" onclick="sendIt();">
					<a style=" font-size: 8px; color: #484848;">JOIN</a>
				</button>	
			</div>
		</div>
	</div>
</div>
   
<jsp:include page="../main/footer.jsp"/>

</body>
</html>