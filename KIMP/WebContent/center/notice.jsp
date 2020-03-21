<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>게시판</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		<!-- 아이콘 설정 -->
		<script src='https://kit.fontawesome.com/a076d05399.js'></script>
		<!-- JQuery CDN 연동 -->
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		
		<style type="text/css">
			#page_control{display: flex; justify-content: center; margin-top: 200px;}
			#page_control a{color: black;}
		</style>
		
		<script type="text/javascript">
		
			$(function() {
				$('#searchBtn').click(function() {

					alert("클릭완료!");
					$.ajax({
						type: 'post',
						async: true,
						url: "http://localhost:8090/KIMP/board",
						success: function(data, textStatus) {
							alert(data);
						}
						
					});
				});
			});
		</script>
		
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		
	<%
		BoardDAO dao = new BoardDAO();
		
		// 전체 글 개수 count에 저장
		int count = dao.getBoardCount();
		// 한 페이지 최대 글 개수 지정
		int pageSize = 5;
		// 페이지번호 클릭 시 클릭한 페이지번호 pageNum에 저장
		String pageNum = request.getParameter("pageNum");
		// 초기 페이지를 1페이지로 지정
		if(pageNum == null) pageNum = "1";
		// pageNum값을 정수로 변환해서 저장
		int currentPage = Integer.parseInt(pageNum);
		// 각 페이지마다 보여질 시작 글번호 ( (현재페이지 - 1) * 페이지당 보여줄 글 개수 5 )
		int startRow = (currentPage - 1) * pageSize;	
		// board테이블에서 검색한 글을 저장할 List인터페이스 타입의 변수 list 선언
		List<BoardDTO> list = null;
		// 글이 존재한다면
		if(count > 0){
			
			list = dao.getBoardlist(startRow, pageSize);
		}
	%>
		<!-- 게시판 -->
		<div class="m-5">
			<h2 align="left">게시판</h2>
			<h5 align="right">전체 글개수: <span class="badge badge-secondary"><%=count %></span></h5>
			<table id="notice" class="table table-hover table-bordered">
				<tr class="thead-dark" align="center">
					<th width="5%">번호</th>
					<th>제목</th>
					<th width="10%">작성자</th>
					<th width="10%">작성일</th>
					<th width="5%">조회수</th>
				</tr>
	<%
				if(count > 0){	// 게시글 존재
				
					for(int i=0; i<list.size(); i++){
						
						BoardDTO dto = list.get(i);
							
	%>
				<tr onclick="location.href='content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&wrap'">
					<td align="center"><%=dto.getNum() %></td>
					<td align="left">
	<%
						int wid = 0;	// 답글 들여쓰기값
						
						if(dto.getRe_lev() > 0){
						
							wid = dto.getRe_lev() * 10;
	%>
						<img src="../img/level.gif" width="<%=wid%>" height="15">
						<img src="../img/re.png">
	<%	
						}
	%>
						<%=dto.getSubject() %>
					</td>
					<td align="center"><%=dto.getName() %></td>
					<td align="center"><%=new SimpleDateFormat("yyyy.MM.dd").format(dto.getDate()) %></td>
					<td align="center"><%=dto.getReadcount() %></td>
				</tr>
	<%
					}
					
				}else{			// 게시글 없음
	%>
				<tr>
					<td colspan="5">게시글이 존재하지 않습니다.</td>
				</tr>
	<%			
				}
	%>
			</table>
	<%
		String id = (String) session.getAttribute("id");
	
		if(id != null){
	%>
			<!-- 글쓰기 및 검색 -->
			<div class="form-row justify-content-end">
				<div class="form-row">
					<div class="col-3">
						<input type="button" value="글쓰기" class="btn btn-dark mr-3" onclick="location.href='write.jsp'">
					</div>
				</div>
			</div>
	<%		
		}
	%>				
			<!-- 페이지 번호 -->
			<ul id="page_control" class="pagination">
	<%
				if(count > 0){
					// 전체 페이지수 = 전체글 / 한 페이지에 보여줄 글수 + 전체글수를 pageSize로 나눈 나머지
					int pageCount = count / pageSize + (count % pageSize == 0?0:1);
					// 한 화면에 보여질 페이지수
					int pageBlock = 3;
					// 시작페이지 번호 구하기
					int startPage = ((currentPage / pageBlock) - (currentPage % pageBlock == 0?1:0)) * pageBlock + 1;
					// 끝페이지 번호 구하기
					int endPage = startPage + pageBlock - 1;
					// 끝페이지 번호가 전체페이지수보다 크면 끝페이지를 전체페이지수로 저장
					if(endPage > pageCount) endPage = pageCount;
					
					// (<) 시작페이지가 pageBlock보다 클 경우
					if(startPage > pageBlock){
	%>
				<li class="page-item"><a class="page-link" href="notice.jsp?pageNum=<%=startPage - pageBlock%>&#wrap">
					<i class='fas fa-angle-left' style='font-size:20px'></i>
				</a></li>
	<%
					}
					for(int i=startPage; i<=endPage; i++){
	%>
				<li class="page-item"><a class="page-link" href="notice.jsp?pageNum=<%=i%>&#wrap"><%=i %></a></li>
	<%
					}
					if(endPage < pageCount){
	%>
				<li class="page-item"><a class="page-link" href="notice.jsp?pageNum=<%=startPage + pageBlock%>&#wrap">
					<i class='fas fa-angle-right' style='font-size:20px'></i>
				</a></li>
	<%
					}
				}
	%>
			</ul>
			<!-- 페이지 번호 END -->
		</div>
		<!-- 게시판 END -->
		<!-- Foooter -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- FoooterEND -->
	</body>
</html>















