<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<style>
	td{
		border-collapse : collapse;
		border : 0px solid black;
	}
	table > tbody > tr > td div{
		text-align: center;
	}
	.td_solid{
		border-collapse : collapse;
		border : 1px solid black;
	}

</style>

<script>
var _col = 7;
var _row = 4;
var _time = 3

var _width = (100/_col).toFixed(1);
var _hight = (100/_row).toFixed(1);

var data = [
				[{"name":1, "value":20},
					{"name":2, "value":50},
					{"name":3, "value":20},
					{"name":4, "value":10},
					{"name":5, "value":30},
					{"name":6, "value":80},
					{"name":7, "value":107}
				],
				[{"name":8, "value":50},
					{"name":9, "value":""},
					{"name":10, "value":""},
					{"name":11, "value":""},
					{"name":12, "value":""},
					{"name":13, "value":""},
					{"name":14, "value":15}
					],
				[{"name":15, "value":115},
					{"name":16, "value":""},
					{"name":17, "value":""},
					{"name":18, "value":""},
					{"name":19, "value":""},
					{"name":20, "value":""},
					{"name":21, "value":121}
				],
				[{"name":22, "value":15},
					{"name":23, "value":16},
					{"name":24, "value":130},
					{"name":25, "value":18},
					{"name":26, "value":19},
					{"name":27, "value":110},
					{"name":28, "value":12}
				]
			];

var data1 = [
				[{"name":1, "value":60},
					{"name":2, "value":70},
					{"name":3, "value":70},
					{"name":4, "value":70},
					{"name":5, "value":70},
					{"name":6, "value":30},
					{"name":7, "value":7}
				],
				[{"name":8, "value":70},
					{"name":9, "value":""},
					{"name":10, "value":""},
					{"name":11, "value":""},
					{"name":12, "value":""},
					{"name":13, "value":""},
					{"name":14, "value":""}
					],
				[{"name":15, "value":30},
					{"name":16, "value":1},
					{"name":17, "value":70},
					{"name":18, "value":1},
					{"name":19, "value":1},
					{"name":20, "value":70},
					{"name":21, "value":11}
				]
			];
</script>

<script>
	window.onload = function() {
		$(document).ready(function() {
			var tbody = $("tbody");
			var img = "./1.jpg";
			tbody.empty();

			startView();
/*
//			for(var aData of data){
			for(var i=0; i<_row; i++){
				var aData = data[i];
				var row="<tr style='hight: "+ _hight +"%'>";

//				for(var bData of aData){
				for(var j=0; j<_col; j++){
					var bData = aData[j];
					row += "<td style='width: "+ _width +"%";
					if(bData.value != "" && bData.value != null && bData.value != undefined){
						row += ";border : 1px solid black;'>";
					//row += "<td style='width: "+ _width +"%";
					//if(bData.value != "" && bData.value != null && bData.value != undefined){
					//	row += ";border : 1px solid black;";
					//}
					//row += "'>"
					//row += "<td style='width: "+ _width +"%'>";
						row += "<div>"+bData.name+"(" + bData.value + ")</div>";
					//row += "<div data-name='"+bData.name+"'>"+bData.name+"(" + bData.value + ")</div>";

					//row += "<div><img class='fit-picture' src='./1.jpg' alt=''></div>";
						if(Number(bData.value) > 50){
							img = "<c:url value='/images/2.jpg' />";
						}
						else{
							img = "<c:url value='/images/1.jpg' />";
						}
						row += "<div><img data-name='"+bData.name+"' class='fit-picture' src='"+img+"' alt=''></div>";
						//row += "<div><img class='fit-picture' src='"+img+"' alt=''></div>";
						row += "</td>";
					}
					else{
						row += "'>"
						row += "<div></div>";
					}

				}

				row += "</tr>";
				tbody.append(row);
			}
*/
			var setImg = null;

			startImg = function(){
				setImg = setInterval(function() {
					dataCall();
/*							var _data = WR.ajax.loadJson('/device/minuteMonitoring.do');

							var tbody = $("#mainTbl").children('tbody');
							for(var aData of _data){
								for(var bData of aData){
									//var _img = tbody.find("img[data-name='"+bData.name+"']");
									var _img = tbody.find("img[data-name='"+bData.eqpmnId+"']");
									if(_img.length > 0){
										//if(Number(bData.value) > 50){
										if(Number(bData.minuDust2) > 50){
											_img.attr("src","<c:url value='/images/2.jpg' />");
										}
										else{
											_img.attr("src","<c:url value='/images/1.jpg' />");
										}
									}
								}
							} */
				}, Number(_time)*1000);
			}


			stopImg = function(){
				alert("중지");
				clearInterval(setImg);
			}

			startImg();

		});

/*
 		function dataCall(){
			var data = WR.ajax.loadJson('/device/minuteMonitoring.do');
			return data;
		}
 */


 		function startView(){
			$.ajax({
				url: "<c:url value='/device/minuteMonitoring.do' />",
				type: 'POST',
				async: false,
				dataType: 'json',
				success: function (data, textStatus, xhr) {

					var row="<tr style='hight: "+ _hight +"%'>";

					for(var j=0; j<data.length; j++){
						var bData = data[j];
						row += "<td style='width: "+ _width +"%";
						if(bData.minuDust2 != "" && bData.minuDust2 != null && bData.minuDust2 != undefined){
							row += ";border : 1px solid black;'>";
							row += "<div data-name='"+bData.eqpmnId+"'>"+bData.eqpmnId+"(" + bData.minuDust2 + ")</div>";
							if(Number(bData.minuDust2) > 75){
								img = "<c:url value='/images/monitoring/4.jpg' />";
							}
							else if(Number(bData.minuDust2) > 35){
								img = "<c:url value='/images/monitoring/3.jpg' />";
							}
							else if(Number(bData.minuDust2) > 15){
								img = "<c:url value='/images/monitoring/2.jpg' />";
							}
							else{
								img = "<c:url value='/images/monitoring/1.jpg' />";
							}

							row += "<div><img data-name='"+bData.eqpmnId+"' class='fit-picture' src='"+img+"' alt=''></div>";
							row += "</td>";
						}
						else{
							row += "'>"
							row += "<div></div>";
						}

					}

					row += "</tr>";
					$("tbody").append(row);

				}
			});
 		}


 		function dataCall(){
			$.ajax({
				url: "<c:url value='/device/minuteMonitoring.do' />",
				type: 'POST',
				async: false,
				dataType: 'json',
				success: function (data, textStatus, xhr) {
					var _data = data;

					var tbody = $("#mainTbl").children('tbody');
					for(var aData of _data){
						bData = aData;
						//for(var bData of aData){
							//var _img = tbody.find("img[data-name='"+bData.name+"']");
							var _div = tbody.find("div[data-name='"+bData.eqpmnId+"']");
							var _img = tbody.find("img[data-name='"+bData.eqpmnId+"']");

							if(_div.length > 0){
								 _div.html(bData.eqpmnId+"(" + bData.minuDust2 + ")");
							}

							if(_img.length > 0){
								//if(Number(bData.value) > 50){
								if(Number(bData.minuDust2) > 75){
									_img.attr("src","<c:url value='/images/monitoring/4.jpg' />");
								}
								else if(Number(bData.minuDust2) > 35){
									_img.attr("src","<c:url value='/images/monitoring/3.jpg' />");
								}
								else if(Number(bData.minuDust2) > 15){
									_img.attr("src","<c:url value='/images/monitoring/2.jpg' />");
								}
								else{
									_img.attr("src","<c:url value='/images/monitoring/1.jpg' />");
								}
							}
						//}
					}
				}
			});
 		}




		function test(){
		/*
			var tbody = $("#mainTbl").children('tbody');
			var _img = tbody.find('img[data-name="1"]');
			_img.attr("src","./2.jpg");
			var _img2 = tbody.find('img');

			tbody.find('img').each(function(){
				console.log($(this).data("name"));
			});

			var _img2 = tbody.find('img');

			for(var i=0; i<_img2.length; i++){
				_img2[i].src = "./2.jpg";

			}
		*/

			var tbody = $("#mainTbl").children('tbody');
			for(var aData of data1){
				for(var bData of aData){
					var _img = tbody.find("img[data-name='"+bData.name+"']");
					if(_img.length > 0){
						if(Number(bData.value) > 50){
							_img.attr("src","<c:url value='/images/monitoring/2.jpg' />");
						}
						else{
							_img.attr("src","<c:url value='/images/monitoring/1.jpg' />");
						}
					}
				}
			}
		}
	}
</script>
					<div class="">
			      		<h4 class="page-header"><span class="glyphicon glyphicon-edit"></span> 사용자 <span class="glyphicon glyphicon-chevron-right"></span>모니터링 </h4>
						<div class="panel">

							<input type="button" onclick="startImg();" value="Start">
							<input type="button" onclick="stopImg();" value="Stop">
							<table id="mainTbl" style='hight:100%; width:100%;'>
								<thead>
								</thead>
								<tbody>
							<!--
									<tr>
										<td>
											<div>1</div>
											<div><img class="fit-picture" src="./1.jpg" alt=""></div>
										</td>
										<td>
											<div>2</div>
											<div><img class="fit-picture" src="./2.jpg" alt=""></div>
										</td>
										<td>
											<div>3</div>
											<div><img class="fit-picture" src="./1.jpg" alt=""></div>
										</td>
										<td>
											<div>4</div>
											<div><img class="fit-picture" src="./2.jpg" alt=""></div>
										</td>
										<td>
											<div>5</div>
											<div><img class="fit-picture" src="./1.jpg" alt=""></div>
										</td>
										<td>
											<div>6</div>
											<div><img class="fit-picture" src="./2.jpg" alt=""></div>
										</td>
									</tr>
									<tr>
										<td>
											<div>7</div>
											<div><img class="fit-picture" src="./2.jpg" alt=""></div>
										</td>
										<td>
											<div>8</div>
											<div><img class="fit-picture" src="./1.jpg" alt=""></div>
										</td>
										<td>
											<div>9</div>
											<div><img class="fit-picture" src="./2.jpg" alt=""></div>
										</td>
										<td>
											<div>10</div>
											<div><img class="fit-picture" src="./1.jpg" alt=""></div>
										</td>
										<td>
											<div>11</div>
											<div><img class="fit-picture" src="./2.jpg" alt=""></div>
										</td>
										<td>
											<div>12</div>
											<div><img class="fit-picture" src="./1.jpg" alt=""></div>
										</td>
									</tr>
									<tr>
										<td>
											<div>13</div>
											<div><img class="fit-picture" src="./1.jpg" alt=""></div>
										</td>
										<td>
											<div>14</div>
											<div><img class="fit-picture" src="./2.jpg" alt=""></div>
										</td>
										<td>
											<div>15</div>
											<div><img class="fit-picture" src="./1.jpg" alt=""></div>
										</td>
										<td>
											<div>16</div>
											<div><img class="fit-picture" src="./2.jpg" alt=""></div>
										</td>
										<td>
											<div>17</div>
											<div><img class="fit-picture" src="./1.jpg" alt=""></div>
										</td>
										<td>
											<div>18</div>
											<div><img class="fit-picture" src="./2.jpg" alt=""></div>
										</td>
									</tr>
							-->
							</tbody>
						</table>


						</div>
					</div>