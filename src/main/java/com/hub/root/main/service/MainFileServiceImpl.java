package com.hub.root.main.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MainFileServiceImpl implements MainFileService{
	@Override
	public String saveFile(MultipartFile mul) {
		SimpleDateFormat simpl = new SimpleDateFormat("yyyyMMddHHmmss-");
		String getOriginalFilename = mul.getOriginalFilename();
		String sysFileName = simpl.format(new Date()) +mul.getOriginalFilename();
		File saveFile = new File(IMAGE_REPO+"/"+sysFileName);
		try {
			mul.transferTo(saveFile); //해당 위치에 파일 저장
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sysFileName;
	}
	@Override
	public void deleteImage(String originName) {
		File file = new File(IMAGE_REPO+"/"+originName);
		if(file.exists())
			file.delete();
	}
}
