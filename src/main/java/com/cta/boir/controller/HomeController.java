package com.cta.boir.controller;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.User;
import com.cta.boir.service.EmployeeService;
import com.cta.boir.service.FillingService;
import com.cta.boir.service.StartupService;
import com.cta.boir.service.UserService;
import com.cta.boir.service.WraperService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeController {
     

	@Autowired
    private EmployeeService employeeService;
    
	@Autowired
	WraperService wraperService;
	@Value("${nybacsAdmin.api.entity.service}") private String entity;
	@Autowired
	private FillingService fs;
	@Autowired
	private HttpServletRequest httpServletRequest;
	@Autowired
	private HttpServletResponse httpServletResponse;
	@Autowired
	private UserService userService;

    @GetMapping("/home")
    public String getHome(Model model, Principal principal) {
        String url = entity;
    	Long boirCount=3000000L;
    	String result=null;
		/*
		 * String pricingData = wraperService.postDataResp(url,"{\r\n" +
		 * "    \"entityName\" : \"pricing\",\r\n" +
		 * "    \"whereClause\" : \"c_price in ('119','149') order by c_priority\"\r\n"
		 * + "}"); String faqData = wraperService.postDataResp(url,"{\r\n" +
		 * "    \"entityName\" : \"faq\",\r\n" +
		 * "    \"whereClause\" : \"c_feature_type = 'A. General Questions' order by datecreated\"\r\n"
		 * + "}"); String testimonialData = wraperService.postDataResp(url,"{\r\n" +
		 * "    \"entityName\" : \"testimonials\",\r\n" +
		 * "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}"); String blogData
		 * = wraperService.postDataResp(url,"{\r\n" +
		 * "    \"entityName\" : \"blogs\",\r\n" +
		 * "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}");
		 */
    	String pricingData = StartupService.pricingData;
    	String faqData =StartupService.faqData;
    	String testimonialData =	StartupService.testimonialData;
    	String blogData = StartupService.blogData;
    	String partners = wraperService.postDataResp(url, "{\r\n"+
    	" \"entityName\" :\"partners\", \r\n" +
    	"\"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}");
    	
    	//partners data
    	JsonParser springParserPartners = JsonParserFactory.getJsonParser();
        List<Object> partnersJsonList = springParserPartners.parseList(partners);
        model.addAttribute("partnersObjectList", partnersJsonList);
    					
    	
    	//pricing data
    	      JsonParser springParserPricing = JsonParserFactory.getJsonParser();
    	        List<Object> pricingJsonList = springParserPricing.parseList(pricingData);
    	        model.addAttribute("pricingObjectList", pricingJsonList);
    	 
    	      
    	      
    	    //faq data
    	      JsonParser springParserFaq = JsonParserFactory.getJsonParser();
    	        List<Object> faqJsonList = springParserFaq.parseList(faqData);
    	        model.addAttribute("faqObjectList", faqJsonList);
    	        
    	  //testimonial data
      	      JsonParser springParserTestimonial = JsonParserFactory.getJsonParser();
      	        List<Object> testimonialJsonList = springParserTestimonial.parseList(testimonialData);
      	        model.addAttribute("testimonialObjectList", testimonialJsonList);
    	       
      	   //blog data
      	      JsonParser springParserBlog = JsonParserFactory.getJsonParser();
      	        List<Object> blogJsonList = springParserBlog.parseList(blogData);
      	        model.addAttribute("blogObjectList", blogJsonList);   
    	
      	      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
          	 // boolean isAuthenticated=false;
          	  if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser") && authentication.isAuthenticated()) {
          		// isAuthenticated=authentication.isAuthenticated();
          		model.addAttribute("isAuthenticated",true); 
          		String userName = authentication.getName();
          		User user = userService.findByEmail(userName);
          		model.addAttribute("image", user.getImage());
              }
           
          	List<FilingInfo> filingInfos = fs.getAllFilingInfo();
          	Optional<FilingInfo> maxFilingInfo = fs.getFilingInfoWithMaxValue(filingInfos);

          	if (maxFilingInfo.isPresent()) {
           	    Long lastFourDigits =Long.parseLong(maxFilingInfo.get().getBoirId().substring(maxFilingInfo.get().getBoirId().length() - 4));
          	   result = boirCount + lastFourDigits+"L";

          	} else {
           	}
          	if(result!=null) {
          		model.addAttribute("boirCount",result.replace("L", "")); 
          	}else {
          		model.addAttribute("boirCount","NOTFOUND"); 
          	}
          	
          	AnonymousUserController auc=new AnonymousUserController();
          	model.addAttribute("firstTimeUser",auc.checkFirstTimeAnonymousUser(httpServletRequest , httpServletResponse));
          	
          	
        return "index";
    }
    

 
}
