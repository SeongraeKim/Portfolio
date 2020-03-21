<%@page import="gboard.GBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="gboard.GBoardDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = (String) session.getAttribute("id");
	//한글처리
	request.setCharacterEncoding("UTF-8");
	// notice.jsp에서 요청받아 넘어온 num, pageNum 값 변수에 저장
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	GBoardDAO dao = new GBoardDAO();
	GBoardDTO dto = dao.getGBoard(num);
	
	// 하나의 글 정보를 가져온 dto 객체를 호출해 변수에 값 저장
	int DBnum = dto.getNum();
	int DBreadcount = dto.getReadcount();
	String DBname = dto.getName();
	Timestamp DBdate = dto.getDate();
	String DBsubject = dto.getSubject();
	String DBcontent = "";
	
	if(dto.getContent() != null){
		
		DBcontent = dto.getContent().replace("\r\n", "<br>");
	}
%>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>갤러리 상세보기</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		<!-- JQuery CDN 연동 -->
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		
		<script type="text/javascript">
			function gcontent_update() {
				document.fr.action = "gupdate.jsp#wrap";
				fr.submit();
			}
			function gcontent_delete() {
				document.fr.action = "gdelete.jsp#wrap";
				fr.submit();
			}
		</script>
		
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->		
		
	<%
		dao.updateReadCount(num);
		dto = dao.getGBoard(num);
	%>
		<!-- 글상세보기 -->
		<div class="m-5">
			<h2 align="left">갤러리 상세보기</h2>
			<form method="post" name="fr">
							
				<input type="hidden" name="num" value="<%=DBnum%>">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				
				<table class="table table-bordered">
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
						<th class="table-dark text-center align-middle">글제목</th>
						<td colspan="9"><input type="text" name="subject" value="<%=DBsubject %>" class="form-control" readonly></td>
					</tr>
					<tr>
						<th class="table-dark text-center align-middle">첨부파일</th>
						<%
							if(dto.getFile() == null){
						%>
								<td colspan="5" align="left">첨부파일이 존재하지 않습니다.</td>
						<%
							}else{
						%>
						
						<td colspan="9" align="left" name="file" id="file">
							<a href="download.jsp?path=upload&name=<%=dto.getFile() %>">
								<img src="../img/download.png"><%=dto.getFile() %>
							</a>
						</td>
						<%
							}
						%>
					</tr>
					<tr>
						<th class="table-dark text-center align-middle">글내용</th>
						<td colspan="9" align="center">
						<%
							if(dto.getFile() != null){
						%>
							<img width="30%" src="../upload/<%=dto.getFile()%>">
						<%
							}
						%>
							<textarea rows="10" class="form-control" readonly><%=DBcontent %></textarea>
						</td>
					</tr>
				</table>
			</form>
			
			<!-- 하단버튼 -->
			<div class="d-flex">
				<div class="mr-auto">
					<input type="button" value="글목록" class="btn btn-dark" onclick="location.href='gallery.jsp?pageNum=<%=pageNum%>'">
				</div>
	<%
					if(id != null){		// 로그인 했을 경우
						
						if(id.equals(DBname)){	
	%>
							<input type="button" value="수정하기" class="btn btn-dark mr-1" onclick="gcontent_update()">
							<input type="button" value="삭제하기" class="btn btn-dark" onclick="gcontent_delete()">
	<%
						}
					}
	%>
			</div>
		</div>
		<!-- 글상세보기 END -->
		<!-- Foooter -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- FoooterEND -->
	</body>
</html>










