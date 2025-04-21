package com.grownited.service;

import java.io.File;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadService {

	
public void uploadUserImage(MultipartFile masterImage,String email) {
		
//		now let's upload the file image into the folder
		
		String path="C:\\Users\\Naitik\\Documents\\workspace-spring-tool-suite-4-4.22.1.RELEASE\\spring-jdbc\\src\\main\\webapp\\images\\profilepic";
		
		//// now you have to create another folder -> email -> copy profile pic
		//email thi ek navu folder create thashe
		File dir=new File(path,email);
		dir.mkdir();// exists -> false | not exists->true
		try {
			byte b[]=masterImage.getBytes();
			
			//now let's create the file and write the byte into that file
			
//			File file=new File(path+email,masterImage.getOriginalFilename());
			File file=new File(dir,masterImage.getOriginalFilename());
			FileUtils.writeByteArrayToFile(file, b);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
