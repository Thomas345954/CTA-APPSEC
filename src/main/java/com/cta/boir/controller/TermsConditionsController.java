package com.cta.boir.controller;

import com.cta.boir.model.User;
import com.cta.boir.service.EmployeeService;
import com.cta.boir.service.UserService;

import org.springframework.security.core.Authentication;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;


@Controller

public class TermsConditionsController {
	@Autowired
	private UserService userService;
    
    @GetMapping("/terms")
    	public String terms(Model model,HttpSession session) {
        	
        	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        	  boolean isAuthenticated=false;
        	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
        		isAuthenticated=authentication.isAuthenticated();
        		String userName = authentication.getName();
          		User user = userService.findByEmail(userName);
          		model.addAttribute("image", user.getImage());
        		 
            }
        	model.addAttribute("isAuthenticated",isAuthenticated); 
    
        return "terms-conditions";
    }

    @GetMapping("/privacy")
    public String privacy(Model model,HttpSession session) {
    	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	  boolean isAuthenticated=false;
    	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
    		isAuthenticated=authentication.isAuthenticated();
    		String userName = authentication.getName();
      		User user = userService.findByEmail(userName);
      		model.addAttribute("image", user.getImage());

    		 
        }
    	model.addAttribute("isAuthenticated",isAuthenticated); 
    	
    
        return "privacy-policy";
    }
    
    @GetMapping("/refund")
    	
    	public String refund(Model model,HttpSession session) {
        	
        	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        	  boolean isAuthenticated=false;
        	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
        		isAuthenticated=authentication.isAuthenticated();
        		String userName = authentication.getName();
          		User user = userService.findByEmail(userName);
          		model.addAttribute("image", user.getImage());

        		 
            }
        	model.addAttribute("isAuthenticated",isAuthenticated); 
    	
        return "refund";
    }
    
    @GetMapping("/cookie")
    public String cookie(Model model,HttpSession session) {
    	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	  boolean isAuthenticated=false;
    	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
    		isAuthenticated=authentication.isAuthenticated();
    		String userName = authentication.getName();
      		User user = userService.findByEmail(userName);
      		model.addAttribute("image", user.getImage());

    		 
        }
    	model.addAttribute("isAuthenticated",isAuthenticated); 
    	
    	
    	
        return "cookie";
    }
    
    @GetMapping("/termsuse")
    	
    	public String termsuse(Model model,HttpSession session) {
        	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        	  boolean isAuthenticated=false;
        	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
        		isAuthenticated=authentication.isAuthenticated();
        		String userName = authentication.getName();
          		User user = userService.findByEmail(userName);
          		model.addAttribute("image", user.getImage());

        		 
            }
        	model.addAttribute("isAuthenticated",isAuthenticated); 
    	
        return "terms-use";
    }
    
}
