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
 //loadComplete


	window.onload = function() {
		$(document).ready(function() {

		      // Load Charts and the corechart package.
		      google.charts.load('current', {'packages':['corechart']});

		     // 스크립트 방식 1(Add Rows 내생각)
		    var cData = [];
	    	$.getJSON("/googleChartSampleData1.do", null, function(data, status, jqXHR) {
	    		/* 		    		if(!data.success) {
	    				    			alert(data.message);
	    				    			return;
	    				    		} */
							for(var i=0; i<data.length; i++){
								var tmp = data[i];
								var tData = [];
								var tObj = {};

								tData[0] = tmp[0];
								tObj.v = tmp[1];
								tObj.f = null;
								tData[1] = tObj;

								cData[cData.length] = tData;
							}

		    		// Draw the pie chart for Sarah's pizza when Charts is loaded.
				      google.charts.setOnLoadCallback(drawSarahChart1);
	    	});

		      function drawSarahChart1() {

			        // Create the data table for Sarah's pizza.
			        var data = new google.visualization.DataTable();
			        data.addColumn('string', '이름');
			        data.addColumn('number', '%');
			        data.addRows(cData)

			        // Set options for Sarah's pie chart.
			        var options = {title:'How Much Pizza Sarah Ate Last Night',
			                       width:400,
			                       height:300};

			        // Instantiate and draw the chart for Sarah's pizza.
			        var chart = new google.visualization.PieChart(document.getElementById('Sarah_chart_div1'));
			        chart.draw(data, options);
		      }

			// 스크립트 방식 2(Add Rows)
			// Draw the pie chart for Sarah's pizza when Charts is loaded.
		      google.charts.setOnLoadCallback(drawSarahChart2);

			  function drawSarahChart2() {
					var cData = new google.visualization.DataTable();
					// Declare columns
					cData.addColumn('string', '이름');
					cData.addColumn('number', '%');

					$.getJSON("/googleChartSampleData1.do", null, function(data, status, jqXHR) {
						/* 		    		if(!data.success) {
								    			alert(data.message);
								    			return;
								    		} */
						    		var tmpData = [];

									for(var i=0; i<data.length; i++){
										var tmp = data[i];
										var tData = [];
										var tObj = {};

										tData[0] = tmp[0];
										tObj.v = tmp[1];
										tObj.f = null;
										tData[1] = tObj;

										tmpData[tmpData.length] = tData;
									}

							// Add Rows.
				    		cData.addRows(tmpData);

					        // Set options for Sarah's pie chart.
					        var options = {title:'How Much Pizza Sarah Ate Last Night',
					                       width:400,
					                       height:300};

					        // Instantiate and draw the chart for Sarah's pizza.
					        var chart = new google.visualization.PieChart(document.getElementById('Sarah_chart_div2'));
					        chart.draw(cData, options);
					});
			  }

			// 스크립트 방식 3(Empty Rows + Add Rows)
			// Draw the pie chart for Sarah's pizza when Charts is loaded.
		      google.charts.setOnLoadCallback(drawSarahChart3);

			  function drawSarahChart3() {
					var cData = new google.visualization.DataTable();
					// Declare columns
					cData.addColumn('string', '이름');
					cData.addColumn('number', '%');

					$.getJSON("/googleChartSampleData1.do", null, function(data, status, jqXHR) {
						// Empty Rows
						cData.addRows(data.length);

						for(var i=0; i<data.length; i++){
							var tmp = data[i];
							// Add Rows
							cData.setCell(i, 0, tmp[0]);
							cData.setCell(i, 1, tmp[1]);
						}

					        // Set options for Sarah's pie chart.
					        var options = {title:'How Much Pizza Sarah Ate Last Night',
					                       width:400,
					                       height:300};

					        // Instantiate and draw the chart for Sarah's pizza.
					        var chart = new google.visualization.PieChart(document.getElementById('Sarah_chart_div3'));
					        chart.draw(cData, options);
					});
			  }

				// 스크립트 방식 4(JavaScript Literal Initializer)
				// Draw the pie chart for Sarah's pizza when Charts is loaded.
			      google.charts.setOnLoadCallback(drawSarahChart4);

				  function drawSarahChart4() {
						$.getJSON("/googleChartSampleData1.do", null, function(data, status, jqXHR) {
							/* 		    		if(!data.success) {
									    			alert(data.message);
									    			return;
									    		} */

							    		var cData = {};
							    		cData.cols = [{id: 'name', label: '이름', type: 'string'},{id: 'value', label: '%', type: 'number'}];
							    		cData.rows = [];
										for(var i=0; i<data.length; i++){
											var tmp = data[i];
											cData.rows[cData.rows.length] = {c:[{v: tmp[0]}, {v: tmp[1], f:null}]};
										}

								 // Create the data table
								var cData = new google.visualization.DataTable(cData, false);

						        // Set options for Sarah's pie chart.
						        var options = {title:'How Much Pizza Sarah Ate Last Night',
						                       width:400,
						                       height:300};

						        // Instantiate and draw the chart for Sarah's pizza.
						        var chart = new google.visualization.PieChart(document.getElementById('Sarah_chart_div4'));
						        chart.draw(cData, options);
						});
				  }

				  // 스크립트 방식 5(Java Data)
				// Draw the pie chart for Sarah's pizza when Charts is loaded.
			      google.charts.setOnLoadCallback(drawSarahChart5);

				  function drawSarahChart5() {
				        var jsonData = $.ajax({ //비동기적 방식으로 호출한다는 의미이다.
				            url : "googleChartSampleData2.do",
				            //json에 sampleData.json파일을 불러온다.
				            //확장자가 json이면 url 맵핑을 꼭 해주어야 한다. 안해주면 자바파일인줄 알고 404에러가 발생한다.
				            //그렇기 때문에 servlet-context파일에서 리소스를 맵핑해준다.
				            dataType : "json",
				            async : false
				        }).responseText; //서버 요청데이터 문자열 반환

					  // Create the data table
						var cData = new google.visualization.DataTable(jsonData);

				        // Set options for Sarah's pie chart.
				        var options = {title:'How Much Pizza Sarah Ate Last Night',
				                       width:400,
				                       height:300};

				        // Instantiate and draw the chart for Sarah's pizza.
				        var chart = new google.visualization.PieChart(document.getElementById('Sarah_chart_div5'));
				        chart.draw(cData, options);
				  }


			//Draw the pie chart for the Anthony's pizza when Charts is loaded.
			google.charts.setOnLoadCallback(drawAnthonyChart);

		      // Callback that draws the pie chart for Anthony's pizza.
		      function drawAnthonyChart() {

		        // Create the data table for Anthony's pizza.
		        var data = new google.visualization.DataTable();
		        data.addColumn('string', 'Topping');
		        data.addColumn('number', 'Slices');
		        data.addRows([
		          ['Mushrooms', 2],
		          ['Onions', 2],
		          ['Olives', 2],
		          ['Zucchini', 0],
		          ['Pepperoni', 3]
		        ]);

		        // Set options for Anthony's pie chart.
		        var options = {title:'How Much Pizza Anthony Ate Last Night',
		                       width:400,
		                       height:300};

		        // Instantiate and draw the chart for Anthony's pizza.
		        var chart = new google.visualization.PieChart(document.getElementById('Anthony_chart_div'));
		        chart.draw(data, options);
		      }

		});
 	}
	</script>

</head>
<body>
	<div>
		<c:import url="/menu.do"></c:import>
	</div>

	<h1>
		Google Chart
	</h1>

    <!--Div that will hold the pie chart-->
    <div>
   	    <table class="columns">
	      <tr>
	        <td><div id="Sarah_chart_div1" style="border: 1px solid #ccc"></div></td>
	        <td><div id="Sarah_chart_div2" style="border: 1px solid #ccc"></div></td>
	        <td><div id="Sarah_chart_div3" style="border: 1px solid #ccc"></div></td>
	        <td><div id="Sarah_chart_div4" style="border: 1px solid #ccc"></div></td>
	        <td><div id="Sarah_chart_div5" style="border: 1px solid #ccc"></div></td>
	      </tr>
	      <tr>
	        <td><div id="Anthony_chart_div" style="border: 1px solid #ccc"></div></td>
	      </tr>
	    </table>


    </div>


	</body>
</html>
