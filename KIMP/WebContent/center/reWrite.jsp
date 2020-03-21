<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>답글 작성</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		
		<style type="text/css">
			#wrap{height: 100%;}
		</style>
		
<%
	String id = (String)session.getAttribute("id");

	// 로그아웃 상태일 경우 로그인페이지로 이동
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	// 한글처리
	request.setCharacterEncoding("UTF-8");

	// 넘어온 값들 변수에 저장
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));	// 페이지 번호
	int num =  Integer.parseInt(request.getParameter("num")); 			// 주글번호
	int re_ref = Integer.parseInt(request.getParameter("re_ref"));		// 주글그룹값
	int re_lev = Integer.parseInt(request.getParameter("re_lev"));		// 주글 들여쓰기 정도값
	int re_seq = Integer.parseInt(request.getParameter("re_seq"));		// 주글 순서
%>
		
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		<!-- 답글 작성 -->
		<div class="m-5">
			<h2 align="left">답글 작성</h2>
			
			<form action="rewritePro.jsp" method="post" class="m-3">
			
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				<input type="hidden" name="num" value="<%=num %>">
				<input type="hidden" name="re_ref" value="<%=re_ref %>">
				<input type="hidden" name="re_lev" value="<%=re_lev %>">
				<input type="hidden" name="re_seq" value="<%=re_seq %>">
			
				<table class="table table-bordered mt-4">
					<tr>
						<th class="table-dark text-center align-middle">제목</th>
						<td width="50%"><input type="text" name="subject" value="[답글] " class="form-control"></td>
						<th class="table-dark text-center align-middle">작성자</th>
						<td>
							<input type="text" name="name" class="form-control" value="<%=id%>" readonly>
						</td>
						<th class="table-dark text-center align-middle">비밀번호</th>
						<td><input type="password" name="passwd" class="form-control"></td>
					</tr>
					<tr>
						<th class="table-dark text-center align-middle">내용</th>
						<td colspan="7"><textarea name="content" class="form-control" rows="13" cols="10"></textarea></td>
					</tr>
				</table>
				
				<!-- 하단버튼 -->
				<div class="d-flex">
					<div class="mr-auto">
						<input type="button" value="글목록" class="btn btn-dark" onclick="location.href='notice.jsp?#wrap'">
					</div>
					<div class="mr-1">
						<input type="submit" value="작성완료" class="btn btn-dark">
					</div>
					<div>
						<input type="button" value="취소" class="btn btn-dark" onclick="history.back()">
					</div>
				</div>
			</form>
		</div>
		<!-- 답글 작성 END -->
		<!-- Footer -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- Footer END -->
	</body>
</html>