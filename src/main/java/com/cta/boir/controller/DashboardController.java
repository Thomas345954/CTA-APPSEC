package com.cta.boir.controller;

import java.net.URI;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.User;
import com.cta.boir.service.FillingService;
import com.cta.boir.service.PaymentHistoryService;
import com.cta.boir.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;

@Controller
public class DashboardController {

	@Autowired
	private PaymentHistoryService phs;
	@Autowired
	private UserService us;
	@Autowired
	private FillingService fs;
	@Autowired
	RestTemplate restTemplate;

	@GetMapping("/dashboard")
	public String getFilingInformation(Model model, Principal principal, HttpSession session) {
		Authentication authentication = null;
		if (principal instanceof Authentication) {
			authentication = (Authentication) principal;
		} else {
			authentication = SecurityContextHolder.getContext().getAuthentication();
		}

		String principalName = "";
		if (authentication != null) {
			principalName = authentication.getName();
		}

		if (principal instanceof OAuth2AuthenticationToken) {
			OAuth2AuthenticationToken token = (OAuth2AuthenticationToken) principal;
			OAuth2User oauth2User = token.getPrincipal();
			principalName = (String) oauth2User.getAttributes().get("email");
		}

		User uservo = us.findByEmail(principalName);
		List<PaymentHistory> phvo = phs.wherePaymentHistoryByUser(String.valueOf(uservo.getEmail()));
		int totalboirFiles = 0;
		for (PaymentHistory ph : phvo) {
			if (ph.getNofiles() != null)
				totalboirFiles += Double.parseDouble(ph.getNofiles());
		}
		List<FilingInfo> fillingvo = fs.checkFilingAvalability(String.valueOf(uservo.getId()));
		model.addAttribute("totalFiles", totalboirFiles);
		model.addAttribute("filesFilled", fillingvo.size());
		model.addAttribute("Pending", totalboirFiles - fillingvo.size());
		session.setAttribute("totalFiles", totalboirFiles);
		session.setAttribute("filesFilled", fillingvo.size());
		session.setAttribute("Pending", totalboirFiles - fillingvo.size());
		model.addAttribute("hasFiles", totalboirFiles);
		if (totalboirFiles - fillingvo.size() > 0) {
			model.addAttribute("canFile", "true");
		}

		// Set the global variables
		/*
		 * GlobalVariables.totalFiles = totalboirFiles; GlobalVariables.filesFilled =
		 * fillingvo.size(); GlobalVariables.pendingFiles = totalboirFiles -
		 * fillingvo.size();
		 */

		// model.addAttribute("canFile","false");
		//boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser") && authentication.isAuthenticated()) {
			//isAuthenticated = authentication.isAuthenticated();
			model.addAttribute("isAuthenticated", true);
		}
		if (uservo.getImage() != null) {
			model.addAttribute("image", uservo.getImage());
		}
		model.addAttribute("dashboard", true);
		// getting the referal link

		String showPromoterURL = "https://firstpromoter.com/api/v1/promoters/show";
		String createPromoterURL = "https://firstpromoter.com/api/v1/promoters/create";
		HttpHeaders headers = new HttpHeaders();
		headers.set("X-API-KEY", "b043befe20e672a3c298de0f84191a1a");

		URI uri = UriComponentsBuilder.fromHttpUrl(showPromoterURL).queryParam("promoter_email", principalName).build().toUri();

		try {
		    HttpEntity<String> entity = new HttpEntity<>(headers);
		    ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		    
		    if (response.getStatusCode() == HttpStatus.OK) {
		        // Process the response
		        try {
		            ObjectMapper objectMapper = new ObjectMapper();
		            JsonNode root = objectMapper.readTree(response.getBody());
		            JsonNode promotions = root.path("promotions");
		            
		            // Ensure the promotions array is not empty
		            if (promotions.isArray() && promotions.size() > 0) {
		                // Get the first promotion object
		                JsonNode firstPromotion = promotions.get(0);

		                // Extract the referral_link
		                String referralLink = firstPromotion.path("referral_link").asText();

		                // Log and set the referralLink to model and session
		                model.addAttribute("referralLink", referralLink);
		                session.setAttribute("referralLink", referralLink);
		            } else {
		            }
		        } catch (Exception e) {
		        	e.printStackTrace();
		        	}
		    } else {
		    }
		} catch (HttpClientErrorException e) {
		    if (e.getStatusCode() == HttpStatus.NOT_FOUND) {
		        // Handle 404 exception
		        try {
		            // Call the create promoter API
		            URI createUri = UriComponentsBuilder.fromHttpUrl(createPromoterURL).queryParam("email", principalName).build().toUri();
		            HttpEntity<String> createEntity = new HttpEntity<>(headers);
		            ResponseEntity<String> createResponse = restTemplate.exchange(createUri, HttpMethod.POST, createEntity, String.class);
		            
		            if (createResponse.getStatusCode() == HttpStatus.OK) {
		            	HttpEntity<String> entity = new HttpEntity<>(headers);
		    		    ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		                // Retry fetching the promoter details after creation
		                response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
		                if (response.getStatusCode() == HttpStatus.OK) {
		                    ObjectMapper objectMapper = new ObjectMapper();
		                    JsonNode root = objectMapper.readTree(response.getBody());
		                    JsonNode promotions = root.path("promotions");
		                    
		                    if (promotions.isArray() && promotions.size() > 0) {
		                        JsonNode firstPromotion = promotions.get(0);

		                        String referralLink = firstPromotion.path("referral_link").asText();

		                        model.addAttribute("referralLink", referralLink);
		                        session.setAttribute("referralLink", referralLink);
		                    } else {
		                    }
		                } else {
		                }
		            } else {
		            }
		        } catch (Exception ex) {
		        	e.printStackTrace();
		        }
		    } else {
		    	e.printStackTrace();
		        model.addAttribute("referralLink", "https://ctaharbor.firstpromoter.com/");
                session.setAttribute("referralLink", "https://ctaharbor.firstpromoter.com/");
		    }
		} catch (Exception e) {
			e.printStackTrace();
	        model.addAttribute("referralLink", "https://ctaharbor.firstpromoter.com/");
            session.setAttribute("referralLink", "https://ctaharbor.firstpromoter.com/");
		}


		return "profile-user-dashboard";
	}

}
