package com.hub.root.main.service;

import org.springframework.web.multipart.MultipartFile;

public interface MainFileService {
	public static final String IMAGE_REPO = "C:/tablehub_image/businessM";
	//public static final String IMAGE_REPO = "c:/spring/img";
	//public static final String IMAGE_REPO = "\\\\192.168.42.40\\공유폴더\\tableHub\\main";
	public String saveFile(MultipartFile mul);
	public void deleteImage(String originName);

}
