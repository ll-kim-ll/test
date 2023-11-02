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
						firmwareInsert();	// 펌웨어 저장
						break;
					case "btnDown":
						firmwareDownload();	// 펌웨어 다운로드
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

		WR.ajax.loadTblData('/admin/firmwareList.do', searchForm, 'mainTable', 'pagination', function(result) {
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

		if($("#dwldLink").val().trim() == ""){
			$("#btnDown").hide();
		}
		else{
			$("#btnDown").show();
		}
	}

	// 데이터 저장
	function firmwareInsert(){
		var url = "/admin/firmwareInsert.do";
//		var params = $("#mainForm").serializeArray();

		var form = $('#mainForm')[0];
	    var params = new FormData(form);
//	    params.append('file1', $('[name="file_1"]')[0].files[0]);


		WR.ajax.doActionMultipart(url, params, function(data){
			if(data.success == true){
				alert("저장 되었습니다.");
			}
			else{
				alert(data.message);
				return false;
			}
			// 검색 조건 수정
			$("#searchTy").val($("#ty").val()); // 타입
			$("#searchKnd").val($("#knd").val()); // 종류
			$("#searchDtFrom,#searchDtTo").datepicker('setDate', new Date(new Date()));

			// 조회
			$("#btnSearch").trigger("click");
		});
	}

	function firmwareDownload(){
//		var url = "<c:url value='/admin/firmwareDownload.do'/>"+"?dwldLink="+$("#dwldLink").val();
		var url = "<c:url value='/util/file/fileDown.do?atchFileId="+$("#dwldLink").val()+"&fileSn=0'/>";

//		$(location).attr("href", encodeURI(url));
		window.open(encodeURI(url));
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

		if($("#ver").val() == "" || $("#ver") == null){
			alert("버전을(를) 입력해 주세요");
			return false;
		}

		return true;
	}

	// 버튼 활성화/비활성화
	function btnDisplay(mode){ // 1: 조회 모드, 2: 입력 모드
		$("#btnDown").hide();
		if(mode == 1){
			$("#btnAdd").show();
			$("#btnReset").hide();
			$("#btnCancel").hide();
			$("#btnSave").hide();

			$("#mainForm select").attr("disabled", true);
			$("#mainForm input[type='file']").attr("disabled", true);
/* 			$("#mainForm input[type='text']").not("#rn").attr("readonly", true);
 */
			$("#mainForm input[type='text']").attr("readonly", true);

			$("#dwldLink").show();
			$("#file_1").hide();
		}
		else if(mode == 2){
			$("#btnAdd").hide();
			$("#btnReset").show();
			$("#btnCancel").show();
			$("#btnSave").show();

			$("#mainForm select").attr("disabled", false);
			$("#mainForm input[type='file']").attr("disabled", false);
			$("#mainForm input[type='text']").not("#rn, #rgsde").attr("readonly", false);

			$("#dwldLink").hide();
			$("#file_1").show();
		}
	}


</script>
					<div class="">
			      		<h4 class="page-header"><span class="glyphicon glyphicon-edit"></span> 관리자 <span class="glyphicon glyphicon-chevron-right"></span> 펌웨어 </h4>
						<div class="searchForm" >
							<form id="searchForm" class="form-inline" onsubmit="return false;">
<%-- 								<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/> --%>
								<div class="form-group">
									<div class="row">
										<div class="form-group">
											<label for="searchTy" class="control-label" >종류</label>
											<select class="form-control input-sm" id="searchKKnd" name="searchKKnd" data-role="combo" data-url="/com/selectcodeClcode.do" data-opt="D0001"  data-default="" data-prompt="전체">
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
											<label for="searchUseAt" class="control-label">사용 여부</label>
											<select class="form-control input-sm" id="searchUseAt" name="searchUseAt">
												<option value="">전체</option>
												<option value="0">미사용</option>
												<option value="1">사용</option>
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
											<label for="searchKeyword" class="control-label">검색 버전</label>
											<input type="text" class="form-control input-sm" id="searchKeyword" name="searchKeyword" placeholder="검색어" value="">
										</div>
									</div>
								</div>
								<button type="button" class="btn btn-primary btn-md pull-right" style="" id="btnSearch">조회</button>
							</form>
						</div>

						<div class="panel">
							<div class="panel-header-grey">
								<span class="glyphicon glyphicon-grain"></span> 펌웨어 목록
							</div>
							<div class="result-list table-responsive" style="padding-top: 0px;">
								<span class="total-count-info" id="totalCount">(총 : 0 건)</span>
								<table id="mainTable" class="table table-hover table-list" data-hidden-value="seq" data-url="">
									<thead>
										<tr>
											<th data-col="seq" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg" >일련번호</th>
											<th data-col="rn">번호</th>
											<th data-col="ty">타입</th>
											<th data-col="knd">종류</th>
											<th data-col="ver">버전</th>
											<th data-col="dc">설명</th>
											<th data-col="rm">비고</th>
											<th data-col="useAt">사용여부</th>
											<th data-col="dwldLink" data-class="hidden-xs hidden-sm hidden-md hidden-lg" class="hidden-xs hidden-sm hidden-md hidden-lg" >등록일자</th>
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
								<span class="glyphicon glyphicon-grain"></span> 펌웨어 목록 상세
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
									   		<label for="ver" class="control-label">버전</label>
											<input type="text" class="form-control" id="ver" name="ver" value="" readonly="readonly">
										</div>
										<div class="form-group">
											<label for="useAt" class="control-label">사용여부</label>
											<select class="form-control" id="useAt" name="useAt" disabled>
												<option value="1">사용</option>
												<option value="0">미사용</option>
											</select>
										</div>
									</div>
									<div class="form-group form-inline">
										<div class="form-group">
									   		<label for="file" class="control-label">펌웨어 파일</label>
											<input type="file" class="form-control" id="file_1" name="file_1" value="" disabled>
<!-- 											<input type="hidden" class="form-control" id="dwldLink" name="dwldLink" value="" readonly="readonly"> -->
											<input type="text" class="form-control" id="dwldLink" name="dwldLink" value="" readonly="readonly">
											<button type="button" id="btnDown" class="btn btn-primary btn-sm" style="display: none;" >다운로드</button>
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
									<div class="form-group form-inline">
										<div class="form-group">
									   		<label for="rgsde" class="control-label">등록일자</label>
											<input type="text" class="form-control" id="rgsde" name="rgsde" value="" readonly="readonly">
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