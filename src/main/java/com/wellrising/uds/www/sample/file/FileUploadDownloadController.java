package com.wellrising.uds.www.sample.file;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.UUID;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.wellrising.uds.util.file.service.WRFileUploadUtil;
import com.wellrising.uds.util.file.service.WRFileUtil;
import com.wellrising.uds.util.file.service.WRFormBasedFileVo;


public class FileUploadDownloadController {
	private static final Logger log = LoggerFactory.getLogger(FileUploadDownloadController.class);

	@Value("#{globalProps['Globals.FileStorePath.Firmware']}")
	private String uploadDir;

	@Value("#{globalProps['Globals.Extensions.FileDownload']}")
	private String extWhiteList;

	@Value("#{globalProps['Globals.Extensions.FileUpload']}")
	private String extensions;

	@Resource(name="propertyConfigurer")
	private Properties propertyConfigurer;

	@Autowired
    private MessageSource messageSource;

	@Autowired
	private WRFileUploadUtil wRFileUploadUtil;

	// Multipart의 transferTo(Path path) 이용하기
    public void uploadFileTransferTo(MultipartFile[] uploadFiles){
    	String uploadPath = "c:/test";
        for(MultipartFile file : uploadFiles){
            String originalName = file.getOriginalFilename();
            String fileName = originalName.substring(originalName.lastIndexOf("\\") + 1);

            String uuid = UUID.randomUUID().toString();
            String savefileName = uploadPath + File.separator + uuid + "_" + fileName;
            Path savePath = Paths.get(savefileName);

            try {
                file.transferTo(savePath.toFile());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    // FileCopyUtils의 copy() 이용하기
    @PostMapping(value = "/upload")
    public void uploadFileCopy(MultipartFile[] uploadFiles){
    	String uploadPath = "c:/test";
        for(MultipartFile file : uploadFiles){
            String originalName = file.getOriginalFilename();
            String fileName = originalName.substring(originalName.lastIndexOf("\\") + 1);

            String uuid = UUID.randomUUID().toString();
            String savefileName = uploadPath + File.separator + uuid + "_" + fileName;
            Path savePath = Paths.get(savefileName);

            try {
                FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(savePath.toFile()));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    // 이미지 파일 업로드 후 이미지 링크 전달
	private void uploadImageFiles(MultipartHttpServletRequest mRequest, Model model) throws Exception {
		try {

			List<WRFormBasedFileVo> list = wRFileUploadUtil.uploadFiles(mRequest, uploadDir, WRFileUtil.MAX_FILE_SIZE, extWhiteList);
			if (list.size() > 0) {
				WRFormBasedFileVo vo = list.get(0);	// 첫번째 이미지

			    String url = mRequest.getContextPath()
						    + "/utl/web/imageSrc.do?"
						    + "path=" + vo.getServerSubPath()
						    + "&physical=" + vo.getPhysicalName()
						    + "&contentType=" + vo.getContentType();

			    model.addAttribute("url", url);
			    model.addAttribute("msg",messageSource.getMessage("이미지 링크", null, "이미지 링크", Locale.KOREAN));
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			model.addAttribute("url", "");
			model.addAttribute("msg",messageSource.getMessage("오류", null, Locale.KOREAN));
		}
	}
}
