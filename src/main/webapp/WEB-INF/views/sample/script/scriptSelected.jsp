<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="false" %>
<html>
<head>
	<title>Home</title>

	<!-- C3.JS -->
<%--
	<link rel="stylesheet" href="<c:url value='/resources/external/c3-0.7.20/c3.css' />">
	<script src="<c:url value='/resources/external/c3-0.7.20/c3.js' />"></script>
 --%>

	<!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

	<style>
	.tn_chart .c3-axis-y .domain {stroke-width: 0px;} .tn_chart text{font-family: 's-core_dream4_regular';font-size: 1.6rem;fill: #666;} .tn_chart .c3 path, .tn_chart_wrap .c3 line{stroke:#c7cee1} .tn_chart .c3-axis-y line{stroke:#fff}

	</style>

	<script type="text/javaScript" language="javascript">

	/* jquery window.onload 사용
	$(window).on('load', function() { .... });
	 */
	window.onload = function() {
		$(document).ready(function() {

			/* 셀렉트 박스 응용 */
			$("#humidifierSrcelct").change(function(e){
				// 값만 변경 됨
				$("#humidifierFnctngMode option").removeAttr("selected"); 				// 셀렉트 해제
				$("#humidifierFnctngMode").val("3");									// 값이 "3"인 셀렉트 선택
				$("#humidifierFnctngMode").val("3").prop("selected", true);				// 값이 "3"인 셀렉트 선택
				$("#humidifierFnctngMode option:eq(0)").attr("selected", "selected");	// 인덱스 0번째 선택 => removeAttr("selected") 해야함
				$("#humidifierFnctngMode option:eq(0)").prop("selected", true);			// 인덱스 0번째 선택 => removeAttr("selected") 해야함

				// 값 변경 후 하위 이벤트 실행 $("#humidifierFnctngMode").change();
				$("#humidifierFnctngMode").val("").trigger("change");					// 값을 "" 변경 후 하위 이벤트 실행 됨

				if($(this).val() == 1){
					$("#humidifierFnctngMode").attr("disabled", false);
				}
				else{
					$("#humidifierFnctngMode").attr("disabled", true);
				}
			});

			$("#humidifierFnctngMode").change(function(e){
				var _value = $(this).val();
				console.log(_value);
				if(_value == "3"){
					$("#humidifierCntncSetupTime").attr("disabled", false);
					$("#humidifierSetupTimeOne").val("");
					$("#humidifierSetupTimeTow").attr("disabled", true);
				}
				else if(_value == "4"){
					$("#humidifierCntncSetupTime").val("");
					$("#humidifierCntncSetupTime").attr("disabled", true);
					$("#humidifierSetupTimeTow").attr("disabled", false);
				}
				else{
					$("#humidifierCntncSetupTime").val("");
					$("#humidifierSetupTimeTow").val("");
					$("#humidifierCntncSetupTime").attr("disabled", true);
					$("#humidifierSetupTimeTow").attr("disabled", true);
				}
			});















		}
	 });

	</script>

</head>
<body>
	<div>
		<c:import url="/menu.do"></c:import>
	</div>

	<h1>
		Script Sample
	</h1>


	<table id="requestGetListResult" class="table table-striped">
		<thead>
			<tr>
				<th>PSN ID</th>
				<th>Company Name</th>
				<th>Employee ID</th>
				<th>Name</th>
				<th>Department</th>
				<th>Position</th>
				<th>Title</th>
				<th>Phone(Home)</th>
				<th>Phone(Office)</th>
				<th>Phone(Mobile)</th>
				<th>E-Mail</th>
				<th>Description</th>
			</tr>
		</thead>

		<tbody>
		</tbody>
	</table>


	</body>
</html>
