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
		WR.ajax.loadTblDataMultiRow('/device/environmentInfo.do', searchForm, 'mainTable', 'pagination', function(result) {
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
			      		<h4 class="page-header"><span class="glyphicon glyphicon-edit"></span> 사용자 <span class="glyphicon glyphicon-chevron-right"></span> 환경정보</h4>
						<div class="searchForm" >
							<form id="searchForm" class="form-inline" onsubmit="return false;">
<%-- 								<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/> --%>
								<div class="form-group">
									<div class="row">
										<div class="form-group">
											<label for="searchDevice" class="control-label" >디바이스</label>
											<select class="form-control input-sm" id="searchDevice" name="searchDevice" data-role="combo" data-url="/device/deviceList.do" data-default="<c:out value='${sParam.searchDevice}' />" data-prompt="전체">

<!--											<select class="form-control input-sm" id="searchRouter" name="searchRouter" data-role="combo" data-url="/device/routerList.do" data-default="<c:out value='${sParam.searchRouter}' />" data-prompt="전체">	-->
											<!-- <select class="form-control input-sm" id="searchRouter" name="searchRouter" data-role="combo" data-url="/device/routerList.do" data-default="1100000285" data-prompt="전체"> -->
												<option>디바이스 선택</option>
											</select>
										</div>
<!--
										<div class="form-group">
											<label for="searchClient">클라이언트</label>
											<select class="form-control input-sm" id="searchClient" name="searchClient" data-role="combo" data-url="/device/clientList.do" data-filter='searchRouter' data-default="<c:out value='${sParam.searchClient}' />" data-prompt="전체">
												<option>클라이언트 선택</option>
											</select>
										</div>
-->
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
								<span class="glyphicon glyphicon-grain"></span> 환경 정보 목록
							</div>
							<div class="result-list table-responsive" style="padding-top: 0px;">
								<span class="total-count-info" id="totalCount">(총 : 0 건)</span>
								<table id="mainTable" class="table tableMultiRow table-list" data-hidden-value="seq" data-url="">
									<thead>
										<tr>
											<th data-col="seq" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg" >일련번호</th>
											<th data-col="rn">번호</th>
											<th data-col="trnsmisDe">전송일자</th>
											<th data-col="eqpmnId">장비 ID</th>
											<th data-col="no">번호</th>
											<th data-col="tp">온도</th>
											<th data-col="hd">습도</th>
											<th data-col="minuDust1">미세먼지 1.0</th>
											<th data-col="oxgn">산소</th>
										</tr>
										<tr>
											<th data-col="cmo">일산화탄소</th>
											<th data-col="trnsmisTime">전송시간</th>
											<th data-col="minuDust2">미세먼지 2.5</th>
											<th data-col="formaldehyde">포름알데히드</th>
											<th data-col="rgsusr">등록자</th>
											<th data-col="rgsde">등록일자</th>
											<th data-col="updusr">수정자</th>
											<th data-col="updde">수정일자</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="19" style="text-align:center">등록된 자료가 없습니다.</td>
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