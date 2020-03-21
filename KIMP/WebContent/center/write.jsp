<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = (String) session.getAttribute("id");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>글쓰기</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		<!-- 게시글 작성 -->
		<div class="m-5">
			<h2 align="left">게시글 작성</h2>
			<form action="writePro.jsp" method="post" class="m-3">

				<table class="table table-bordered mt-4">
					<tr>
						<th class="table-dark text-center align-middle">제목</th>
						<td width="50%"><input type="text" name="subject" class="form-control"></td>
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
				
				<!-- 하단버튼(글목록, 작성완료, 작성취소) -->
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
		<!-- 게시글 작성 END -->
		<!-- Footer -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- Footer END -->
	</body>
</html>













