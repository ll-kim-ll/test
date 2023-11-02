<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<c:forEach var="menu" items="${menuList}" varStatus="status">
		<a href="#" class="list-group-item list-group-item-action text-center font-weight-bold">
			<c:out value="${menu.id}" />-<c:out value="${menu.nm}" />
		</a>
	</c:forEach>
</body>
</html>
