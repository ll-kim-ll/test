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

			var test = '<c:out value="${test}" />';
			console.log(test);

			/* 버튼 클릭 액션 */
			$('button').on('click', function() {
				console.log("this.id("+this.id+")");
				console.log("$(this)[0]("+$(this)[0].id+")");
				console.log("$(this).attr("+$(this).attr('id')+")");

				switch ($(this).attr('id')) {
					case "alert":
						console.log("button_alert");
						break;
					case "confirm":
						console.log("button_alert");
						break;
				}
			});


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


		    /*****************************************************
		    * WR 모듈 ajax 호출 예제
		    * WR 모듈의 경우 ajax contentType: "application/x-www-form-urlencoded; charset=UTF-8" 으로 설정되어 있어 java @RequestParam Map<String, Object> param 또는 @ModelAttribute 으로 데이터 받아야 함.
		    *****************************************************/
			var searchVo = $('#searchForm').serializeArray();
			searchVo[searchVo.length]={name: "pageIndex", value: pageIndex };

			WR.callPage('/device/command.do', searchVo);

			WR.ajax.loadTblData('/device/routerDataList.do',searchVo, 'mainTable', 'pagination');

			WR.ajax.loadTblData('/device/routerDataList.do', searchVo, 'mainTable', 'pagination', function(result) {
				$('#mainTable').find('td[data-col="realloadGrton"]').number(true);
				$('#mainTable').find('td[data-col="realloadGrton"]').css('text-align', 'right');
			});


			WR.ajax.loadJson('/req/selectBerthAsignList.do', arr, function(result){
				$('#totalCount').text("(총 :"+result.count+" 건)");
			});


			WR.ajax.loadJson('/device/routerList.do', null, function(result){
				console.log(result);
			});


			var params = {};
			params={"keyword": "test"};
			for(var i=0; i<searchVo.length; i++) {
				params[searchVo[i].name]=searchVo[i].value;
			}

		    /*****************************************************
		    * 일반 ajax 호출 예제
		    * contentType : 'application/json; charset=utf-8' 으로 설정된 경우 {"keyword": "test"} 타입으로 데이터 전송해야 하며, java에서 @RequestBody Map<String, Object> param  또는 @ModelAttribute 으로 데이터 받아야 함.
		    * contentType: "application/x-www-form-urlencoded; charset=UTF-8" 설정된 경우 form.serializeArray()로 데이터 데이터 전송하면 되고, java @RequestParam Map<String, Object> param 또는 @ModelAttribute 으로 데이터 받아야 함.
		    * @RequestBody 의 경우 get 호출 시 오류 발생한다.
		    *****************************************************/
			$.ajax({
	    		url: "/device/routerJsonDataList.do",
	    		type: 'POST',
	    		contentType : 'application/json; charset=utf-8', // java에서 @RequestBody Map<String, Object> param  또는 @ModelAttribute 으로 데이터 받아야 함.
//	    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",	// form.serializeArray() 데이터 그대로 넘기면 됨, java @RequestParam Map<String, Object> param 또는 @ModelAttribute 으로 데이터 받아야 함.
	    		dataType    : 'json',
	    		data: JSON.stringify(params),
	    		success: function(data, status, jqXHR) {
	    			console.log(data);
	    			console.log(status);
	    			console.log("Status Code : "+jqXHR.statusText+"\n"+"Status Code : "+ jqXHR.status);

	    			$("#btn_get_list").trigger("click");
	    		},
	    		error : function(error, status, jqXHR) {
	    			console.log("Status Code : "+"ERR"+"\n"+"Status Code : "+ error.status+"\n"+"Status Message : "+ error.statusText);
	    		},
	    		complete : function() {
	    			console.log("complete");
					console.log(JSON.stringify(params));
	    	    }
	    	});

		    /*****************************************************
		    * 버튼 클릭 폼 ajax 호출 예제
		    *****************************************************/
			endpoint=$('#endpoint').text();
			$("#btn_psn_save").on("click", function(){

		    	var form = $(this).closest('form');
		    	var formData = form.serializeArray();
		    	var params = {};
		    	params={"keyword": "test"};
				for(var i=0; i<formData.length; i++) {
					params[formData[i].name]=formData[i].value;
				}

				$.ajax({
		    		url: endpoint,
		    		type: 'POST',
		    		contentType : 'application/json; charset=utf-8', // java에서 @RequestBody Map<String, Object> param  또는 @ModelAttribute 으로 데이터 받아야 함.
//		    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",	// form.serializeArray() 데이터 그대로 넘기면 됨, java @RequestParam Map<String, Object> param 또는 @ModelAttribute 으로 데이터 받아야 함.
		    		dataType    : 'json',
		    		data: JSON.stringify(params),
		    		success: function(data, status, jqXHR) {
		    			console.log(data);
		    			console.log(status);
		    			console.log("Status Code : "+jqXHR.statusText+"\n"+"Status Code : "+ jqXHR.status);

		    			$("#btn_get_list").trigger("click");
		    		},
		    		error : function(error, status, jqXHR) {
		    			console.log("Status Code : "+"ERR"+"\n"+"Status Code : "+ error.status+"\n"+"Status Message : "+ error.statusText);
		    		},
		    		complete : function() {
		    			console.log("complete");
    					console.log(JSON.stringify(params));
		    	    }
		    	});
			});

		    /*
		    * $.get 호출 후 load 이용한 트리 상세 데이터 변경 샘플
		    * $.get(url+"?key=v&key=v&", callback)
		    */
//		    $.get(url, params, function (data, status, jqXHR) {
		    $.get(url+"?dn="+encodeURIComponent(encodeURIComponent(dn)), function (data, status, jqXHR) {
				// load html, jsp 로드 후 처리
				 $("#data .default").load(htmlfile, function() {
					 	// 문서의 input 부분 데이터 넣기
						$.each($("#form1 input"), function(i,v) {
							//console.log(v);
							// 해당 데이터 넣기
						    $(v).val(data[v.name]);
						});
				 });
			});

		    /*
		    * $.post(url, param, callback)
		    */
			$.post("<c:url value='/common/data/selectCityList.do'/>", params, function(data, status, jqXHR){
				$('#searchCombo').empty();
				var hidCenter = '<c:out value="${hidCenter}" />';
				if(data.length==0){
	 					appendStr = '<option value="">없음</option>';
	 				}else{
	 					appendStr = '<option value="">전체</option>';
	 				}
					$('#searchCombo').append(appendStr);
		 			$.each(data, function(index, value) {
						if(hidCenter == value.orgnztId) {
							appendStr = '<option value="' + value.orgnztId + '" svaluected="svaluected">' + value.orgnztNm + "</option>";
						} else {
							appendStr = '<option value="' + value.orgnztId + '">' + value.orgnztNm + "</option>";
						}
						$('#searchCombo').append(appendStr);
					});
			});

		    /*
		    * $.getJSON(url, param, callback)
		    */
			$.getJSON(URL, $("#baseFrame").serialize(), function(data, status, jqXHR){
				console.log
			});



			/* .load를 이용해 해당 위치 jsp 내용 추가 후 후처리 로직   */
			function searchRecipe(pageNo) {
				var page = pageNo||1;
				$("#selectGroupList").load("<c:url value='/center/date/selectCenterRecipeList.do' />", [{name: 'pageIndex', value:page}
						, {name: 'searchKeyword', value:$('#searchKeyword').val()}, {name: 'searchCondition', value:$('#searchCondition').val()}], function() {
				  $('#searchKeyword').focus();
			 	});
			}


			/*
		    * 또 다른 호출 방법 ajax, get, post, getJson, load 모두 적용 가능
		    * 호출 뒤에 .don, fail, always 사용(호출 흐름 success=>complete=>don=>always, error=>complete=>fail=>always)
			* 명명 함수 선언 후 호출 방식, 익명 함수 표현 후 호출 방식
			*/
			$.ajax({
			    url: url,
			    type: 'post',
			    dataType: 'json',
			    beforeSend: ''
			  })
			  .done(function() {
			    //
			  })
			  .fail(function() {
			    // handle request failures
			  })
			  .always(function() {
			    // remove loading image maybe
			  });

			// 함수 방식
			function xhr_get(url) {
				  return $.ajax({
							    url: url,
							    type: 'post',
							    dataType: 'json',
							    beforeSend: ''
							  })
							  .done(function() {
							    //
							  })
							  .fail(function() {
							    // handle request failures
							  })
							  .always(function() {
							    // remove loading image maybe
							  });
			}

			xhr_get("/device/routerList.do").done(function(data) {
			  	// xhr_get의 본문 함수 먼저 실행 후 실행 됨 done=>always=>this
				// do stuff with index data
			});

			// 익명 함수 표현 후 호출 방식
			var jqxhr = $.ajax({
								url: "/device/routerList.do",
							    type: 'post',
							    dataType: 'json',
							    beforeSend: ''
							  })
							  .done(function() {
							    //
							  })
							  .fail(function() {
							    // handle request failures
							  })
							  .always(function() {
							    // remove loading image maybe
							  });
			// Perform other work here ...

			// Set another completion function for the request above
			jqxhr.always(function() {
			  	// xhr_get의 본문 함수 먼저 실행 후 실행 됨 done=>always=>this
				// do stuff with index data
			});


			/*
			* 테이블 조회 데이터 자동 출력 getJson, Ajax 2가지 예제
			*/
			// getJson 테이블 데이터 자동 설정
			function dataSearche(){
				var form = $(this).closest('form');
		    	var params = form.serialize();

		    	var keyValues = "data1,data2";

		    	$.getJSON("/url", params, function(data, status, jqXHR) {
		    		var tbody = $('#requestGetListResult > tbody');
		    		tbody.empty();

		    		if(!data.success) {
		    			alert(data.message);
		    			return;
		    		}

		    		var headers = $('#requestGetListResult > thead > tr > th');
		    		for(var k in data.logList) {
		    			var r=data.logList[k];
		    			var row='<tr data-psnid="'+r['psnId']+'" data-cmpId="'+r['cmpId']+'">';

						var row="<tr";
						if(keyValues!="") {
							$.each(keyValues.split(","), function() {
								var v=data.logList[k][this]||"";
								if(v!="") {
									row+=" data-"+this+"='"+v+"'";
								}
							});
						}
						row+=">";

		    			headers.each(function() {
		    				var col = $(this).data('col');
		    				var val = r[col] != null ? r[col]:'';
			    			row+='<td>'+val+'</td>';
		    			});
		    			row+='</tr>';
		    			tbody.append(row);
		    		}

				 	if(data.data.logList < 0){
						tbody.append('<tr> <td colspan="'+(headers.length+1)+'" style="text-align:center">등록된 자료가 없습니다.</td></tr>');
					}

		    	});
			}

			// ajax 테이블 데이터 자동 설정
			function loadData(){
				var searchForm = $('#searchForm').serializeArray();
				searchForm[searchForm.length]={name: "pageIndex", value: pageIndex };

				var tableId = "mainTable";
				var keyValues = "data1,data2";

				 $.ajax({
					 url: "/device/commandRouterList.do",
					 type: 'POST',
					 data: searchForm,
					 dataType: 'json',
					 success: function(data){
						var headers = $('#'+tableId+' > thead > tr > th');
						var tbody = $('#'+tableId+' > tbody');

						tbody.empty();


						for(var k in data.data) {
							var r=data.data[k];

							var row="<tr";
							if(keyValues!="") {
								$.each(keyValues.split(","), function() {
									var v=data.logList[k][this]||"";
									if(v!="") {
										row+=" data-"+this+"='"+v+"'";
									}
								});
							}
							row+=">";

							headers.each(function() {
								var col = $(this).data('col');
								var val = r[col] != null ? r[col]:'';
								row+='<td>'+val+'</td>';
							});
							row+='</tr>';
							tbody.append(row);
						}

					 	if(data.data.length < 0){
							tbody.append('<tr> <td colspan="'+(headers.length+1)+'" style="text-align:center">등록된 자료가 없습니다.</td></tr>');
						}
					 }
				  });
			}

			/*
			* 테이블 클릭 이벤트 단일, 복수 처리
			*/
			// 테이블 클릭 이벤트 처리 단일
			$("#mainTable > tbody").on("click", "td", function(e){
				console.log(e.target);
				if($(e.target).attr("colspan") != undefined && $(e.target).attr("colspan") != null && $(e.target).attr("colspan") != ""){
					return false;
				}

				var params1 =[];
				var params2 ={};
				var sel_row=$(e.target).parent('tr');
				$.each(sel_row.data(), function(k,v){
					console.log(k+"-"+v);
					params1[params1.length] = {"name":k, "value":v}; ;
					params2[k] = v;
				});

				console.log(params1);
				console.log(params2);

				// 후 처리
			});

			// 테이블 클릭 이벤트 처리 복수
			$("table > tbody").on("click", "td", function(e){
				console.log(e.target);
				if($(e.target).attr("colspan") != undefined && $(e.target).attr("colspan") != null && $(e.target).attr("colspan") != ""){
					return false;
				}

				var params1 =[];
				var params2 ={};
				var table = $(this).closest('table');

				var url = table.data("url");

				if(url != undefined && url != null && url != ""){
					var sel_row=$(e.target).parent('tr');
					$.each(sel_row.data(), function(k,v){
						console.log(k+"-"+v);
						params1[params1.length] = {"name":k, "value":v}; ;
						params2[k] = v;
					});
					console.log(params1);
					console.log(params2);

					// 후 처리
				}
			});

			// 테이블 클릭(상세)
//			$("#mainTable > tbody").on("click", "td", function(e){
			$('#mainTable > tbody').on('click', function(e) {
				console.log(e.target);
				if($(e.target).attr("colspan") != undefined && $(e.target).attr("colspan") != null && $(e.target).attr("colspan") != ""){
					return false;
				}

				if($(e.target).is('td')) {
					if($(e.target).is('td[data-col="reqstEntrpsNm"]')){
						var _value = $(e.target).text();

						if(typeof _value == "undefined" || _value=="") return false;

						var searchVo = $('#searchForm').serializeArray();
						searchVo[length]={name: "reqstEntrpsNm", value: _value };

						WR.ajax.doPopup('popupEntrpsSts', '/popup/sts/berthEntrpsStsPopup.do',searchVo);
					}

					else{
						var sel_row=$(e.target).parent('tr');
						var _value = sel_row.data('berthreqstseq');

						if (typeof _value =="undefined") return false;

						var searchVo = $('#searchForm').serializeArray();

						searchVo[length]={name: "berthMtgSeq", value: sel_row.data('berthmtgseq') };
						searchVo[length]={name: "berthAsignId", value: sel_row.data('berthasignid') };
						searchVo[length]={name: "berthReqstSeq", value: _value };

						WR.callPage('/req/selectBerthAsignForm.do', searchVo);
					}

				}
			});

			// 테이블 클릭 데이터 바인딩 함수 생성
			function tableDataBind(target){
				var sel_row = $(target).parent('tr');
				var td = sel_row.find('td');

//				var inputs = $('#mainForm').find(':input'); // 모든 버튼 까지 모든 속성을 가지고 온다.
				var input = $('#mainForm').find('input');
				var select = $('#mainForm').find('select');

				input.each(function() {
					var col = $(this).attr("name");

					td.each(function(){
						if($(this).data("col") == col){
							$("#"+col).val($(this).text());
						}
					});
				});

				select.each(function() {
					var col = $(this).attr("name");

					td.each(function(){
						if($(this).data("col") == col){
							$("#"+col).val($(this).text());
						}
					});
				});
			}

		    /* each 오브젝트 루프 */
   			var test111 = {"test1":1 ,"test2":2 ,"test3":3 ,"test4":4 };

    	    $.each(test111, function (key, val) {
    	    	console.log(key);
    	    	console.log(val);
    	    });

		    /* 오브젝트 키 추출 후 루프 */
    		var dataKeys = Object.keys(test111);
			console.log(dataKeys);


			for(var i=0; i<dataKeys.length; i++){
    			console.log(i);
    			console.log(dataKeys[i]);

    			console.log(data[dataKeys[i]]);

			}

    		for(var cData in dataKeys){
    			console.log(cData);
    			console.log(dataKeys[cData]);

    			console.log(data[dataKeys[cData]]);

    		}

    		for(var cData of dataKeys){
    			console.log(cData);
    			console.log(data[cData]);

    		}


    		/* 문자자르기 */
			/* 0번째 부터 마지막 -1 만큰 자름 */
 			dAddRows = dAddRows.slice(0, -1);

			/* 문자 자르기 */
	  		dAddRows = dAddRows.substr(0, str.length - 1); // 시작 인덱스 부터 몇 자리까지
 			dAddRows = dAddRows.substring(0, str.length - 1); // 시작 인덱스 부터 선택한 인덱스까지

			/* 정규식 제거 */
			dAddRows = dAddRows.replace(/,$/, '');
			dAddRows = dAddRows.replace(/,\s*$/, '');

/* 			/ : 정규식의 시작과 끝
			\s : 공백
			* : 있을수도 있고 없을 수도 있고, 여러개가 있을수도 있음
			$ : 문자열의 마지막
 */

			/* show hide */
 			function dis(){
				if($('#dis').css('display') == 'none'){ // 숨김 처리 체크
					$('#dis').show();
				}else{
					$('#dis').hide();
				}
			}

			/* 셀렉트 박스 초기화 */
			var selectChageData = function(selector,itemValue, url) {
				selector.empty();
				$.getJSON(url, "", function(data) {
					if(data.code!=200) {
						alert("loading error : "+selector.attr('name')+" "+data.message);
						return;
					}
					var list = data.list;

					if(selector.attr('name') == "accessGroup"){
						selector.append("<option value='-1'></option>");
					}
					else{
						selector.append("<option value=''></option>");
					}
					for(var k in list) {
						var r = list[k];

						if(itemValue == r['value']){
							selector.append("<option value='"+r['value']+"' selected>"+r['name']+"</option>")
						}
						else{
							selector.append("<option value='"+r['value']+"'>"+r['name']+"</option>")
						}
					}
				});
			};

			/* 테이블 클릭 데이터 이동 시키기 */
			$("#requestAccessGroupGetListResultNew").on("dblclick", function(e) {
				if(!$("#checkAccessDoor").is(":checked")){
					return false;
				}

				if($(e.target).is('td')) {
					var tbody = $('#requestAccessGroupGetListResult > tbody');
					var sel_row=$(e.target).parent('tr');
					var td = sel_row.find('td');

	//				var row='<tr><td><input type="button" value="Delete"></td>';
					var row='<tr>';
					row+='<td>'+td.eq(0).text()+'</td>';
					row+='<td>'+td.eq(1).text()+'</td>';
					row+='<td>'+td.eq(2).text()+'</td>';
					row+='<td>'+td.eq(3).text()+'</td>';
					row+='<td>'+td.eq(4).text()+'</td>';
					row+='<td>'+td.eq(5).text()+'</td>';
					row+='<td>'+td.eq(6).text()+'</td>';
					row+='<td>'+td.eq(7).text()+'</td></tr>';
					tbody.append(row);

					$(e.target).closest('tr').remove()
				 }
			});


			/* 테이블 리스트 클릭 */
			$("table").on('click',function(e) {
				if ($(e.target).is('td')) {
					var sel_row = $(e.target).parent('tr');
					var all_row = $(e.target).parent('tr').parent('tbody').find('tr');

					all_row.each(function(){
						$(this).removeClass("trClick")
					});

					sel_row.addClass("trClick");
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
