package com.wellrising.uds.util.file.service;

import java.io.File;

public class WRFileDeleteUtil {
	/**
	 * 서버 파일 삭제
	 * @param s
	 * @return
	 */
   public static boolean deleteFile(WRFileVO fileVO) {
	   boolean result = false;
	   if(!fileVO.getFileStreCours().isEmpty() && !fileVO.getStreFileNm().isEmpty()) {
		   try {
			   File file = new File(fileVO.getFileStreCours(), fileVO.getStreFileNm());
			   if(file.isDirectory()){
				   File[] fList = file.listFiles();

				   //디렉토리내의 파일 삭제
				   for(int i=0; i<fList.length; i++){
					   result = fList[i].delete();
				   }
				   //디렉토리 삭제
				   result = file.delete();
			   }else{
				   result = file.delete();
			   }
			   return result;
		   } catch(Exception exception) {
			   exception.printStackTrace();
			   return false;
		   }
	   }
	   return result;
    }
}
