package com.cta.boir.controller;

import com.cta.boir.model.Employee;
import com.cta.boir.model.User;
import com.cta.boir.service.EmployeeService;
import com.cta.boir.service.UserService;
import com.cta.boir.service.WraperService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class FaqController {
    @Autowired
    private EmployeeService employeeService;
    @Autowired
	WraperService wraperService;
    @Autowired
    private UserService userService;
    @Value("${nybacsAdmin.api.entity.service}") private String entity;
    @GetMapping("/faq")
    public String getFaq(Model model) {
    	String url = entity;
    	String faqData = wraperService.postDataResp(url,"{\r\n"
    			+ "    \"entityName\" : \"faq\",\r\n"
    			+ "    \"whereClause\" : \"modifiedbyname = 'Admin Admin' order by datecreated\"\r\n"
    			+ "}");
    	//faq data
	      JsonParser springParserFaq = JsonParserFactory.getJsonParser();
	        List<Object> faqJsonList = springParserFaq.parseList(faqData);
	        model.addAttribute("faqObjectList", faqJsonList);
	        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        	  boolean isAuthenticated=false;
        	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
        		isAuthenticated=authentication.isAuthenticated();
        		String userName = authentication.getName();
          		User user = userService.findByEmail(userName);
          		model.addAttribute("image", user.getImage());
            }
        	model.addAttribute("isAuthenticated",isAuthenticated); 

    	        
	        return "faq";
    }

    
}
