<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="gboard.GBoardDTO"%>
<%@page import="gboard.GBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	// 세션에 저장된 id값 id변수에 저장
	String id = (String) session.getAttribute("id");
	//로그아웃된 상태면 로그인으로 이동
	if(id == null){ 
		response.sendRedirect("../member/login.jsp");
	}

	// 업로드될 실제 서버 경로 얻기
	String realFolder = getServletContext().getRealPath("/upload");
	// 업로드 최대크기(10MB) 지정
	int max = 10 * 1024 * 1024;
	// 파일 업로드 처리
	MultipartRequest multi 
	= new MultipartRequest(request, realFolder, max, "UTF-8",
						new DefaultFileRenamePolicy());
	
	Enumeration e = multi.getFileNames();
	
	String fname = (String)e.nextElement();
	String file = multi.getFilesystemName(fname);
	
	
	GBoardDTO dto = new GBoardDTO();
	
	// 글작성 후 돌아갈 페이지 번호 변수에 저장
	String pageNum = multi.getParameter("pageNum");
	//작성한 시간 BoardDTO에 저장
	dto.setDate(new Timestamp(System.currentTimeMillis()));
	//작성한 IP주소 BoardDTO에 저장
	dto.setIp(request.getRemoteAddr());

	// 게시글의 정보를 변수에 저장
	String name = multi.getParameter("name");
	String passwd = multi.getParameter("passwd");
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content");
	// GBoardDTO에 저장
	dto.setName(name);
	dto.setPasswd(passwd);
	dto.setSubject(subject);
	dto.setContent(content);
	dto.setFile(file);

	GBoardDAO dao = new GBoardDAO();
	// 게시글 추가
	dao.insertGBoard(dto);
%>

<jsp:forward page="gallery.jsp"/>
