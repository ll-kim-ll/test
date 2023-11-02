<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<div>
		<c:import url="/menu.do"></c:import>
	</div>

	<h1>
		Hello world!
	</h1>

	<div>
		<P class='12_<c:out value="${test}"/>'>  The time on the server is ${serverTime}. </P>
	</div>
	</body>
</html>
