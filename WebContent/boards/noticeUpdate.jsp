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
<title>게 시 판</title>

<link rel="stylesheet" type="text/css"href="<%=cp%>/css/shopStyle.css" />
<link rel="stylesheet" type="text/css"href="<%=cp%>/boards/css/writeStyle.css" />

<script type="text/javascript" src="<%=cp%>/boards/js/util.js"></script>
<script type="text/javascript">

	function sendIt(){
		
		var f = document.myForm;
		
		str = f.subject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.subject.focus();
			return;
		}
		f.subject.value = str;
		
		f.action = "<%=cp%>/shop/boards/noticeUpdate_ok.do";
		f.submit();
		
	}

</script>

</head>
<body>
	<jsp:include page="../main/header.jsp"/>
		<div id="content" align="center">
			<form action="" method="post" name="myForm">
				<div style="display: inline-block; margin: auto;" align="left">
					<div class="box row" style="margin: 0px; border-top: 1px solid #DBDBDB;">
						<div class="box label"><label for="subject">SUBJECT</label></div>
						<div class="box input"><input type="text" name="subject" value="${dto.subject }"></div>
					</div>
					<div class="box row" style="margin: 0px;">
						<div class="box label"><label for="userId">ID</label></div>
						<div class="box text">${dto.userId }</div>
					</div>
					<div class="box row">
						<label for="userId">CONTENT</label><br/>
						<div class="box input">
							<textarea rows="" cols="">${dto.content }</textarea>
						</div>
					</div>
					<div class="box row" align="center">
						<div style="border: 1px solid; width: 50px; padding: 5px; float: left; margin-left: 30px;">
							<a href="<%=cp %>/shop/boards/notice.do">목록</a>
						</div>
						<div style="border: 1px solid; width: 50px; padding: 5px; float: right; margin-right: 30px;">
							<a href="<%=cp %>/shop/boards/noticeView.do?boardNum?=${dto.boardNum }">취소</a>
						</div>
						<div style="border: 1px solid; width: 50px; padding: 5px; float: right; margin-right: 10px;">
							<a href="<%=cp %>/shop/boards/noticeWrite_ok.do">수정</a>
						</div>
					</div>
				</div>
			</form>
		</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>