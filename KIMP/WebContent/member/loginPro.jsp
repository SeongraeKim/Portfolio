<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	MemberDAO dao = new MemberDAO();
	
	int check = dao.userCheck(id, passwd);
	
	if(check == 1){			// 아이디 일치,	비밀번호 일치	

		session.setAttribute("id", id);
		response.sendRedirect("../index.jsp");
		
	}else if(check == 0){	// 아이디 일치,	비밀번호 불일치	
%>
		<script>
			alert("비밀번호가 일치하지 않습니다!");
			history.back();
		</script>
<%		
	}else{					// 아이디 불일치	
%>
		<script>
			alert("아이디가 존재하지 않습니다!");
			history.back();
		</script>
<%	
	}
%>