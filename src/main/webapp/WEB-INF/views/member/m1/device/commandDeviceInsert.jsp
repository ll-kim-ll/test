<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- bootstrap datetimepicker -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/momentjs/2.14.1/moment.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<script>
	var today = new Date();
	window.onload = function() {
		$(document).ready(function() {
			/* 버튼 체크 */
			$('button').on('click', function() {
				switch ($(this).attr('id')) {
					case "btnReset": // 초기화
	 					break;
					case "btnCancel": // 취소
						WR.callPage('/device/commandDevice.do', $('#searchForm').serializeArray());
						break;
					case "btnSave": // 저장
						if(!validateCheck()) {
							return;
						}
						commandDeviceInsert();	// 디바이스 명령 저장
						break;
				}
			});

			// 공기청정기 전원 변경
			$("#fanSrcelct").change(function(e){
				console.log("fanSrcelct");
				if($(this).val() == 1){ // ON
					$("#fanFnctngMode").val("1").trigger("change");
					$("#fanFnctngMode").attr("disabled", false);
				}
				else{	 // OFF
					$("#fanFnctngMode").val("").trigger("change");
					$("#fanFnctngMode").attr("disabled", true);
				}

			});

			// 공기청정 작동모드
			$("#fanFnctngMode").change(function(e){
				console.log("fanFnctngMode");
				if($(this).val() == 2){ // 수동
					$("#fanVe").val("2").prop("selected", true);
					$("#fanVe").attr("disabled", false);
				}
				else{  // 자동
					$("#fanVe").val("").prop("selected", true);
					$("#fanVe").attr("disabled", true);
				}

			});

			// 살균 전원 변경
			$("#humidifierSrcelct").change(function(e){
//				$("#humidifierFnctngMode option").removeAttr("selected");
//				$("#humidifierFnctngMode").val("3");
//				$("#humidifierFnctngMode").val("3").prop("selected", true);
//				$("#humidifierFnctngMode option:eq(0)").attr("selected", "selected");
//				$("#humidifierFnctngMode option:eq(0)").prop("selected", true);

				if($(this).val() == 1){ // ON
					$("#humidifierFnctngMode").attr("disabled", false);
					$("#humidifierFnctngMode").val("1").trigger("change");
				}
				else{ // OFF
					$("#humidifierFnctngMode").attr("disabled", true);
					$("#humidifierFnctngMode").val("").trigger("change");
//					$("#humidifierCntncSetupTime").attr("disabled", true);
//					$("#humidifierSetupTimeOne").attr("disabled", true);
//					$("#humidifierSetupTimeTwo").attr("disabled", true);
				}
			});

			// 살균모드 변경
			$("#humidifierFnctngMode").change(function(e){
				var _value = $(this).val();
				$("#humidifierCntncSetupTime").val("05023");

				if(_value == "1" || _value == "3"){	// 자동, 타이머
					$("#timer").val("6").trigger("change");
					$("#timer").attr("disabled", false);

//					$("#humidifierSetupTimeOne").val("");
//					$("#humidifierSetupTimeTwo").val("");
//					$("#humidifierSetupTimeOne").attr("disabled", true);
//					$("#humidifierSetupTimeTwo").attr("disabled", true);

					$("#timeOne").val("");
					$("#timeTwo").val("");
					$("#timeOne").attr("disabled", true);
					$("#timeTwo").attr("disabled", true);
				}
				else if(_value == "4"){	// 시간
					$("#timer").val("");
					$("#timer").attr("disabled", true);

					$("#timeOne").val("08:00").trigger("change");
					$("#timeTwo").val("15:00").trigger("change");
//					$("#humidifierSetupTimeOne").attr("disabled", false);
//					$("#humidifierSetupTimeTwo").attr("disabled", false);
					$("#timeOne").attr("disabled", false);
					$("#timeTwo").attr("disabled", false);


				}
				else{	// 선택
					$("#timer").val("");
					$("#humidifierSetupTimeOne").val("");
					$("#humidifierSetupTimeTwo").val("");
					$("#timeOne").val("");
					$("#timeTwo").val("");
					$("#timeOne").attr("disabled", true);
					$("#timeTwo").attr("disabled", true);

					$("#humidifierCntncSetupTime").attr("readonly", true);
					$("#timer").attr("disabled", true);

				}
			});

			// 타이머 변경 이벤트
			$("#timer").change(function(e){
				$("#humidifierSetupTimeOne").val(dateFormat(today)+"00:00");
				$("#humidifierSetupTimeTwo").val(dateFormat(today)+"0"+$(this).val()+":00");
			});

			// 시간1
			$("#timeOne").datetimepicker({
				format : 'HH:mm',
				showClose: true,
				widgetPositioning:{vertical:'bottom'}
			})
			.on('dp.change', function (e) {
				$("#humidifierSetupTimeOne").val(dateFormat(today)+$(this).val());


			});

			// 시간1
			$("#timeTwo").datetimepicker({
				format : 'HH:mm',
				showClose: true,
				widgetPositioning:{vertical:'bottom'}
			})
			.on('dp.change', function (e) {
				$("#humidifierSetupTimeTwo").val(dateFormat(today)+$(this).val());
			});

			// 타이머 시간 기본 6시간 설정
			$("#timer").val("6").trigger('change');
		});
	}

	// 데이터 저장
	function commandDeviceInsert(){
		var url = "<c:url value='/device/commandDeviceInsert.do'/>"
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
			$("#searchDevice").val($("#eqpmnId").val());

			WR.callPage('/device/commandDevice.do', $('#searchForm').serializeArray());
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

	// 날짜 포멧 변경
	function dateFormat(date) {
        var month = date.getMonth() + 1;
        var day = date.getDate();
        var hour = date.getHours();
        var minute = date.getMinutes();

        month = month >= 10 ? month : '0' + month;
        day = day >= 10 ? day : '0' + day;
        hour = hour >= 10 ? hour : '0' + hour;
        minute = minute >= 10 ? minute : '0' + minute;

//        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute;
        return date.getFullYear() + '-' + month + '-' + day + ' ';
	}


</script>
					<div class="">
			      		<h4 class="page-header"><span class="glyphicon glyphicon-edit"></span> 사용자 <span class="glyphicon glyphicon-chevron-right"></span> 디바이스 설정 <span class="glyphicon glyphicon-chevron-right"></span> 등록</h4>
						<form id="searchForm" class="">
							<input type="hidden" name="searchDevice" id="searchDevice" value="<c:out value='${sParam.searchDevice}' />">
							<input type="hidden" name="searchDtFrom" value="<c:out value='${sParam.searchDtFrom}' />">
							<input type="hidden" name="searchDtTo" value="<c:out value='${sParam.searchDtTo}' />">
							<input type="hidden" name="searchReflctAt" value="<c:out value='${sParam.searchReflctAt}' />">
						</form>

						<form id="mainForm" class="">
							<div class="panel">
								<div class="panel-header-grey">
									<span class="glyphicon glyphicon-grain"></span> 기본 설정
								</div>
								<div class="form-group form-inline">
									<label for="eqpmnId" class="control-label">디바이스</label>
									<select class="form-control" id="eqpmnId" name="eqpmnId" data-role="combo" data-url="/device/deviceList.do" data-default="<c:out value='${sParam.searchDevice}' />" data-prompt="선택">
										<option>디바이스 선택</option>
									</select>
								</div>
								<div class="form-group form-inline">
									<label for="srcelct" class="control-label">전원</label>
									<select class="form-control" id="srcelct" name="srcelct">
										<option value="1">ON</option>
										<option value="0">OFF</option>
									</select>
								</div>
							</div>
							<div class="panel">
								<div class="panel-header-grey">
									<span class="glyphicon glyphicon-grain"></span> 환경정보 설정
								</div>
								<div class="form-group form-inline">
									<label for="trnsmisAt" class="control-label">환경정보 전송</label>
									<select class="form-control" id="trnsmisAt" name="trnsmisAt">
										<option value="1">전송</option>
										<option value="0">미전송</option>
									</select>
								</div>
								<div class="form-group">
							   		<label for="trnsmisSecnd" class="control-label">설정 시간(초)</label>
									<input type="text" name="trnsmisSecnd" id="trnsmisSecnd" value="300" >
								</div>


							</div>
							<div class="panel">
								<div class="panel-header-grey">
									<span class="glyphicon glyphicon-grain"></span> 공기청정 설정
								</div>
								<div class="form-group form-inline">
									<label for="fanSrcelct" class="control-label">청정기 전원</label>
									<select class="form-control" id="fanSrcelct" name="fanSrcelct">
										<option value="1">ON</option>
										<option value="0">OFF</option>
									</select>
								</div>
								<div class="form-group form-inline">
									<label for="fanFnctngMode" class="control-label">작동모드</label>
									<select class="form-control" id="fanFnctngMode" name="fanFnctngMode">
										<option value="">선택</option>
										<option value="1" selected="selected">자동</option>
										<option value="2">수동</option>
									</select>
								</div>
								<div class="form-group form-inline">
									<label for="fanVe" class="control-label">풍속조절</label>
									<select class="form-control" id="fanVe" name="fanVe" disabled="disabled">
										<option value="">선택</option>
										<option value="2">약풍</option>
										<option value="3">중풍</option>
										<option value="4">강풍</option>
									</select>
								</div>
							</div>
							<div class="panel">
								<div class="panel-header-grey">
									<span class="glyphicon glyphicon-grain"></span> 살균 설정
								</div>
								<div class="form-group form-inline">
									<label for="humidifierSrcelct" class="control-label">살균 전원</label>
									<select class="form-control" id="humidifierSrcelct" name="humidifierSrcelct">
										<option value="1">ON</option>
										<option value="0">OFF</option>
									</select>
								</div>
								<div class="form-group form-inline">
									<label for="humidifierFnctngMode" class="control-label">살균모드</label>
									<select class="form-control" id="humidifierFnctngMode" name="humidifierFnctngMode">
										<option value="">선택</option>
										<option value="1" selected="selected">자동</option>
										<option value="2">수동</option>
										<option value="3">타이머</option>
										<option value="4">시간</option>
									</select>
								</div>
								<div class="form-group form-inline">
									<label for="humidifierCntncSetupTime" class="control-label">분사 설정</label>
									<input type="text" name="humidifierCntncSetupTime" id="humidifierCntncSetupTime" value="05023" >
								</div>
								<div id="setupTimer" class="form-group form-inline">
									<label for="timer" class="control-label">타이머</label>
									<input type="text" name="timer" id="timer" value=""> 단위(시간)
								</div>
								<div id="" class="form-group form-inline" >
									<label for="timeOne" class="control-label">시간1</label>
									<input type="text" id="timeOne" disabled="disabled">
								</div>
								<div id="" class="form-group form-inline" >
									<label for="timeTwo" class="control-label">시간2</label>
									<input type="text" id="timeTwo" disabled="disabled">
								</div>
								<div id="setupTime" class="form-group form-inline" hidden="">
									<label for="humidifierSetupTimeOne" class="control-label">시간</label>
									<input type="text" name="humidifierSetupTimeOne" id="humidifierSetupTimeOne" placeholder="2022-01-01 17:00" >
									~
									<input type="text" name="humidifierSetupTimeTwo" id="humidifierSetupTimeTwo" placeholder="2022-01-01 17:00" >
								</div>
							</div>

							<div class="panel">
								<div class="panel-header-grey">
									<span class="glyphicon glyphicon-grain"></span> 향균 설정
								</div>
								<div class="form-group form-inline">
									<label for="uvSrcelct" class="control-label">UV</label>
									<select class="form-control" id="uvSrcelct" name="uvSrcelct">
										<option value="1">ON</option>
										<option value="0">OFF</option>
									</select>
								</div>
							</div>


							<div class="form-group pull-right">
						   		<label for="" class="control-label"></label>
								<button type="reset" id="btnReset" class="btn btn-primary btn-sm" >초기화</button>
								<button type="button" id="btnCancel" class="btn btn-primary btn-sm" >취소</button>
								<button type="button" id="btnSave" class="btn btn-primary btn-sm" >저장</button>
							</div>


						</form>
					</div>