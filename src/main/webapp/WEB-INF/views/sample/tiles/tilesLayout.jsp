<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>


<!-- 공통변수 처리 -->
<%-- taglib.jspf 공동적으로 선언해 줌
<c:set var="CONTEXT_PATH" value="${pageContext.request.contextPath}" scope="application"/>
<c:set var="RESOURCES_PATH" value="${CONTEXT_PATH}/resources" scope="application"/>
 --%>

<!DOCTYPE html>
<html>
  <head>
	<meta charset="UTF-8">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title><tiles:insertAttribute name="title" /></title>

<%--
	<link rel="stylesheet" href="${resources}/css/common.css" />
	<link rel="stylesheet" type="text/css" media="all" href="<c:url value="/css/titles-test.css" />">
	<link rel="stylesheet" type="text/css" href="<c:url value="/css/titles-test.css" />">
	<link rel="stylesheet" href="<c:url value='/js/bootstrap/custom/css/bootstrap.min.css' />">

	<script src="${resources}/js/main.js" >
	<script src="<c:url value='/js/bootstrap/custom/js/bootstrap.min.js' />"></script>
--%>

	<script type="text/javascript">
		var CONTEXT_PATH = "${context}";
		var RESOURCES_PATH = "${resources}";

		console.log(CONTEXT_PATH+" and "+RESOURCES_PATH)
	</script>

<%--
	<c:forEach var="link" items="${links }">
	  <link rel="stylesheet" href="<c:url value="${link }" />" type="text/css" />
	</c:forEach>
	<c:forEach var="script" items="${scripts }">
	  <script src="<c:url value="${script }" />"></script>
	</c:forEach>
 --%>

	<!-- User Css -->
<%-- 	<tiles:importAttribute name="links" /> 왜 우류나는지 모름.--%>

	<!-- PAGE CSS FILE -->
	<c:if test="${fn:length(links)>0 }">
	    <c:forEach var="link" items="${links}">
			<link rel="stylesheet" href="<c:url value="${link }" />" type="text/css" />
	    </c:forEach>
    </c:if>
	<c:if test="${fn:length(link)==0 }">
		<link rel="stylesheet" type="text/css" media="all" href="<c:url value="/css/default.css" />">
	</c:if>

	<!-- User Script -->
<%-- 	<tiles:importAttribute name="scripts" /> --%>

	<!-- PAGE JS FILE -->
	<c:if test="${fn:length(scripts)>0 }">
	    <c:forEach var="script" items="${scripts}">
	        <script src="<c:url value="${script}"/>"></script>
	    </c:forEach>
    </c:if>
	<c:if test="${fn:length(scripts)==0 }">
        <script src="<c:url value="/js/default.js"/>"></script>
	</c:if>

  </head>

  <body>
  	<div class='wrap'>
  		<tiles:insertAttribute name="header" />
		  <div class='content'>
  			<tiles:insertAttribute name="left"/>
	  		<div class="page_content">
	  			<tiles:insertAttribute name="body"/>
	  		</div>
  		</div>
  		<tiles:insertAttribute name="foot" />
  	</div>
  </body>

</html>