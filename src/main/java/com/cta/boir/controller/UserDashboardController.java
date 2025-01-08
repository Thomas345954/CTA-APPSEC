package com.cta.boir.controller;

import com.cta.boir.model.Employee;
import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.User;
import com.cta.boir.service.EmployeeService;
import com.cta.boir.service.FillingService;
import com.cta.boir.service.PaymentHistoryService;
import com.cta.boir.service.UserService;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
public class UserDashboardController {
    
    @Autowired
    private PaymentHistoryService phs;
    @Autowired
    private UserService us;
    @Autowired
    private FillingService fs;
    
    @GetMapping("/userdashboard")
    public String getHome(Model model) {
    	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String principalName="";
    	  if (authentication != null) {
             principalName=authentication.getName() ;
        }
    	
    	User uservo=us.findByEmail(principalName);
    	
    	List<PaymentHistory> phvo=phs.wherePaymentHistoryByUser(String.valueOf(uservo.getEmail()));
    	int totalboirFiles = 0;
        // Iterate over the list and sum the amountPaid values
        for (PaymentHistory ph : phvo) {
        	if(ph.getNofiles()!=null)
            totalboirFiles += Double.parseDouble(ph.getNofiles());
        }
        List<FilingInfo> fillingvo=fs.checkFilingAvalability(String.valueOf(uservo.getId()));
    	model.addAttribute("totalFiles", totalboirFiles);
    	model.addAttribute("filesFilled", fillingvo.size());
    	model.addAttribute("Pending",totalboirFiles-fillingvo.size());
    	model.addAttribute("principalName",principalName);
    	
        return "user-dashboard";
    }
    
    @GetMapping("/editboir")
	
	public String editboir(Model model,HttpSession session) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	  boolean isAuthenticated=false;
    	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
    		isAuthenticated=authentication.isAuthenticated();
    		 
        }
    	model.addAttribute("isAuthenticated",isAuthenticated); 
	
    return "editboir";
}

    
}
