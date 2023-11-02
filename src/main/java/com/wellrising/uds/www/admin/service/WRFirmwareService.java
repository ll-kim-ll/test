package com.wellrising.uds.www.admin.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.wellrising.uds.core.service.AbstractService;
import com.wellrising.uds.util.file.service.WRFileDownloadUtile;
import com.wellrising.uds.util.file.service.WRFileMngService;
import com.wellrising.uds.util.file.service.WRFileUploadUtil;
import com.wellrising.uds.util.file.service.WRFileVO;
import com.wellrising.uds.util.idGeneration.service.WRIdGenerationService;

@Service
public class WRFirmwareService extends AbstractService {
	private static final Logger log = LoggerFactory.getLogger(WRFirmwareService.class);

	@Value("#{globalProps['Globals.FileStorePath.Firmware']}")
	private String uploadDir;

	@Value("#{globalProps['Globals.Extensions.FileDownload']}")
	private String extWhiteList;

	@Value("#{globalProps['Globals.Extensions.FileUpload']}")
	private String extensions;

	@Resource(name="propertyConfigurer")
	private Properties propertyConfigurer;

	@Autowired
	WRFileUploadUtil fileUploadUtil;

	@Autowired
	WRFileDownloadUtile fileDownloadUtile;

	@Autowired
	WRFileMngService wRFileMngService;

	@Autowired
	WRIdGenerationService idGenerationService;
	/*
	 * @Autowired private
	 * Properties propertyConfigurer;
	 */

    /** 첨부 최대 파일 크기 지정 */
    private final long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)

    public static final String SEPERATOR = File.separator;

    @Autowired
    MessageSource messageSource;

	public List<Map> selectFirmwareList(Map<String, Object> params) throws Exception{
		// TODO Auto-generated method stub
		//List<Map> resultList = new HashMap<Map>();
		return dao.selectList("wRFirmware.selectFirmwareList", params);
	}

//	public List<FormBasedFileVo> insertFirmware(Map<String, Object> params, HttpServletRequest request) throws Exception {
	public void insertFirmware(Map<String, Object> params, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception {
		// TODO Auto-generated method stub

//		List<WRFormBasedFileVo> formBasedFileVo = fileUploadUtil.uploadFiles(request, uploadDir, maxFileSize);
//		List<FormBasedFileVo> formBasedFileVo1 = FileUploadUtil.uploadFilesExt(mRequest, uploadDir, maxFileSize, extensions);
		List<WRFileVO> result = null;
		String atchFileId = "";

	    //final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    List<MultipartFile> files = mRequest.getFiles("file_1");

	    if (!files.isEmpty() && files.get(0).getSize() > 0) {
	    	result = fileUploadUtil.parseFileInf(files, "FILE_FW_", 0, "", "Globals.FileStorePath.Firmware");
	    	atchFileId = wRFileMngService.insertFileInfs(result);
	    }

		params.put("dwldLink", atchFileId);


		dao.insert("wRFirmware.insertFirmware", params);

	}

	public void firmwareDownload(Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception{
		// TODO Auto-generated method stub

		params.put("fileStreCours", uploadDir);
		params.put("streFileNm", params.get("dwldLink"));
		params.put("orignlFileNm", "firmwareDownload");

		fileDownloadUtile.FileDownload(params, request, response);
	}


}
