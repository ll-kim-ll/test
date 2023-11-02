<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- <script type="text/javascript" src="https://www.google.com/jsapi"></script> -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script>
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart1);
function drawChart1() {
  var data = google.visualization.arrayToDataTable([
    ['Year', '미세먼지'],
    ['00',  17],
    ['01',  15],
    ['02',  20],
    ['03',  14],
	  ['04',  15],
	  ['05',  30],
	  ['06',  36],
	  ['07',  31],
	  ['08',  20],
	  ['09',  21],
	  ['10',  20],
	  ['11',  15],
	  ['12',  13],
	  ['13',  10],
	  ['14',  10],
	  ['15',  12],
	  ['16',  10],
	  ['17',  18],
	  ['18',  15],
	  ['19',  13],
	  ['20',  15],
	  ['21',  15],
	  ['22',  10],
	  ['23',  10]

  ]);

  var options = {
    title: '* 시간별 공기질 정보',
	  curveType: 'function'
  };

  var chart = new google.visualization.LineChart(document.getElementById('chart_div1'));
  chart.draw(data, options);
}

      google.setOnLoadCallback(drawChart2);
function drawChart2() {
  var data = google.visualization.arrayToDataTable([
    ['Year', '미세먼지'],
    ['월',  17],
    ['화',  15],
    ['수',  20],
    ['목',  14],
	  ['금',  15],
	  ['토',  30],
	  ['일',  36]

  ]);

  var options = {
    title: '* 주별 공기질 정보',
	  curveType: 'function'
  };

  var chart = new google.visualization.ColumnChart(document.getElementById('chart_div2'));
  chart.draw(data, options);
}

      google.setOnLoadCallback(drawChart3);
function drawChart3() {
  var data = google.visualization.arrayToDataTable([
    ['Year', '미세먼지'],
    ['1월',  17],
    ['2월',  15],
    ['3월',  20],
    ['4월',  14],
	  ['5월',  15],
	  ['6월',  30],
	  ['7월',  36],
	  ['8월',  31],
	  ['9월',  20],
	  ['10월',  21],
	  ['11월',  20],
	  ['12월',  13]

  ]);

  var options = {
    title: '* 월별 공기질 정보',
	  curveType: 'function'
  };

  var chart = new google.visualization.ColumnChart(document.getElementById('chart_div3'));
  chart.draw(data, options);
}


</script>
					<div class="container">
			      		<h4 class="page-header"><span class="glyphicon glyphicon-edit"></span> 대시보드</h4>
			      		<div class="panel">
				      		<div class="row">
				      			<div class="col-xs-12">
									<div id="chart_div1" ></div>
								</div>
				      		</div>

				      		<div class="row">
				      			<div class="col-xs-6">
									<div id="chart_div2" ></div>
								</div>
				      			<div class="col-xs-6">
									<div id="chart_div3" ></div>
								</div>
				      		</div>
				      	</div>
					</div>