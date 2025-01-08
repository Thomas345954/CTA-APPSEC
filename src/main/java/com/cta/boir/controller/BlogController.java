package com.cta.boir.controller;

import com.cta.boir.model.Comments;
import com.cta.boir.model.Employee;
import com.cta.boir.model.User;
import com.cta.boir.service.CommentsService;
import com.cta.boir.service.EditProfileService;
import com.cta.boir.service.EmployeeService;
import com.cta.boir.service.UserService;
import com.cta.boir.service.WraperService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class BlogController {
	@Autowired
    private EmployeeService employeeService;
    @Autowired
	WraperService wraperService;
    @Autowired
    private CommentsService commentsService;
    @Autowired
   private UserService userService;
    @Value("${nybacsAdmin.api.entity.service}") private String entity;

    @GetMapping("/blog")
    public String getBlog(Model model) {
    	String url = entity;
    	String blogData = wraperService.postDataResp(url,"{\r\n"
    			+ "    \"entityName\" : \"blogs\",\r\n"
    			+ "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n"
    			+ "}");
    	
    	
    	//blog data
	      JsonParser springParserBlog = JsonParserFactory.getJsonParser();
	      List<Object> blogJsonList = springParserBlog.parseList(blogData);
	      model.addAttribute("blogObjectList", blogJsonList);   
	      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
         // boolean isAuthenticated=false;
          if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser") && authentication.isAuthenticated()) {
        	//	isAuthenticated=authentication.isAuthenticated();
        		model.addAttribute("isAuthenticated",true); 
        		String userName = authentication.getName();
          		User user = userService.findByEmail(userName);
          		model.addAttribute("image", user.getImage());
        	 }
        
    	        
	        
        return "blog";
    }
    
    @GetMapping("/blogdetails/{id}")
    public String getBlogDetail(Model model,@PathVariable String id) {
    	String url = entity;
    	String blogDetailsData = wraperService.postDataResp(url,"{\r\n"
    			+ "    \"entityName\" : \"blogs\",\r\n"
    			+ "    \"whereClause\" : \"modifiedby = 'admin' and id='"+id+"'\"\r\n"
    			+ "}");
    	          //blog data
	        JsonParser springParserBlog = JsonParserFactory.getJsonParser();
	        List<Object> blogDetailsJsonList = springParserBlog.parseList(blogDetailsData);
	        model.addAttribute("blogDetailsObjectList", blogDetailsJsonList);
	             //c_recent_news
	        Map e=null;
	        for (Object obj : blogDetailsJsonList) {
	             // Process each object
	             e=(Map) obj;
	        }
	        if(e != null) {
	        	 List<Object> blogDetailsRecentNews = springParserBlog.parseList(e.get("c_recent_news").toString());
	 	         model.addAttribute("blogDetailsRecentNews", blogDetailsRecentNews);
	        }
	            //c_keywords
	        Map k=null;
	        for (Object obj : blogDetailsJsonList) {
	             // Process each object
	             k=(Map) obj;
	        }
	        if(k != null) {
	        	List<Object> blogDetailsKeywords = springParserBlog.parseList(k.get("c_keywords").toString());
		        model.addAttribute("blogDetailsKeywords", blogDetailsKeywords);
	        }
	        //c_content_images
	        Map i=null;
	        for (Object obj : blogDetailsJsonList) {
	            // Process each object
	             i=(Map) obj;
	        }
	        if(i != null) {
	        	List<Object> blogDetailsContentImages = springParserBlog.parseList(i.get("c_content_images").toString());
	 	        model.addAttribute("blogDetailsContentImages", blogDetailsContentImages);
	        }
	        //c_comments
	        Map c=null;
	        for (Object obj : blogDetailsJsonList) {
	            // Process each object
	             c=(Map) obj;
	        } 
	        if(c != null) {	
	        	List<Object> blogDetailsComment = springParserBlog.parseList(c.get("c_comments").toString());
	        	model.addAttribute("BlogDetailsComment", blogDetailsComment);
	        }
	                        
	          Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	          // boolean isAuthenticated=false;
	          if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser") && authentication.isAuthenticated()) {
	        		// isAuthenticated=authentication.isAuthenticated();
	        		model.addAttribute("isAuthenticated",true); 
	        		String userName = authentication.getName();
	          		User user = userService.findByEmail(userName);
	          		model.addAttribute("image", user.getImage());
	        	 }
	        Comments comments = new Comments();
            model.addAttribute("comments", comments);
            return "blogdetails";
    }
   
    
    @PostMapping("/savecomments")
	public String saveComment(@ModelAttribute Comments comments, RedirectAttributes redirectAttributes) {
		commentsService.saveComments(comments);
		redirectAttributes.addFlashAttribute("successMessage",
				"Thank you for your feedback! Your comments have been successfully submitted");
		return "redirect:/blog";
	}

 
	}

    

