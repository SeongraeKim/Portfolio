<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = (String) session.getAttribute("id");
	String passwd = request.getParameter("passwd");
	
	//로그아웃된 상태면 로그인으로 이동
	if(id == null){ 
		response.sendRedirect("../member/login.jsp");
	}
	
	MemberDAO dao = new MemberDAO();
	int check = dao.userCheck(id, passwd);
	
	if(check == 1){		// 비밀번호 일치	

		response.sendRedirect("myInfo.jsp");
	
	}else{				// 비밀번호 불일치
%>
	<script>
		alert("비밀번호가 일치하지 않습니다!");
		history.back();
	</script>
<%	
	}
%>
