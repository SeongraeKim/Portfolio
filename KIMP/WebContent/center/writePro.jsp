<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
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
%>

<%-- 액션태그를 이용해 request에서 꺼내온 값들을 BoardDTO 내의 변수에 저장 --%>
<jsp:useBean id="dto" class="board.BoardDTO"/>
<jsp:setProperty property="*" name="dto"/>
<jsp:useBean id="dao" class="board.BoardDAO"/>

<%
	//작성한 시간 BoardDTO에 저장
	dto.setDate(new Timestamp(System.currentTimeMillis()));
	//작성한 IP주소 BoardDTO에 저장
	dto.setIp(request.getRemoteAddr());

	// write.jsp에서 입력한 passwd값 passwd 변수에 저장
	String passwd = (String) request.getParameter("passwd");
	
	if(passwd != ""){	// 비밀번호를 입력했을 경우
		
		dao.insertBoard(dto);
 		response.sendRedirect("notice.jsp");
		
	}else{				// 비밀번호를 입력하지 않았을 경우
		
%>
	<script>
		alert("비밀번호를 입력해주세요.");
		history.back();
	</script>
<%
	}
%>