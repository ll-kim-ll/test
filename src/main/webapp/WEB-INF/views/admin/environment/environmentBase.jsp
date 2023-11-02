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
 					case "btnAdd": // 추가
 						$("#btnReset").trigger("click");
						btnDisplay(2);
	 					break;
					case "btnReset": // 초기화
	 					break;
					case "btnCancel": // 취소
						$("#btnReset").trigger("click");
						btnDisplay(1);
						break;
					case "btnSave": // 저장
						if(!validateCheck()) {
							return;
						}
						environmentBaseInsert();	// 저장
						break;
					case "btnDel": // 삭제
						if (confirm("삭제 하시겠습니까?.")) {
							environmentBaseDelete();	// 삭제
					    }
				}
			});

			WR.table.tableDataBind("mainTable", "mainForm", function(){
				btnDisplay(1);
			});
/*
			// 테이블 클릭 이벤트
			$("table > tbody").on("click", "td", function(e){
				if($(e.target).attr("colspan") != undefined && $(e.target).attr("colspan") != null && $(e.target).attr("colspan") != ""){
					return false;
				}


				var sel_row = $(e.target).parent('tr');
				var td = sel_row.find('td');

//				var inputs = $('#mainForm').find(':input'); // 모든 버튼 까지 모든 속성을 가지고 온다.
				var input = $("#mainForm").find('input');
				var select = $('#mainForm').find('select');

				input.each(function() {
					var col = $(this).attr("name");

					td.each(function(){
						if($(this).data("col") == col){
							$("#"+col).val($(this).text());
						}
					})
				});

				select.each(function() {
					var col = $(this).attr("name");

					td.each(function(){
						if($(this).data("col") == col){
							$("#"+col).val($(this).text());
						}
					})
				});

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

		WR.ajax.loadTblData('/admin/environmentBaseList.do', searchForm, 'mainTable', 'pagination', function(result) {
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

	// 데이터 저장
	function environmentBaseInsert(){
		var url = "<c:url value='/admin/environmentBaseInsert.do' />";
//		var params = $("#mainForm").serializeArray();
		var params = $("#mainForm").serializeArray();

		$.post(url, params).done(function(data){
			if(data.success == true){
				alert("저장 되었습니다.");
			}
			else{
				alert(data.message);
				return false;
			}
			// 검색 조건 수정
/* 			$("#searchKnd").val($("#knd").val()); // 종류
			$("#searchTy").val($("#ty").val()); // 타입
			$("#searchInfoSe").val($("#infoSe").val()); // 정보 구분
			$("#searchDtFrom,#searchDtTo").datepicker('setDate', new Date(new Date()));
 */
			// 조회
			$("#btnSearch").trigger("click");
		});
	}

	// 데이터 삭제
	function environmentBaseDelete(){
		var url = "<c:url value='/admin/environmentBaseDelete.do' />";
//		var params = $("#mainForm").serializeArray();
		var params = $("#mainForm").serializeArray();

		$.post(url, params).done(function(data){
			if(data.success == true){
				alert("삭제 되었습니다.");
			}
			else{
				alert(data.message);
				return false;
			}
			// 검색 조건 수정
/* 			$("#searchKnd").val($("#knd").val()); // 종류
			$("#searchTy").val($("#ty").val()); // 타입
			$("#searchInfoSe").val($("#infoSe").val()); // 정보 구분
			$("#searchDtFrom,#searchDtTo").datepicker('setDate', new Date(new Date()));
 */
			// 조회
			$("#btnSearch").trigger("click");
		});
	}

	// 유효성 체크
	function validateCheck(){
		if($("#ty").val() == "" || $("#ty") == null){
			alert("타입을(를) 선택해 주세요");
			return false;
		}
		if($("#knd").val() == "" || $("#knd") == null){
			alert("종류을(를) 선택해 주세요");
			return false;
		}

		return true;
	}

	// 버튼 활성화/비활성화
	function btnDisplay(mode){ // 1: 조회 모드, 2: 입력 모드
		$("#btnDown").hide();
		if(mode == 1){
			$("#btnAdd").show();
			$("#btnDel").show();
			$("#btnReset").hide();
			$("#btnCancel").hide();
			$("#btnSave").hide();

			$("#mainForm select").attr("disabled", true);
//			$("#mainForm input[type='text']").attr("readonly", true);
			$("#mainForm input[type='text']").not("#rn").attr("readonly", true);

		}
		else if(mode == 2){
			$("#btnAdd").hide();
			$("#btnDel").hide();
			$("#btnReset").show();
			$("#btnCancel").show();
			$("#btnSave").show();

			$("#mainForm select").attr("disabled", false);
//			$("#mainForm input[type='text']").attr("readonly", false);
			$("#mainForm input[type='text']").not("#rn").attr("readonly", false);

		}
	}


</script>
					<div class="">
			      		<h4 class="page-header"><span class="glyphicon glyphicon-edit"></span> 관리자 <span class="glyphicon glyphicon-chevron-right"></span> 환경정보 </h4>
						<div class="searchForm" >
							<form id="searchForm" class="form-inline" onsubmit="return false;">
<%-- 								<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/> --%>
								<div class="form-group">
									<div class="row">
										<div class="form-group">
											<label for="searchKnd" class="control-label" >종류</label>
											<select class="form-control input-sm" id="searchKnd" name="searchKnd" data-role="combo" data-url="/com/selectcodeClcode.do" data-opt="D0001"  data-default="" data-prompt="전체">
												<option>타입 선택</option>
											</select>
										</div>
										<div class="form-group">
											<label for="searchTy" class="control-label" >타입</label>
											<select class="form-control input-sm" id="searchTy" name="searchTy" data-role="combo" data-url="/com/selectcodeClcode.do" data-opt="D0002" data-default="" data-prompt="전체">
												<option>종류 선택</option>
											</select>
										</div>
										<div class="form-group">
											<label for="searchInfoSe" class="control-label">정보 구분</label>
											<select class="form-control input-sm" id="searchInfoSe" name="searchInfoSe" data-role="combo" data-url="/com/selectcodeClcode.do" data-opt="D0013"  data-default="" data-prompt="전체">
												<option value="">전체</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="form-group">
											<label for="searchDtFrom" class="control-label">검색 날짜</label>
											<input type="text" class="form-control input-sm dtPicker" id="searchDtFrom" name="searchDtFrom" placeholder="년-월-일 부터" value=""> ~
											<input type="text" class="form-control input-sm dtPicker" id="searchDtTo" name="searchDtTo" placeholder="년-월-일 까지" value="">
										</div>
										<div class="form-group">
											<label for="searchKeyword" class="control-label">검색</label>
											<input type="text" class="form-control input-sm" id="searchKeyword" name="searchKeyword" placeholder="검색어" value="">
										</div>
									</div>
								</div>
								<button type="button" class="btn btn-primary btn-md pull-right" style="" id="btnSearch">조회</button>
							</form>
						</div>

						<div class="panel">
							<div class="panel-header-grey">
								<span class="glyphicon glyphicon-grain"></span> 환경정보 목록
							</div>
							<div class="result-list table-responsive" style="padding-top: 0px;">
								<span class="total-count-info" id="totalCount">(총 : 0 건)</span>
								<table id="mainTable" class="table table-hover table-list" data-hidden-value="seq" data-url="">
									<thead>
										<tr>
											<th data-col="seq" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg" >일련번호</th>
											<th data-col="rn">번호</th>
											<th data-col="knd">종류</th>
											<th data-col="ty">타입</th>
											<th data-col="infoSe">정보 구분</th>
											<th data-col="dtrmnDe">설정일자</th>
											<th data-col="ncl">좋음</th>
											<th data-col="ncl1">보통</th>
											<th data-col="ncl2">나쁨</th>
											<th data-col="ncl3">매우나쁨</th>
											<th data-col="dc">설명</th>
											<th data-col="rm">비고</th>
											<th data-col="rgsusr" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg" >등록일자</th>
											<th data-col="rgsde" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg" >등록일자</th>
											<th data-col="updusr" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg" >등록일자</th>
											<th data-col="updde" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg" >등록일자</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="9" style="text-align:center">등록된 자료가 없습니다.</td>
										</tr>
									</tbody>
								</table>
								<nav class="text-center">
									<ul class="pagination" id="pagination" data-load-id="loadData()">
									</ul>
								</nav>
							</div>
						</div>
						<div class="">
							<div class="panel-header-grey">
								<span class="glyphicon glyphicon-grain"></span> 환경정보 목록 상세
							</div>

							<form id="mainForm" class="" method="post" enctype="multipart/form-data">
<%-- 										<input type="hidden" id="" name="" value="${}">
											<input type="hidden" id="" name="" value="${}">
 --%>
								<input type="hidden" id="seq" name="seq" value="">
								<div class="panel">
									<div class="form-group form-inline">
										<div class="form-group">
									   		<label for="rn" class="control-label">번호</label>
											<input type="text" class="form-control" id="rn" name="rn" value="" readonly="readonly">
										</div>
									</div>
									<div class="form-group form-inline">
										<div class="form-group">
											<label for="knd" class="control-label" >종류</label>
											<select class="form-control input-sm" id="knd" name="knd" data-role="combo" data-url="/com/selectcodeClcode.do" data-opt="D0001"  data-default="" data-prompt="선택" disabled>
												<option>종류 선택</option>
											</select>
										</div>
										<div class="form-group">
											<label for="ty" class="control-label" >타입</label>
											<select class="form-control input-sm" id="ty" name="ty" data-role="combo" data-url="/com/selectcodeClcode.do" data-opt="D0002" data-default="" data-prompt="선택" disabled>
												<option>타입 선택</option>
											</select>
										</div>
									</div>
									<div class="form-group form-inline">
										<div class="form-group">
											<label for="infoSe" class="control-label">정보 구분</label>
											<select class="form-control input-sm" id="infoSe" name="infoSe" data-role="combo" data-url="/com/selectcodeClcode.do" data-opt="D0013"  data-default="" data-prompt="전체" disabled>
												<option>정보 구분 선택</option>
											</select>
										</div>
										<div class="form-group">
									   		<label for="dtrmnDe" class="control-label">설정일자</label>
											<input type="text" class="form-control" id="dtrmnDe" name="dtrmnDe" value="" readonly="readonly">
										</div>
									</div>
									<div class="form-group form-inline">
										<div class="form-group">
									   		<label for="ncl" class="control-label">좋음</label>
											<input type="text" class="form-control" id="ncl" name="ncl" value="" readonly="readonly">
										</div>
										<div class="form-group">
									   		<label for="ncl1" class="control-label">보통</label>
											<input type="text" class="form-control" id="ncl1" name="ncl1" value="" readonly="readonly">
										</div>
										<div class="form-group">
									   		<label for="ncl2" class="control-label">나쁨</label>
											<input type="text" class="form-control" id="ncl2" name="ncl2" value="" readonly="readonly">
										</div>
										<div class="form-group">
									   		<label for="ncl3" class="control-label">매우나쁨</label>
											<input type="text" class="form-control" id="ncl3" name="ncl3" value="" readonly="readonly">
										</div>
									</div>
									<div class="form-group form-inline">
										<div class="form-group">
									   		<label for="dc" class="control-label">설명</label>
											<input type="text" class="form-control" id="dc" name="dc" value="" readonly="readonly">
										</div>
									</div>
									<div class="form-group form-inline">
										<div class="form-group">
									   		<label for="rm" class="control-label">비고</label>
											<input type="text" class="form-control" id="rm" name="rm" value="" readonly="readonly">
										</div>
									</div>
								</div>

								<div class="form-group pull-right">
							   		<label for="" class="control-label"></label>
									<button type="button" id="btnAdd" class="btn btn-primary btn-sm" style="">추가</button>
									<button type="button" id="btnDel" class="btn btn-primary btn-sm" style="">삭제</button>
									<button type="reset" id="btnReset" class="btn btn-primary btn-sm" style="display: none;">초기화</button>
									<button type="button" id="btnCancel" class="btn btn-primary btn-sm" style="display: none;">취소</button>
									<button type="button" id="btnSave" class="btn btn-primary btn-sm" style="display: none;">저장</button>
								</div>
							</form>
						</div>
					</div>