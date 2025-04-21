package com.grownited.controller;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.grownited.dto.ContactUsDto;
import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private MailService mailService;
	
	@GetMapping("/userlist")
	public String getAllUser(HttpSession httpSession,Model model) {
		List<UserEntity> userList=userRepository.findAll();
		model.addAttribute("users" ,userList);
		return "UserList";
	}
	
	@GetMapping("/deleteuser")
	public String deleteUserById(@RequestParam("id") UUID userId) {
		userRepository.deleteById(userId);
		return "redirect:/userlist";
	}
	
	@GetMapping("/edituser")
	public String editUserById(@RequestParam("id") UUID userId,Model model) {
		System.out.println(userId);
	Optional<UserEntity> op=userRepository.findById(userId);
		model.addAttribute("user",op.get());
		
		return "EditUser";
	}
	
	@PostMapping("/updateuser")
	public String updateUserById(UserEntity  userEntity) {
		System.out.println("upadte user");
		Optional<UserEntity> op=userRepository.findById(userEntity.getUserId());
		UserEntity entity=op.get();
		
		System.out.println(entity.getStatus()+"status");
		entity.setName(userEntity.getName());
		entity.setEmailId(userEntity.getEmailId());
		entity.setPhone(userEntity.getPhone());
		
		entity.setUpdatedAt(new Date());
		userRepository.save(entity);
		return "redirect:/userlist";
	}
	
	
	@PostMapping("/user/contactus")
	public String userContactUs(ContactUsDto contactUsDto) {
		mailService.contactUsEmail(contactUsDto);
		return "redirect:/";
	}
	
}
