package com.wellrising.uds.util.file.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.wellrising.uds.core.comm.util.ResourceCloseHelper;
import com.wellrising.uds.core.comm.util.WebUtil;

public class WRFileUtil {
	private static final Logger LOGGER = LoggerFactory.getLogger(WRFileUtil.class);

	public static final int BUFF_SIZE = 2048;
	public static final long MAX_FILE_SIZE = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
	public static final String SEPERATOR = File.separator;

	/**
	 * 파일 확장자를 추출한다.
	 *
	 * @param fileNamePath
	 * @return 확장자 : "" 또는 추출된 확장자
	 */
	public static String getFileExtension(String fileNamePath) {

		if (fileNamePath == null) return "";
		String ext = fileNamePath.substring(fileNamePath.lastIndexOf(".") + 1,fileNamePath.length());

		return (ext == null) ? "" : ext;
	}

	/**
	 * 파일 확장자의 허용유무를 검증한다.
	 *
	 * @param fileNamePath
	 * @param whiteListExtensions : ex) .png.pdf.txt
	 * @return true : 허용
	 * @return true : 불가
	 */
	public static boolean checkFileExtension(String fileNamePath, String whiteListExtensions) {
		String extension = getFileExtension(fileNamePath);

		if ( "".equals(extension) ) return false;

		if ( whiteListExtensions == null ) return false;
		if ( "".equals(whiteListExtensions) ) return false;

		if ( whiteListExtensions.indexOf("."+extension) >= 0 ) return true;
		else return false;
	}

	/**
	 * 최대 파일 사이즈 허용유무를 검증한다.
	 *
	 * @param multipartFile
	 * @param maxFileSize : ex) 1048576 = 1M , 1K = 1024
	 * @return true : 허용
	 * @return true : 불가
	 */
	public static boolean checkFileMaxSize(MultipartFile multipartFile, long maxFileSize) {

		if ( multipartFile == null ) return false;

		if ( multipartFile.getSize() <= maxFileSize ) return true;
		else return false;
	}
}
