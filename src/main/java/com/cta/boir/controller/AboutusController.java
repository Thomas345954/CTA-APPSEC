package com.cta.boir.controller;

import com.cta.boir.model.Employee;
import com.cta.boir.model.User;
import com.cta.boir.service.EmployeeService;
import com.cta.boir.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class AboutusController {
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private UserService userService;
    

    @GetMapping("/aboutus")
    public String getAboutUs(Model model) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	  boolean isAuthenticated=false;
    	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
    		isAuthenticated=authentication.isAuthenticated();
    		String userName = authentication.getName();
      		User user = userService.findByEmail(userName);
      		model.addAttribute("image", user.getImage());
    		 
        }
    	model.addAttribute("isAuthenticated",isAuthenticated);  
	        
    	return "aboutus";
    }

    
}
