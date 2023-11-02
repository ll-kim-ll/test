package com.wellrising.uds.util.file.service;


import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

import com.wellrising.uds.core.comm.util.ResourceCloseHelper;
import com.wellrising.uds.core.comm.util.WebUtil;
import com.wellrising.uds.util.WRDateUtil;
import com.wellrising.uds.util.idGeneration.service.WRIdGenerationService;

/**
 * @Class Name  : FileUploadUtil.java
 * @Description : Spring 기반 File Upload 유틸리티
 * @Modification Information
 *
 *  수정일               수정자            수정내용
 *  ----------   --------   ---------------------------
 *  2009.08.26   한성곤            최초 생성
 *  2018.08.17   신용호            uploadFilesExt(확장자 기록) 추가
 *  2019.12.06   신용호            checkFileExtension(), checkFileMaxSize() 추가
 *  2020.08.05   신용호            uploadFilesExt Parameter 수정
 *  2021.02.16   신용호            WebUtils.getNativeRequest(request,MultipartHttpServletRequest.class);
 *
 * @author 공통컴포넌트 개발팀 한성곤
 * @since 2009.08.26
 * @version 1.0
 * @see
 */
@Component
public class WRFileUploadUtil extends WRFormBasedFileUtil {
	private static final Logger log = LoggerFactory.getLogger(WebUtil.class);
	@Value("#{globalProps['Globals.FileStorePath.Firmware']}")
	private String uploadDir;

	@Value("#{globalProps['Globals.Extensions.FileDownload']}")
	private String extWhiteList;

	@Value("#{globalProps['Globals.Extensions.FileUpload']}")
	private String extensions;

	@Resource(name="propertyConfigurer")
	private Properties propertyConfigurer;

	@Autowired
	WRIdGenerationService idGenerationService;
	/*
	 * @Autowired private
	 * Properties propertyConfigurer;
	 */


	/**
	 * 파일을 Upload 처리한다.
	 *
	 * @param request
	 * @param path
	 * @param maxFileSize
	 * @return
	 * @throws Exception
	 */
	public List<WRFormBasedFileVo> uploadFiles(HttpServletRequest request, String path, long maxFileSize) throws Exception {
		List<WRFormBasedFileVo> list = new ArrayList<WRFormBasedFileVo>();

		//MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;
		MultipartHttpServletRequest mptRequest = WebUtils.getNativeRequest(request,MultipartHttpServletRequest.class);

		Iterator<?> fileIter = mptRequest.getFileNames();

		while (fileIter.hasNext()) {
			MultipartFile mFile = mptRequest.getFile((String) fileIter.next());

			WRFormBasedFileVo vo = new WRFormBasedFileVo();

			String tmp = mFile.getOriginalFilename();

			if (tmp.lastIndexOf("\\") >= 0) {
				tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
			}

			vo.setFileName(tmp);
			vo.setContentType(mFile.getContentType());
			vo.setServerSubPath(getTodayString());
			vo.setPhysicalName(getPhysicalFileName());
			vo.setSize(mFile.getSize());

			if (tmp.lastIndexOf(".") >= 0) {
				vo.setPhysicalName(vo.getPhysicalName()); // 2012.11 KISA 보안조치
			}

			if (mFile.getSize() > 0) {
				InputStream is = null;

				try {
					is = mFile.getInputStream();
					saveFile(is, new File(WebUtil.filePathBlackList(path + WRFileUtil.SEPERATOR + vo.getServerSubPath() + WRFileUtil.SEPERATOR + vo.getPhysicalName())));
				} finally {
					if (is != null) {
						is.close();
					}
				}
				list.add(vo);
			}
		}

		return list;
	}

	/**
	 * 파일을 Upload(확장명 저장 및 확장자 제한) 처리한다.
	 *
	 * @param request
	 * @param path
	 * @param maxFileSize
	 * @return
	 * @throws Exception
	 */
	public List<WRFormBasedFileVo> uploadFiles(MultipartHttpServletRequest mptRequest, String path, long maxFileSize, String extensionWhiteList) throws Exception {
		List<WRFormBasedFileVo> list = new ArrayList<WRFormBasedFileVo>();

		Iterator<?> fileIter = mptRequest.getFileNames();

		while (fileIter.hasNext()) {
			MultipartFile mFile = mptRequest.getFile((String) fileIter.next());

			WRFormBasedFileVo vo = new WRFormBasedFileVo();

			String tmp = mFile.getOriginalFilename();

			if (tmp.lastIndexOf("\\") >= 0) {
				tmp = tmp.substring(tmp.lastIndexOf("\\") + 1);
			}
			String ext = "";
			if ( tmp.lastIndexOf(".") > 0 )
				ext = WRFileUtil.getFileExtension(tmp).toLowerCase();
			else
				throw new SecurityException("Unacceptable file extension."); // 허용되지 않는 확장자 처리
			if ( extensionWhiteList.indexOf(ext) < 0 )
				throw new SecurityException("Unacceptable file extension."); // 허용되지 않는 확장자 처리

			vo.setFileName(tmp);
			vo.setContentType(mFile.getContentType());
			vo.setServerSubPath(getTodayString());
			vo.setPhysicalName(getPhysicalFileName()+"."+ext);
			vo.setSize(mFile.getSize());

			if (tmp.lastIndexOf(".") >= 0) {
				vo.setPhysicalName(vo.getPhysicalName()); // 2012.11 KISA 보안조치
			}

			if (mFile.getSize() > 0) {
				InputStream is = null;

				try {
					is = mFile.getInputStream();
					saveFile(is, new File(WebUtil.filePathBlackList(path + WRFileUtil.SEPERATOR + vo.getServerSubPath() + WRFileUtil.SEPERATOR + vo.getPhysicalName())));
				} finally {
					if (is != null) {
						is.close();
					}
				}
				list.add(vo);
			}
		}

		return list;
	}

	/**
	 * 첨부파일에 대한 목록 정보를 취득한다.
	 *
	 * @param files
	 * @return
	 * @throws Exception
	 */
	public List<WRFileVO> parseFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
		int fileKey = fileKeyParam;

		String storePathString = "";
		String atchFileIdString = "";

		if ("".equals(storePath) || storePath == null) {
			storePathString = propertyConfigurer.getProperty("Globals.fileStorePath");
		} else {
			storePathString = propertyConfigurer.getProperty(storePath);
		}
		storePathString += WRDateUtil.getCurrentDate(null)+WRFileUtil.SEPERATOR;

		if ("".equals(atchFileId) || atchFileId == null) {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("tableName", "FILE_ID");
			if ("".equals(KeyStr) || KeyStr == null) {
				param.put("prefix", "FILE_");
			}
			else {
				param.put("prefix", KeyStr);
			}
			param.put("fillChar", '0');
			param.put("cipers", 5);

			atchFileIdString = idGenerationService.getIdgen(param);
		} else {
			atchFileIdString = atchFileId;
		}

		File saveFolder = new File(WebUtil.filePathBlackList(storePathString));

		if (!saveFolder.exists() || saveFolder.isFile()) {
			//2017.03.03 	조성원 	시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
			if (saveFolder.mkdirs()){
				log.debug("[file.mkdirs] saveFolder : Creation Success ");
			}else{
				log.error("[file.mkdirs] saveFolder : Creation Fail ");
			}
		}

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		String filePath = "";
		List<WRFileVO> result = new ArrayList<WRFileVO>();
		WRFileVO fvo;

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			String orginFileName = file.getOriginalFilename();

			//--------------------------------------
			// 원 파일명이 없는 경우 처리
			// (첨부가 되지 않은 input file type)
			//--------------------------------------
			if ("".equals(orginFileName)) {
				continue;
			}
			////------------------------------------

			int index = orginFileName.lastIndexOf(".");
			//String fileName = orginFileName.substring(0, index);
			String fileExt = orginFileName.substring(index + 1);
			String newName = KeyStr + WRDateUtil.getTimeStamp() + fileKey;
			long size = file.getSize();

			if (!"".equals(orginFileName)) {
				filePath = storePathString + WRFileUtil.SEPERATOR + newName;
				file.transferTo(new File(WebUtil.filePathBlackList(filePath)));
			}

			fvo = new WRFileVO();
			fvo.setFileExtsn(fileExt);
			fvo.setFileStreCours(storePathString);
			fvo.setFileSize(Long.toString(size));
			fvo.setOrignlFileNm(orginFileName);
			fvo.setStreFileNm(newName);
			fvo.setAtchFileId(atchFileIdString);
			fvo.setFileSn(String.valueOf(fileKey));

			result.add(fvo);

			fileKey++;
		}

		return result;
	}

	/**
	 * 첨부파일에 대한 목록 정보를 취득한다.
	 *
	 * @param files
	 * @return
	 * @throws Exception
	 */
	public List<WRFileVO> parseFileInf(List<MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
		int fileKey = fileKeyParam;

		String storePathString = "";
		String atchFileIdString = "";

		if ("".equals(storePath) || storePath == null) {
			storePathString = propertyConfigurer.getProperty("Globals.fileStorePath");
		} else {
			storePathString = propertyConfigurer.getProperty(storePath);
		}
		storePathString += WRDateUtil.getCurrentDate(null)+WRFileUtil.SEPERATOR;

		if ("".equals(atchFileId) || atchFileId == null) {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("tableName", "FILE_ID");
			if ("".equals(KeyStr) || KeyStr == null) {
				param.put("prefix", "FILE_");
			}
			else {
				param.put("prefix", KeyStr);
			}
			param.put("fillChar", '0');
			param.put("cipers", 5);
			atchFileIdString = idGenerationService.getIdgen(param);
		} else {
			atchFileIdString = atchFileId;
		}

		File saveFolder = new File(WebUtil.filePathBlackList(storePathString));

		if (!saveFolder.exists() || saveFolder.isFile()) {
			//2017.03.03 	조성원 	시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
			if (saveFolder.mkdirs()){
				log.debug("[file.mkdirs] saveFolder : Creation Success ");
			}else{
				log.error("[file.mkdirs] saveFolder : Creation Fail ");
			}
		}

		String filePath = "";
		List<WRFileVO> result = new ArrayList<WRFileVO>();
		WRFileVO fvo;

		for (MultipartFile file : files ) {

			String orginFileName = file.getOriginalFilename();

			//--------------------------------------
			// 원 파일명이 없는 경우 처리
			// (첨부가 되지 않은 input file type)
			//--------------------------------------
			if ("".equals(orginFileName)) {
				continue;
			}
			////------------------------------------

			int index = orginFileName.lastIndexOf(".");
			//String fileName = orginFileName.substring(0, index);
			String fileExt = orginFileName.substring(index + 1);
			String newName = KeyStr + WRDateUtil.getTimeStamp() + fileKey;
			long size = file.getSize();

			if (!"".equals(orginFileName)) {
				filePath = storePathString + WRFileUtil.SEPERATOR + newName;
				file.transferTo(new File(WebUtil.filePathBlackList(filePath)));
			}

			fvo = new WRFileVO();
			fvo.setFileExtsn(fileExt);
			fvo.setFileStreCours(storePathString);
			fvo.setFileSize(Long.toString(size));
			fvo.setOrignlFileNm(orginFileName);
			fvo.setStreFileNm(newName);
			fvo.setAtchFileId(atchFileIdString);
			fvo.setFileSn(String.valueOf(fileKey));

			result.add(fvo);

			fileKey++;
		}

		return result;
	}


	/**
	 * 파일을 실제 물리적인 경로에 생성한다.
	 *
	 * @param file
	 * @param newName
	 * @param stordFilePath
	 * @throws Exception
	 */
	protected void writeFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
		InputStream stream = null;
		OutputStream bos = null;

		try {
			stream = file.getInputStream();
			File cFile = new File(WebUtil.filePathBlackList(stordFilePath));

			if (!cFile.isDirectory()){
				//2017.03.03 	조성원 	시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
				if (cFile.mkdirs()){
					log.debug("[file.mkdirs] saveFolder : Creation Success ");
				}else{
					log.error("[file.mkdirs] saveFolder : Creation Fail ");
				}
			}

			bos = new FileOutputStream(WebUtil.filePathBlackList(stordFilePath + WRFileUtil.SEPERATOR + newName));

			int bytesRead = 0;
			byte[] buffer = new byte[WRFileUtil.BUFF_SIZE];

			while ((bytesRead = stream.read(buffer, 0, WRFileUtil.BUFF_SIZE)) != -1) {
				bos.write(buffer, 0, bytesRead);
			}
		} finally {
			ResourceCloseHelper.close(bos, stream);
		}
	}


	/**
	 * 첨부로 등록된 파일을 서버에 업로드한다.
	 *
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, String> uploadFile(MultipartFile file) throws Exception {

		HashMap<String, String> map = new HashMap<String, String>();
		//Write File 이후 Move File????
		String newName = "";
		String stordFilePath = propertyConfigurer.getProperty("Globals.fileStorePath");
		String orginFileName = file.getOriginalFilename();

		int index = orginFileName.lastIndexOf(".");
		//String fileName = orginFileName.substring(0, _index);
		String fileExt = orginFileName.substring(index + 1);
		long size = file.getSize();

		//newName 은 Naming Convention에 의해서 생성
		newName = WRDateUtil.getTimeStamp(); // 2012.11 KISA 보안조치
		writeFile(file, newName, stordFilePath);
		//storedFilePath는 지정
		map.put("originFileNm", orginFileName);
		map.put("uploadFileNm", newName);
		map.put("fileExt", fileExt);
		map.put("filePath", stordFilePath);
		map.put("fileSize", String.valueOf(size));

		return map;
	}

}
