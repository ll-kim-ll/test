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
 						loadData();
	 					break;
				}
			});

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

			loadData();
		});
	}

	// 데이터 조회
	function loadData(){
		console.log("loadData");
		var from = $("#searchDtFrom").val().replaceAll(/-/gi,"");
		var to = $("#searchDtTo").val().replaceAll(/-/gi,"");
		if(from == "" || to == "" || from > to){
			alert("검색 날짜을(를) 확인해 주세요");
			return false;
		}

		var searchForm = $('#searchForm').serializeArray();
		searchForm[searchForm.length]={name: "pageIndex", value: pageIndex };
		WR.ajax.loadTblDataMultiRow('/device/alramEventList.do', searchForm, 'mainTable', 'pagination', function(result) {
			$("#totalCount").html("(총 : "+result.count+" 건)");
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
			      		<h4 class="page-header"><span class="glyphicon glyphicon-edit"></span> 사용자 <span class="glyphicon glyphicon-chevron-right"></span> 알람이벤트</h4>
						<div class="searchForm" >
							<form id="searchForm" class="form-inline" onsubmit="return false;">
<%-- 								<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/> --%>
								<div class="form-group">
									<div class="row">
										<div class="form-group">
											<label for="searchRouter" class="control-label" >라우터</label>
											<select class="form-control input-sm" id="searchRouter" name="searchRouter" data-role="combo" data-url="/device/routerList.do" data-default="<c:out value='${sParam.searchRouter}' />" data-prompt="전체">
											<!-- <select class="form-control input-sm" id="searchRouter" name="searchRouter" data-role="combo" data-url="/device/routerList.do" data-default="1100000285" data-prompt="전체"> -->
												<option>라우터 선택</option>
											</select>
										</div>
										<div class="form-group">
											<label for="searchClient">클라이언트</label>
											<select class="form-control input-sm" id="searchClient" name="searchClient" data-role="combo" data-url="/device/clientList.do" data-filter='searchRouter' data-default="<c:out value='${sParam.searchClient}' />" data-prompt="전체">
												<option>클라이언트 선택</option>
											</select>
										</div>
										<div class="form-group">
											<label for="searchDtFrom" class="control-label">검색 날짜</label>
											<input type="text" class="form-control input-sm dtPicker" id="searchDtFrom" name="searchDtFrom" placeholder="년-월-일 부터" value="<c:out value='${sParam.searchDtFrom}' />"> ~
											<input type="text" class="form-control input-sm dtPicker" id="searchDtTo" name="searchDtTo" placeholder="년-월-일 까지" value="<c:out value='${sParam.searchDtTo}' />"">
										</div>
									</div>
								</div>
								<button type="button" class="btn btn-primary btn-md pull-right" style="" id="btnSearch">조회</button>
							</form>
						</div>

						<div class="panel">
							<div class="panel-header-grey">
								<span class="glyphicon glyphicon-grain"></span> 알람이벤트 목록
							</div>
							<div class="result-list table-responsive" style="padding-top: 0px;">
								<span class="total-count-info" id="totalCount">(총 : 0 건)</span>
								<table id="mainTable" class="table table-list" data-hidden-value="seq" data-url="">
									<thead>
										<tr>
											<th data-col="rn">번호</th>
											<th data-col="eqpmnId">장비 ID</th>
											<th data-col="no">클라이언트</th>
											<th data-col="eqpmnSe">장비구분</th>
											<th data-col="eventSe">이벤트구분</th>
											<th data-col="eventCode">이벤트코드</th>
											<th data-col="eventTime">이벤트시간</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="7" style="text-align:center">등록된 자료가 없습니다.</td>
										</tr>
									</tbody>
								</table>
								<nav class="text-center">
									<ul class="pagination" id="pagination" data-load-id="loadData()">
									</ul>
								</nav>
							</div>
						</div>
					</div>