<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="airlineList" value="${requestScope.airlineList}" />
<c:set var="parkList" value="${requestScope.parkList}" />
<c:set var="wIcon" value='http://openweathermap.org/img/wn/${wIcon}.png'/>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="airplaneResult" value="${requestScope.airplaneResult}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>항공권 조회</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<!-- 아이콘 -->
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<!-- JQuery CDN 연동 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 아임포트(결제 API) JQuery CDN -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
	// 아임포트(결제API)	-	https://admin.iamport.kr/
	// 아임포트 사용방법		-	https://www.iamport.kr/getstarted
	// 아임포트 매뉴얼		-	https://docs.iamport.kr/
	/*
		pg(결제대행)							pay_method(결제방식)
		
		'kakao':카카오페이,					'samsung':삼성페이,
		'html5_inicis':이니시스(웹표준결제)		'card':신용카드,
		'nice':나이스페이						'trans':실시간계좌이체,
		'jtnet':제이티넷						'vbank':가상계좌,
		'uplus':LG유플러스					'phone':휴대폰소액결제
		'danal':다날
		'payco':페이코
		'syrup':시럽페이
		'paypal':페이팔
	*/
		
		
	function payment(airlineNm, economyCharge, vihicleId) {
				
		var IMP = window.IMP; 		// 생략가능
		IMP.init("imp78062500"); 	// 가맹점 식별코드 (코드확인 : 아임포트 관리자페이지 -> 내정보 -> 가맹점식별코드)

		IMP.request_pay({
			pg : 'danal' ,														// PG사(결제대행사)
			pay_method : 'card',												// 결제방식
			merchant_uid : vihicleId + new Date().getTime(),					// 결제 시 고유 주문번호(결제가 된 적이 있는 merchant_uid로는 결제 불가)
            
			name : airlineNm,   												// 구매할 상품명
			amount : economyCharge,												// 가격
            
			buyer_email : 'ODE@tour.com',										// 판매자 이메일
			buyer_name : 'ODE TOUR',											// 판매자 이름
			buyer_tel : '051) 803 - 0909',													// 판매자 전화번호
			buyer_addr : '부산 부산진구 동천로 109 삼한골든게이트 7층',					// 판매자 주소
			buyer_postcode : '211-0005',										// 판매자 우편번호
        	
			m_redirect_url : 'https://www.yourdomain.com/payments/complete'		// 결제 완료 후 보낼 컨트롤러의 메서드명 (*임의 변경 시 오작동)
            
		}, function(rsp) {
			console.log(rsp);
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				msg += '고유ID : ' 		+ rsp.imp_uid;
				msg += '상점 거래ID : '	+ rsp.merchant_uid;
				msg += '결제 금액 : ' 		+ rsp.paid_amount;
				msg += '카드 승인번호 : ' 	+ rsp.apply_num;
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' 		+ rsp.error_msg;
			}
			alert(msg);
		});
	}
</script>

</head>
<body>
	<!-- 조회결과 -->
	<div class="container m-5 p-5">
		<!-- 항공권 조회결과 -->
		<input type="hidden" id="test" value="${airlineList[0].depAirportNm}">
		<h3><span class="badge p-2" style="background: #ccc;">
			<i class='fas fa-plane-departure'></i>${airlineList[0].depAirportNm}<img src="${wIcon}">
			&nbsp;&nbsp;<i class='fas fa-minus'></i>&nbsp;&nbsp;
			<i class='fas fa-plane-arrival'></i>${airlineList[0].arrAirportNm}<img src="${wIcon}">
		</span></h3>
		<table class="table" id="example">
			<tr align="center" class="thead-dark">
				<th>항공사</th>
				<th>출발시간</th>
				<th>도착시간</th>
				<th>운임</th>
				<th>항공편명</th>
				<th></th>
			</tr>
			<c:choose>
				<c:when test="${airlineList != null}">
					<c:forEach var="airLine" items="${airlineList}" varStatus="status">
						<tr align="center">
							<td id="airlineNm">${airLine.airlineNm}</td>
							<td>${airLine.depPlandTime}</td>
							<td>${airLine.arrPlandTime}</td>
							<td>${airLine.economyCharge}</td>
							<td>${airLine.vihicleId}</td>
							<td><input type="button" id="pay" value="결제" class="btn btn-outline-dark" onclick="payment('${airLine.airlineNm}',
																														'${airLine.economyCharge}',
																														'${airLine.vihicleId}')"></td>
						</tr>
						
						
						
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="7">항공권이 존재하지 않습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		
<!--TICKET SAMPLE------------------------------------------------------------------------------------------------------------------------------->



<div class="container m-5 p-5">
		<div class="row border rounded-lg shadow p-3 text-center" style="background: skyblue; font-size: 30px;">
			<!-- 김해&emsp;<i class='fas fa-plane'></i>&emsp;김포
			02/20 07:30 -->
			
			<div class="col m-auto">
				<p>${airlineList[0].depAirportNm}&nbsp;<i class='fas fa-plane'></i>&nbsp;${airlineList[0].arrAirportNm}</p>
				<p><small>(OZ512)</small></p>
			</div>
			<div class="col m-auto">
				<p>02 / 20</p>
				<p>07:30&nbsp;&nbsp;<i class='fas fa-minus'></i>&nbsp;&nbsp;08:40</p>
			</div>
			<div class="col m-auto">
				39800<small>WON</small>
			</div>
			<div class="col m-auto" align="right">
				<input type="button" class="btn btn-outline-dark" value="결제">
			</div>
		</div>
	</div>
	
	
<!------------------------------------------------------------------------------------------------------------------------------------------------>
		<!-- 항공권 조회결과 END -->
		<!-- 주차 조회결과 -->
		<h3>
			<i class='fas fa-car-side'></i>${airlineList[0].depAirportNm}공항 주차현황
		</h3>
		<table class="table">
			<tr class="thead-dark" align="center">
				<th>주차장명</th>
				<th>총주차공간</th>
				<th>현재 주차수</th>
				<th>주차 가능수</th>
				<th>업데이트날짜</th>
				<th>업데이트시간</th>
			</tr>
			<c:choose>
				<c:when test="${parkList != null}">
					<c:forEach var="park" items="${parkList}">
						<tr align="center">
							<td>${park.parkingAirportCodeName}</td>
							<td>${park.parkingFullSpace}</td>
							<td>${park.parkingIstay}</td>
							<td>${park.parkingIempty}</td>
							<td>${park.parkingGetdate}</td>
							<td>${park.parkingGettime}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					
				</c:otherwise>
			</c:choose>
		</table>
		<!-- 주차 조회결과 END -->
	</div>
	<!-- 조회결과 END -->
</body>
</html>