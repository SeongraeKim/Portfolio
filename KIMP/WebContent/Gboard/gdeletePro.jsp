<%@page import="java.text.SimpleDateFormat"%>
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
	// 요청값 변수에 저장
	int num = Integer.parseInt(request.getParameter("num"));	// 삭제할 글번호 num변수에 저장
	String pageNum = request.getParameter("pageNum");			// 삭제할 글이 속한 페이지번호
	String passwd = request.getParameter("passwd");				// 입력한 비밀번호
%>

<%-- 액션태그를 이용해 request에서 꺼내온 값들을 BoardDTO 내의 변수에 저장 --%>
<jsp:useBean id="dto" class="gboard.GBoardDTO"/>
<jsp:setProperty property="*" name="dto"/>
<jsp:useBean id="dao" class="gboard.GBoardDAO"/>

<%
	int check = dao.deleteGBoard(num, passwd);

	if(check == 1){
%>
		<script>
			alert("삭제완료");
			location.href="gallery.jsp?pageNum=<%=pageNum%>";
		</script>
<%
	}else{
%>
		<script>
			alert("삭제실패!\n비밀번호가 일치하지 않습니다.");
			history.back();
		</script>
<%
	}
%>