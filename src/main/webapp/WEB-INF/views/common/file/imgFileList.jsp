<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 /**
  * @Class Name : ImgFileList.jsp
  * @Description : 이미지 파일 조회화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.31  이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.31
  *  @version 1.0
  *  @see
  *
  */
%>
<title>이미지파일목록</title>

	<table>
      	<c:forEach var="fileVO" items="${fileList}" varStatus="status">
	      <tr>
	      	<td></td>
	      </tr>
	      <tr>
	       <td>
	       		<img src='<c:url value='/util/file/getImage.do'/>?atchFileId=<c:out value="${fileVO.atchFileId}"/>&fileSn=<c:out value="${fileVO.fileSn}"/>'  width="640" alt="해당파일이미지"/>
	       </td>
	      </tr>
	      <tr>
	      	<td></td>
	      </tr>
        </c:forEach>
      </table>