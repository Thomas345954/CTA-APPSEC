package com.cta.boir.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cta.boir.model.User;
import com.cta.boir.service.UserService;

@Controller
public class UnsubscribeController {

	@Autowired
	private UserService userService;

	@GetMapping("unsubscribe")
	public String unsubscribe(@RequestParam("email") String userEmail, Model model) {
		model.addAttribute("userEmail", userEmail);
		return "unsubscribe";
	}
	
	@PostMapping("confirmUnsubscribe")
	public String confirmUnsubscribe(@RequestParam("userEmail") String userEmail, Model model) {
		/*
		 * Authentication authentication =
		 * SecurityContextHolder.getContext().getAuthentication(); boolean
		 * isAuthenticated = false;
		 * 
		 * isAuthenticated = authentication.isAuthenticated()
		 */;
		//String userName = authentication.getName();
		 User user = userService.findByEmail(userEmail);
		 model.addAttribute("confirmBtnClicked", "true");
		String unsubscribe;
		if(user!=null) {
			 if (!"true".equals(user.getUnsubscribe()))  {
				unsubscribe = "true";
				user.setUnsubscribe(unsubscribe);
				userService.save(user);
				model.addAttribute("message", "You have successfully unsubscribed.");
			 }else {
				 model.addAttribute("message", "You are already unsubscribed, and no further action is needed.");
			 } 
		}else {
			model.addAttribute("message", "Unsubscription failed. Please try again or reach out to us for assistance.");
		}
		return "unsubscribe";
		
	}

}
