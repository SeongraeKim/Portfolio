<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<!-- 아이콘 -->
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

</head>
<body>
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
				<select class="custom-select" name="depAirportNm">
					<option selected>출발지</option>
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
					<label class="input-group-text"><i class='fas fa-plane-arrival'></i></label>
				</div>
				<select class="custom-select" name="arrAirportNm">
					<option selected>도착지</option>
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
			<!-- 출발일자 -->
			<div class="col input-group mt-3">
				<div class="input-group-prepend">
					<label class="input-group-text"><i class='far fa-calendar-alt' style='font-size:23px'></i></label>
				</div>
				<input class="input-group form-control" type="text" placeholder="가는날">
			</div>
			<!-- 도착일자 -->
			<div class="col input-group mt-3">
				<div class="input-group-prepend">
					<label class="input-group-text"><i class='far fa-calendar-alt' style='font-size:23px'></i></label>
				</div>
				<input class="input-group form-control" type="text" placeholder="오는날">
			</div>
		</div>
		<!-- 공항 및 날짜 선택 END -->
		<!-- 인원선택 -->
		<div class="row row-cols-2">
			<div class="col input-group mt-3">
				<input type="text" value="성인 1명 , 아동 0명" class="input-group form-control" readonly>
				<div class="input-group-prepend">
					&nbsp;
					<label class="input-group-text"><i class="fa fa-minus"></i></i></label>
					<label class="input-group-text"><i class='fas fa-male' style='font-size:23px'></i></label>
					<label class="input-group-text"><i class='fa fa-plus'></i></label>
					&nbsp;
					<label class="input-group-text"><i class="fa fa-minus"></i></i></label>
					<label class="input-group-text"><i class='fas fa-baby' style='font-size:23px'></i></label>
					<label class="input-group-text"><i class='fa fa-plus'></i></label>
				</div>
			</div>
		</div>
		<!-- 인원선택 END -->
	</div>
</body>
</html>