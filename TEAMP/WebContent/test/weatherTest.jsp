<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- JQuery CDN 연동 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script>
	$(document).ready(function(){
		$.getJSON("http://api.openweathermap.org/data/2.5/weather?lat=35.124&lon=126.8031&appid=a79479d2d982619acbd0468021a88e8f", function(data){

			var $wiCon = data.weather[0].icon;
			$('.cicon').append('<img src="http://openweathermap.org/img/wn/'+$wiCon+'.png">');
		});
	});
	
</script>
</head>

<body>
	<div class="cicon">아이콘 :</div>
</body>
</html>
