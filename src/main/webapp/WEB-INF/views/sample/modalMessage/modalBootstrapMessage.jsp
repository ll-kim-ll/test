<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="false" %>
<html>
	<head>
		<title>Home</title>

		<style>
		</style>

		<script>
			$(function () {

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



			    //사용 예시 **************************
			    $(document).on("click", "#alert", function () {
			    	console.log("alert");
			    	// 콜백함수 있을 때
			    	MsgBox.Alert("Alert Message!", function() {MsgBox.Alert("OK");});
			    	// 콜백함수 없을 때
			    	//MsgBox.Alert("Alert Message!");
			    });


			    $(document).on("click", "#confirm", function () {
			    	console.log("confirm");
			    	// YES버튼에만 콜백 함수 넣을 경우
			    	MsgBox.Confirm("Confirm Message!", function() {MsgBox.Alert("YES");});

			    	// NO버튼에도 콜백 함수 넣을 경우
//			    	MsgBox.Confirm("Confirm Message!", function() {MsgBox.Alert("YES");} , function() {MsgBox.Alert("NO");});
			    });
			});



			var MsgBox = {
					/* Alert */
					Alert: function(msg, okhandler) {
						new Promise((resolve, reject) => {
							$("#msg_popup #btn_confirm").hide();
							$("#msg_popup #btn_alert").show();
							$("#msg_popup #alert_ok").unbind();
							$("#msg_popup .modal-body").html(msg);
							$('#msg_popup').modal('show');
							$("#msg_popup #alert_ok").click(function() {
								$('#msg_popup').modal('hide');
							});
							$("#msg_popup").on("hidden.bs.modal", function(e) {
								e.stopPropagation();
								if(okhandler != null)
									resolve();
								else
									reject();
							});
						}).then(okhandler).catch(function() {});
					},

					/* Confirm */
					Confirm: function(msg, yeshandler, nohandler) {
						new Promise((resolve, reject) => {
							var flag = false; $("#msg_popup #btn_alert").hide();
							$("#msg_popup #btn_confirm").show();
							$("#msg_popup #confirm_yes").unbind();
							$("#msg_popup #confirm_no").unbind();
							$("#msg_popup .modal-body").html(msg);
							$('#msg_popup').modal('show');
							$('#msg_popup').on('keypress', function (e) {
								var keycode = (e.keyCode ? e.keyCode : e.which);
								if(keycode == '13') {
									flag = true; $('#msg_popup').modal('hide');
								}
							});
							$("#msg_popup #confirm_yes").click(function() {
								flag = true; });
							$("#msg_popup #confirm_no").click(function() {
								flag = false;
							}); $("#msg_popup").on("hidden.bs.modal", function(e) {
								e.stopPropagation();
								if(yeshandler != null && flag == true)
									resolve(1);
								else if(nohandler != null && flag == false)
									resolve(2);
								else reject();
							});
						}).then(function(value) {
							if(value == 1)
								yeshandler();
							else if(value == 2)
								nohandler();
							}).catch(function() {});
					},
				}



		</script>
	</head>
	<body>
		<div>
            <button type="button" id="confirm">컨펌창</button>
            <button type="button" id="alert">경고창</button>
		</div>
		<div class="modal" id="msg_popup" tabindex="-1" role="dialog">

			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-body">
						<!-- MSG Space-->
					</div>

					<div class="modal-footer" id="btn_confirm">
						<button type="button" id="confirm_yes" class="btn btn-primary" data-dismiss="modal" >YES</button>
						<button type="button" id="confirm_no"class="btn btn-secondary" data-dismiss="modal">NO</button>
					</div>

					<div class="modal-footer" id="btn_alert">
						<button type="button" id="alert_ok"class="btn btn-primary" data-dismiss="modal" >OK</button>
					</div>
				</div>
			</div>
		</div>

	</body>
</html>
