<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>로그인 페이지</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		<!-- 로그인 -->
		<div class="container d-flex" style="height: 550px;">
			<div class="row align-self-content-center m-auto p-5 mb-5 border rounded shadow">
				<form action="loginPro.jsp" method="post">
					<h2 class="mb-4" align="left">회원 로그인 </h2>
					<div class="container">
						<div class="row mb-3">
							<div class="col">
								
								<!-- 아이디 -->		
								<div class="input-group input-group-lg mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text">
											<img src="../img/person-outline.png" width="20px" height="20px">
										</span>
									</div>
									<input type="text" name="id" class="form-control" placeholder="아이디">
								</div>
								
								<!-- 비밀번호 -->
								<div class="input-group input-group-lg">
									<div class="input-group-prepend">
										<span class="input-group-text">
											<img src="../img/lock-outline.png" width="20px" height="20px">
										</span>
									</div>
									<input type="password" name="passwd" class="form-control" placeholder="비밀번호">
								</div>
							</div>
							
							<!-- 버튼 -->
							<input type="submit" value="로그인" class="btn-lg btn-dark">
						</div>
						<input type="button" onclick="location.href='../member/join.jsp'" value="회원가입" class="btn btn-dark btn-block">
					</div>
				</form>
			</div>
		</div>
		<!-- 로그인 END -->
		<!-- Foooter -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- FoooterEND -->
	</body>
</html>