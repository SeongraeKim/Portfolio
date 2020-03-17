<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<!-- 아이콘 -->
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<!-- JQuery CDN 연동 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- Bootstrap Datepicker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />

<script type="text/javascript">

	/* 필수값 체크 */
	function Check() {
		if( !$("#depAirportNm").val() ){
			alert("출발지를 선택해주세요.");
			
		}else if( !$("#arrAirportNm").val() ){
			alert("도착지를 선택해주세요.");
			
		}else if( !$("#depPlandTime").val() ){
			alert("가는날을 선택해주세요.");
		
		}/* else if($("#roundTrip").checked){
			alert("눌러눌러");
			
		} */else{
			fr.submit();
		}
	}
	
	$(function() {
		$.datepicker.setDefaults({ // datepicker 설정
			dateFormat 			: 'yymmdd',
			prevText 			: '이전 달',
			nextText 			: '다음 달',
			monthNames 			: [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort 	: [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			dayNames 			: [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesShort 		: [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesMin 		: [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear 	: true,
			changeMonth 		: false,
			changeYear 			: true,
			yearRange 			: ":+1"
		});
		
		$("#depPlandTime").datepicker(); 	// 가는날 datepicker
		
		$("#roundTrip").click(function() {	// 왕복 클릭 시 오는날 datepicker 생성
			var addCal = document.getElementById("addCal");
			addCal.innerHTML = 	'<div class="col input-group mt-3">' +
									'<div class="input-group-prepend">' +
										'<label class="input-group-text"><i class="far fa-calendar-alt" style="font-size:23px"></i></label>' +
									'</div>' +
									'<input class="input-group form-control" type="text" id="arrPlandTime" name="arrPlandTime"' +
											'placeholder="오는날" autocomplete="off" readonly>' +
								'</div>';
								
			$("#arrPlandTime").datepicker(); // 오는날 datepicker ( * 동적으로 생성 시 생성 후 이벤트 호출 )
			
		});
		
		$("#oneWay").click(function() {		// 편도 클릭 시 오는날 datepicker 제거
			addCal.innerHTML = '';
		});
		
		/* 인원 선택 */
		$("#adultP").click(function() {		// 성인 +1
			var num = document.getElementById("adult").innerHTML;
			
			if(num < 9){
				document.getElementById("adult").innerHTML = Number(num) + 1;
			}
			
		});
		$("#adultM").click(function() {		// 성인 -1
			var num = document.getElementById("adult").innerHTML;
			
			if(num > 1){
				document.getElementById("adult").innerHTML = Number(num) - 1;
			}
		});
		$("#childP").click(function() {		// 유아 +1
			var num = document.getElementById("child").innerHTML;
			
			if(num < 9){
				document.getElementById("child").innerHTML = Number(num) + 1;
			}
		});
		$("#childM").click(function() {		// 유아 -1
			var num = document.getElementById("child").innerHTML;
			
			if(num > 0){
				document.getElementById("child").innerHTML = Number(num) - 1;
			}
		});
		
		
		
	}); // function END
	
</script>

</head>
<body>
	<!-- 항공권 조회 -->
	<h1 align="center" class="m-5">항공편 조회</h1>
	<form action="${contextPath }/airplane/airplaneSearch.do" name="fr">
		<div class="container p-5 m-5 bg-warning">
			<h1>ODE GANO</h1>
			<!-- 편도/왕복 선택 -->
			<div class="btn-group mb-3">
				<div class="custom-control custom-radio custom-control-inline">
					<input type="radio" id="oneWay" name="tourType" class="custom-control-input" checked>
					<label class="custom-control-label" for="oneWay">편도</label>
				</div>
				<div class="custom-control custom-radio custom-control-inline">
					<input type="radio" id="roundTrip" name="tourType"class="custom-control-input">
					<label class="custom-control-label" for="roundTrip">왕복</label>
				</div>
			</div>
			<!-- 편도/왕복 선택 END -->
			<!-- 공항 및 날짜 선택 -->
			<div class="row row-cols-2">
				<!-- 출발지 -->
				<div class="col input-group">
					<div class="input-group-prepend">
						<label class="input-group-text">
						<i class='fas fa-plane-departure'></i></label>
					</div>
					<select class="custom-select" id="depAirportNm" name="depAirportNm">
						<option value="">출발지</option>
						<option value="NAARKJK">군산</option>
						<option value="NAARKJJ">광주</option>
						<option value="NAARKSS">김포</option>
						<option value="NAARKPK">김해</option>
						<option value="NAARKTN">대구</option>
						<option value="NAARKJB">무안</option>
						<option value="NAARKPS">사천</option>
						<option value="NAARKNY">양양</option>
						<option value="NAARKJY">여수</option>
						<option value="NAARKPU">울산</option>
						<option value="NAARKNW">원주</option>
						<option value="NAARKSI">인천</option>
						<option value="NAARKPC">제주</option>
						<option value="NAARKTU">청주</option>
						<option value="NAARKTH">포항</option>
					</select>
				</div>
				<!-- 도착지 -->
				<div class="col input-group">
					<div class="input-group-prepend">
						<label class="input-group-text">
						<i class='fas fa-plane-arrival'></i></label>
					</div>
					<select class="custom-select" id="arrAirportNm" name="arrAirportNm">
						<option value="">도착지</option>
						<option value="NAARKJK">군산</option>
						<option value="NAARKJJ">광주</option>
						<option value="NAARKSS">김포</option>
						<option value="NAARKPK">김해</option>
						<option value="NAARKTN">대구</option>
						<option value="NAARKJB">무안</option>
						<option value="NAARKPS">사천</option>
						<option value="NAARKNY">양양</option>
						<option value="NAARKJY">여수</option>
						<option value="NAARKPU">울산</option>
						<option value="NAARKNW">원주</option>
						<option value="NAARKSI">인천</option>
						<option value="NAARKPC">제주</option>
						<option value="NAARKTU">청주</option>
						<option value="NAARKTH">포항</option>
					</select>
				</div>
				<!-- 가는날 -->
				<div class="col input-group mt-3">
					<div class="input-group-prepend">
						<label class="input-group-text"><i class='far fa-calendar-alt' style='font-size:23px'></i></label>
					</div>
					<input class="input-group form-control" type="text" id="depPlandTime" name="depPlandTime" 
						   maxlength="20" placeholder="가는날" autocomplete="off" readonly>
				</div>
				<!-- 오는날 -->
				<div id="addCal"></div>
			</div>
			<!-- 공항 및 날짜 선택 END -->
			<div class="row row-cols-2">
				<!-- 인원 선택 -->
				<div class="col input-group mt-3">
					<div class="input-group-prepend">
						<label class="input-group-text">성인</label>
						<label id="adultP" class="input-group-text btn"><i class='fa fa-plus'></i></label>
						<label id="adult" class="input-group-text">1</label>
						<label id="adultM" class="input-group-text btn"><i class="fa fa-minus"></i></i></label>
						&nbsp;&nbsp;
						<label class="input-group-text">유아</label>
						<label id="childP" class="input-group-text btn"><i class='fa fa-plus'></i></label>
						<label id="child" class="input-group-text">0</label>
						<label id="childM" class="input-group-text btn"><i class="fa fa-minus"></i></i></label>
					</div>
				</div>
				<!-- 인원 선택 END -->
				<!-- 조회버튼 -->
				<div class="col mt-3 d-flex justify-content-end">
					<input type="button" class="btn btn-dark" value="항공권 검색" onclick="Check()">
				</div>
				<!-- 조회버튼 END -->
			</div>
		</div>
	</form>
	<!-- 항공권 조회 END -->
</body>
</html>










