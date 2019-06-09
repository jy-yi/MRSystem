package com.gsitm.mrs.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;


/**
 * 파일 업로드용 클래스
 * 
 * @author jongy
 *
 */
public class UploadFileUtils {

	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);

	public static String uploadFile (String uploadPath, String originalName, byte[] fileData) throws Exception {
		
		// 겹치지 않는 파일명을 위한 유니크한 값 생성
		UUID uuid = UUID.randomUUID();
		
		// 원본 파일 이름 + UUID
		String savedName = uuid.toString() + "_" + originalName;
		
		// 저장할 파일 준비
		File target = new File(uploadPath, savedName); 
		
		// 파일 저장
		FileCopyUtils.copy(fileData, target);
		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);
		String uploadedFileName = null;
		
		/* 확장자가 이미지일 경우 썸네일 생성 */
		if (MediaUtils.getMediaType(formatName) != null) {
			uploadedFileName = makeThumbnail(uploadPath, savedName, savedName);
		}
		
		return uploadedFileName;
	}
	
	/** 썸네일 이미지 생성*/
	private static String makeThumbnail (String uploadPath, String path, String fileName) throws Exception {
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		
		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
