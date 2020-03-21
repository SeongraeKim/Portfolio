<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		
<%
	String id = (String)session.getAttribute("id");	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>비밀번호 재확인</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		<!-- 비밀번호 확인 -->
		<div class="container d-flex" style="height: 550px;">
			<div class="row align-self-content-center m-auto p-5 mb-5 border rounded shadow">
				<div>
					<h2 align="left">비밀번호 재확인</h2>
					<p>본인확인을 위해 비밀번호를 다시 입력해주세요.</p>
					
					<form action="pwCheckPro.jsp" method="post">
						<div class="row mb-3">
							<div class="col">
							
								<!-- 아이디 -->		
								<div class="input-group input-group-lg mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text">
											<img src="../img/person-outline.png" width="20px" height="20px">
										</span>
									</div>
									<input type="text" name="id" class="form-control" value="<%=id %>" readonly>
								</div>
								
								<!-- 비밀번호 -->
								<div class="input-group input-group-lg">
									<div class="input-group-prepend">
										<span class="input-group-text">
											<img src="../img/lock-outline.png" width="20px" height="20px">
										</span>
									</div>
									<input type="text" name="passwd" class="form-control" >
								</div>
							</div>
						</div>	
						<input type="submit" value="확인" class="btn-lg btn-dark btn-block">
					</form>
				</div>
			</div>
		</div>
		<!-- 비밀번호 확인 END -->
		<!-- Foooter -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- FoooterEND -->
	</body>
</html>