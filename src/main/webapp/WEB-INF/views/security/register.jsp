<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<h1>Register</h1>
	<form action="${pageContext.request.contextPath}/users/register.do" method="post">
		<div> 아이디 <input type="text" name="userid" /> </div>
		<div> 비밀번호 <input type="password" name="userpw" /> </div>
		<div> 이름 <input type="text" name="userName" /> </div>
		<div> 권한 <input type="text" name="authority" value="ROLE_USER/ROLE_MEMBER/ROLE_ADMIN" /> </div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div> <input type="submit" value="회원가입"/> </div>
	</form>
</body>
</html>

