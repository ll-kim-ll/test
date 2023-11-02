<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<script src="<c:url value='/resources/external/qrcodejs/qrcode.js' />"></script>

	<script type="text/javaScript" language="javascript">
		window.onload = function() {
			$(document).ready(function() {
				$("button").on("click", function(){
					console.log("qrcode");
					var qrcode = new QRCode(document.getElementById("qrcode"), {
						 text: "naver.com",
						 width: 300,  //가로
						 height: 300, //세로
						 colorDark : "#000000", //qr에서 어두운 색 (보통 검은색)
						 colorLight : "#ffffff", //qr에서 밝은 색 (보통 하얀색) colorDark 보다 옅어야한다.
						 correctLevel : QRCode.CorrectLevel.H //qr코드 오류복원능력임 (L->M->Q->H)
						 });
				});

			});
		}
	</script>

</head>
<body>
	<div>
		<c:import url="/menu.do"></c:import>
	</div>

	<h1>
		Script Sample
	</h1>

	<div>
		<img src="/qrCode/getQrCode.do?qrData=naver.com"/>
		<img src="/qrCode/getQrCode.do?qrData=nate.com"/>
	</div>
	<div>
		<button type="button" class="btn btn-primary btn-sm" >스크립트 QR생성</button>
		<div id="qrcode"></div>
	</div>


	</body>
</html>
