<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberDAO dao = new MemberDAO();
	ArrayList list = dao.listMembers();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		<!-- 회원관리 -->
		<div class="m-5">
			<h2 align="left">회원관리</h2>
			<table class="table table-striped table-bordered border-dark">
				<tr class="thead-dark" align="center">
					<th>아이디</th>
					<th>비밀번호</th>
					<th>이름</th>
					<th>우편번호</th>
					<th>주소</th>
					<th>상세주소</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>등록일</th>
					<th>관리</th>
				</tr>
			<%
				if(list.size() == 0){	// 회원정보가 없다면
			%>
					<tr>
						<td colspan="7">등록된 회원이 없습니다.</td>
					</tr>
			<%				
				}else{
					for(int i=0;i<list.size();i++){
						
						MemberDTO dto = (MemberDTO)list.get(i);
			%>
					<tr>
						<td align="center"><%=dto.getId() %></td>
						<td align="center"><%=dto.getPasswd() %></td>
						<td align="center"><%=dto.getName() %></td>
						<td align="center"><%=dto.getPostcode() %></td>
						<td align="left"><%=dto.getAddress() %></td>
						<td align="left"><%=dto.getAddress2() %></td>
						<td align="center"><%=dto.getTel() %></td>
						<td align="center"><%=dto.getEmail() %></td>
						<td align="center"><%=dto.getReg_date() %></td>
						<td align="center">
							<a href="#"><img alt="수정" src="../img/edit.png"></a>　
							<a href="#"><img alt="삭제" src="../img/delete.png"></a>
						</td>
					</tr>
			<%
					}
				}
			%>
			</table>
		</div>
		<!-- 회원관리 END -->
		<!-- Foooter -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- FoooterEND -->
	</body>
</html>