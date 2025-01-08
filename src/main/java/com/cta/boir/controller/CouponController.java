package com.cta.boir.controller;
  
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import java.util.UUID;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.cta.boir.model.GeneratedCoupon;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.User;
import com.cta.boir.repository.GeneratedCouponRepository;
import com.cta.boir.service.GeneratedCouponService;
import com.cta.boir.service.PaymentHistoryService;
import com.cta.boir.service.UserService;
import com.cta.boir.service.WraperService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

@RestController
public class CouponController {
	@Autowired
	WraperService wraperService;
	@Autowired
	GeneratedCouponService  generatedCoupon;
	@Autowired
	GeneratedCouponRepository generatedCouponRepository;
	@Autowired
	PaymentHistoryService phs;
	@Value("${nybacsAdmin.api.entity.service}") private String entity;
	 @Value("${spring.mail.username}") private String sender;
	@Autowired
    private JavaMailSender mailSender;
	@Autowired
	private UserService userService;
    private static final Random random = new Random();
    
    @GetMapping("/gencoupons")
    public List<Object> getCoupon(Model model) {
    	JsonParser springParserPricing = JsonParserFactory.getJsonParser();
    String couponData= wraperService.postDataResp(entity, "{\r\n" + "    \"entityName\" : \"couponcode\",\r\n"
				+ "    \"whereClause\" : \"c_is_utilized='No' order by datecreated desc limit 1\"\r\n" + "}");
    	List<Object> couponJsonList = springParserPricing.parseList(couponData);
    	Gson gson = new Gson();
        JsonArray jsonArray = gson.fromJson(couponData, JsonArray.class);
       
     //   JsonObject object = jsonArray.getAsJsonObject();
     
        int cNoofTimes = 0 ;
        String cStartDate = null;
        int cMinLimit =0 ;
        String cEndDate = null;
        String cCouponType = null;
        int cDiscountPercentage = 0 ;
        int cMaxLimit = 0 ;
        String cCouponCode = null;
        String cCouponDescription = null;
        String cIsUtilized = null;
        
        for (JsonElement element : jsonArray) {
              JsonObject object = element.getAsJsonObject();
              cNoofTimes = Integer.parseInt(object.get("c_nooftimes").getAsString()) ;
              cStartDate = object.get("c_start_date").getAsString();
              cMinLimit = Integer.parseInt(object.get("c_min_limit").getAsString()) ;
              cEndDate = object.get("c_end_date").getAsString();
              cCouponType = object.get("c_coupon_type").getAsString();
              cDiscountPercentage = Integer.parseInt(object.get("c_discount_percentage").getAsString()) ;
              cMaxLimit = Integer.parseInt(object.get("c_max_limit").getAsString()) ;
              cCouponCode = object.get("c_coupon_code").getAsString();
              cCouponDescription = object.get("c_coupon_description").getAsString();
              cIsUtilized = object.get("c_is_utilized").getAsString();
//              break;
        }

    	  List<GeneratedCoupon> generatedcoupons = generateCouponCode(cNoofTimes,cMinLimit,cCouponType,cMaxLimit,cCouponCode,cStartDate,cEndDate,cDiscountPercentage);
    	 
    	  for (GeneratedCoupon coupon : generatedcoupons) {
    		  generatedCoupon.saveGeneratedCoupon(coupon);
    	  }
    	
	    return couponJsonList;
    }

    public  List<GeneratedCoupon> generateCouponCode(int cNoofTimes,  int cMinLimit,String cCouponType,  int cMaxLimit, String cCouponCode,String cStartDate,String cEndDate,int cDiscountPercentage) {
        // Validate input parameters
        if (cNoofTimes <= 0 || cMinLimit < 0 || cMaxLimit < 0  || cCouponCode == null  ) {
            throw new IllegalArgumentException("Invalid input parameters.");
        }
        List<GeneratedCoupon> coupons = new ArrayList<>();
        // Generate coupon codes
        Set<String> generatedCodes = new HashSet<>();
        List<String[]> data = new ArrayList<>();
       
        for (int i = 0; i < cMaxLimit; i++) {
            String couponCode = generateUniqueCouponCode(generatedCodes, cCouponCode, cMinLimit, cMaxLimit);
             data.add(new String[] {couponCode});
            GeneratedCoupon gc=new GeneratedCoupon();
            gc.setCouponCode(couponCode);
            gc.setNumberOfTimes((String.valueOf(cNoofTimes)));
            gc.setCouponType(cCouponType);
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

            try {
                Date fromDate =   formatter.parse(cStartDate);
                Date toDate =   formatter.parse(cEndDate);
                gc.setFromDate( fromDate);
                gc.setToDate(toDate);
                gc.setPercentage(String.valueOf(cDiscountPercentage));
             } catch (ParseException e) {
                e.printStackTrace();
            }
            coupons.add(gc);
            
            
                        
            
            if(cCouponType!=null && cCouponType.equals("Unique")) {
            	break;
            }
        }

        

        //Send email 
        
        try {
            FileWriter writer = new FileWriter("your_csv_file.csv");
            CSVPrinter printer = CSVFormat.DEFAULT.withHeader("COUPONCODE").print(writer);

            

            printer.printRecords(data);

            printer.close();
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        try {
        	

              // Replace with the actual path to your CSV file
              String csvFilePath = "your_csv_file.csv";
              File csvFile = new File(csvFilePath);
        	
		   MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
	        helper.setFrom(sender);
	        helper.setTo("surya.m@microgridtechsol.com");
	        helper.setBcc("ananth@microgridtechsol.com");
	        helper.setSubject("Coupons");
	        helper.addAttachment(cCouponCode, csvFile);
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
	       		+ "        <p>Dear Admin,</p>\r\n"
	       		+ "        <p>We are pleased to share the coupons. </p>\r\n"
	       		+ "        <p><strong>Coupon Details:</strong></p>\r\n"
	       		+ "        <p>Download the CSV file for coupons</p>\r\n"
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
        }catch(MessagingException be) {}
        //End Email part 

        
        
        // Return generated coupon codes
        return coupons;
    }

    private static String generateUniqueCouponCode(Set<String> generatedCodes, String c_coupon_code, int c_min_limit, int c_max_limit) {

    	String couponCode;
        do {
            int randomLength = random.nextInt(6);
            char[] chars = new char[randomLength];
            for (int i = 0; i < randomLength; i++) {
                chars[i] = (char) (random.nextInt(26) + 'A');
            }
            couponCode = c_coupon_code + new String(chars);
        } while (generatedCodes.contains(couponCode));
        return couponCode;
    }
    
    
    @GetMapping("/validateCoupon")
    public ResponseEntity<String> validateCoupon(Model model,@RequestParam String couponCode) {
    	String couponcode = couponCode.toUpperCase();//"MICJC";
    	List<GeneratedCoupon> gc= generatedCoupon.getGeneratedCouponBycode(couponcode);
    	String response =null;
    	if(gc.isEmpty()) {
  		  response = "{\"message\": \"Coupon is not valid\",\"messagecode\":\"201\"}";
  		return ResponseEntity.ok(response);
  	}
    	
    	if(gc.get(0).getCouponType()!=null && gc.get(0).getCouponType().equals("Random")) {
    		List<PaymentHistory>  ph=  	phs.findbycoupon_code(couponcode);
    		response = "{\"message\": \"Coupon valid\", \"percentage\": " + gc.get(0).getPercentage() + ",\"messagecode\":\"200\"}";
        	
    		if(!ph.isEmpty()) {
        		response = "{\"message\": \"Coupon already used\", \"messagecode\":\"404\"}";
        	}
    		 	
    	}else {
   		 response = "{\"message\": \"Coupon valid\", \"percentage\": " + gc.get(0).getPercentage() + ",\"messagecode\":\"200\"}";
        if(Integer.parseInt(gc.get(0).getNumberOfTimes())>0) {	
       		//here need to check how many times the same coupon can be used
        	List<PaymentHistory>  ph=  	phs.findbycoupon_code(couponcode);
        	if(ph.size()==Integer.parseInt(gc.get(0).getNumberOfTimes())) {
        		response = "{\"message\": \"Coupon cannot be user more than configured limit\",\"messagecode\":\"405\"}";
        	}
       	}
   	    }
 
    	return ResponseEntity.ok(response);
	    
    }

    @PostMapping("/enableCoupon")
	public ResponseEntity<String> enableCoupon(@RequestParam("email") String email) throws MessagingException {
    	JsonParser springParserPricing = JsonParserFactory.getJsonParser();
    	String enableCouponData = wraperService.postDataResp(entity,
				"{ " + "\"entityName\": \"credit\", " + "\"orderBy\": \"datecreated desc\", " + "\"limit\": 1" + "}");
		
		if(enableCouponData == null || enableCouponData.isEmpty() || enableCouponData.equals("[]")) {
			return ResponseEntity.ok().body("Error: Empty coupon data.");
		}
		//List<Object> couponJsonList = springParserPricing.parseList(enableCouponData);
		Gson gson = new Gson();
		JsonArray jsonArray = gson.fromJson(enableCouponData, JsonArray.class);

		String emailToCredit = "";

		for (JsonElement element : jsonArray) {
			JsonObject object = element.getAsJsonObject();
			emailToCredit = object.get("c_email").getAsString();
		}

		String requestId = UUID.randomUUID().toString();

		User user = userService.findByEmail(emailToCredit);
		
		if (user != null) {
			
			PaymentHistory phvo = new PaymentHistory();
			phvo.setAmount(String.valueOf(0));
			// Date date=new Date().getTime(); //phvo.setDate((java.sql.Date) new Date());
			phvo.setAmount_status("Completed");
			phvo.setTransaction_id(requestId);
			phvo.setPayment_method("CARD");
			phvo.setDescription("Success your charge id is " + requestId);
			phvo.setCreated_by(emailToCredit);
			phvo.setNofiles("1");
			phvo.setCreated_date(new Date());
			phvo.setPlan_id("f8c42e56-3a41-4782-955c-53055f70d037");
			phs.savePaymentHistory(phvo);
			
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(sender);
			helper.setTo(emailToCredit);
			helper.setBcc("ananth@microgridtechsol.com");
			helper.setSubject("Unlock 0% BOIR Filing Fee—Exclusive Offer for You!");
			helper.setText("<!DOCTYPE html>\r\n" + "<html lang=\"en\">\r\n" + "<head>\r\n"
					+ "    <meta charset=\"UTF-8\">\r\n"
					+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
					+ "    <title>Email Template</title>\r\n" + "</head>\r\n"
					+ "<body style=\"font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4;\">\r\n"
					+ "\r\n" + "    <!-- Email container -->\r\n"
					+ "    <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"margin: 0; padding: 20px;\">\r\n"
					+ "        <tr>\r\n" + "            <td align=\"center\">\r\n"
					+ "                <!-- Inner email container -->\r\n"
					+ "                <table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color: #ffffff; padding: 20px; border-radius: 8px;\">\r\n"
					+ "                    \r\n" + "                    <!-- Logo section -->\r\n"
					+ "                    <tr>\r\n"
					+ "                        <td align=\"center\" style=\"padding-bottom: 20px;\">\r\n"
					+ "                            <img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"Your Company Logo\" width=\"150\">\r\n"
					+ "                        </td>\r\n" + "                    </tr>\r\n" + "\r\n"
					+ "                    <!-- Content section -->\r\n" + "                    <tr>\r\n"
					+ "                        <td style=\"padding: 20px; color: #333333; line-height: 1.6;\">\r\n"
					+ "                            <h2 style=\"color: #333333;\">Unlock 0% BOIR Filing Fee—Exclusive Offer for You!</h2>\r\n"
					+ "                            \r\n"
					+ "                            <p>Dear "+user.getName()+",</p>\r\n"
					+ "                            <p>We’re excited to offer you an <strong>exclusive coupon</strong> to file your BOIR with <strong>0% filing fees</strong>—our way of simplifying business for you.</p>\r\n"
					+ "\r\n"
					+ "                            <p>All you need to do is <strong>log in with your email</strong> and file your BOIR today. It’s <strong>quick, hassle-free</strong>, and comes at <strong>zero cost</strong>!</p>\r\n"
					+ "\r\n"
					+ "                            <p>If you have any questions or need assistance, our dedicated support team is here to help. Feel free to contact us anytime at <a href=\"mailto:service@ctaharbor.com\" style=\"color: #1a73e8; text-decoration: none;\">service@ctaharbor.com</a> or give us a call at <strong>+1 (888) 203-2246</strong>.</p>\r\n"
					+ "\r\n"
					+ "                            <p>Thank you for choosing CTAHarbor for your business needs! We look forward to continuing to serve you.</p>\r\n"
					+ "\r\n" + "                            <p>Warm regards,<br>\r\n"
					+ "                            <strong>The BOIR Filing Team</strong><br>\r\n"
					+ "                            CTAHarbor<br>\r\n"
					+ "                            A division of New York Business Advisory & Corporate Services Inc.<br>\r\n"
					+ "                            <a href=\"http://www.ctaharbor.com\" style=\"color: #1a73e8; text-decoration: none;\">www.ctaharbor.com</a></p>\r\n"
					+ "                        </td>\r\n" + "                    </tr>\r\n" + "\r\n"
					+ "                </table>\r\n" + "            </td>\r\n" + "        </tr>\r\n"
					+ "    </table>\r\n" + "\r\n" + "</body>\r\n" + "</html>\r\n" + "\r\n" + "", true);

			try {
				mailSender.send(message);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return ResponseEntity.ok().body("Email sent to user");
		} else {
			return ResponseEntity.ok().body("User not found.");
		}
	}
    @GetMapping("/getReferrels")
    public List<PaymentHistory> getReferrels(Model model) {
    	
    	 return phs.getAllCouponcodePaymentHistory();
    }
    
    
}
