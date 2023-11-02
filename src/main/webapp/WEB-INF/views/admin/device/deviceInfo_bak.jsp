<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.standalone.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>

<script>
	window.onload = function() {
		$(document).ready(function() {
			/* 버튼 체크 */
			$('button').on('click', function() {
				switch ($(this).attr('id')) {
 					case "btnSearch": // 조회
 						pageIndex = 1;
 						$("#btnCancel").trigger("click");
 						loadData();
	 					break;
				}
			});

			// 테이블 클릭 이벤트
			WR.table.tableClick("mainTable", "array", function(params) {
				console.log("params");
				loadDetailData(params);
			});

/*
			$("table#mainTable > tbody").on("click", "td", function(e){
				if($(e.target).attr("colspan") != undefined && $(e.target).attr("colspan") != null && $(e.target).attr("colspan") != ""){
					return false;
				}
				var params =[];
				var table = $(this).closest('table');

				var sel_row=$(e.target).parent('tr');
				$.each(sel_row.data(), function(k,v){
					params[params.length] = {"name":k, "value":v}; ;
				});

				loadDetailData(params);

			});
*/
			// 검색 시작일 달력 셋팅
			$("#searchDtFrom").datepicker({
				format : "yyyy-mm-dd",
				language : "ko",
				autoclose : true,
			}).datepicker('setDate', new Date(new Date()))
			.on('changeDate', function(e){
				if($("#searchDtFrom").val() > $("#searchDtTo").val()){
					$("#searchDtTo").val($("#searchDtFrom").val());
				}
			});

			// 검색 종료일 달력 셋팅
			$("#searchDtTo").datepicker({
				format : "yyyy-mm-dd",
				language : "ko",
				autoclose : true,
			}).datepicker('setDate', new Date(new Date()))
			.on('changeDate', function(e){
				if($("#searchDtFrom").val() > $("#searchDtTo").val()){
					$("#searchDtFrom").val($("#searchDtTo").val());
				}
			});

		});
	}

	// 데이터 조회
	function loadData(){
		var from = $("#searchDtFrom").val().replaceAll(/-/gi,"");
		var to = $("#searchDtTo").val().replaceAll(/-/gi,"");
		if(from == "" || to == "" || from > to){
			alert("검색 날짜을(를) 확인해 주세요");
			return false;
		}

		var searchForm = $('#searchForm').serializeArray();
		searchForm[searchForm.length]={name: "pageIndex", value: pageIndex };

		WR.ajax.loadTblData('/admin/deviceInfoList.do', searchForm, 'mainTable', 'pagination', function(result) {
			$("#totalCount").html("(총 : "+result.count+" 건)");
		});

	}

	// 데이터 조회
	function loadDetailData(params){
		WR.ajax.loadTblData('/admin/clientList.do', params, 'detailTable', null, function(result) {
			$("#detailCount").html("(총 : "+result.count+" 건)");
		});

	}

	/**
	 * 페이징 처리 펑션
	 */
	function pagingProcess(page_id, page) {
		pageIndex = page;
		loadData();
	}

</script>
					<div class="">
			      		<h4 class="page-header"><span class="glyphicon glyphicon-edit"></span> 관리자 <span class="glyphicon glyphicon-chevron-right"></span> 장치 조회</h4>
						<div class="searchForm" >
							<form id="searchForm" class="form-inline" onsubmit="return false;">
<%-- 								<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/> --%>
								<div class="form-group">
									<label for="searchSe" class="control-label" >검색 구분</label>
									<select class="form-control input-sm" id="searchSe" name="searchSe" >
										<option value="">전체</option>
										<option value="cstmrNo">고객번호</option>
										<option value="cstmrNm">고객명</option>
										<option value="telno">전화번호</option>
										<option value="eqpmnId">장비 ID</option>
									</select>
								</div>
								<div class="form-group">
									<label for="searchKeyword" class="control-label">검색어</label>
									<input type="text" class="form-control input-sm" id="searchKeyword" name="searchKeyword" placeholder="검색어" value="">
								</div>
								<div class="form-group">
									<label for="searchClient" class="control-label">검색 날짜</label>
									<input type="text" class="form-control input-sm dtPicker" id="searchDtFrom" name="searchDtFrom" placeholder="년-월-일 부터" value="${searchDtFrom }"> ~
									<input type="text" class="form-control input-sm dtPicker" id="searchDtTo" name="searchDtTo" placeholder="년-월-일 까지" value="${searchDtTo }">
								</div>
								<button type="button" class="btn btn-primary btn-md pull-right" style="" id="btnSearch">조회</button>
							</form>
						</div>

						<div class="panel">
							<div class="panel-header-grey">
								<span class="glyphicon glyphicon-grain"></span> 장치 목록
							</div>
							<div class="result-list table-responsive" style="padding-top: 0px;">
								<span class="total-count-info" id="totalCount">(총 : 0 건)</span>
								<table id="mainTable" class="table table-hover table-list" data-hidden-value="eqpmnId" data-url="">
									<thead>
										<tr>
											<th data-col="eqpmnId">eqpmnId</th>
											<th data-col="cstmrNo">cstmrNo</th>
											<th data-col="knd">knd</th>
											<th data-col="ty">ty</th>
											<th data-col="ip">ip</th>
											<th data-col="macadrs">macadrs</th>
											<th data-col="sttus">sttus</th>
											<th data-col="frmwrVer">frmwrVer</th>
											<th data-col="routerRm">routerRm</th>
											<th data-col="cstmrNm">cstmrNm</th>
											<th data-col="cstmrSe">cstmrSe</th>
											<th data-col="telno">telno</th>
											<th data-col="lclasGroup">lclasGroup</th>
											<th data-col="mlsfcGroup">mlsfcGroup</th>
											<th data-col="sclasGroup">sclasGroup</th>
											<th data-col="lclasArea">lclasArea</th>
											<th data-col="mlsfcArea">mlsfcArea</th>
											<th data-col="sclasArea">sclasArea</th>
											<th data-col="infoOthbcAt">infoOthbcAt</th>
											<th data-col="customerRm">customerRm</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="20" style="text-align:center">등록된 자료가 없습니다.</td>
										</tr>
									</tbody>
								</table>
								<nav class="text-center">
									<ul class="pagination" id="pagination" data-load-id="loadData()">
									</ul>
								</nav>
							</div>
						</div>

						<div class="panel">
							<div class="panel-header-grey">
								<span class="glyphicon glyphicon-grain"></span> 클라이언트 목록
							</div>
							<div class="result-list table-responsive" style="padding-top: 0px;">
								<span class="total-count-info" id="detailCount">(총 : 0 건)</span>
								<table id="detailTable" class="table table-hover table-list" data-hidden-value="eqpmnId,no" data-url="">
									<thead>
										<tr>
											<th data-col="rn">번호</th>
											<th data-col="eqpmnId">eqpmnId</th>
											<th data-col="no">no</th>
											<th data-col="eqpmnNm">eqpmnNm</th>
											<th data-col="macadrs">macadrs</th>
											<th data-col="fan">fan</th>
											<th data-col="humidifier">humidifier</th>
											<th data-col="motionSensor">motionSensor</th>
											<th data-col="uv">uv</th>
											<th data-col="useAt">useAt</th>
											<th data-col="trnsmisAt">trnsmisAt</th>
											<th data-col="useAt">rm</th>
											<th data-col="useAt">rgsusr</th>
											<th data-col="useAt">updusr</th>
											<th data-col="useAt">updde</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="15" style="text-align:center">등록된 자료가 없습니다.</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>