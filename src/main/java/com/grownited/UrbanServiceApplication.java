package com.grownited;

import java.util.Map;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

@SpringBootApplication
@EntityScan(basePackages = "com.grownited.entity")
public class UrbanServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(UrbanServiceApplication.class, args);
	}
	
	@Bean
 	Cloudinary cloudinary() {
 		Map<String, String> config = ObjectUtils.asMap("cloud_name", "ddolp4fuu", "api_key", "221774898368287",
 				"api_secret", "mzX_GMhlRtb6CJBeMQ1KLHQbGmQ");
 		return new Cloudinary(config);
 	}

}
