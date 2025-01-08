package com.cta.boir.controller;

import com.cta.boir.model.Employee;
import com.cta.boir.model.User;
import com.cta.boir.service.ContactUsService;
import com.cta.boir.service.EditProfileService;
import com.cta.boir.service.EmployeeService;
import com.cta.boir.service.UserService;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Controller
public class EditProfileController {
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private UserService userService;
    @Autowired
    private EditProfileService editProfileService;

    @GetMapping("/editprofile")
    public String getFilingInformation(Model model) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	boolean isAuthenticated=false;
    	if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
         isAuthenticated=authentication.isAuthenticated();
    	}
    	model.addAttribute("isAuthenticated",isAuthenticated);
    	
    	User user =new User();
    	if(authentication!=null) {
    		user=    	userService.findByEmail(authentication.getName().toString());
    	}
    	model.addAttribute("user", user);
        return "edit-profile";
    }

    @PostMapping("/saveuser")
    public String saveUser(@ModelAttribute User user,HttpSession session) {
    	
    	User userpassword =new User();
    	userpassword=    	userService.findByEmail(user.getEmail());
    	user.setPassword(userpassword.getPassword());
    	editProfileService.saveUser(user);
    	session.setAttribute("editProfileMessage", "All your changes have been saved successfully. You’re good to go! ");
    	return "redirect:/dashboard";
    }
    
}
