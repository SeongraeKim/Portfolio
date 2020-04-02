<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 아이콘 -->
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<!-- 구글폰트 적용 -->
<link href="https://fonts.googleapis.com/css?family=Stylish&display=swap" rel="stylesheet">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<style>
	* {font-family: 'Stylish', sans-serif;}
</style>

<!-- Header -->
<!-- 로고 -->
<div class="navbar d-flex justify-content-center navbar-light bg-light">
	<a class="navbar-brand p-3" href="../index.jsp">
		<i class='fas fa-mug-hot' style='font-size:60px'></i>
	</a>
</div>
<!-- 로고END -->
<!-- 메뉴 -->
<div class="navbar navbar-expand sticky-top navbar-dark bg-dark">
    <div class="navbar-nav">
        <ul class="navbar-nav" style="font-size: 20px;">
            <li class="nav-item">
                <a class="nav-link" href="../index.jsp">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="../cafe/cafe_center.jsp">Map</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="../center/notice.jsp">Notice</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="../Gboard/gallery.jsp">Gallery</a>
            </li>
            <!-- <li class="nav-item">
                <a class="nav-link" href="#">Help</a>
            </li> -->
        </ul>
    </div>
    <!-- 메뉴END -->
    <!-- 회원정보 -->
	<div class="navbar-nav ml-auto">
		<ul class="navbar-nav" style="font-size: 15px;">
	<%
    	String id = (String)session.getAttribute("id");
    	
		if(id == null){
  		%>

			<li class="nav-item">
				<a class="nav-link" href="../member/login.jsp">로그인</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="../member/join.jsp?#wrap">회원가입</a>
			</li>
	<%
			}else{
				if(id.equals("admin")){
	%>
					<li><span class="navbar-text text-light">관리자 님 환영합니다</span></li>
					<li class="nav-item">
						<a class="nav-link" href="../member/memberInfo.jsp">회원관리</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="../member/logout.jsp">로그아웃</a>
					</li>
	<%
				}else{
	%>
					<li><span class="navbar-text text-light"><%=id %> 님 환영합니다</span></li>
					<li class="nav-item">
						<a class="nav-link" href="../member/pwCheck.jsp">내정보수정</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="../member/logout.jsp">로그아웃</a>
					</li>
		
	<%
				}
			}
	%>
		</ul>
    </div>
</div>
<!-- 회원정보END -->
<!-- HeaderEND -->