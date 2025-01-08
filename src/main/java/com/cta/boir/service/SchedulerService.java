package com.cta.boir.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.cta.boir.config.EncryptionUtil;
import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.BeneficialOwner;
import com.cta.boir.model.PaymentRequest;
import com.cta.boir.model.User;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;
import net.minidev.json.parser.ParseException;


@Service
public class SchedulerService {

	@Autowired
	RestTemplate restTemplate;
	@Value("${nybacs.payment.gateway.context}") private String context;
	@Value("${nybacs.payment.gateway.tazapay.authorization}") private String tazapayauthorization;
	@Value("${nybacs.payment.gateway.tazapay.context}") private String tajapaycontext;
	@Value("${nybacs.payment.gateway.receiptcontext}") private String receiptcontext;
	@Value("${nybacs.payment.gateway.chargecontext}") private String chargecontext;
	 @Value("${spring.mail.username}") private String sender;

    @Autowired
    private HttpServletRequest httprequest; 
    @Autowired
    private JavaMailSender mailSender;
    @Autowired
    private  UserService us;
	@Autowired
	GeoIPService geoIPService; 
	@Autowired
    private  FillingService fillingService;
	@Autowired
	EncryptDecrypt encDec;
	@Autowired
    private CustomEntityService entityService;
	@Autowired
	PaymentService ps;
	@Value("${benificialDomain}")
	private String benificialDomain;
	@Autowired
	
	private UserService userService;

//	    private static SecretKey secretKey = new SecretKeySpec(KEY_BYTES, "AES");


	public URI buildURI(String s) {
		URI uri = null;
		try {
			uri = new URI(s.replace(" ", "%20"));
		} catch (URISyntaxException e) {

		}
		return uri;
	}

	public HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();
		//String authString = encDec.decrypt("apiuser") + ":" + encDec.decrypt("password");
		//String encoding = Base64.getEncoder().encodeToString((authString).getBytes());
		//headers.add("Authorization", "Basic " + encoding);
		headers.setContentType(MediaType.APPLICATION_JSON);
		return headers;
	}

	public String postDataResp(String url,String body) {
		HttpEntity<Object> entity = new HttpEntity<>(body, getHeaders());
		return (restTemplate.exchange(buildURI(url), HttpMethod.POST, entity, String.class).getBody());
	}

	public String getData(String url) {
		HttpEntity<Object> entity = new HttpEntity<>(getHeaders());
		return restTemplate.exchange(buildURI(url), HttpMethod.GET, entity, String.class).getBody(); //String we can replace with pojo to handle response 
	}
	
	
	public String sendPendingReminders() throws MessagingException {

        List<Map<String, Object>> filingdata=entityService.getDynamicQueryResults("SELECT a.*, b.reporting_company_legal_name as companyname \r\n"
        		+ "FROM public.filing_info a\r\n"
        		+ "LEFT JOIN public.reporting_company b \r\n"
        		+ "ON a.filing_info_id = b.filing_info_id \r\n"
        		+ "WHERE a.status not in ('submission_validation_failed','submission_accepted','submission_rejected')  order by a.date_prepared desc", null);
        List<FilingInfo> filingInfo=fillingService.convertToFilingInfo(filingdata);
        
        for(int i=0;i<filingInfo.size();i++) {
//        	String userid=filingInfo.get(i).getUserId();
       
         	 String url=context+"boirfiling?filingInfoId="+filingInfo.get(i).getFilingInfoId(); // URL which will used to navigate current inprogress form
        	 
         	//User uservo=us.findById(Long.parseLong(filingInfo.get(i).getUserId()));
        	 String email=filingInfo.get(i).getCreatedBy();
        	 User user=us.findByEmail(email);
        	
    		 if (!"true".equals(user.getUnsubscribe()))  {
    			
    		 String encodedEmail;
    		 String unsubscribeUrl="";
				try {
					encodedEmail = URLEncoder.encode(email, StandardCharsets.UTF_8.toString());
					unsubscribeUrl = context + "unsubscribe?email=" + encodedEmail;
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
             MimeMessage message = mailSender.createMimeMessage();
     	        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
     	        helper.setFrom(sender);
     	        helper.setTo(email);
    	        helper.setBcc("ananth@microgridtechsol.com");
     	        helper.setSubject("Action Required: Complete Your In-Progress Report for "+filingInfo.get(i).getUserId());
           //helper.setText("Request has been submitted by"+contactus.getName()+"by email"+contactus.getEmail_id()+"with comments "+contactus.getComments(), true); // Setting the second parameter to true enables HTML

     	     //helper.setText("<!DOCTYPE html><html lang='en'><head> <meta charset='UTF-8'> <meta name='viewport' content='width=device-width, initial-scale=1.0'> <title>Contact Form Submission</title> <style> body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; } .container { width: 100%; max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); } .header { text-align: center; padding-bottom: 20px; } .header img { max-width: 150px; } .content { font-size: 16px; line-height: 1.6; color: #333333; } .content h2 { color: #333333; } .content p { margin: 10px 0; } .footer { text-align: center; padding-top: 20px; font-size: 12px; color: #777777; } .footer a { color: #1a73e8; text-decoration: none; } </style></head><body> <div class='container'> <div class='header'><img src='Logo.png' alt='Company Logo'> </div> <div class='content'> <h2>Contact Form Submission</h2> <p>Dear [Recipient Name],</p> <p>You have received a new contact form submission. Here are the details:</p> <p><strong>Name:</strong> [User's Name]</p> <p><strong>Email:</strong> [User's Email]</p> <p><strong>Subject:</strong> [User's Subject]</p> <p><strong>Message:</strong> [User's Message]</p> <p>Please respond to this inquiry at your earliest convenience.</p> <p>Best regards,<br>CTAHarbor</p> </div> <div class='footer'> <p>&copy; [2024] CTAHarbor. All rights reserved.</p> <p><a href='https://www.ctaharbor.com'>Visit our website</a></p> </div> </div></body></html>");
     	       helper.setText("<!DOCTYPE html>\r\n"
     		+ "<html lang=\"en\">\r\n"
     		+ "<head>\r\n"
     		+ "  <meta charset=\"UTF-8\">\r\n"
     		+ "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
     		+ "  <title>CTAHarbor - Incomplete Report Reminder</title>\r\n"
     		+ "  <style>\r\n"
     		+ "    body {\r\n"
     		+ "      font-family: Arial, sans-serif;\r\n"
     		+ "      margin: 0;\r\n"
     		+ "      padding: 20px;\r\n"
     		+ "    }\r\n"
     		+ "    h2 {\r\n"
     		+ "      font-size: 20px;\r\n"
     		+ "      margin-bottom: 10px;\r\n"
     		+ "    }\r\n"
     		+ "    p {\r\n"
     		+ "      line-height: 1.5;\r\n"
     		+ "    }\r\n"
     		+ "    a {\r\n"
     		+ "      text-decoration: none;\r\n"
     		+ "    }\r\n"
     		+ "    .header img {\r\n"
     		+ "     max-width: 150px;\r\n"
     		+ "    }\r\n"
     		+ "    .btn-four {\r\n"
     		+ "     padding: 10px 20px;\r\n"
     		+ "     border-radius: 20px;\r\n"
     		+ "     background: #003B6A;\r\n"
     		+ "     color: #fff;\r\n"
     		+ "    }\r\n"
     		+ "    .btn-four:hover {\r\n"
     		+ "     background: #B31942;\r\n"
     		+ "     color: #fff;\r\n"
     		+ "    }\r\n"
     		+ "    .unsub {\r\n"
     		+ "     color: #008EFF;\r\n"
     		+ "     font-weight: 500px;\r\n"
     		+ "     font-size: 14px;\r\n"
     		+ "    }\r\n"
     		+ "    .unsub:hover {\r\n"
     		+ "     text-decoration: underline;\r\n"
     		+ "    }\r\n"	
     		+ "  </style>\r\n"
     		+ "</head>\r\n"
     		+ "<body>\r\n"
     		+ " <div class=\"header\">\r\n"
     		+ " <center><img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"CTA Harbor Logo\" /></center>\r\n"
     		+ " </div>\r\n"
     		+ "  <h2 style=\"color:#003B6A;\">Hi "+user.getName()+",</h2>\r\n"
     		+ "  <p style=\"color:#003B6A;\">You have an incomplete "+filingInfo.get(i).getFilingType()+" report for "+filingInfo.get(i).getUserId()+".</p>\r\n"
     		+ "  <p style=\"color:#003B6A;\">Please log in and complete the remaining sections to submit the report.</p>\r\n"
     		+ "  <p style=\"color:#003B6A;\"><b>Click here to continue:</p></b>\r\n"
     		+ "  <p><a style=\"color:#fff;\"class=\"btn-four\"href="+url+">Continue Reporting</a></p><br>\r\n"
     	//	+ "  <p><a href=\"#\">[[Continue Reporting]]</a></p>\r\n"
     		+ "  <p style=\"color:#003B6A;\">If you have any questions or require further assistance, please feel free to contact us at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or call us at <a href=\"tel:+1 (888) 203-2246\">+1 (888) 203-2246</a>.</p>\r\n"
     		+ "  <p style=\"color:#003B6A;\">Best regards,</p>\r\n"
     		+ "  <p style=\"color:#003B6A;\"><br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a>\r\n"
     		+ "  <p><a href=\"mailto:support@ctaharbor.com\">support@ctaharbor.com</a></p>\r\n"
     		+ "  <p style=\"color:#003B6A;\">\r\n"
     		+ "	  <a class=\"unsub\" href="+unsubscribeUrl+">Unsubscribe</a>\r\n"
     		+ "   <br> You can opt out of reminder emails, and your in-progress reports will remain accessible on your dashboard.\r\n"
     		+ "  </p>\r\n"
     		+ "</body>\r\n"
     		+ "</html>",true);
             
 
     		try {
      	        mailSender.send(message);
      	       }catch(Exception e) {}
        	 }
        }
       		return ""; 
	}
	
	public String sendBeneficialPendingReminders() throws MessagingException {

        List<Map<String, Object>> beneficialdata=entityService.getDynamicQueryResults("SELECT bo.*, rc.reporting_company_legal_name AS companyname\r\n"
        		+ "FROM public.beneficial_owner bo\r\n"
        		+ "JOIN public.reporting_company rc\r\n"
        		+ "ON bo.filing_info_id = rc.filing_info_id\r\n"
        		+ "WHERE bo.beneficial_status = 'pending'\r\n"
        		+ "ORDER BY bo.created_date DESC;\r\n"
        		+ "", null);
        List<BeneficialOwner> beneficialOwner=fillingService.convertToBeneficialInfo(beneficialdata);
        
        for(int i=0;i<beneficialOwner.size();i++) {
//        	String beneficialCompanyName=beneficialOwner.get(i).getSuffix();
       
         	 String trackId = beneficialOwner.get(i).getBeneficialTrackId(); // Get tracking id from db
        	 String url= benificialDomain+"?trackingid="+trackId; // URL which will used to navigate beneficialOwner form
//        	 String email=beneficialOwner.get(i).getCreatedBy();
//        	 User user=us.findByEmail(email);
    		 String benEmail = beneficialOwner.get(i).getBenficialEmail();
    		// if (!"true".equals(user.getUnsubscribe()))  {
    			
			/*
			 * String encodedEmail; String unsubscribeUrl=""; try { encodedEmail =
			 * URLEncoder.encode(benEmail, StandardCharsets.UTF_8.toString());
			 * unsubscribeUrl = context + "unsubscribe?email=" + encodedEmail; } catch
			 * (UnsupportedEncodingException e) { // TODO Auto-generated catch block
			 * e.printStackTrace(); }
			 */
    		 
    		 	MimeMessage message = mailSender.createMimeMessage();
	 	        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
	 	        helper.setFrom(sender);
	 	        helper.setTo(benEmail);
		        helper.setBcc("ananth@microgridtechsol.com");
	 	        helper.setSubject("Action Required: Complete Your Beneficial Ownership Form for "+beneficialOwner.get(i).getSuffix());
	 	        //helper.setText("Request has been submitted by"+contactus.getName()+"by email"+contactus.getEmail_id()+"with comments "+contactus.getComments(), true); // Setting the second parameter to true enables HTML

	 	       //helper.setText("<!DOCTYPE html><html lang='en'><head> <meta charset='UTF-8'> <meta name='viewport' content='width=device-width, initial-scale=1.0'> <title>Contact Form Submission</title> <style> body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; } .container { width: 100%; max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); } .header { text-align: center; padding-bottom: 20px; } .header img { max-width: 150px; } .content { font-size: 16px; line-height: 1.6; color: #333333; } .content h2 { color: #333333; } .content p { margin: 10px 0; } .footer { text-align: center; padding-top: 20px; font-size: 12px; color: #777777; } .footer a { color: #1a73e8; text-decoration: none; } </style></head><body> <div class='container'> <div class='header'><img src='Logo.png' alt='Company Logo'> </div> <div class='content'> <h2>Contact Form Submission</h2> <p>Dear [Recipient Name],</p> <p>You have received a new contact form submission. Here are the details:</p> <p><strong>Name:</strong> [User's Name]</p> <p><strong>Email:</strong> [User's Email]</p> <p><strong>Subject:</strong> [User's Subject]</p> <p><strong>Message:</strong> [User's Message]</p> <p>Please respond to this inquiry at your earliest convenience.</p> <p>Best regards,<br>CTAHarbor</p> </div> <div class='footer'> <p>&copy; [2024] CTAHarbor. All rights reserved.</p> <p><a href='https://www.ctaharbor.com'>Visit our website</a></p> </div> </div></body></html>");
     	       helper.setText("<!DOCTYPE html>\r\n"
			     		+ "<html lang=\"en\">\r\n"
			     		+ "<head>\r\n"
			     		+ "  <meta charset=\"UTF-8\">\r\n"
			     		+ "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
			     		+ "  <title>CTAHarbor - Start Your Beneficial Ownership Form</title>\r\n"
			     		+ "  <style>\r\n"
			     		+ "    body {\r\n"
			     		+ "      font-family: Arial, sans-serif;\r\n"
			     		+ "      margin: 0;\r\n"
			     		+ "      padding: 20px;\r\n"
			     		+ "    }\r\n"
			     		+ "    h2 {\r\n"
			     		+ "      font-size: 20px;\r\n"
			     		+ "      margin-bottom: 10px;\r\n"
			     		+ "    }\r\n"
			     		+ "    p {\r\n"
			     		+ "      line-height: 1.5;\r\n"
			     		+ "    }\r\n"
			     		+ "    a {\r\n"
			     		+ "      text-decoration: none;\r\n"
			     		+ "     color: #fff;\r\n"
			     		+ "    }\r\n"
			     		+ "    .header img {\r\n"
			     		+ "     max-width: 150px;\r\n"
			     		+ "    }\r\n"
			     		+ "    .btn-four {\r\n"
			     		+ "     padding: 10px 20px;\r\n"
			     		+ "     border-radius: 20px;\r\n"
			     		+ "     background: #003B6A;\r\n"
			     		+ "     color: #fff;\r\n"
			     		+ "    }\r\n"
			     		+ "    .btn-four:hover {\r\n"
			     		+ "     background: #B31942;\r\n"
			     		+ "     color: #fff;\r\n"
			     		+ "    }\r\n"
			     		+ "    .unsub {\r\n"
			     		+ "     color: #008EFF;\r\n"
			     		+ "     font-weight: 500px;\r\n"
			     		+ "     font-size: 14px;\r\n"
			     		+ "    }\r\n"
			     		+ "    .unsub:hover {\r\n"
			     		+ "     text-decoration: underline;\r\n"
			     		+ "    }\r\n"	
			     		+ "  </style>\r\n"
			     		+ "	</head>\r\n"
			     		+ "	<body>\r\n"
			     		+ " <div class=\"header\">\r\n"
			     		+ " <center><img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"CTA Harbor Logo\" /></center>\r\n"
			     		+ " </div>\r\n"
			     		+ "  <h2 style=\"color:#003B6A;\">Hi "+benEmail+",</h2>\r\n"
			     		+ "  <p style=\"color:#003B6A;\"> This is a friendly reminder to complete the Beneficial Ownership Information for "+beneficialOwner.get(i).getSuffix()+". Your submission is important to finalize the report.</p>\r\n"
						+ "  <p style=\"color:#003B6A;\"><strong>Please click the link below to complete your form:</strong></p>\r\n"
						+ "	 <a style=\"border-width:0px; background-color:#003B6A; color:#FFFFFF !important; border-radius:20px; padding:10px;\" href=\""+ url+"\" style=\"color:#FFFFFF;text-decoration:none;\">Complete Your Information</a>"
						+ "  <p style=\"color:#003B6A;\">Thank you for your prompt attention.</p>\r\n"
			     		+ "  <p>Best regards,</p>\r\n"
			     		+ "  <p><br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a>\r\n"
			     		+ "  <p><a href=\"mailto:support@ctaharbor.com\">support@ctaharbor.com</a></p>\r\n"
			     		//+ "  <p>\r\n"
			     		//+ "   <a class=\"unsub\"href="+unsubscribeUrl+">Unsubscribe</a><br> You can opt out of reminder emails, and your in-progress reports will remain accessible on your dashboard.\r\n"
			     		//+ "  </p>\r\n"
			     		+ "</body>\r\n"
			     		+ "</html>",true);
				try {
					mailSender.send(message);
				} catch (Exception e) {
				}
         	 //}
        }
       		return ""; 
	}

	
	

}
