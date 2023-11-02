<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<c:forEach var="menu" items="${menuList}" varStatus="status">
	    ||<c:out value="${menu.id}" />-<c:out value="${menu.nm}" />
	</c:forEach>
</body>
</html>
