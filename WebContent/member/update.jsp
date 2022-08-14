<%@page import="com.sun.prism.impl.Disposer.Target"%>
<%@page import="com.member.MemberDTO"%>
<%@page import="com.member.MemberDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String userId = request.getParameter("userId");
	
	Connection conn= DBConn.getConnection();
	MemberDAO dao = new MemberDAO(conn);
	
	MemberDTO dto = dao.getReadData(userId);
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>kristal회원정보수정</title>
<link rel="stylesheet" type="text/css"href="<%=cp%>/css/shopStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/member/css/memberListStyle.css" />
<link rel="stylesheet" type="text/css" href="<%=cp%>/member/css/member.css" />



<script type="text/javascript">


	function sendIt() {
		var f = document.myForm;
		
		
		
		if(!f.userPwd.value){
			alert("패스워드를 입력해 주세요.");
			f.userPwd.focus();
			return;
		}
		
		
		
		
		if(!f.userAddr[0].value){
			alert("0주소을 입력해 주세요.");
			f.userAddr[0].focus();
			return;
		}
		
		if(!f.userAddr[1].value){
			alert("1주소을 입력해 주세요.");
			f.userAddr[1].focus();
			return;
		}
		
		if(!f.userAddr[2].value){
			alert("2주소을 입력해 주세요.");
			f.userAddr[2].focus();
			return;
		}
		
		if(!f.userAddr[3].value){
			alert("3주소을 입력해 주세요.");
			f.userAddr[3].focus();
			return;
		}
		
		
		
		
		if(!f.userTel.value){
			alert("전화번호를 입력해 주세요.");
			f.userTel.focus();
			return;
		}
		
		
		if(!f.userEmail.value){
			alert("이메일를 입력해 주세요.");
			f.userEmail.focus();
			return;
		}
		
		
	
			
		f.action = "<%=cp%>/shop/member/update_ok.do"
		f.submit();
	}
	
	</script>
	
<!-- <script type="text/javascript">
	function wewe() {
		var f = document.myForm;
		var month = f.userBirth[]; 
		var gender = f.userGender; 
		
		for(i=0;i<12;i++){
			
			if(f.userBirth[i].value == ${dto.userBirth }){
				f.userBirth[i].selected =true;
			}
			
			
		}
		
		for(i=0;i<4;i++){
			
			if(f.userGender[i].value ==${dto.userGender}){
				f.userGender[i].selected = true;
			}
		}
		
		
		
	}

	

	
	
	</script>  -->
	
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
   
   <div id="content" align="center" >
   
      
   	<form action="" method="post" name="myForm">
   	

   
   	


			

		<div id="left_area" style="display: inline-block; width: 400px;padding-bottom: 25px;">
	               <div id="update_area">
	                  <div class="box row">
	                  <div class="joinLabel">
	                        <label for="userId"><span>ID</span></label>
	                     </div>
	                   <div class="box input">
	                        <input readonly="readonly" autofocus onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');" type="text" 
	                        name="userId" class="inputStyle" placeholder="아이디" value="${dto.userId }"/>
	                     
	                     </div>
	                   </div>
	                   <div class="box row">
		                     <div class="joinLabel">
		                        <label for="userName"><span>PASSWORD</span><br><a>(선택가능)</a></label>
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
		                        <input type="text" name="userName" class="inputStyle" placeholder="이름" value="${dto.userName }" readonly="readonly"/>
		                     </div>
	             		</div>
	                  
	                    
	                  	  <div class="box row">
		                     <div class="joinLabel">
		                        <label for="userName""><span>GENDER</span></label>
		                     </div>
		                     <div class="box input">
		                     <input type="text" name="userGender" id="userGender" value="${dto.userGender }" readonly="readonly"/>
		                       <!--  <select style="border: none; width: 80; height: 30; font-size: 8pt;font-style: italic;"name="userGender">
		                       		 -->
		                     </div>
	             		</div>
	                   <div class="box row">
		                     <div class="joinLabel">
		                        <label for="userName"><span>BIRTH</span></label>
		                     </div>
		                     <div class="box input">
		                     <span style="float: left;vertical-align: middle;">
		                  		<input readonly="readonly"  maxlength="4" style="width: 100px;" type="text" 
		                  		name="userBirth" class="inputStyle"  value="${dto.userBirth[0]} 년 ${dto.userBirth[1]} 월 ${dto.userBirth[2]} 일 " />
		                  		<%-- <input readonly="readonly" maxlength="4" style="width: 50px;" type="text" 
		                  		name="userBirth" class="inputStyle"  value="${dto.userBirth[1]}" /><a>월</a>
			                	<input readonly="readonly"  maxlength="4" style="width: 50px;" type="text" 
		                  		name="userBirth" class="inputStyle"  value="${dto.userBirth[2]} + ${dto.userBirth[0]}" /><a>일</a> --%>
			                 </span>
			                 
			                 
			                 
			            <!--      <span style="float: left;vertical-align: middle;">
			    
			                 
			                 
			                 
			                   
							</span> -->
							<!-- <span style="float: left;vertical-align: middle;padding-left: 20px;">
								<input maxlength="2" style="width: 50px;margin-bottom: 5px;font-style: italic;" type="text" name="userBirth" id="userBirth" placeholder="일"/> 
	                    	</span> -->
		                    </div>
	             		</div>

						<div class="box row" style="height: 110px;">
							<div class="joinLabel" style="height: 80px;">
								<label style="" for="userAddress"><span>ADDRESS</span><br><a>(선택가능)</a></label>
							</div>
							<div class="box input"
								style="margin-top: 10px; margin-bottom: 15px; height: 80px;">
								<div style="padding-bottom: 8px;">
									<input maxlength="6" type="text" name="userAddr" id="sample6_postcode"
									style="float: left; padding-right: 0; padding-bottom:10pt; display: block;vertical-align: middle;font-size: 9pt;"
									class="input-2" placeholder="우편번호" value="${dto.userAddr[0] }">
									<input class="join_button" type="button" onclick="sample6_execDaumPostcode()"
									style="display: block;vertical-align: middle; height: 15pt;font-size: 9pt;float: left;line-height: 4px;" value="우편번호 찾기">
								</div>
								<div class="box input" style="display:block; padding-bottom: 15px;">
									<input type="text" name="userAddr" id="sample6_address" placeholder="주소" style="padding-bottom:8pt;font-size: 9pt;" value="${dto.userAddr[1] }">
								</div>
								<div class="box input"
									style="display: block; padding-bottom: 15px;">
									<input type="text" name="userAddr" id="sample6_detailAddress" placeholder="상세주소" style="padding-bottom: 8pt;font-size: 9pt;" value="${dto.userAddr[2] }">

									<div class="box input">
										<input type="text" maxlength="50" name="userAddr" id="sample6_extraAddress" placeholder="참고항목" value="${dto.userAddr[3] }">
									</div>
								</div>
							</div>
						</div>
					</div>
	                <div class="box row">
	                     <div class="joinLabel">
	                        <label for="userTel"><span>TEL</span><a>(선택가능)</a></label>
	                     </div>
	                     <div class="box input">
	                        <input onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="11" type="text" name="userTel" id="userTel" 
	                        placeholder="(-)없이 숫자만 입력해주세요." value="${dto.userTel }"/>
	                     </div>
	                  </div>
	                  <div class="box row">
	                     <div class="joinLabel">
	                        <label for="userEmail"><span>E-MAIL</span><a>(선택가능)</a></label>
	                     </div>
	                     <div class="box input">
	                        <input type="text" name="userEmail" id="userEmail" placeholder="이메일 (선택사항)" value="${dto.userEmail }"/>
	                     </div>
	                  </div>
	                </div>
	                </form>
	            </div>

	<div align="center">
	
	
		<button
			style="cursor: pointer; border: 1px solid #BDBDBD; background-color: #FFFFFF; width: 200px; line-height: 48px;"
			type="button" onclick="javascript:history.back();"
			onmouseover=this.style.backgroundColor='#F0F0F0' onmouseout=this.style.backgroundColor='white'>
			<a style="font-size: 8px; color: #484848;">BACK</a>
		</button>

		<button
			style="cursor: pointer; border: 1px solid #BDBDBD; background-color: #FFFFFF; width: 200px; line-height: 48px;"
			type="button" onclick="sendIt();"
			onmouseover=this.style.backgroundColor='#F0F0F0' onmouseout=this.style.backgroundColor='white'>
			<a style="font-size: 8px; color: #484848;">완료</a>
		</button>
		
		<button
			style="cursor: pointer; border: 1px solid #BDBDBD; background-color: #FFFFFF; width: 200px; line-height: 48px;"
			type="button" onclick="javascript:location.href='<%=cp%>/shop/member/delete.do';"
			onmouseover=this.style.backgroundColor='#F0F0F0' onmouseout=this.style.backgroundColor='white'>
			<a style="font-size: 8px; color: #484848;">회원탈퇴</a>
		</button>

	
		<!-- 	<button
			style="cursor: pointer; border: 0.5; background-color: white; width: 200px; height: 50px;"
			type="button" onclick="javascript:history.back();"
			onmouseover=this.style.backgroundColor=
			'#F0F0F0' onmouseout=this.style.backgroundColor='white'>
			<b style="font-size: 17px; color: black;">뒤로가기</b>
		</button> -->
		<!-- &nbsp;&nbsp; -->
	<%-- 	<button
			style="cursor: pointer; background-color: black; width: 200px; height: 50px;"
			type="button" onclick="sendIt();"
			onmouseover=this.style.backgroundColor=
			'#6E6E6E' onmouseout=this.style.backgroundColor='black'>
			<b style="font-size: 17px; color: white;">수정완료</b>
		</button>
	</div>
	<br>
	<div class="box input">
		<button
			style="cursor: pointer; border: 0.5; background-color: white; width: 100px; height: 25px;"
			type="button"
			onclick="javascript:location.href='<%=cp%>/shop/member/delete.do';"
			onmouseover=this.style.backgroundColor=
			'#F0F0F0' onmouseout=this.style.backgroundColor='white'>
			<b style="font-size: 13px; color: black;">회원탈퇴</b>
		</button>
	</div>
 --%>











</div>
	

<jsp:include page="../main/footer.jsp"/>
</body>
</html>