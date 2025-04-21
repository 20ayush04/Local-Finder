package com.grownited.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.grownited.dto.ForgotPasswordDto;
import com.grownited.entity.UserEntity;
import com.grownited.enumD.Status;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.ServicesRepository;
import com.grownited.repository.UserRepository;
import com.grownited.service.FileUploadService;
import com.grownited.service.MailService;

import jakarta.servlet.http.HttpSession;

@Controller
public class SessionController {

	@Autowired
	private FileUploadService fileUploadService;

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private ServicesRepository servicesRepository;

	@Autowired
	private MailService mailService;
	

	
	@Autowired
 	Cloudinary cloudinary;

	// This open the singup page
	@GetMapping(value = { "sp", "signup" })
	public String signUp() {
		return "Signup";
	}

	// This open the Login Page
	@GetMapping("login")
	public String login() {

		return "Login";
	}

	// This open the forgot password jsp
	@GetMapping("forgotpassword")
	public String forgotPassword() {

		return "ForgotPassword";
	}

	// This is url to save the user in the database . for signup

//	this use when we take the photo of the user
//	@PostMapping("saveUser")
//	public String saveUser(@ModelAttribute UserEntity userEntity) {
//		
//		userEntity.setCreatedAt(new Date());
//		userEntity.setUpdatedAt(new Date());
//		fileUploadService.uploadUserImage(userEntity.getProfilePic(),userEntity.getEmailId());
//		
//		
//		String path="images/products/";
//		String imgName=userEntity.getProfilePic().getOriginalFilename();
//		
//		String imgSrc=path+imgName;
//		userEntity.setProfilePicUrl(imgSrc);
//	
//		
//		return "Login";
//	}

	@PostMapping("saveUser")
	public String saveUser(@ModelAttribute UserEntity userEntity) {

		System.out.println(userEntity.getRole());
		userEntity.setCreatedAt(new Date());
		userEntity.setUpdatedAt(new Date());
		userEntity.setStatus(Status.ACTIVE);
		
		
		//uploading image
		Map result;
		try {
			result = cloudinary.uploader().upload(userEntity.getProfilePic().getBytes(), ObjectUtils.emptyMap());

			//System.out.println(result);
			//System.out.println(result.get("url"));
			userEntity.setProfilePicUrl(result.get("url").toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		userRepository.save(userEntity);
		mailService.sendDemoMail(userEntity);

		return "redirect:/login";
	}

	// This is url to loginUser : for login
	@PostMapping("loginuser")
	public String loginUser(UserEntity userEntity, HttpSession httpSession,Model model) {
	    System.out.println("Login user checked");

	    UserEntity foundUser = userRepository.findByEmailIdAndPassword(userEntity.getEmailId(), userEntity.getPassword());
	    
	    if (foundUser == null) {
	        System.out.println("Invalid credentials");
	        return "redirect:/login";  // Show error message
	    }

	    System.out.println("Credentials are correct");
	    httpSession.setAttribute("userId", foundUser.getUserId());
	    httpSession.setAttribute("role", foundUser.getRole());
	    foundUser.setPassword("");
	    System.out.println("User ID stored in session: " + foundUser.getUserId());
	    System.out.println("User Role stored in session: " + foundUser.getRole());

	    switch (foundUser.getRole()) {
	        case ADMIN:
//	            return "redirect:/admin/dashboard";
	        	return "redirect:/admindashboard";
	        case SERVICE_PROVIDER:
	        	System.out.println("serviceProvider name"+foundUser.getName());
	        	System.out.println("serviceProvider emailId"+foundUser.getEmailId());
	        	System.out.println("serviceProvider Status"+foundUser.getStatus());
	        
	        	model.addAttribute("serviceProvider", foundUser);
	            return "redirect:/service-provider/dashboard";
	        default:
	        	//category pass
	        	
//	        	return "redirect:/loginuserhome";  // This is the problem
	        	return "redirect:/loginuserhome";
	    }
	}

//	public String loginUser(UserEntity userEntity, HttpSession httpSession) {
//		System.out.println("login user checked");
//		userEntity = userRepository.findByEmailIdAndPassword(userEntity.getEmailId(), userEntity.getPassword());
//		if (userEntity != null) {
//			System.out.println("crediantial is correct");
//			httpSession.setAttribute("userId", userEntity.getUserId());
//			httpSession.setAttribute("userRole", userEntity.getRole());
//			 switch (userEntity.getRole()) {
//	            case ADMIN:
//	                return "redirect:/admin/dashboard";
//	            case SERVICE_PROVIDER:
//	                return "redirect:/service-provider/dashboard";
//	            default:
//	            	System.out.println("defaul case");
//	                return "redirect:/loginuserhome";
//	        }
//			
//		} else
//			return "redirect:/login";
//	}

	// Update Password url
	@PostMapping("/updatePassword")
	public String updatePassword(ForgotPasswordDto dto, HttpSession httpSession) {
		Integer gotp = (Integer) httpSession.getAttribute("gotp");

		if ((dto.getOtp().equals(gotp)) && (dto.getPassword().equals(dto.getCpassword()))) {
			Optional<UserEntity> op = userRepository.findByEmailId(dto.getEmailId());
			if (op.isPresent()) {
				UserEntity entity = op.get();
				entity.setPassword(dto.getPassword());
				System.out.println(dto);
				userRepository.save(entity);
				httpSession.removeAttribute("gotp");
			}
			return "redirect:/login";
		}
		return "redirect:/forgotpassword";
	}

	@PostMapping("sendotp")
	public String sendOtp(String emailId, Model model, HttpSession httpSession) {
		// otp logic
		Random random = new Random();
		Integer otp = 100000 + random.nextInt(900000); // Generates 6-digit OTP
		Optional<UserEntity> op = userRepository.findByEmailId(emailId);
		if (op.isPresent()) {
			mailService.sendOtpForForgotPassword(emailId, otp);
			httpSession.setAttribute("gotp", otp);
			httpSession.setAttribute("emailId",emailId);
			return "UpdatePassword";
		} else {
			return "forgotpassword";
		}
	}

	@GetMapping("logout")
	public String logout(HttpSession httpSession) {
		httpSession.invalidate();
		return "Home";
	}

}
