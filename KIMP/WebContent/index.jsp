<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>개인프로젝트</title>
	<!-- 기본 css 설정 -->
	<link href="css/style.css?ver=1" rel="stylesheet">
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<!-- 아이콘 -->
	<script src='https://kit.fontawesome.com/a076d05399.js'></script>
	<!-- JQuery CDN 연동 -->
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<!-- bxSlider 플러그인 연동 -->
	<script type="text/javascript" src="js/jquery.bxslider.min.js"></script>
	<!-- 구글폰트 적용 -->
	<link href="https://fonts.googleapis.com/css?family=Stylish&display=swap" rel="stylesheet">
	
	<script type="text/javascript">
	
		/* 박스슬라이드  */
		$(function(){	// bxSlider 설정
    		$('.slider').bxSlider({
    			auto: true,								// 자동 넘김
    			pause: 2000,							// 보여주는 시간
    			speed: 500,								// 슬라이드 속도
    			pager: false,							// 페이지 활성화
    			controls: true,							// prev, next 활성화
    			prevText: '<img src="img/prev.png">',	// prev 버튼 이미지 설정
    			nextText: '<img src="img/next.png">',	// next 버튼 이미지 설정

    		});
	    });
		
		
	</script>
	
	<style type="text/css">
		.bx-wrapper .bx-prev{position: absolute; top: 450px; left: 80px;}
		.bx-wrapper .bx-next{position: absolute; top: 450px; right: 80px;}
		.slider img{width: 100%; height: 615px;}
		* {font-family: 'Stylish', sans-serif;}
	</style>
		
</head>

<body>
	<!-- Header -->
	<!-- 로고 -->
	<div class="navbar d-flex justify-content-center navbar-light bg-light">
		<a class="navbar-brand p-3" href="index.jsp">
			<i class='fas fa-mug-hot' style='font-size:60px'></i>
		</a>
	</div>
	<!-- 로고END -->
	<!-- 메뉴 -->
	<div class="navbar navbar-expand sticky-top navbar-dark bg-dark">
	    <div class="navbar-nav">
	        <ul class="navbar-nav" style="font-size: 20px;">
	            <li class="nav-item">
	                <a class="nav-link" href="index.jsp">Home</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="cafe/cafe_center.jsp">Map</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="center/notice.jsp">Notice</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="Gboard/gallery.jsp">Gallery</a>
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
					<a class="nav-link" href="member/login.jsp">로그인</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="member/join.jsp?#wrap">회원가입</a>
				</li>
		<%
				}else{
					if(id.equals("admin")){
		%>
						<li><span class="navbar-text text-light">관리자 님 환영합니다</span></li>
						<li class="nav-item">
							<a class="nav-link" href="member/memberInfo.jsp">회원관리</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="member/logout.jsp">로그아웃</a>
						</li>
		<%
					}else{
		%>
						<li><span class="navbar-text text-light"><%=id %> 님 환영합니다</span></li>
						<li class="nav-item">
							<a class="nav-link" href="member/pwCheck.jsp">내정보수정</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="member/logout.jsp">로그아웃</a>
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
	<!-- bxSlider -->
	<div id="slide_wrap" align="center">
		<div class="slider">
	    	<div><img src="./img/slider/image1.jpg"></div>
	    	<div><img src="./img/slider/image2.jpg"></div>
	    	<div><img src="./img/slider/image3.jpg"></div>
	    	<div><img src="./img/slider/image4.jpg"></div>
	    	<div><img src="./img/slider/image5.jpg"></div>
	    	<div><img src="./img/slider/image6.jpg"></div>
		</div>
	</div>
	<!-- bxSlider END -->
	<!-- article -->
	<!-- <article>
		<div class="row p-3">
			<div class="col-sm-6">
				<div class="card">
					<div class="card-header">
						<h4>공지사항</h4>
					</div>
					<div class="card-body">
						<ul class="list-group list-group-flush">
							<li class="list-group-item">고오옹지사하하항</li>
							<li class="list-group-item">공지이이이이사하하항</li>
							<li class="list-group-item">공공공지지지지사사항</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="card">
					<div class="card-header" onclick="location.href='center/notice.jsp'">
						<h4>게시판</h4>
					</div>
					<div class="card-body">
						<ul class="list-group list-group-flush">
							<li class="list-group-item">게시이이잉이이판</li>
							<li class="list-group-item">게에에에엥시시시판</li>
							<li class="list-group-item">게시시시시시시8</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</article> -->
	<!-- articleEND -->
	<!-- footer -->
	<footer class="py-3 bg-dark text-white-50">
		<div align="center" style="line-height:.5em">
			<p><b>COMPANY</b> : (주)KIMP <b>OWNER</b> : 김성래 <b>PRIVACY MANAGER</b> : 김성래</p>
			<p><b>ADDRESS</b> : 47246 부산 부산진구 동천로 109 삼한골든게이트 7층</p>
			<p><b>TEL</b> : 010 - 6631 - 2166</p>
			<p><b>BUSINESS LICENSE</b> : 000-00-00000 | <b>LICENSE</b> : 제2020-부산진구-0117호</p>
			<p>Copyright. (주)KIMP all rights reserved.</p>
		</div>
	</footer>
	<!-- footerEND -->
</body>
</html>