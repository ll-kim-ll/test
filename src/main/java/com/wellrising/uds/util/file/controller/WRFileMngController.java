package com.wellrising.uds.util.file.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wellrising.uds.core.comm.response.CommonResult;
import com.wellrising.uds.core.comm.response.service.ResponseService;
import com.wellrising.uds.core.comm.response.service.ResponseService.CommonResponse;
import com.wellrising.uds.core.comm.util.BrowserUtil;
import com.wellrising.uds.core.comm.util.ResourceCloseHelper;
import com.wellrising.uds.util.file.service.WRFileMngService;
import com.wellrising.uds.util.file.service.WRFileVO;

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
@Controller
@RequestMapping(value = "/util/file")
public class WRFileMngController {
	private static final Logger log = LoggerFactory.getLogger(WRFileMngController.class);

	@Autowired
	private WRFileMngService fileService;

	@Autowired
	private ResponseService responseService;

	/**
	 * 브라우저 구분 얻기.
	 *
	 * @param request
	 * @return
	 */
	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
			return "Trident";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}

	/**
	 * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
	 *
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/fileDown.do")
	public void fileDownload(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String atchFileId = (String) commandMap.get("atchFileId");
		String fileSn = (String) commandMap.get("fileSn");

		WRFileVO fileVO = new WRFileVO();
		fileVO.setAtchFileId(atchFileId);
		fileVO.setFileSn(fileSn);
		WRFileVO fvo = fileService.selectFileInf(fileVO);

		File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
		long fSize = uFile.length();

		if (fSize > 0) {
			String mimetype = "application/x-msdownload";

			String userAgent = request.getHeader("User-Agent");
			HashMap<String,String> result = BrowserUtil.getBrowser(userAgent);
			if ( !BrowserUtil.MSIE.equals(result.get(BrowserUtil.TYPEKEY)) ) {
				mimetype = "application/x-stuff";
			}

			String contentDisposition = BrowserUtil.getDisposition(fvo.getOrignlFileNm(),userAgent,"UTF-8");
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
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fvo.getOrignlFileNm() + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");

			printwriter.flush();
			printwriter.close();
		}
	}

    /**
     * 첨부파일에 대한 목록을 조회한다.
     *
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return view
     * @throws Exception
     */
    @RequestMapping("/fileInfs.do")
    public String fileInfs(@ModelAttribute("searchVO") WRFileVO fileVO, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
	String atchFileId = (String)commandMap.get("atchFileId");

		fileVO.setAtchFileId(atchFileId);
		List<WRFileVO> result = fileService.selectFileInfs(fileVO);

		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "N");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);

		return "/common/file/fileList";
    }

    /**
     * 첨부파일에 대한 목록을 조회한다.
     *
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return view
     * @throws Exception
     */
    @RequestMapping("/selectFileInfs.do")
    @ResponseBody
    public Map<String, Object> selectFileInfs(@ModelAttribute("searchVO") WRFileVO fileVO, ModelMap model) throws Exception {
		Map<String, Object> data = new HashMap<String, Object>();
    	List<WRFileVO> result = fileService.selectFileInfs(fileVO);

		data.put("fileList", result);
		data.put("updateFlag", "N");
		data.put("fileListCnt", result.size());

		return data;
    }

    /**
     * 첨부파일 변경을 위한 수정페이지로 이동한다.
     *
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectFileInfsForUpdate.do")
    public String selectFileInfsForUpdate(@ModelAttribute("searchVO") WRFileVO fileVO, @RequestParam Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model) throws Exception {

	String atchFileId = (String)commandMap.get("atchFileId");

	fileVO.setAtchFileId(atchFileId);

	List<WRFileVO> result = fileService.selectFileInfs(fileVO);

	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "Y");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileId", atchFileId);

	return "/common/file/fileList";
    }

    /**
     * 첨부파일에 대한 삭제를 처리한다.
     *
     * @param fileVO
     * @param returnUrl
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @PostMapping("/deleteFileInfs.do")
    @ResponseBody
    public CommonResult deleteFileInf(@ModelAttribute("searchVO") WRFileVO fileVO, HttpServletRequest request, ModelMap model) throws Exception {
//		Boolean isAuthenticated = WRUserDetailsHelper.isAuthenticated();

		try {
//			if (isAuthenticated) {
				fileService.deleteFileInf(fileVO);
//			}
		}
		catch(Exception e) {
 			return responseService.getFailResult(CommonResponse.FAILURE);
		}

		return responseService.getSuccessResult();



/*


    	Boolean isAuthenticated = WRUserDetailsHelper.isAuthenticated();

		if (isAuthenticated) {
		    fileService.deleteFileInf(fileVO);
		}

		 return "blank";
*/


		//--------------------------------------------
		// contextRoot가 있는 경우 제외 시켜야 함
		//--------------------------------------------
		////return "forward:/selectFileInfs.do";
		//return "forward:" + returnUrl;
		/* *******************************************************
		 *  modify by jdh
		 *******************************************************
		if ("".equals(request.getContextPath()) || "/".equals(request.getContextPath())) {
		    return "forward:" + returnUrl;
		}

		if (returnUrl.startsWith(request.getContextPath())) {
		    return "forward:" + returnUrl.substring(returnUrl.indexOf("/", 1));
		} else {
		    return "forward:" + returnUrl;
		}
		*/
		////------------------------------------------
    }

    /**
     * 이미지 첨부파일에 대한 목록을 조회한다.
     *
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return view
     * @throws Exception
     */
    @RequestMapping("/imageFileInfs.do")
    public String imageFileInfs(@ModelAttribute("searchVO") WRFileVO fileVO, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

	String atchFileId = (String)commandMap.get("atchFileId");

	fileVO.setAtchFileId(atchFileId);
	List<WRFileVO> result = fileService.selectImageFileList(fileVO);

	model.addAttribute("fileList", result);

	return "/common/file/imgFileList";
    }

    /**
     * 이미지 첨부파일에 대한 목록을 조회한다.
     *
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return view
     * @throws Exception
     */
    @RequestMapping("/selectImageFileInfs.do")
    @ResponseBody
    public List<WRFileVO> selectImageFileInfs(@ModelAttribute("searchVO") WRFileVO fileVO, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		Map<String, Object> data = new HashMap<String, Object>();
    	List<WRFileVO> result = fileService.selectFileInfs(fileVO);

		return result;
    }
}
