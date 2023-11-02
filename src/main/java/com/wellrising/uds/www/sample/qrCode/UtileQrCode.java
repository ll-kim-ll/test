package com.wellrising.uds.www.sample.qrCode;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@Controller
@RequestMapping(value="/qrCode")
public class UtileQrCode {
	private static final Logger log = LoggerFactory.getLogger(UtileQrCode.class);

	@RequestMapping(value="/qrCode.do")
	public String qrCode(HttpServletRequest request) throws Exception {

		return "/sample/qrCode/qrCode";
	}

	@GetMapping(value="/getQrCode.do")
	public void getQrCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		QRCodeWriter insQrCodeWriter = new QRCodeWriter();
		//한글 데이터 처리
		String strData = new String(request.getParameter("qrData").getBytes("UTF8"), "ISO-8859-1");
		//가로,세로 177 사이즈로 qr코드 생성
		BitMatrix insBitMatrix = insQrCodeWriter.encode(strData, BarcodeFormat.QR_CODE, 400, 400);
		ServletOutputStream insOutputStream = response.getOutputStream();
		MatrixToImageWriter.writeToStream(insBitMatrix, "png", insOutputStream);
		insOutputStream.flush();
		insOutputStream.close();

	}
}
