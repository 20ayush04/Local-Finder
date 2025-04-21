package com.grownited.controller;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserProfileController {

	@Autowired
	private UserRepository userRepository;
	
	@GetMapping("/profile")
	public String openProfilePage(HttpSession httpSession, Model model) {
	    UUID userId = (UUID) httpSession.getAttribute("userId");
	    Optional<UserEntity> op = userRepository.findById(userId);
	    
	    if (op.isPresent()) {
	        model.addAttribute("user", op.get()); // ✅ User data Model ke through JSP me bhej raha hai
	        return "UserProfile"; // ✅ Ye return karega `UserProfile.jsp`
	    } else {
	        return "redirect:/login"; // ❌ Agar user nahi mila toh login page par redirect
	    }
	}
}
