<%@page import="gboard.GBoardDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>갤러리 게시판</title>

<!-- 기본 css 설정 -->
<link href="../css/style.css?ver=1" rel="stylesheet">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<!-- 아이콘 -->
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<!-- JQuery CDN 연동 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style type="text/css">
	#g_wrap{ width: 1100px; height: 860px;}
	#g_wrap div{
		width: 210px; height: 240px;
		border: 1px solid; margin: 20px; 
		display: inline-block;
		border-radius: 20px; box-shadow: 5px 5px 5px black;}
	#wrap img{margin:3px; width: 200px; height: 200px; border-radius: 20px; overflow: hidden;}
	#page_control{display: flex; justify-content: center; margin-top: 30px;}
	#page_control a{color: black;}
	#page_control a img{width: 50%; height: 60%;}
	
</style>

</head>
<body>
	<!-- Header -->
	<jsp:include page="../inc/top.jsp" />
	<!-- Header END -->
	
<jsp:useBean id="dao" class="gboard.GBoardDAO"/>
<jsp:useBean id="dto" class="gboard.GBoardDTO"/>

<%
	// 전체 글 개수 count에 저장
	int count = dao.getGBoardCount();
	//한 페이지 최대 글 개수 지정
	int pageSize = 12;
	// 페이지번호 클릭 시 클릭한 페이지번호 pageNum에 저장
	String pageNum = request.getParameter("pageNum");
	// 초기 페이지를 1페이지로 지정
	if(pageNum == null) pageNum = "1";
	// pageNum값을 정수로 변환해서 저장
	int currentPage = Integer.parseInt(pageNum);
	// 각 페이지마다 보여질 시작 글번호 ( (현재페이지 - 1) * 페이지당 보여줄 글 개수 5 )
	int startRow = (currentPage - 1) * pageSize;	
	// board테이블에서 검색한 글을 저장할 List인터페이스 타입의 변수 list 선언
	List<GBoardDTO> list = null;
	// 글이 존재한다면
	if(count > 0){
		
		list = dao.getGBoardlist(startRow, pageSize);
	}
%>
	
	<!-- 갤러리 게시판 -->
	<div class="m-5">
		<h2 align="left">갤러리</h2>
		<h5 align="right">전체 글개수: <span class="badge badge-secondary"><%=count %></span></h5>
		<div>
			<div class="row">
<% 
			if(count > 0){	// 갤러리 글이 존재하면
				
				for(int i=0; i<list.size(); i++){
					
					dto = list.get(i);
%>
				<div class="col-md-3">
					<div class="card mb-4 shadow-sm">
					    <a href="gcontent.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&wrap">
					    	<img src="../upload/<%=dto.getFile()%>" width="100%" height="200px" onerror="this.src='../img/document-richtext.svg'">
				    	</a>
					    <div class="card-body">
							<a href="#" class="text-dark"><p class="card-text text-truncate"><%=dto.getSubject() %></p></a>
							<div class="d-flex justify-content-between align-items-center">
						        <small class="text-muted"><i class='far fa-calendar-alt'></i> <%= new SimpleDateFormat("yyyy.MM.dd").format(dto.getDate()) %></small>
						        <small class="text-muted"><i class='fas fa-eye'></i> <%=count %></small>
							</div>
						</div>
					</div>
				</div>
<%
				}
			}
%>
			</div>
		</div>
	<%
		String id = (String) session.getAttribute("id");
		if(id != null){
	%>
		<!-- 글쓰기 버튼 -->
		<div class="form-row justify-content-end mt-3">
			<div class="form-row">
				<input type="button" value="글쓰기" class="btn btn-dark mr-3" onclick="location.href='gwrite.jsp'">
			</div>
		</div>		
	<%		
		}
	%>			
		<!-- 페이지 번호 -->
		<div id="page_control" class="pagination">
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
					<a class="page-link" href="gallery.jsp?pageNum=<%=startPage - pageBlock%>&#wrap">
						<i class='fas fa-angle-left' style='font-size:20px'></i>
					</a>
	<%
				}
				for(int i=startPage; i<=endPage; i++){
	%>
					<a class="page-link" href="gallery.jsp?pageNum=<%=i%>&#wrap"><%=i %></a>
	<%
				}
				if(endPage < pageCount){
	%>
					<a class="page-link" href="gallery.jsp?pageNum=<%=startPage + pageBlock%>&#wrap">
						<i class='fas fa-angle-right' style='font-size:20px'></i>
					</a>
	<%
				}
			}
	%>
		</div>
	</div>
	<!-- 갤러리 게시판 END -->
	<!-- Foooter -->
	<jsp:include page="../inc/footer.jsp"/>
	<!-- FoooterEND -->
</body>
</html>














