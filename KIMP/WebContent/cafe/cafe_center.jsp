<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		<!-- 아이콘 -->
		<script src='https://kit.fontawesome.com/a076d05399.js'></script>
		<!-- JQuery CDN 연동 -->
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<!-- 구글폰트 적용 -->
		<link href="https://fonts.googleapis.com/css?family=Stylish&display=swap" rel="stylesheet">
		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9442dc3fa8a694fdec98072b0137a131"></script>
		<script>
			$(function() {
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
				mapOption = { 
				    center: new kakao.maps.LatLng(35.158504, 129.062039), // 지도의 중심좌표
				    level: 3 // 지도의 확대 레벨
				};
				
				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				
				//지도를 클릭했을때 클릭한 위치에 마커를 추가하도록 지도에 클릭이벤트를 등록합니다
				kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
				// 클릭한 위치에 마커를 표시합니다 
				addMarker(mouseEvent.latLng);             
				});
				
				//지도에 표시된 마커 객체를 가지고 있을 배열입니다
				var markers = [];
				
				//마커 하나를 지도위에 표시합니다 
				addMarker(new kakao.maps.LatLng(35.158504, 129.062039));
				addMarker(new kakao.maps.LatLng(35.157945, 129.061850));
				
				//마커를 생성하고 지도위에 표시하는 함수입니다
				function addMarker(position) {
				
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: position
				});
				
				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
				
				// 생성된 마커를 배열에 추가합니다
				markers.push(marker);
				}
				
				//배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
				function setMarkers(map) {
				for (var i = 0; i < markers.length; i++) {
				    markers[i].setMap(map);
				}            
				}
				
			});
		</script>
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		<div>
		
			<div id="map" style="width:100%;height:500px;"></div>
			<div id="clickLatlng"></div>
		
		</div>
		<!-- Foooter -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- FoooterEND -->
	</body>
</html>