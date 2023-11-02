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

	<!-- C3 css 추가 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css"/>

	<!--d3 c3 js추가 -->
	<script src="https://d3js.org/d3.v3.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>


	<style>
	.tn_chart .c3-axis-y .domain {stroke-width: 0px;} .tn_chart text{font-family: 's-core_dream4_regular';font-size: 1.6rem;fill: #666;} .tn_chart .c3 path, .tn_chart_wrap .c3 line{stroke:#c7cee1} .tn_chart .c3-axis-y line{stroke:#fff}

	</style>

	<script type="text/javaScript" language="javascript">
/*
	window.onload = function() {
		$(document).ready(function() {


		    $("#locales").change(function () {
		        var selectedOption = $('#locales').val();
		        if (selectedOption != ''){
		            window.location.replace('admin?lang=' + selectedOption);
		        }
		    });

		    $("#btn_get_list").on("click", function() {
		    	var form = $(this).closest('form');
		    	form.submit();
		    });

		    $("#btn_remove_log").on("click", function() {

		    	var param={"keyword": $('#keyword').val()};

		    	$.ajax({
		    		url: '/user/sends',
		    		type: 'DELETE',
//		    		contentType : 'application/json; charset=utf-8',
//		    		dataType    : 'json',
		    		data: param,
		    		success: function(data, status, jqXHR) {
			    		alert("Log Deleted");
			            window.location.replace('/user/sends');
		    		},
		    		error: function(jqXHR, textStatus, errorThrown) {
		    			console.log('error thrown');
		    			console.log(jqXHR);
		    			console.log(errorThrown);
			    		alert("Delete Log Error : "+textStatus);
		    		}
	    		});
		    });

		});
	}
 */
 //loadComplete
	window.onload = function() {
		$(document).ready(function() {

			$("#bt_ch").click(function(){
				chart1.load({
					  columns: [
					    ['data1', 300, 100, 250, 150, 300, 150, 500],
					    ['data2', 100, 200, 150, 50, 100, 250]
					  ]
					});
			});

			var chart1 = c3.generate({
			    bindto: '#chart',
			    data: {
			      columns: [
			        ['data1', 30, 200, 100, 400, 150, 250],
			        ['data2', 50, 20, 10, 40, 15, 25]
			      ]
			    }
			});

			var chart2 = null;
			$("#bt_sc").click(function(){

				var params = null;

		    	$.getJSON("/c3ChartSampleData.do", params, function(data, status, jqXHR) {
/* 		    		if(!data.success) {
		    			alert(data.message);
		    			return;
		    		} */
		    		var dataKeys = Object.keys(data);

		    		// Object.keys 했을 때 역순으로 리스트 담겨서 반대로 정렬
		    		dataKeys.reverse();

		    		dColumns = [];

		    		for(var i in dataKeys){
		    			var tmp = [];

		    			tmp[0] = dataKeys[i];
		    			for(var j of data[dataKeys[i]]){
							tmp[tmp.length] = j;
		    			}
		    			dColumns[dColumns.length] = tmp;
		    		}

		    		console.log(dColumns);


					chart2 = c3.generate({
					    bindto: '#chart_cust',
					    data: {
					      columns: dColumns,
					      axes: {
					        data2: 'y2' // ADD
					      }
					    },
					    axis: {
					      y2: {
					        show: true // ADD
					      }
					    }
					});

	    		});

			});


			var chart3 = c3.generate({
			    bindto: '#chart_cust_label',
			    data: {
			      columns: [
			        ['data1', 30, 200, 100, 400, 150, 250],
			        ['data2', 50, 20, 10, 40, 15, 25]
			      ],
			      axes: {
			        data2: 'y2'
			      }
			    },
			    axis: {
			      y: {
			        label: { // ADD
			          text: 'Y Label',
			          position: 'outer-middle'
			        }
			      },
			      y2: {
			        show: true,
			        label: { // ADD
			          text: 'Y2 Label',
			          position: 'outer-middle'
			        }
			      }
			    }
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
		C3 Chart
	</h1>

	<h3>Chart1</h3>
	<button id="bt_ch">데이터 변경</button>
	<div id="chart"></div>
	<h3>Chart2</h3>
	<button id="bt_sc">데이터 조회</button>
	<div id="chart_cust"></div>
	<h3>Chart3</h3>
	<div id="chart_cust_label"></div>


	</body>
</html>
