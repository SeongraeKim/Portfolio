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
	// 수정완료 후 돌아갈 페이지 번호 변수에 저장
	String pageNum = request.getParameter("pageNum");
%>

<%-- 액션태그를 이용해 request에서 꺼내온 값들을 BoardDTO 내의 변수에 저장 --%>
<jsp:useBean id="dto" class="board.BoardDTO"/>
<jsp:setProperty property="*" name="dto"/>
<jsp:useBean id="dao" class="board.BoardDAO"/>

<%
	int check = dao.updateBoard(dto);

	if(check == 1){
%>
		<script>
			alert("수정완료");
			location.href="notice.jsp?pageNum=<%=pageNum%>";
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