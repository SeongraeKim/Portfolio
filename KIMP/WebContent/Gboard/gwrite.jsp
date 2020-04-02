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
		<!-- JQuery CDN 연동 -->
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		
		<script type="text/javascript">
			function readURL(input) {
				
				console.debug(input);
				console.debug(input.files);
				
				if(input.files && input.files[0]){
					
					$('#imgPreview').html("<img id='preview' src='#' width='30%'>");
					
					// 파일을 읽어올 객체 생성
					var reader = new FileReader();
					// 첨부한 파일에 대한 File객체를 읽음
					reader.readAsDataURL(input.files[0]);
					
					reader.onload = function(ProgressEvent) {
						
						console.debug(ProgressEvent);
						
						$('#preview').attr('src', ProgressEvent.target.result);
					}
					
				}
			}
		</script>
		
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		<!-- 게시글 작성 -->
		<div id="wrap">
			<h2 align="left">게시글 작성</h2>
			<form action="gwritePro.jsp" enctype="multipart/form-data" method="post" class="m-3">
				
				<table class="table table-bordered mt-4">
					<tr>
						<th width="25%" class="table-dark">작성자</th>
						<td width="25%">
							<input type="text" name="name" class="form-control" value="<%=id%>" readonly>
						</td>
						<th width="25%" class="table-dark">비밀번호</th>
						<td width="25%"><input type="password" name="passwd" class="form-control"></td>
					</tr>
					<tr>
						<th class="table-dark">제목</th>
						<td colspan="3"><input type="text" name="subject" class="form-control"></td>
					</tr>
					<tr>
						<th class="table-dark">첨부파일</th>
						<td colspan="5">
							<input type="file" name="file" onchange="readURL(this);">
						</td>
					</tr>
					<tr>
						<th class="table-dark">내용</th>
						<td colspan="3">
							<div id="imgPreview"></div>
							<textarea name="content" class="form-control" rows="13" cols="10"></textarea>
						</td>
					</tr>
				</table>
				
				<!-- 하단버튼(글목록, 작성완료, 작성취소) -->
				<div class="d-flex mt-4 mb-5">
					<div class="mr-auto">
						<input type="button" value="글목록" class="btn btn-dark" onclick="location.href='notice.jsp?#wrap'">
					</div>
					
					<div class="d-flex justify-content-end">
						<input type="submit" value="작성완료" class="btn btn-dark">
						<input type="reset" value="작성취소" class="btn btn-dark ml-2" onclick="history.back()">
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













