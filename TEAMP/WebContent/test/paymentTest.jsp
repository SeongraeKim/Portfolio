<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- 아임포트(결제 API) JQuery CDN -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
	// 아임포트(결제API)	-	https://admin.iamport.kr/
	// 아임포트 사용방법		-	https://www.iamport.kr/getstarted
	// 아임포트 매뉴얼		-	https://docs.iamport.kr/
	/*
		pg(결제대행)							pay_method(결제방식)
		
		'kakao':카카오페이,						'samsung':삼성페이,
		'html5_inicis':이니시스(웹표준결제)		'card':신용카드,
		'nice':나이스페이						'trans':실시간계좌이체,
		'jtnet':제이티넷						'vbank':가상계좌,
		'uplus':LG유플러스						'phone':휴대폰소액결제
		'danal':다날
		'payco':페이코
		'syrup':시럽페이
		'paypal':페이팔
	*/
	function payment() {
			var IMP = window.IMP; 		// 생략가능
			IMP.init("imp78062500"); 	// 가맹점 식별코드 (코드확인 : 아임포트 관리자페이지 -> 내정보 -> 가맹점식별코드)

			IMP.request_pay({
				pg : 'danal' ,														// PG사(결제대행사)
				pay_method : 'card',												// 결제방식
				merchant_uid : 'merchant_' + new Date().getTime(),					// 결제 시 고유 주문번호(결제가 된 적이 있는 merchant_uid로는 결제 불가)
	            
				name : '젠가',   														// 구매할 상품명
				amount : 1000,														// 가격
	            
				buyer_email : 'ODE@naver.com',										// 판매자 이메일
				buyer_name : 'ODE tour',											// 판매자 이름
				buyer_tel : '010-',													// 판매자 전화번호
				buyer_addr : '부산 부산진구 동천로 109 삼한골든게이트 7층',						// 판매자 주소
				buyer_postcode : '211-0005',										// 판매자 우편번호
            	
				m_redirect_url : 'https://www.yourdomain.com/payments/complete'		// 결제 완료 후 보낼 컨트롤러의 메서드명 (*임의 변경 시 오작동)
	            
			}, function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg);
			});
	}
	
	$(function(){
		/* $("#check_module").click(function() {
			var IMP = window.IMP; 		// 생략가능
			IMP.init("imp78062500"); 	// 가맹점 식별코드 (코드확인 : 아임포트 관리자페이지 -> 내정보 -> 가맹점식별코드)

			IMP.request_pay({
				pg : 'danal' ,														// PG사(결제대행사)
				pay_method : 'card',												// 결제방식
				merchant_uid : 'merchant_' + new Date().getTime(),					// 결제 시 고유 주문번호(결제가 된 적이 있는 merchant_uid로는 결제 불가)
	            
				name : '젠가',   														// 구매할 상품명
				amount : 1000,														// 가격
	            
				buyer_email : 'ODE@naver.com',										// 판매자 이메일
				buyer_name : 'ODE tour',											// 판매자 이름
				buyer_tel : '010-',													// 판매자 전화번호
				buyer_addr : '부산 부산진구 동천로 109 삼한골든게이트 7층',						// 판매자 주소
				buyer_postcode : '211-0005',										// 판매자 우편번호
            	
				m_redirect_url : 'https://www.yourdomain.com/payments/complete'		// 결제 완료 후 보낼 컨트롤러의 메서드명 (*임의 변경 시 오작동)
	            
			}, function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg);
			});
		}); */
	  
	});
</script>
</head>
<body>
	<p>
		<p>아임 서포트 결제 모듈 테스트 해보기</p>
		<button id="check_module" type="button" onclick="payment()">다날 결제</button>
		<button id="check_module" type="button" onclick="payment()">다날 결제</button>
	</p>
</body>
</html>