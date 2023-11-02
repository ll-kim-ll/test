package com.wellrising.uds.util.file.service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Component;

@Component
public class WRImageFileUtil {
	/**
	* tif to jpg 변환 로직
	* @param tiffFile
	* @param outputPath
	* @param convertFormat
	* @return
	* @throws IOException
	*/
    public File convertTiff(File tiffFile, String outputPath, String convertFormat) throws IOException {
        String fileName = tiffFile.getName();
        String ext = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        fileName = fileName.replace(ext, "."+convertFormat);
        BufferedImage tiff = ImageIO.read(tiffFile);
        File output = new File(outputPath + fileName);
        ImageIO.write(tiff, convertFormat, output);
        return output;
    }

	/**
	 * 이미지 imageToByteArray 변환(BLOB)
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
    public byte[] imageToByteArray(String filePath) throws Exception{
    	byte[] returnValue = null;

    	ByteArrayOutputStream baos = null;
    	FileInputStream fis = null;

    	try {
    		baos = new ByteArrayOutputStream();
    		fis = new FileInputStream(filePath);

    		byte[] buf = new byte[1024];
    		int read = 0;

    		while((read=fis.read(buf, 0, buf.length)) != -1) {
    			baos.write(buf, 0, read);
    		}
    		returnValue = baos.toByteArray();
    	}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	finally {
    		if(baos != null) {
    			baos.close();
    		}
    		if(fis != null) {
    			fis.close();
    		}
    	}
    	return returnValue;
    }
}
