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
 					case "btnAdd": // 추가
 						WR.callPage('/device/commandDeviceInsert.do', $('#searchForm').serializeArray());
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

			// 검색
			var searchDtFrom = '<c:out value="${sParam.searchDtFrom}" />';
			var searchDtTo = '<c:out value="${sParam.searchDtTo}" />';

			if(searchDtFrom != ""){
				$("#searchDtFrom").val(searchDtFrom);
			}
			if(searchDtTo != ""){
				$("#searchDtTo").val(searchDtTo);
			}

			loadData();
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

		WR.ajax.loadTblData('/device/commandDeviceList.do', searchForm, 'mainTable', 'pagination', function(result) {
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
			      		<h4 class="page-header"><span class="glyphicon glyphicon-edit"></span> 사용자 <span class="glyphicon glyphicon-chevron-right"></span> 디바이스 설정</h4>
						<div class="searchForm" >
							<form id="searchForm" class="form-inline" onsubmit="return false;">
<%-- 								<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/> --%>
								<div class="form-group">
									<div class="row">
										<div class="form-group">
											<label for="searchDevice" class="control-label" >디바이스</label>
											<select class="form-control input-sm" id="searchDevice" name="searchDevice" data-role="combo" data-url="/device/deviceList.do" data-default="<c:out value='${sParam.searchDevice}' />" data-prompt="전체">
											<!-- <select class="form-control input-sm" id="searchDevice" name="searchDevice" data-role="combo" data-url="/device/deviceList.do" data-default="1100000285" data-prompt="전체"> -->
												<option>디바이스 선택</option>
											</select>
										</div>
										<div class="form-group">
											<label for="searchReflctAt" class="control-label">적용 여부</label>
											<select class="form-control input-sm" id="searchReflctAt" name="searchReflctAt">
												<option value="">전체</option>
												<option value="Y" <c:if test ="${sParam.searchReflctAt eq 'Y'}">selected="selected"</c:if>>적용</option>
												<option value="N" <c:if test ="${sParam.searchReflctAt eq 'N'}">selected="selected"</c:if>>미적용</option>
											</select>
										</div>
										<div class="form-group">
											<label for="searchCmmndSe" class="control-label">명령 구분</label>
											<select class="form-control input-sm" id="searchCmmndSe" name="searchCmmndSe">
												<option value="">전체</option>
												<option value="1" <c:if test ="${sParam.searchReflctAt eq 'Y'}">selected="selected"</c:if>>웹</option>
												<option value="2" <c:if test ="${sParam.searchReflctAt eq 'N'}">selected="selected"</c:if>>클라이언트</option>
											</select>
										</div>
									</div>
									<div class="row">
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
								<span class="glyphicon glyphicon-grain"></span> 설정 작동 목록
							</div>
							<div class="result-list table-responsive" style="padding-top: 0px;">
								<span class="total-count-info" id="totalCount">(총 : 0 건)</span>
								<table id="mainTable" class="table table-hover table-list" data-hidden-value="seq" data-url="">
									<thead>
										<tr>
											<th data-col="seq" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg" >일련번호</th>
											<th data-col="rn">번호</th>
											<th data-col="eqpmnId">디바이스</th>
											<th data-col="no">순번</th>
											<th data-col="srcelct">전체전원</th>
											<th data-col="trnsmisAt">전송여부</th>
											<th data-col="fanSrcelct">환기구 전원</th>
											<th data-col="fanFnctngMode">환기구 모드</th>
											<th data-col="fanVe">환기구 속도</th>
											<th data-col="fanSetupTimeOne" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg">환기구 설정시간1</th>
											<th data-col="fanSetupTimeTwo" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg">환기구 설정시간2</th>
											<th data-col="humidifierSrcelct">가습기 전원</th>
											<th data-col="humidifierFnctngMode">가습기 모드</th>
											<th data-col="humidifierCntncSetupTime">가습기분사지속시간</th>
											<th data-col="humidifierSetupTimeOne">가습기설정시간1</th>
											<th data-col="humidifierSetupTimeTwo">가습기설정시간2</th>
											<th data-col="uvSrcelct">UV 전원</th>
											<th data-col="trnsmisSecnd">전송시간</th>
											<th data-col="reflctAt">반영여부</th>
											<th data-col="rm">비고</th>
											<th data-col="rgsde">등록일시</th>
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
						<div class="form-group pull-right">
						   		<label for="" class="control-label"></label>
								<button type="button" id="btnAdd" class="btn btn-primary btn-sm" style="">추가</button>
						</div>
					</div>