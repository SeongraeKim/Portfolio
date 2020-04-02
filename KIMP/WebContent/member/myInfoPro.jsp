<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>
<jsp:useBean id="dao" class="member.MemberDAO"/>

<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	String passwd = (String) request.getParameter("passwd");
	String passwd2 = (String) request.getParameter("passwd2");

	dao.updateMember(dto);
%>

<script>
	alert("수정완료");
	history.go(-3);
</script>