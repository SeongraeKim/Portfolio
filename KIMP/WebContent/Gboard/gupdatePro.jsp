<%@page import="gboard.GBoardDAO"%>
<%@page import="gboard.GBoardDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 세션에 저장된 id값 id변수에 저장
	String id = (String) session.getAttribute("id");
	//로그아웃된 상태면 로그인으로 이동
	if(id == null){ 
		response.sendRedirect("../member/login.jsp");
	}
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 업로드될 실제 서버 경로 얻기
	String realFolder = getServletContext().getRealPath("/upload");
	// 업로드 최대크기(10MB) 지정
	int max = 10 * 1024 * 1024;
	// 파일 업로드 처리
	MultipartRequest multi 
	= new MultipartRequest(request, realFolder, max, "UTF-8",
						new DefaultFileRenamePolicy());
	
	// 파일명 가져오기
	Enumeration e = multi.getFileNames();
		String fname = (String)e.nextElement();
	String file = multi.getFilesystemName(fname);
	
	
	GBoardDTO dto = new GBoardDTO();
	
	// 수정완료 후 돌아갈 페이지 번호 변수에 저장
	String pageNum = multi.getParameter("pageNum");

	// 수정할 게시글의 정보를 변수에 저장
	int num = Integer.parseInt(multi.getParameter("num"));
	String name = multi.getParameter("name");
	String passwd = multi.getParameter("passwd");
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content");
	
	// GBoardDTO에 저장
	dto.setNum(num);
	dto.setName(name);
	dto.setPasswd(passwd);
	dto.setSubject(subject);
	dto.setContent(content);
	dto.setFile(file);

	GBoardDAO dao = new GBoardDAO();
	// 갤러리 수정
	int check = dao.updateGBoard(dto);

	if(check == 1){
%>
		<script>
			alert("수정완료");
			location.href="gallery.jsp?pageNum=<%=pageNum%>";
		</script>
<%
	}else{
%>
		<script>
			alert("수정실패!\n비밀번호가 일치하지 않습니다.");
			history.back();
		</script>
<%
	}
%>