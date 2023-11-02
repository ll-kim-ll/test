<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<style>
  #table1 {
    width: 75%;
    border: 1px solid #444444;
    border-collapse: collapse;
	margin-left:auto;
    margin-right:auto;

  }
  #table1 th, #table1 td {
    border: 1px solid #444444;
	text-align:center;
  }

    #table2 {

    border: 1px solid #444444;
    border-collapse: collapse;
	margin-left:auto;
    margin-right:auto;

  }
  #table2 th, #table2 td {
    border: 1px solid #444444;
	text-align:center;
  }

  table, td, th {
    border-collapse : collapse;
		margin-left:auto;
    margin-right:auto;
};
</style>

<div style="height: 400px;">
	<div style="width:40%;float:left">
		<div>
			<table id="table2" style="width:100%;">
				<head>
					<tr>
						<th style="width: 15%;">순번</th>
						<th style="width: 20%;">지역</th>
						<th style="width: 40%;">명칭</th>
						<th style="width: 15%;">기능</th>
					</tr>
				<thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>경기도</td>
						<td>배곧테크노벨리1</td>
						<td><button>전환</button></td>
					</tr>
					<tr>
						<td>2</td>
						<td>경기도</td>
						<td>배곧테크노벨리2</td>
						<td><button>전환</button></td>
					</tr>
					<tr>
						<td>3</td>
						<td>경기도</td>
						<td>배곧테크노벨리3</td>
						<td><button>전환</button></td>
					</tr>
					<tr>
						<td>4</td>
						<td>경기도</td>
						<td>배곧테크노벨리4</td>
						<td><button>전환</button></td>
					</tr>
					<tr>
						<td>5</td>
						<td>경기도</td>
						<td>배곧테크노벨리5</td>
						<td><button>전환</button></td>
					</tr>

				</tbody>
			</table>

			<p><p><p><p><p><p>

			<table id="table1" style="width:100%">
				<head>
					<tr>
						<th style="width: 10%;">구역</th>
						<th style="width: 20%;">온도(°C)</th>
						<th style="width: 20%;">습도(%)</th>
						<th style="width: 20%;">미세먼지(㎍/m³)</th>
						<th style="width: 30%;">기능</th>
					</tr>
				<thead>
				<tbody>
					<tr>
						<td>1층</td>
						<td>25°C</td>
						<td>60%</td>
						<td>좋음</td>
						<td><button>강제 순환</button><button style="margin-left: 10px;">피톤치드</button></td>
					</tr>
					<tr>
						<td>2층</td>
						<td>27°C</td>
						<td>50%</td>
						<td>보통</td>
						<td><button>강제 순환</button><button style="margin-left: 10px;">피톤치드</button></td>
					</tr>
					<tr>
						<td>3층</td>
						<td>24°C</td>
						<td>61%</td>
						<td>좋음</td>
						<td><button>강제 순환</button><button style="margin-left: 10px;">피톤치드</button></td>
					</tr>
					<tr>
						<td>4층</td>
						<td>25°C</td>
						<td>60%</td>
						<td>좋음</td>
						<td><button>강제 순환</button><button style="margin-left: 10px;">피톤치드</button></td>
					</tr>
					<tr>
						<td>5층</td>
						<td>25°C</td>
						<td>60%</td>
						<td>좋음</td>
						<td><button>강제 순환</button><button style="margin-left: 10px;">피톤치드</button></td>
					</tr>
					<tr>
						<td>6층</td>
						<td>25°C</td>
						<td>60%</td>
						<td style="background-color:red;">나쁨</td>
						<td><button>강제 순환</button><button style="margin-left: 10px;">피톤치드</button></td>
					</tr>
					<tr>
						<td>7층</td>
						<td>25°C</td>
						<td>60%</td>
						<td>좋음</td>
						<td><button>강제 순환</button><button style="margin-left: 10px;">피톤치드</button></td>
					</tr>

				</tbody>

			</table>

		</div>
	</div>


	<div style="width:60%;float:right">
		<div id="chart_div1" style="width: 100%; height: 450px;"></div>
	</div>
</div>




<div>
	<div id="chart_div4" style="width: 100%; height: 500px;"></div>
</div>


<p>
<div>
	<table>
		<tr>
			<td><div id="chart_div3" style="width: 800px; height: 500px;"></div></td>
			<td><div id="chart_div2" style="width: 800px; height: 500px;"></div></td>
		</tr>
	</table>
</div>




<script type="text/javascript">

	  google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart1);

function drawChart1() {
        var data = google.visualization.arrayToDataTable([
	['층', '온도(°C)', '습도(%)', '미세먼지(㎍/m³)'],
						['1층',19,30,9],
						['2층',30,50,20],
						['3층',25,65,17],
						['4층',22,52,8],
						['5층',24,34,10],
						['6층',26,36,30],
						['7층',25,35,15]
        ]);

        var options = {
          title: '배곧테크노벨리(전체)',
          hAxis: {title: '',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div1'));
        chart.draw(data, options);
      }

////////////////////

google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart2);

function drawChart2() {
    var data = google.visualization.arrayToDataTable([
	['월', '온도(°C)', '습도(%)', '미세먼지(㎍/m³)'],
						['1',30,50,9],
						['2',25,65,15],
						['3',22,52,8],
						['4',24,34,33],
						['5',26,36,45],
						['6',25,35,66],
						['7',20,40,50],
						['8',20,40,48],
						['9',20,50,40],
						['10',20,50,33],
						['11',20,60,15],
						['12',20,60,8]

		]);

    var options = {
        chart: {
        title: '월별',
        subtitle: '',
        }
    };

    var chart = new google.charts.Bar(document.getElementById('chart_div2'));
    chart.draw(data, google.charts.Bar.convertOptions(options));
}

//////////////////////
	      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart3);

function drawChart3() {
        var data = google.visualization.arrayToDataTable([
	['시간', '온도(°C)', '습도(%)', '미세먼지(㎍/m³)'],
						['월',19,30,35],
						['화',30,50,22],
						['수',25,65,60],
						['목',22,52,15],
						['금',24,34,10],
						['토',26,36,24],
						['일',25,35,19]
        ]);

        var options = {
          title: '요일별',
          hAxis: {title: '',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div3'));
        chart.draw(data, options);
      }


//////////////////////
	  google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart4);

function drawChart4() {
        var data = google.visualization.arrayToDataTable([
	['시간', '온도(°C)', '습도(%)', '미세먼지(㎍/m³)'],
						['01',19,30,9],
						['02',30,50,20],
						['03',25,65,17],
						['04',22,52,8],
						['05',24,55,10],
						['06',26,70,20],
						['07',25,71,18],
						['08',24,68,20],
						['09',27,62,19],
						['10',24,65,16],
						['11',22,65,15],
						['12',23,68,16],
						['13',25,55,10],
						['14',22,53,13],
						['15',23,58,9],
						['16',23,60,11],
						['17',24,58,14],
						['18',22,58,10],
						['19',0,0,0],
						['20',0,0,0],
						['21',0,0,0],
						['22',0,0,0],
						['23',0,0,0]

        ]);

        var options = {
          title: '배곧테크노벨리(1층)',
          hAxis: {title: '',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div4'));
        chart.draw(data, options);
      }

////////////////////

</script>