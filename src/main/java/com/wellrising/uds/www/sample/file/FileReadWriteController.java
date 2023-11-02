package com.wellrising.uds.www.sample.file;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.wellrising.uds.util.file.JakartaFtpWrapper;

public class FileReadWriteController {

	// 전송 텍스트 파일 리드
	public Map fileRead(HttpServletRequest requestData) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> resource = new HashMap<String, String>();

		Map<String, String> search = new HashMap<String, String>();
		Map<String, String> value = new HashMap<String, String>();
		Map dmParams = requestData.getParameterMap();

		String file_name = dmParams.get("FILE_SE") + dmParams.get("RECEIPTDT").toString().substring(4, 8);
		String date = dmParams.get("RECEIPTDT").toString();

		search.put("FILE_NAME", file_name);
		search.put("RECEIPTDT", date);

//		value = dao.selectOne("cmsEB11List.selectEB11", search);
		value = null;

		if(value == null) {
/*
			Map<String, String> dmParam = dmParams.getSingleValueMap();
			Map<String, UploadFile[]> uploadFiles = requestData.getUploadFiles();

			UploadFile[] files = uploadFiles.get("file1");
*/
			Map<String, String> dmParam = dmParams;
			Map<String, MultipartFile[]> uploadFiles = null;

			List<MultipartFile> files = null;

			File file = null;

			BufferedReader br = new BufferedReader(new FileReader(file));

			String str = br.readLine();

			String head = str.substring(0, 119);
			String Receiptdt = dmParam.get("RECEIPTDT");
			String fileNm = head.substring(19,27).toString();

			String data = str.substring(120,str.indexOf("T"));
			String foot = str.substring(str.indexOf("T"), str.length());

			String[] subData = data.split("R");

			for(int i = 1; i < subData.length; i++) {

				String body = subData[i];

				String dATA = body.substring(0,8); //DATA 일련번호
				String dRAWINGREQDT = body.substring(18, 24); //신청일자
				dRAWINGREQDT = dRAWINGREQDT.trim();
				dmParam.get("FILE_SE").concat(Receiptdt.substring(4));

				Map<String, String> insert = new HashMap<String, String>();
				insert.put("FILE_NAME", fileNm);
				insert.put("RECEIPTDT", Receiptdt);
				insert.put("PRCNO", dATA);
				insert.put("DRAWINGREQDT", dRAWINGREQDT);

//				dao.insert("cmsEB11List.insertCmsEB11List", insert);

				new HashMap<String, String>();
			}
			System.out.println("없음");

		}
		resource.put("code", "0");
		resource.put("msg", "성공!");

		return resource;
	}

	// 디비 조회 후 파일 생성
	// file_write ouputStream
	public int fileWriteOuputStream(Map<String, String> mapParam, HttpServletRequest requestData) throws Exception {
		// TODO Auto-generated method stub

		Map dsParams = requestData.getParameterMap();
//		Iterator<ParameterRow> insertedRows = dsParams.getInsertedRows();
		Iterator<Map> insertedRows = null;

		String cms_code = mapParam.get("CMS_CODE");
//		String file_name = mapParam.get("FILE_NAME");
		String file_dir = mapParam.get("FILE_DIR");
		String fileName = "EB12" + mapParam.get("RECEIPTDT2").substring(4,8);

		String target_folder = file_dir;
//		String title = file_name;

		File locaFile = new File(target_folder+"\\"+fileName);
		FileOutputStream fos = null;
		fos = new FileOutputStream(locaFile);
		try {
			//HEADER
			String head = "H";
			String headerSn = "00000000";
			String headerInstt =  String.format("%-10s", cms_code);// 기관코드(10)
			String headerReqstDt = String.format("%-6s", mapParam.get("RECEIPTDT").substring(2)); // 신청일_YYMMDD(6)(파일명의 MMDD와 동일한 날짜)
			String headerFilter = String.format("%87s", " ");

			String file_Name = "EB12"+ headerReqstDt.substring(2, headerReqstDt.length());

			String hederText = "";
			hederText += head;
			hederText += headerSn;
			hederText += headerInstt;
			hederText += file_Name;
			hederText += headerReqstDt;
			hederText += headerFilter;

			fos.write(hederText.getBytes());

			int newCnt = 0;
			int endCnt = 0;
			int forceEndCnt = 0;
			int i = 1;
			Map<String, String> mapIns = null;
			Map<String, String> mapData = null;
			while(insertedRows.hasNext()){

				mapIns = insertedRows.next();
//				mapData = dao.selectOne("cmsEB11List.selectCmsEB11ListOne", mapIns);
				mapData = null;

				String recordText = "";
				recordText += "R"; // Record 구분(1)
				recordText += StringUtils.leftPad(Integer.toString(i++), 8, "0"); // Data 일련번호(8)
				recordText += String.format("%-10s", cms_code);// 기관코드(10);
				recordText += headerReqstDt; // 신청일자(6)
				recordText += mapData.get("DRAWINGTYPE"); // 신청구분(1) "1" : 신규, "3" : 해지, "7" : 임의해지
				recordText += String.format("%-20s", mapData.get("PAYID")); // 납부자번호(20)
				recordText += String.format("%-7s", StringUtils.rightPad(mapData.get("BANK"), 7, "0")); // 은행코드(7)
				recordText += String.format("%10s", mapData.get("FILTER2")); // FILLER(10)

				fos.write(recordText.getBytes());

				if (mapData.get("DRAWINGTYPE").equals("1"))  newCnt++;
				if (mapData.get("DRAWINGTYPE").equals("3"))  endCnt++;
				if (mapData.get("DRAWINGTYPE").equals("7"))  forceEndCnt++;

			}

			// Trailer
			String traierdHead = "T";
			String traierdCn = "99999999";
			String traierdInstt = String.format("%-10s", cms_code);
			String traierdFileName = String.format("%-8s", file_Name);
			String traierdTotCnt = StringUtils.leftPad(Integer.toString(newCnt+endCnt+forceEndCnt), 8, '0');
			String traierdModCnt = "00000000";
			String traierdFiler1 = String.format("%43s", " ");

			String trailerText = "";
			trailerText += traierdHead;
			trailerText += traierdCn;
			trailerText += traierdInstt;
			trailerText += "EB12"+ headerReqstDt.substring(2, headerReqstDt.length());
			trailerText += traierdTotCnt;
			trailerText += traierdModCnt;
			trailerText += traierdFiler1;

			fos.write(trailerText.getBytes());
		} catch(IOException e) {

		} finally {
			try {
				fos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} // end of try catch finally
		return 0;
	}

	// file_write OutputStreamWriter
	public void fileWriteOutputStreamWriter(Map<String, String> mapParam) throws FileNotFoundException {
		// TODO Auto-generated method stub
		String file_Dir = mapParam.get("FILE_DIR");
		String cms_Code = mapParam.get("CMS_CODE");

		Map<String, String> map = new HashMap<String, String>();

		String target_folder = file_Dir;
		String title = mapParam.get("title");

		File locaFile = new File(target_folder+"\\"+title);
		FileOutputStream fos = new FileOutputStream(locaFile);
		OutputStreamWriter osr = null;

		try {
			osr = new OutputStreamWriter(fos, "ms949");

			// header
			String head = "H";
			String headFilter = "00000000";
			String acctNo = StringUtils.rightPad("43720179750", 16, " ");
			String headFilter1 = String.format("%94s", " ");

			String headText = "";
			headText += head;
			headText += headFilter;
			headText += acctNo;
			headText += headFilter1;

			//fos.write(headText.getBytes());
			osr.write(headText);


			// Record
			String record = "R";
			StringBuffer fullStrCompany = new StringBuffer();
			String halfStrCompany = "케이엘넷    ";
			//전각문자 변환
			char fullSpace = 0x3000;
			char fullChar = 0;
			int nStrLenth = halfStrCompany.length();

			for (int i=0; i<nStrLenth; i++) {
				fullChar = halfStrCompany.charAt(i);

				if (fullChar >= 0x21 && fullChar <=0x7e) {
					fullChar += 0xfee0;
				} else if (fullChar == 0x20) {
					fullChar = 0x3000;
				}

				fullStrCompany.append(fullChar);
			}

			List<Map<String, String>> list = new ArrayList<Map<String, String>>();
//			list = dao.selectList("cmsEB21Mng.selectBankTextOne", mapParam);
			list = null;

			Map<String, String> a = null;
			int j = 1;
			for(int i = 0; i < list.size(); i++){
				a = list.get(i);

				if(a.get("BANK") != null && a.get("BANK") != "") {
					if(a.get("ACCTNO") != null && a.get("ACCTNO") != "") {
						String data = Integer.toString(j++);
						data = StringUtils.leftPad(data, 8, "0");
						String bank = a.get("BANK");
						String acctNO = a.get("ACCTNO");
						String company = fullStrCompany.toString();

						String recordText = "";
						recordText += record;
						recordText += data;
						recordText += cms_Code;
						recordText += bank;
						recordText += acctNO;
						recordText += company;

						//fos.write(recordText.getBytes());
						osr.write(recordText);

					}
				}

			}
			// tail
			String tail = "T";
			String tail_Filter = "99999999";

			String count = Integer.toString(j-1);
			count = StringUtils.leftPad(count, 8, "0");

//			Map<String, String> c = dao.selectOne("cmsEB21Mng.selectBankTextSumReqAmt", mapParam);
			Map<String, String> c = null;
			String sum = c.get("SUM");

			String tailText = "";
			tailText += tail;
			tailText += tail_Filter;
			tailText += cms_Code;
			tailText += count;
			tailText += sum;

			//fos.write(tailText.getBytes());
			osr.write(tailText);
			osr.flush();
		} catch(IOException e) {

		} finally {
			try {
				osr.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	// 외부 서버 이미지파일 조회 다운로 바이너리 변경
	public void atchmnflWrite(HttpServletRequest requestData) {
		// TODO Auto-generated method stub
		Map<String,Object> dsm = new HashMap<String,Object>();
		Map<String, String> dmTab2Param =  (Map<String, String>) requestData.getAttribute("dmTab2Param");
		List dsListEI13 = (List) requestData.getAttribute("dsListEI13");
		int dataRowCount = dsListEI13.size();
		Iterator<Map> updateRows = null;

		String localPath = dmTab2Param.get("FILE_DIR");
		String fileNm = dmTab2Param.get("FILE_NAME");

//		String filePath = "";
		JakartaFtpWrapper ftpWrapper = new JakartaFtpWrapper();
		File localDirectory = new File(localPath);

		if(!localDirectory.exists()) {
			boolean mkdirs= localDirectory.mkdirs();
			//System.out.println("mkdirs = " + mkdirs);
		}


		File locaFile = new File(localPath+"\\"+fileNm);
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(locaFile);
//		OutputStreamWriter osw = new OutputStreamWriter(fos, "MS949");
//			OutputStreamWriter osw = new OutputStreamWriter(fos);
//			BufferedWriter bf = new BufferedWriter(osw);

			String connectIP = "172.25.1.182";
            String connectID = "INFRA";
            String connectPWD = "#vortm_17";

			if(ftpWrapper.connectAndLogin(connectIP, connectID, connectPWD)){
				ftpWrapper.setControlEncoding("EUC-KR");
				ftpWrapper.setPassiveMode(true);
//				ftpWrapper.setFileType(FTP.BINARY_FILE_TYPE);
//				ftpWrapper.setFileTransferMode(FTP.BINARY_FILE_TYPE);

//				StringBuffer sb = new StringBuffer();

				int snCnt = 0;
				while(updateRows.hasNext()){
					String serverPath = "test/test.jpg";
					String fileName = "filename";

					String fileExtention = serverPath.substring(serverPath.lastIndexOf(".")+1);

//					boolean fileDown = ftpWrapper.downloadFile("/Storage/"+serverPath, filePath);
//					convertTiff(new File(filePath), localPath, "jpg");

					// FTP 파일 읽어오기
					InputStream ins = ftpWrapper.retrieveFileStream("/Storage/"+serverPath);
/*
					byte[] buffer = new byte[8*1024];

					File file = new File(localPath+"test.tif");
					OutputStream out = new FileOutputStream(file);

					int bytesRead;
					while((bytesRead = ins.read(buffer)) != -1) {
						out.write(buffer, 0, bytesRead);
					}
					out.flush();
					out.close();
*/

					byte[] img = null;
					if(ins != null) {
						// BLOB 입력을 위한 바이트 변환
						img = IOUtils.toByteArray(ins);
					}

					// // EI13 문서 RECORD
					String rJobSeCode = "AE1112"; // 업무구분코드(6)
					String rSn = StringUtils.leftPad(Integer.toString(++snCnt), 7, '0'); // 일련번호(7) "0000001" - "9999998"

					byte[] rAgreDta = img; // 동의자료 Data X nnnn 실 동의자료 Data (Binary 모드)
					String rAgreDtaLt = StringUtils.leftPad(Integer.toString(rAgreDta.length), 7, "0"); // 동의자료 길이(7) 동의자료 Data의 실제 길이 (단위 : Bytes)

					String recordText = rJobSeCode;
					recordText += rSn;
					recordText += rAgreDtaLt;

					fos.write(recordText.getBytes());
					fos.write(rAgreDta);

//					recordText = String.format("%-1024s", recordText);

//					bf.write(recordText);
//					ops.write(recordText.getBytes());
//					sb.append(recordText);

					// FTP 정상 수진 확인
					ftpWrapper.completePendingCommand();
					// InputStream 닫기
					ins.close();
				}

				fos.flush();

				InputStream fileRead = new FileInputStream(locaFile);
				int bytesRead;
				int size = 0;
				while((bytesRead = fileRead.read()) != -1) {
					size++;
				}
				fileRead.close();

				// 바이스 사이즈 조정
				int recordByte = 1024-(size%1024);
				String filler = StringUtils.leftPad(" ", recordByte, " ");
				fos.write(filler.getBytes());

				size += recordByte;

				// // EI13 문서  TRAILER
				String tJobSeCode = "AE1112"; // 업무구분코드(6)
				String tDataRecordRepr = StringUtils.leftPad(Integer.toString(dataRowCount), 7, "0"); // Header Record의 총 동의자료 개수와 동일(7)
				String tDataBlockRepR = StringUtils.leftPad(Integer.toString((size/1024)-1 ), 10, "0"); // 1,024 Bytes 단위의 Record 수(10)
																	  // Data Record(Record 구분 "22")를 구성하는 1,024Bytes Block의 총 개수로서,
				                                                      // 파일크기를 1,024로 나눈 값에 Header, Trailer Record 수를 제외 ⇨ 파일크기/1,024 - 2
				String tFiller = String.format("%-972s", " "); // FILLER(972)

				String trailerText = tJobSeCode;
				trailerText += tDataRecordRepr;
				trailerText += tDataBlockRepR;
				trailerText += tFiller;

				trailerText = String.format("%-1024s", trailerText);

				fos.write(trailerText.getBytes());
//				bf.write(trailerText);
//				ops.write(trailerText.getBytes());
//				sb.append(trailerText);

//				bf.flush();
				fos.flush();

				dsm.put("forwardName","success");
				dsm.put("forwardMessage","");
			}
		} catch (Exception e) {
			dsm.put("forwardName","fail");
			dsm.put("forwardMessage",e.getMessage());
		} finally {
//			deleteFile(filePath);

//			bf.close();
//			osw.close();
			try {
				fos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			if(ftpWrapper.isConnected()) {
				try {
					ftpWrapper.logout();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					ftpWrapper.disconnect();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

/**
 * 서버 파일 삭제
 * @param s
 * @return
 */
	   public boolean deleteFile(String s) {
	        try {
	            File file = new File(s);
	            boolean result = false;
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
