<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// UTF-8 설정
	request.setCharacterEncoding("UTF-8");
	// join.jsp에서 입력한 값 변수에 저장
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String postcode = request.getParameter("postcode");
	String address = request.getParameter("address");
	String address2 = request.getParameter("address2");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	
	Timestamp time = new Timestamp(System.currentTimeMillis());
	
	// MemberBean객체 생성해서 변수값 저장
	MemberDTO dto = new MemberDTO();
	dto.setId(id);
	dto.setPasswd(passwd);
	dto.setName(name);
	dto.setEmail(email);
	dto.setPostcode(postcode);
	dto.setAddress(address);
	dto.setAddress2(address2);
	dto.setTel(tel);
	dto.setReg_date(time);
	
	// MemberDAO를 통해서 DB에 INSERT
	MemberDAO memberdao = new MemberDAO();
	memberdao.insertMember(dto);

	// 로그인 화면(login.jsp)으로 이동
	response.sendRedirect("../index.jsp");

%>