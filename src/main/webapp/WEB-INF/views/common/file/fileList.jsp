<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

/**
  * @Class Name : FileList.jsp
  * @Description : 파일 목록화면
  * @Modification Information
  * @
  * @ 수정일   	      수정자		         수정내용
  * @ ----------   -----------   ---------------------------
  * @ 2009.03.26   이삼섭최초 생성
  *   2011.07.20   옥찬우<Input>   Tag id속성 추가( Line : 68 )
  *   2018.09.11   신용호                 불필요한 function 삭제 - fn_multi_selector_update_delete
  *   2019.12.11   신용호                 KISA 보안약점 조치 (크로스사이트 스크립트)
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.26
  *  @version 1.0
  *  @see
  *
  */
%>
<script type="text/javascript">

	function fn_downFile(atchFileId, fileSn){
		window.open("<c:url value='/util/file/fileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
	}
/*
	function fn_deleteFile(atchFileId, fileSn, delTrName) {
		var url = "<c:url value='/util/file/deleteFileInfs.do'/>";
		var param = {"atchFileId":atchFileId, "fileSn":fileSn};

		$.post(url, param)
			.done(function( data ) {
		    	alert("첨부파일이 삭제 되었습니다.");
		    	var objDelTr = document.getElementById(delTrName);
				objDelTr.parentNode.removeChild(objDelTr);
		  	})
		  	.fail(function(jqXHR) {
			    alert("삭제 오류 발생" );
			})
			.always(function(jqXHR) {
			});
	}
*/
	function fn_deleteFile(atchFileId, fileSn, delTrName) {
		var url = "<c:url value='/util/file/deleteFileInfs.do'/>";
		var param = {"atchFileId":atchFileId, "fileSn":fileSn};

		$.post(url, param)
			.done(function( data ) {
		    	alert("첨부파일이 삭제 되었습니다.");
				$("#"+delTrName).remove();
		  	})
		  	.fail(function(jqXHR) {
			    alert("삭제 오류 발생" );
			})
			.always(function(jqXHR) {
			});
	}


</script>

<!-- <form name="fileForm" action="" method="post" >  -->
<input type="hidden" name="atchFileId" value="<c:out value='${atchFileId}'/>">
<input type="hidden" name="fileSn" >
<input type="hidden" name="fileListCnt" id="fileListCnt" value="<c:out value='${fileListCnt}'/>">
<c:set var="fileCount" value="${fn:length(fileList) }" />
<!-- </form>  -->

<!--<title>파일목록</title> -->

	<table id="file_view_table" style="border:0px solid #666;">
		<c:forEach var="fileVO" items="${fileList}" varStatus="status">
		<tr id="file_view_table_tr_${status.count}">
			<td style="border:0px solid #666;text-align:left;padding:0 0 0 0;margin:0 0 0 0;" height="22">
			<c:choose>
				<c:when test="${updateFlag eq 'Y'}">
					<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileSize}"/>&nbsp;byte]
					<img src="<c:url value='/images/button/btn_del.png' />" class="cursor" onClick="fn_deleteFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>','file_view_table_tr_${status.count}');" alt="<spring:message code="title.fileDelete" />">
				</c:when>
				<c:otherwise>
					<a href="javascript:fn_downFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>')">
					<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileSize}"/>&nbsp;byte]
					</a>
				</c:otherwise>

			</c:choose>
			</td>
			<td>
				<img src="<c:url value='/images/button/btn_del.png' />" class="cursor" onClick="fn_deleteFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>','file_view_table_tr_${status.count}');" alt="<spring:message code="title.fileDelete" />">
			</td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(fileList) == 0}">
			<tr>
				<td style="border:0px solid #666;padding:0 0 0 0;margin:0 0 0 0;"></td>
			</tr>
	    </c:if>
	</table>
