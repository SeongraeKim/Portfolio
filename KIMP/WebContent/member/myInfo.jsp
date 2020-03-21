<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>내정보</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		<!-- JQuery CDN 연동 -->
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<!-- 주소검색을 위한 다음API CDN 연결 -->
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		
		<style type="text/css">
			#info_wrap{
				width: 600px; height: 600px;
				margin: 50px auto 30px;
				padding: 40px 40px 0;
				text-align: center;
				border: 1px solid;
				border-radius: 20px;
				box-shadow: 5px 5px 5px black;}
				
/* 			#passwd_check, #passwd2_check{margin-left: 140px;} */
		</style>
		
		<script type="text/javascript">
		
			// 비밀번호 정규식
			var pwJ = /^[A-Za-z0-9]{4,12}$/;
			
			$(function() {
				// 비밀번호 유효성 검사
				$('#passwd').blur(function() {
					if(pwJ.test($(this).val())){
						$('#passwd_check').text('');
						$('#passwd').attr('class', 'form-control is-valid');
					}else{
						$('#passwd_check').text('비밀번호 확인(4~12자의 영문,숫자 입력)');
						$('#passwd').attr('class', 'form-control is-invalid').focus();
					}
				});
				// 비밀번호 일치 확인
				$('#passwd2').blur(function() {
					if($('#passwd').val() == $(this).val()){
						$('#passwd2_check').text('');
						$('#passwd2').attr('class', 'form-control is-valid');
					}else{
						$('#passwd2_check').text('비밀번호가 일치하지 않습니다');
						$('#passwd2').attr('class', 'form-control is-invalid').focus();
					}
				});
			});
		
			// 다음API를 이용한 주소검색
		    function execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 도로명 주소를 roadAddr 변수에 저장
		                var roadAddr = data.address; // 도로명 주소 변수
		
		                // 우편번호와 주소 정보를 input태그에 넣는다.
		                document.getElementById('postcode').value = data.zonecode;
		                document.getElementById("address").value = roadAddr;
		            }
		        }).open();
		    }
		</script>
		
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		
	<%
		
		String id = (String)session.getAttribute("id");
	
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = dao.myInfo(id);
	%>
		<!-- 내정보 수정 -->
		<div id="info_wrap">
			<div class="d-flex">
				<h2 align="left">내정보 수정</h2>
				<span class="ml-auto mt-auto">가입일 <%=new SimpleDateFormat("yyyy.MM.dd").format(dto.getReg_date()) %></span>
			</div>
			
			<form action="myInfoPro.jsp" class="container mt-5">
			
				<!-- 아이디 -->
				<div class="row mt-3">
					<div class="col-4">아이디</div>
					<div class="col-7">
						<input type="text" name="id" value="<%=id %>" class="form-control" readonly>
					</div>
				</div>

				<!-- 변경할 비밀번호 -->
				<div class="row mt-3">
					<div class="col-4">새 비밀번호</div>
					<div class="col-7">
						<input type="password" id="passwd" name="passwd" value="" class="form-control">
					</div>
				</div>
				<div id="passwd_check" class="red" align="right"></div>
				
				<!-- 비밀번호 재확인 -->
				<div class="row mt-3">
					<div class="col-4">새 비밀번호 확인</div>
					<div class="col-7">
						<input type="password" id="passwd2" name="passwd2" class="form-control">
					</div>
				</div>
				<div id="passwd2_check" class="red" align="right"></div>
				
				<!-- 이름 -->
				<div class="row mt-3">
					<div class="col-4">이름</div>
					<div class="col-7">
						<input type="text" name="name" value="<%=dto.getName() %>" class="form-control" readonly>
					</div>
				</div>
				
				<!-- 주소 -->
				<div class="row mt-3">
					<div class="col-4">주소</div>
					<div class="col-7">
						<div class="form-row">
							<div class="col-4">
								<input type="text" class="form-control" id="postcode" name="postcode" value="<%=dto.getPostcode() %>" readonly>
							</div>
							<div class="col-4">
								<input type="button" value="주소검색" class="btn btn-dark" onclick="execDaumPostcode();">
							</div>
						</div>
					</div>
				</div>
				<div class="row mt-3">
					<div class="col-4"></div>
					<div class="col-7">
						<input type="text" class="form-control" id="address" name="address" value="<%=dto.getAddress() %>" readonly>
					</div>
				</div>
				<div class="row mt-3">
					<div class="col-4"></div>
					<div class="col-7">
						<input type="text" class="form-control" id="address2" name="address2" value="<%=dto.getAddress2() %>">
					</div>
				</div>
				
				<!-- 버튼 -->		
				<div class="mt-4">
					<input type="submit" value="수정완료" class="btn btn-dark">
					<input type="reset" value="수정취소" class="btn btn-dark" onclick="history.go(-2)">
				</div>
			</form>

		</div>
		<!-- 내정보 수정 END -->
		<!-- Foooter -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- FoooterEND -->
	</body>
</html>