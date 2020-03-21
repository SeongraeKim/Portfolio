<%@page import="java.sql.Timestamp"%>
<%@page import="gboard.GBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="gboard.GBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = (String) session.getAttribute("id");
	//한글처리
	request.setCharacterEncoding("UTF-8");
	// notice.jsp에서 요청받아 넘어온 num, pageNum 값 변수에 저장
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// GBoardDAO객체를 생성해서 게시글 정보 가져오기
	GBoardDAO dao = new GBoardDAO();
	GBoardDTO dto = dao.getGBoard(num);
	
	// 하나의 글 정보를 가져온 dto 객체를 호출해 변수에 값 저장
	int DBnum = dto.getNum();
	int DBreadcount = dto.getReadcount();
	Timestamp DBdate = dto.getDate();
	String DBname = dto.getName();
	String DBsubject = dto.getSubject();
	String DBpasswd = dto.getPasswd();
	String DBcontent = "";
	
	if(dto.getContent() != null){
		
		DBcontent = dto.getContent().replace("\r\n", "<br>");
	}
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		
		<style type="text/css">
			#wrap{height: auto;}
		</style>
		
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		<!-- 갤러리 삭제 -->
		<div class="m-5">
			<h2 align="left">갤러리 삭제</h2>
			<form action="gdeletePro.jsp" method="post" name="fr">
							
				<input type="hidden" name="num" value="<%=DBnum%>">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				
				<table class="table table-bordered mt-4">
					<tr>
						<th class="table-dark text-center align-middle">번호</th>
						<td><input class="form-control" value="<%=DBnum %>" readonly></td>
						<th class="table-dark text-center align-middle">작성자</th>
						<td><input class="form-control" value="<%=DBname %>" readonly></td>
						<th class="table-dark text-center align-middle">작성일</th>
						<td><input class="form-control" value="<%=new SimpleDateFormat("yyyy.MM.dd").format(DBdate) %>" readonly></td>
						<th class="table-dark text-center align-middle">IP</th>
						<td><input class="form-control" value="<%=dto.getIp() %>" readonly></td>
						<th class="table-dark text-center align-middle">조회수</th>
						<td><input class="form-control" value="<%=DBreadcount %>" readonly></td>
					</tr>
					<tr>
						<th class="table-dark text-center align-middle">첨부파일</th>
						<td colspan="9" align="left">
							<a href="download.jsp?path=upload&name=<%=dto.getFile() %>">
								<img src="../img/download.png"><%=dto.getFile() %>
							</a>
						</td>
					</tr>
					<tr align="center">
						<th class="table-dark text-center align-middle">글내용</th>
						<td colspan="9">
							<img width="30%" src="../upload/<%=dto.getFile()%>">
							<textarea rows="10" class="form-control" readonly><%=DBcontent %></textarea>
						</td>
					</tr>
				</table>			
				<!-- 하단버튼 -->
				<div class="d-flex">
					<div class="mr-auto">
						<input type="button" value="글목록" class="btn btn-dark" onclick="location.href='gallery.jsp?pageNum=<%=pageNum%>'">
					</div>
	<%
						if(id != null){		// 로그인 했을 경우
	%>
							<div>
								<input type="password" name="passwd" class="form-control" placeholder="비밀번호를 입력하세요.">
							</div>
							<div class="ml-1">
								<input type="submit" value="삭제" class="btn btn-dark">
							</div>
							<div class="ml-1">
								<input type="button" value="취소" class="btn btn-dark" onclick="history.back()">
							</div>
	<%
						}
	%>
				</div>
			</form>
		</div>
		<!-- 갤러리 삭제 END -->
		<!-- Foooter -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- FoooterEND -->
	</body>
</html>