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
						commandRouterInsert();	// 디바이스 명령 저장
						break;
				}
			});

			// 테이블 클릭 이벤트
			$("table > tbody").on("click", "td", function(e){
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
				}
				else{
					tableDataBind(e.target);
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

		WR.ajax.loadTblData('/device/commandRouterList.do', searchForm, 'mainTable', 'pagination', function(result) {
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

	// 테이블 클릭 데이터 바인딩
	function tableDataBind(target){
		// 조회 모드 변경
		$("#btnReset").trigger("click");
		btnDisplay(1);

		var sel_row = $(target).parent('tr');
		var td = sel_row.find('td');

//		var inputs = $('#mainForm').find(':input'); // 모든 버튼 까지 모든 속성을 가지고 온다.
		var input = $('#mainForm').find('input');
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
	}

	// 데이터 저장
	function commandRouterInsert(){
		var url = "<c:url value='/device/commandRouterInsert.do'/>"
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
			$("#searchRouter").val($("#eqpmnId").val()); // 라우터
			$("#searchDtFrom,#searchDtTo").datepicker('setDate', new Date(new Date()));

			// 조회
			$("#btnSearch").trigger("click");
		});


	}

	// 유효성 체크
	function validateCheck(){
		if($("#eqpmnId").val() == "" || $("#eqpmnId") == null){
			alert("장비 ID을(를) 선택해 주세요");
			return false;
		}

		if($("#trnsmisSecnd").val() == "" || $("#trnsmisSecnd") == null){
			alert("설정 시간을(를) 입력해 주세요");
			return false;
		}

		if(Number($("#trnsmisSecnd").val()) < 300){
			alert("설정 300초 이상의 값을 입력해 주세요");
			return false;
		}


		return true;
	}

	// 버튼 활성화/비활성화
	function btnDisplay(mode){ // 1: 조회 모드, 2: 입력 모드
		if(mode == 1){
			$("#btnAdd").show();
			$("#btnReset").hide();
			$("#btnCancel").hide();
			$("#btnSave").hide();

			$("#eqpmnId").attr("disabled", true);
			$("#trnsmisSecnd").attr("readonly", true);
			$("#reflctAt").val("");
		}
		else if(mode == 2){
			$("#btnAdd").hide();
			$("#btnReset").show();
			$("#btnCancel").show();
			$("#btnSave").show();

			$("#eqpmnId").attr("disabled", false);
			$("#trnsmisSecnd").attr("readonly", false);
			$("#trnsmisSecnd").val("300");
			$("#reflctAt").val("N");

			// 장비 ID 기본 첫번째 선택
			$("#eqpmnId option:eq(0)").prop("selected", true);
		}
	}


</script>
					<div class="">
			      		<h4 class="page-header"><span class="glyphicon glyphicon-edit"></span> 사용자 <span class="glyphicon glyphicon-chevron-right"></span> 라우터 설정</h4>
						<div class="searchForm" >
							<form id="searchForm" class="form-inline" onsubmit="return false;">
<%-- 								<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/> --%>
								<div class="form-group">
									<label for="searchRouter" class="control-label" >라우터</label>
									<select class="form-control input-sm" id="searchRouter" name="searchRouter" data-role="combo" data-url="/device/routerList.do" data-default="" data-prompt="전체">
										<option>라우터 선택</option>
									</select>
								</div>
								<div class="form-group">
									<label for="searchClient" class="control-label">검색 날짜</label>
									<input type="text" class="form-control input-sm dtPicker" id="searchDtFrom" name="searchDtFrom" placeholder="년-월-일 부터" value="${searchDtFrom }"> ~
									<input type="text" class="form-control input-sm dtPicker" id="searchDtTo" name="searchDtTo" placeholder="년-월-일 까지" value="${searchDtTo }">
								</div>
								<div class="form-group">
									<label for="searchReflctAt" class="control-label">적용 여부</label>
									<select class="form-control input-sm" id="searchReflctAt" name="searchReflctAt">
										<option value="">전체</option>
										<option value="Y">적용</option>
										<option value="N">미적용</option>
									</select>
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
											<th data-col="eqpmnId">장비 ID</th>
											<th data-col="trnsmisSecnd">전송 초</th>
											<th data-col="reflctAt">반영 여부</th>
											<th data-col="rgsusr">등록자</th>
											<th data-col="rgsde">등록일자</th>
											<th data-col="updusr">수정자</th>
											<th data-col="updde">수정일자</th>
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
								<span class="glyphicon glyphicon-grain"></span> 설정 작동 목록 상세
							</div>

							<form id="mainForm" class="">
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
										<div class="form-group">
									   		<label for="eqpmnId" class="control-label">장비ID</label>
											<select class="form-control" id="eqpmnId" name="eqpmnId" data-role="combo" data-url="/device/routerList.do" data-default="" data-prompt="선택" disabled>
												<option>라우터 선택</option>
											</select>
										</div>
									</div>
									<div class="form-group form-inline">
										<div class="form-group">
									   		<label for="trnsmisSecnd" class="control-label">설정 시간(초)</label>
											<input type="text" class="form-control" id="trnsmisSecnd" name="trnsmisSecnd" value=""  readonly="readonly">
										</div>
										<div class="form-group">
									   		<label for="" class="control-label">반영 여부</label>
											<input type="text" class="form-control" id="reflctAt" name="reflctAt" value=""  readonly="readonly">
										</div>
									</div>
								</div>

								<div class="form-group pull-right">
							   		<label for="" class="control-label"></label>
									<button type="button" id="btnAdd" class="btn btn-primary btn-sm" style="">추가</button>
									<button type="reset" id="btnReset" class="btn btn-primary btn-sm" style="display: none;">초기화</button>
									<button type="button" id="btnCancel" class="btn btn-primary btn-sm" style="display: none;">취소</button>
									<button type="button" id="btnSave" class="btn btn-primary btn-sm" style="display: none;">저장</button>
								</div>
							</form>
						</div>
					</div>