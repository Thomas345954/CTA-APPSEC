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
public class PricingController {
    @Autowired
    private EmployeeService employeeService;
    @Autowired
	private UserService userService;

    @Autowired
	WraperService wraperService;
    @Value("${nybacsAdmin.api.entity.service}") private String entity;
    @GetMapping("/dashboardpricing")
    public String getDashboardPricing(Model model) {
      	String url =entity;
    	String pricingIndividualData = wraperService.postDataResp(url,"{\r\n"
    			+ "    \"entityName\" : \"pricing\",\r\n"
    			+ "    \"whereClause\" : \"c_name ='A' order by c_priority\"\r\n"
    			+ "}");
    	String pricingEnterpriseData = wraperService.postDataResp(url,"{\r\n"
    			+ "    \"entityName\" : \"pricing\",\r\n"
    			+ "    \"whereClause\" : \"c_name='B' order by c_priority\"\r\n"
    			+ "}");
    	
    	
    	JsonParser springParserPricingInd = JsonParserFactory.getJsonParser();
        List<Object> pricingIndJsonList = springParserPricingInd.parseList(pricingIndividualData);
        model.addAttribute("pricingIndObjectList", pricingIndJsonList);
        
        
        JsonParser springParserPricingEnt = JsonParserFactory.getJsonParser();
        List<Object> pricingEntJsonList = springParserPricingEnt.parseList(pricingEnterpriseData);
        model.addAttribute("pricingEntObjectList", pricingEntJsonList);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	  boolean isAuthenticated=false;
    	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
    		isAuthenticated=authentication.isAuthenticated();
    		 
        }
    	model.addAttribute("isAuthenticated",isAuthenticated);  
        return "dashboard-pricing";
    }

    @GetMapping("/pricing")
    public String getPricing(Model model) {

    	String url = entity;
    	String pricingIndividualData = wraperService.postDataResp(url,"{\r\n"
    			+ "    \"entityName\" : \"pricing\",\r\n"
    			+ "    \"whereClause\" : \"c_name ='A' order by c_priority\"\r\n"
    			+ "}");
    	String pricingEnterpriseData = wraperService.postDataResp(url,"{\r\n"
    			+ "    \"entityName\" : \"pricing\",\r\n"
    			+ "    \"whereClause\" : \"c_name='B' order by c_priority\"\r\n"
    			+ "}");
    	
    	
    	JsonParser springParserPricingInd = JsonParserFactory.getJsonParser();
        List<Object> pricingIndJsonList = springParserPricingInd.parseList(pricingIndividualData);
        model.addAttribute("pricingIndObjectList", pricingIndJsonList);
        
        
        JsonParser springParserPricingEnt = JsonParserFactory.getJsonParser();
        List<Object> pricingEntJsonList = springParserPricingEnt.parseList(pricingEnterpriseData);
        model.addAttribute("pricingEntObjectList", pricingEntJsonList);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	  boolean isAuthenticated=false;
    	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
    		isAuthenticated=authentication.isAuthenticated();
    		String userName = authentication.getName();
      		User user = userService.findByEmail(userName);
      		model.addAttribute("image", user.getImage());
    		 
        }
    	model.addAttribute("isAuthenticated",isAuthenticated);  
	                
    	
        return "pricing";
    }

    
}
