<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>

<style>
html, body {
	height: 100%;
}

body {
	display: -ms-flexbox;
	display: flex;
	-ms-flex-align: center;
	text-align: center;
	align-items: center;
	padding-top: 40px;
	padding-bottom: 40px;
	background-color: #f5f5f5;
}

.form-signin {
	width: 100%;
	max-width: 330px;
	padding: 15px;
	margin: auto;
}

.form-signin .checkbox {
	font-weight: 400;
}

.form-signin .form-control {
	position: relative;
	box-sizing: border-box;
	height: auto;
	padding: 10px;
	font-size: 16px;
}

.form-signin .form-control:focus {
	z-index: 2;
}

.form-signin input[type="email"] {
	margin-bottom: -1px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
	margin-bottom: 10px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}
</style>

			<!-- csrf 처리 -->
			<sec:csrfMetaTags />
			<script>
				window.onload = function() {
					$(document).ready(function() {
						try {
							var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
							var csrfHeader = $("meta[name='_csrf_header']").attr("content");
							var csrfToken = $("meta[name='_csrf']").attr("content");

							// ajax가 호출 되는 전역
							$.ajaxSetup({
								beforeSend: function(xhr, settings) {
									if (!/^(GET|HEAD|OPTIONS)$/i.test(settings.type) && !this.crossDomain) {
										xhr.setRequestHeader(csrfHeader, csrfToken)
									}
								}
							});
							// form
							$("form").each(function() {
		/*
								var input = $("<input/>").attr({type:"hidden", name:csrfParameter, value:csrfToken});
								$(this).append(input);
		*/
								$(this).append($('<input/>',{type:'hidden', name:csrfParameter, value:csrfToken}));

							});
						} catch(e) {
							console.log(e);
						}
					});
				}
			</script>
			<!-- csrf 처리 -->


</head>
<body>
	<div>
		<form class="form-signin" action='<c:url value="/login.do" />' method="POST">
			<h1 class="h3 mb-3 font-weight-normal"></h1>
<%--
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 --%>
			<input type="text" name="userid" class="form-control" placeholder="ID" required autofocus>
			<input type="password" name="userpw" class="form-control" placeholder="Password" required>
			<button class="btn btn-lg btn-primary btn-block" type="submit">LOGIN</button>
			<c:if test="${loginFailMsg != ''}">
				<p style="color: red"><c:out value="${loginFailMsg}"/> </p>
			</c:if>
		</form>
	</div>


	<div>

	<!-- 인증하지 않은 상태 -->
	<sec:authorize access="isAnonymous()">
   		로그인
	</sec:authorize>
	<!-- 인증 상태 -->
	<sec:authorize access="isAuthenticated()">
		<div>
			<form action="<c:url value='/customLogout.do'/>" method="post">
<%--
				<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
 --%>
				<button type="submit">로그아웃</button>
			</form>
		</div>
   	</sec:authorize>

	<sec:authorize access="hasRole('admin')">
	  관리자 페이지
	</sec:authorize>
<!--
hasRole('role')	해당 권한이 있을 경우
hasAnyRole('role1,'role2')	포함된 권한 중 하나라도 있을 경우
isAuthenticated()	권한에 관계없이 로그인 인증을 받은 경우
isFullyAuthenticated()	권한에 관계없이 인증에 성공했고, 자동 로그인이 비활성인 경우
isAnonymous()	권한이 없는 익명의 사용자일 경우
isRememberMe()	자동 로그인을 사용하는 경우
permitAll	모든 경우 출력함
denyAll	모든 경우 출력하지 않음
 -->


	</div>

</body>
</html>

