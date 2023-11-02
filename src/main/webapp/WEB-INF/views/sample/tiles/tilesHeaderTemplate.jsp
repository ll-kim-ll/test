<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>

<div class="Header">

	<tiles:importAttribute name = "menuList"/>
	<c:forEach var = "menu" items = "${menuList}">
		    ||<c:out value="${menu.id}" />-<c:out value="${menu.nm}" />
	</c:forEach>

	<br>
	Header
</div>