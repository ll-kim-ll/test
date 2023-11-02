package com.wellrising.uds.util.file.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;

import com.wellrising.uds.core.comm.util.BrowserUtil;
import com.wellrising.uds.core.comm.util.ResourceCloseHelper;
import com.wellrising.uds.core.comm.util.WebUtil;


/**
 * 파일 다운로드를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *     수정일      	수정자           수정내용
 *  ------------   --------    ---------------------------
 *   2009.03.25  	이삼섭          최초 생성
 *   2014.02.24		이기하          IE11 브라우저 한글 파일 다운로드시 에러 수정
 *   2018.08.28		신용호          Safari, Chrome, Firefox, Opera 한글파일 다운로드 처리 수정 (macOS에서 확장자 exe붙는 문제 처리)
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Component
public class WRFileDownloadUtile {
	private static final Logger log = LoggerFactory.getLogger(WRFileDownloadUtile.class);

	/**
	 * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
	 *
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	public void FileDownload(Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String atchFileId = (String) commandMap.get("atchFileId");
		String fileSn = (String) commandMap.get("fileSn");

		WRFileVO fileVO = new WRFileVO();
		fileVO.setAtchFileId(atchFileId); // 첨부파일 아이디
		fileVO.setFileSn(fileSn); // 파일 일렵번호
		fileVO.setFileExtsn(commandMap.get("fileExtsn")!=null?commandMap.get("fileExtsn").toString():""); // 파일확장자
		fileVO.setStreFileNm(commandMap.get("streFileNm").toString()); // 저장파일명
		fileVO.setOrignlFileNm(commandMap.get("orignlFileNm").toString()); // 원파일명
		fileVO.setFileStreCours(commandMap.get("fileStreCours").toString()); // 파일저장경로

//		FileVO fvo = fileService.selectFileInf(fileVO);

		File uFile = new File(fileVO.getFileStreCours(), fileVO.getStreFileNm());
		long fSize = uFile.length();

		if (fSize > 0) {
			String mimetype = "application/x-msdownload";

			String userAgent = request.getHeader("User-Agent");
			HashMap<String,String> result = BrowserUtil.getBrowser(userAgent);
			if ( !"MSIE".equals(result.get("type")) ) {
				mimetype = "application/x-stuff";
			}

			String contentDisposition = BrowserUtil.getDisposition(fileVO.getOrignlFileNm(),userAgent,"UTF-8");
			//response.setBufferSize(fSize);	// OutOfMemeory 발생
			response.setContentType(mimetype);
			//response.setHeader("Content-Disposition", "attachment; filename=\"" + contentDisposition + "\"");
			response.setHeader("Content-Disposition", contentDisposition);
			response.setContentLengthLong(fSize);

			/*
			 * FileCopyUtils.copy(in, response.getOutputStream());
			 * in.close();
			 * response.getOutputStream().flush();
			 * response.getOutputStream().close();
			 */
			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
				in = new BufferedInputStream(new FileInputStream(uFile));
				out = new BufferedOutputStream(response.getOutputStream());
/*
				byte[] buffer = new byte[4096];
				int bytesRead = 0;

				while((bytesRead = in .read(buffer)) != -1) {
					out.write(buffer, 0, bytesRead);
				}
*/
				FileCopyUtils.copy(in, out);

				out.flush();
			} catch (IOException ex) {
				// 다음 Exception 무시 처리
				// Connection reset by peer: socket write error
				log.debug("IO Exception", ex);
			} finally {
				ResourceCloseHelper.close(in, out);
			}

		} else {
			response.setContentType("application/x-msdownload");

			PrintWriter printwriter = response.getWriter();

			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fileVO.getOrignlFileNm() + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");

			printwriter.flush();
			printwriter.close();
		}
	}

	/**
	 * 서버 파일에 대하여 다운로드를 처리한다.
	 *
	 * @param response
	 * @param streFileNm 파일저장 경로가 포함된 형태
	 * @param orignFileNm
	 * @throws Exception
	 */
	public void FileDownload(HttpServletResponse response, String streFileNm, String orignFileNm) throws Exception {
		String downFileName = streFileNm;
		String orgFileName = orignFileNm;

		File file = new File(downFileName);

		if (!file.exists()) {
			throw new FileNotFoundException(downFileName);
		}

		if (!file.isFile()) {
			throw new FileNotFoundException(downFileName);
		}

		int fSize = (int) file.length();
		if (fSize > 0) {
			BufferedInputStream in = null;

			try {
				in = new BufferedInputStream(new FileInputStream(file));

				String mimetype = "application/x-msdownload";

				//response.setBufferSize(fSize);
				response.setContentType(mimetype);
				response.setHeader("Content-Disposition:", "attachment; filename=" + orgFileName);
				response.setContentLength(fSize);
				//response.setHeader("Content-Transfer-Encoding","binary");
				//response.setHeader("Pragma","no-cache");
				//response.setHeader("Expires","0");
				FileCopyUtils.copy(in, response.getOutputStream());
			} finally {
				ResourceCloseHelper.close(in);
			}
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}

		/*
		String uploadPath = propertiesService.getString("fileDir");

		File uFile = new File(uploadPath, requestedFile);
		int fSize = (int) uFile.length();

		if (fSize > 0) {
		    BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));

		    String mimetype = "text/html";

		    //response.setBufferSize(fSize);
		    response.setContentType(mimetype);
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + requestedFile + "\"");
		    response.setContentLength(fSize);

		    FileCopyUtils.copy(in, response.getOutputStream());
		    in.close();
		    response.getOutputStream().flush();
		    response.getOutputStream().close();
		} else {
		    response.setContentType("text/html");
		    PrintWriter printwriter = response.getWriter();
		    printwriter.println("<html>");
		    printwriter.println("<br><br><br><h2>Could not get file name:<br>" + requestedFile + "</h2>");
		    printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
		    printwriter.println("<br><br><br>&copy; webAccess");
		    printwriter.println("</html>");
		    printwriter.flush();
		    printwriter.close();
		}
		//*/

		/*
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(),"UTF-8" ));
		response.setHeader("Content-Transfer-Encoding","binary");
		response.setHeader("Pragma","no-cache");
		response.setHeader("Expires","0");

		BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
		int read = 0;

		while ((read = fin.read(b)) != -1) {
		    outs.write(b,0,read);
		}
		log.debug(this.getClass().getName()+" BufferedOutputStream Write Complete!!! ");

		outs.close();
		fin.close();
		//*/
	}

	/**
	 * 서버의 파일을 다운로드한다.
	 *
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public static void FileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String downFileName = "";
		String orgFileName = "";

		if ((String) request.getAttribute("downFile") == null) {
			downFileName = "";
		} else {
			downFileName = (String) request.getAttribute("downFile");
		}

		if ((String) request.getAttribute("orgFileName") == null) {
			orgFileName = "";
		} else {
			orgFileName = (String) request.getAttribute("orginFile");
		}

		orgFileName = orgFileName.replaceAll("\r", "").replaceAll("\n", "");

		File file = new File(WebUtil.filePathBlackList(downFileName));

		if (!file.exists()) {
			throw new FileNotFoundException(downFileName);
		}

		if (!file.isFile()) {
			throw new FileNotFoundException(downFileName);
		}

		byte[] buffer = new byte[WRFileUtil.BUFF_SIZE]; //buffer size 2K.

		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(), "UTF-8"));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");

		BufferedInputStream fin = null;
		BufferedOutputStream outs = null;

		try {
			fin = new BufferedInputStream(new FileInputStream(file));
			outs = new BufferedOutputStream(response.getOutputStream());
			int read = 0;

			while ((read = fin.read(buffer)) != -1) {
				outs.write(buffer, 0, read);
			}
		} finally {
			ResourceCloseHelper.close(outs, fin);
		}
	}

}
