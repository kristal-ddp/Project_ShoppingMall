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
		
		if(!f.userBirth.value){
			alert("생일을 입력해 주세요.");
			f.userBirth.focus();
			return;
		}
		
		if(!f.userTel.value){
			alert("전화번호를 입력해 주세요.");
			f.userTel.focus();
			return;
		}
		
		f.action = "<%=cp%>/shop/member/join_ok.do"
		f.submit();
		
		
		
	}

	function asdf() {
	
		window.open("/sub/member/idCheck.jsp","idcheck","width=500, height=300");
	
	}
	
	
	
</script>


</head>
<body>

<div id="bbs">
	<div id="bbs_title">
	회원가입
	</div>
	
	<form action="" method="post" name="myForm">
	<div id="bbsCreated">
	
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>아&nbsp;이&nbsp;디</dt>
				<dd>
				<input type="text" name="userId" size="35" maxlength="20" class="boxTF"/>
				<input type="button" value=" 중복확인 " name="checkId" onclick="asdf();"/>
				</dd> 
			</dl>
			
		</div>

		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>패스워드</dt>
				<dd>
				<input type="password" name="userPwd" size="35" maxlength="20" class="boxTF"/>
				</dd> 
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</dt>
				<dd>
				<input type="text" name="userName" size="35" maxlength="20" class="boxTF"/>
				</dd> 
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;별</dt>
				<dd>
				<input type="text" name="userGender" size="35" maxlength="20" class="boxTF"/>
				</dd> 
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>생&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일</dt>
				<dd>
				<input type="text" name="userBirth" size="35" maxlength="20" class="boxTF"/>[YYYY-MM-DD]
				</dd> 
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</dt>
				<dd>
				<input type="text" name="userAddress" size="35" maxlength="20" class="boxTF"/>
				</dd> 
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이&nbsp;메&nbsp;일</dt>
				<dd>
				<input type="text" name="userEmail" size="35" maxlength="20" class="boxTF"/>
				</dd> 
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>전&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;화</dt>
				<dd>
				<input type="text" name="userTel" size="35" maxlength="20" class="boxTF"/>
				</dd> 
			</dl>
		</div>

	</div>
	
	<div id="bbsCreated_footer">
		<input type="button" value=" 가입하기 " class="btn2" onclick="sendIt();"/> 
		<input type="reset" value=" 회원정보수정 " class="btn2" onclick="location.href='<%=cp%>/shop/member/update.do';"/> 
		<input type="button" value=" 가입취소 " class="btn2" onclick="location.href='<%=cp%>';"/> 
		
	
	</div>
	
	
	</form>
	
</div>

</body>
</html>