package com.cta.boir.controller;


import java.util.Base64;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.HandlerMapping;

import com.cta.boir.config.EncryptionUtil;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.Response;
import com.cta.boir.model.User;
import com.cta.boir.service.GeoIPService;
import com.cta.boir.service.PaymentHistoryService;
import com.cta.boir.service.StripeService;
import com.cta.boir.service.UserService;
import com.cta.boir.service.WraperService;
import com.stripe.model.Coupon;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;


@Controller
public class PaymentController {
	
	@Value("${nybacsAdmin.api.entity.service}") private String entity;
	 @Value("${spring.mail.username}") private String sender;
	@Value("${stripe.key.public}")private String apiPublicKey;
	@Value("${Stripe.privatekey}")private String stripeprivatekey;
	@Value("${encryption.key}") private String encryptionkey;
	@Autowired
	GeoIPService geoIPService;
	@Autowired
	private UserService userService;
	@Autowired
    private PaymentHistoryService phs;
	private StripeService stripeService;
	@Autowired
	WraperService wraperService;
	@Autowired
    private JavaMailSender mailSender;

	private final  SecretKey secretKey = new SecretKeySpec(Base64.getDecoder().decode("AAECAwQFBgcICQoLDA0ODw=="), "AES");

	public PaymentController(StripeService stripeService) {
		this.stripeService = stripeService;
	}

	@GetMapping("/")
	public String homepage() {
		return "homepage";
	}

	@GetMapping("/subscription")
	public String subscriptionPage(Model model) {
		model.addAttribute("stripePublicKey", apiPublicKey);
		return "subscription";
	}
	@PostMapping("/loadcharge")
	public String  loadchargePage(@ModelAttribute PaymentHistory ph,Model model) {
		model.addAttribute("paymentAmount",ph.getNofiles());
		model.addAttribute("stripePublicKey", apiPublicKey);
		EncryptionUtil eu=new EncryptionUtil();
		String url = entity;
		String pricingData = wraperService.postDataResp(url,"{\r\n"
    			+ "    \"entityName\" : \"pricing\",\r\n"
    			+ "    \"whereClause\" : \"id in ('"+ph.getPlan_id()+"')\"\r\n"
    			+ "}");
		
		JsonParser springParserPricing = JsonParserFactory.getJsonParser();
        List<Object> pricingJsonList = springParserPricing.parseList(pricingData);
        int priceoffile=0;
        String planId=null;
        for (Object obj : pricingJsonList) {
            if (obj instanceof LinkedHashMap) {
                LinkedHashMap<String, Object> map = (LinkedHashMap<String, Object>) obj;
                
                // Assuming the map contains a key "price"
                if (map.containsKey("c_price")) {
                    Object price = map.get("c_price");
                    priceoffile=Integer.parseInt(price.toString());
                    planId=map.get("id").toString();
                } else {
                 }
            } else {
             }
        }
        //c_price
        // Generate an IV (initialization vector)
        CheckoutController c = new CheckoutController();
        IvParameterSpec iv = c.generateRandomIV();
		String encryptKey=null;
		try {
			 encryptKey=eu.encrypt(String.valueOf(Integer.parseInt(ph.getNofiles())*priceoffile)+"@"+ph.getNofiles()+"@"+planId+"@"+"TazaPay", secretKey, iv);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(encryptKey!=null) {
			encryptKey=encryptKey.replaceAll("/", "@");
		}
		return "redirect:/charge/"+encryptKey;
	}
	
	
	
	@GetMapping("/charge/{encryptKey}")
	public String chargePage(@PathVariable String encryptKey,Model model,HttpServletRequest request) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String principalName="";
    	  if (authentication != null) {
             principalName=authentication.getName() ;
        }
    	
		// boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser") && authentication.isAuthenticated()) {
	//		isAuthenticated = authentication.isAuthenticated();
    		
      		User user = userService.findByEmail( principalName);
      		model.addAttribute("image", user.getImage());
    		model.addAttribute("isAuthenticated",true); 
    		
        }
    	  
    	  // Get country code using the client IP
    	  	String ipAdd = getClientIp(request);
    	    String countryCode = geoIPService.getCountryByIP(ipAdd); // Directly get the country code
    	    model.addAttribute("countryCode", countryCode);
    	    
		    String fullPath = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
	        String bestMatchPattern = (String) request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);
	        String arguments = new AntPathMatcher().extractPathWithinPattern(bestMatchPattern, fullPath);
	         
 

	        encryptKey=encryptKey.replaceAll("@", "/");
	        
	        
		    EncryptionUtil eu=new EncryptionUtil();
            // Generate an IV (initialization vector)
	        CheckoutController c = new CheckoutController();
	        IvParameterSpec iv = c.generateRandomIV();
		    String decryptKey=null;
		    String[] parts = null;
	    	try {
			decryptKey=eu.decrypt(encryptKey, secretKey, iv); 
			parts=decryptKey.split("@");
			} catch (Exception e) {
			// TODO Auto-generated catch block
		  	e.printStackTrace();
	    	}
	    	if(parts!=null) {
	    		model.addAttribute("costperfile",Integer.parseInt(parts[0])/Integer.parseInt(parts[1]));
	    	}
    		model.addAttribute("amount",parts[0]);
		    model.addAttribute("nooffiles",parts[1]);
		    model.addAttribute("planId",parts[2]);
		     model.addAttribute("encryptKey",encryptKey);

			model.addAttribute("stripePublicKey", apiPublicKey);
			
			
		   
			String pricingIndividualData = wraperService.postDataResp(entity,"{\r\n"
	    			+ "    \"entityName\" : \"pricing\",\r\n"
	    			+ "    \"whereClause\" : \"id ='"+parts[2]+"' order by c_priority\"\r\n"
	    			+ "}");
	    	 
	    	
	    	
	    	JsonParser springParserPricingInd = JsonParserFactory.getJsonParser();
	        List<Object> pricingIndJsonList = springParserPricingInd.parseList(pricingIndividualData);
	        String pricingPlan="";
	        for (Object obj : pricingIndJsonList) {
	            if (obj instanceof Map) {
	                Map<String, Object> map = (Map<String, Object>) obj;
	                pricingPlan=map.get("c_name").toString();
 	            } 
	        }
	 
	        
	        if(pricingPlan.equals("A")) {
	        	pricingPlan="Individual";
		} else if (pricingPlan.equals("B")) {

	        	pricingPlan="Professional";
	        }
	        model.addAttribute("pricingPlan",pricingPlan);
	        model.addAttribute("stripeprivatekey",stripeprivatekey);
	        
		if (parts[3] != null && parts[3].equals("TazaPay")) {
				return "checkout";
			}
			return "charge";
	
	}

	public String getClientIp(HttpServletRequest request) {
	    String ip = null;

	    // Headers commonly used by proxies/load balancers to pass client IP
	    String[] headers = {
	        "X-Forwarded-For",        // Standard header for proxies
	        "X-Real-IP",              // Nginx proxy/Cloudflare
	        "Proxy-Client-IP",        // Apache HTTP Server proxies
	        "WL-Proxy-Client-IP",     // WebLogic proxies
	        "HTTP_X_FORWARDED_FOR",
	        "HTTP_X_FORWARDED",
	        "HTTP_X_CLUSTER_CLIENT_IP",
	        "HTTP_CLIENT_IP",
	        "HTTP_FORWARDED_FOR",
	        "HTTP_FORWARDED",
	        "HTTP_VIA",
	        "REMOTE_ADDR"             // Standard header for remote address
	    };

	    for (String header : headers) {
	        ip = request.getHeader(header);
	        if (ip != null && !ip.isEmpty() && !"unknown".equalsIgnoreCase(ip)) {
	            // Handle multiple IPs (e.g., X-Forwarded-For: client, proxy1, proxy2)
	            ip = ip.split(",")[0].trim();
	            break;
	        }
	    }

	    // Fallback to request's remote address if no IP found in headers
	    if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getRemoteAddr();
	    }

	    // Optional: Override for local testing (IPv6 localhost -> desired IP)
	    if ("0:0:0:0:0:0:0:1".equals(ip) || "127.0.0.1".equals(ip)) {
	        ip = "106.222.229.47";  // Replace with desired testing IP
	    }

	    return ip;
	}


	@PostMapping("/redirectionHandler")
	public @ResponseBody Response redirectionHandler(Model model,@RequestParam("couponCode") String couponCode,@RequestParam("encryptKey") String encryptKey) throws Exception {
        String url=wraperService.checkoutSession(couponCode,encryptKey);
        return new Response(true, url);
	}

	@PostMapping("/create-subscription")
	public @ResponseBody Response createSubscription(String email, String token, String plan, String coupon) {

		if (token == null || plan.isEmpty()) {
			return new Response(false, "Stripe payment token is missing. Please try again later.");
		}

		String customerId = stripeService.createCustomer(email, token);

		if (customerId == null) {
			return new Response(false, "An error accurred while trying to create customer");
		}

		String subscriptionId = stripeService.createSubscription(customerId, plan, coupon);

		if (subscriptionId == null) {
			return new Response(false, "An error accurred while trying to create subscription");
		}

		return new Response(true, "Success! your subscription id is " + subscriptionId);
	}

	@PostMapping("/cancel-subscription")
	public @ResponseBody Response cancelSubscription(String subscriptionId) {

		boolean subscriptionStatus = stripeService.cancelSubscription(subscriptionId);

		if (!subscriptionStatus) {
			return new Response(false, "Faild to cancel subscription. Please try again later");
		}

		return new Response(true, "Subscription cancelled successfully");
	}

	@PostMapping("/coupon-validator")
	public @ResponseBody Response couponValidator(String code) {

		Coupon coupon = stripeService.retriveCoupon(code);

		if (coupon != null && coupon.getValid()) {
			String details = (coupon.getPercentOff() == null ? "$" + (coupon.getAmountOff() / 100)
					: coupon.getPercentOff() + "%") + "OFF" + coupon.getDuration();
			return new Response(true, details);
		}
		return new Response(false, "This coupon code is not available. This may be because it has expired or has "
				+ "already been applied to your account.");
	}

	@PostMapping("/create-charge")
	public @ResponseBody Response createCharge(String email, String token,int amount,String nooffiles,String planId, Model model) throws MessagingException {
		
    
    
		if (token == null) {
			return new Response(false, "Stripe payment token is missing. please try again later.");
		}

		String chargeId = stripeService.createCharge(email, token, amount*100);// 9.99 usd

		if (chargeId == null) {
			return new Response(false, "An error accurred while trying to charge.");
		}

		// You may want to store charge id along with order information
		 
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String principalName="";
    	  if (authentication != null) {
             principalName=authentication.getName() ;
        }
    	User users =  userService.findByEmail(principalName); 
    	  
	    PaymentHistory phvo=new PaymentHistory();
	    phvo.setAmount(String.valueOf(amount));
	    //Date date=new Date().getTime();
		//phvo.setDate((java.sql.Date) new Date());
		phvo.setAmount_status("Completed");
  		phvo.setTransaction_id(chargeId);
  		phvo.setPayment_method("CARD");
  		phvo.setDescription("Success your charge id is " + chargeId);
  		phvo.setCreated_by(principalName);
  		phvo.setNofiles(nooffiles);
  		phvo.setCreated_date(new Date());
  		phvo.setPlan_id(planId);
  		phs.savePaymentHistory(phvo);
        // invoke first promotor sales by Ananth on 06/Sep/2024
  		
  		wraperService.postFPDataResp(String.valueOf(amount*100), principalName, chargeId);
  		
  		//ended
  		
  		String url = entity;
		String pricingIndividualData = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"pricing\",\r\n"
				+ "    \"whereClause\" : \"id ='" + planId + "' order by c_priority\"\r\n" + "}");

		JsonParser springParserPricingInd = JsonParserFactory.getJsonParser();
		List<Object> pricingIndJsonList = springParserPricingInd.parseList(pricingIndividualData);
		model.addAttribute("pricing", pricingIndJsonList);
		for (Object obj : pricingIndJsonList) {
			if (obj instanceof Map) {
				Map<String, Object> map = (Map<String, Object>) obj;
 				model.addAttribute("pricingname", map.get("c_name").toString());
			}
		}
		String pricingname = (String) model.asMap().get("pricingname");
 		String product;
		if (pricingname.equals("A")) {
			product = "Individual";
		} else if (pricingname.equals("B")) {
			product = "Professional";
		} else {
			product = "Unknown Product";
		}
  		
		   MimeMessage message = mailSender.createMimeMessage();
  	        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
  	        helper.setFrom(sender);
  	        helper.setTo(email);
  	        helper.setBcc("ananth@microgridtechsol.com");
  	        helper.setSubject("Payment Acknowledgement");
          //helper.setText("Request has been submitted by"+contactus.getName()+"by email"+contactus.getEmail_id()+"with comments "+contactus.getComments(), true); // Setting the second parameter to true enables HTML

  	     //helper.setText("<!DOCTYPE html><html lang='en'><head> <meta charset='UTF-8'> <meta name='viewport' content='width=device-width, initial-scale=1.0'> <title>Contact Form Submission</title> <style> body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; } .container { width: 100%; max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); } .header { text-align: center; padding-bottom: 20px; } .header img { max-width: 150px; } .content { font-size: 16px; line-height: 1.6; color: #333333; } .content h2 { color: #333333; } .content p { margin: 10px 0; } .footer { text-align: center; padding-top: 20px; font-size: 12px; color: #777777; } .footer a { color: #1a73e8; text-decoration: none; } </style></head><body> <div class='container'> <div class='header'><img src='Logo.png' alt='Company Logo'> </div> <div class='content'> <h2>Contact Form Submission</h2> <p>Dear [Recipient Name],</p> <p>You have received a new contact form submission. Here are the details:</p> <p><strong>Name:</strong> [User's Name]</p> <p><strong>Email:</strong> [User's Email]</p> <p><strong>Subject:</strong> [User's Subject]</p> <p><strong>Message:</strong> [User's Message]</p> <p>Please respond to this inquiry at your earliest convenience.</p> <p>Best regards,<br>CTAHarbor</p> </div> <div class='footer'> <p>&copy; [2024] CTAHarbor. All rights reserved.</p> <p><a href='https://www.ctaharbor.com'>Visit our website</a></p> </div> </div></body></html>");
  	       helper.setText("<!DOCTYPE html>\r\n"
  	       		+ "<html lang=\"en\">\r\n"
  	       		+ "<head>\r\n"
  	       		+ "    <meta charset=\"UTF-8\">\r\n"
  	       		+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
  	       		+ "    <title>Payment Confirmation</title>\r\n"
  	       		+ "</head>\r\n"
  	       		+ "<body style=\"font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4;\">\r\n"
  	       		+ "    <div style=\"max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);\">\r\n"
  	       		+ "        <div style=\"text-align: center; margin-bottom: 20px;\">\r\n"
  	       		+ "            <img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"Company Logo\" style=\"max-width: 150px; height: auto;\">\r\n"
  	       		+ "        </div>\r\n"
  	       		+ "        <p>Dear "+users.getName()+",</p>\r\n"
  	       		+ "        <p>We are pleased to confirm that we have received your payment of "+phvo.getAmount()+" for "+product+ " filing service. Thank you for your prompt payment.</p>\r\n"
  	       		+ "        <p><strong>Payment Details:</strong></p>\r\n"
  	       		+ "        <ul style=\"list-style-type: none; padding: 0;\">\r\n"
  	       		+ "            <li><strong>Invoice Number:</strong> "+phvo.getTransaction_id()+"</li>\r\n"
  	       		+ "            <li><strong>Payment Date:</strong> "+phvo.getCreated_date()+"</li>\r\n"
  	       		+ "            <li><strong>Amount Received:</strong> "+phvo.getAmount()+"</li>\r\n"
  	       		+ "        </ul>\r\n"
  	       		+ "        <p>Your transaction has been successfully processed, and your account has been credited accordingly.</p>\r\n"
  	       		+ "        <p>If you have any questions or require further assistance, please feel free to contact us at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or call us at <a href=\"tel:+1 (888) 203-2246\">+1 (888) 203-2246</a>.</p>\r\n"
  	       		+ "        <p>Thank you for your business!</p>\r\n"
  	       		+ "        <p>Best regards,</p>\r\n"
  	       		+ "        <p><br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a>\r\n"
  	       		+ "</p>\r\n"
  	       		+ "    </div>\r\n"
  	       		+ "</body>\r\n"
  	       		+ "</html>\r\n"
  	       		+ "",true);
  	       try {
  	        mailSender.send(message);
  	       }catch(Exception e) {}
		return new Response(true,chargeId);
	}
}