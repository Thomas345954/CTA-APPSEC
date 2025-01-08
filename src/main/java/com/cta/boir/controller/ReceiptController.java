package com.cta.boir.controller;

import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.PaymentRequest;
import com.cta.boir.model.User;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionListLineItemsParams;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpSession;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;

import com.cta.boir.service.FillingService;
import com.cta.boir.service.PaymentHistoryService;
import com.cta.boir.service.PaymentService;
import com.cta.boir.service.UserService;
import com.cta.boir.service.WraperService;
import com.stripe.Stripe;
import com.stripe.model.LineItem;
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
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class ReceiptController {
	@Value("${Stripe.apiKey}") private static String stripeapiKey;
	@Value("${spring.mail.username}") private String sender;
	static {
		try {
			Stripe.apiKey = stripeapiKey;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // Replace
		   }

	@Autowired
	PaymentService ps;
	@Autowired
	private PaymentHistoryService phs;
	@Autowired
	WraperService wraperService;
	@Autowired
	private UserService us;
	@Autowired
    private JavaMailSender mailSender;
	@Autowired
	FillingService fs;
	@Value("${nybacsAdmin.api.entity.service}")
	private String entity;

	@GetMapping("/receipt/{session_id}")
	public String getReceipt(@PathVariable("session_id") String sessionId, Model model,HttpSession fileCountSession) {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String principalName = "";
		if (authentication != null) {
			principalName = authentication.getName();
		}

//		boolean isAuthenticated  = false;
		User user=null;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
//			isAuthenticated = authentication.isAuthenticated();
			  user = us.findByEmail( principalName);
      		model.addAttribute("image", user.getImage());
			model.addAttribute("isAuthenticated", true);
		}

		List<PaymentRequest> pr = ps.wherePaymentHistoryByTid(sessionId);
		
		if (pr.size() > 0 && pr.get(0).getPaymentGateway() != null&& pr.get(0).getPaymentGateway().toString().contains("TazaPay")
			|| pr.size() > 0 && !pr.get(0).getPaymentGateway().isEmpty()&& pr.get(0).getPaymentGateway().toString().contains("TazaPay")) {

			try {

				String checkoutsession = wraperService.fetchSession(pr.get(0).getPaymentIntentId());

				JSONParser parser = new JSONParser();
				JSONObject jsonObj = (JSONObject) parser.parse(checkoutsession);
				JSONObject data = (JSONObject) jsonObj.get("data");
				String paymentintentid = data.get("payin").toString();

				JSONArray paymentAttempts = (JSONArray) data.get("payment_attempts");

				// Get the first payment attempt (if only one exists)
				JSONObject firstPaymentAttempt = (JSONObject) paymentAttempts.get(0);

				// Get payment_method_details
				JSONObject paymentMethodDetails = (JSONObject) firstPaymentAttempt.get("payment_method_details");

				// Extract the type field from payment_method_details
				String paymentType = paymentMethodDetails.get("type").toString();
 				// Retrieve the session details using the session ID
				String paymentIntentId = paymentintentid;
				// Extract payment details
				String paymentStatus = data.get("payment_status").toString();
				int amountTotal = (int)(Double.valueOf(data.get("amount_paid").toString()) / 100);
				String currency = data.get("invoice_currency").toString();

				// model.addAttribute("pricingname","BOIR File Pricing");
 
				model.addAttribute("Quantity", pr.get(0).getNooffiles());

				int costPerfile = (int)(Double.valueOf(pr.get(0).getAmount()) / Double.valueOf(pr.get(0).getNooffiles()));
 				model.addAttribute("costPerfile", costPerfile);

				// Add the session details to the model (if using Thymeleaf)
				model.addAttribute("sessionId", paymentIntentId);
				model.addAttribute("paymentStatus", paymentStatus);
				model.addAttribute("amountTotal", amountTotal);
				model.addAttribute("currency", currency);
				model.addAttribute("paymentMethod", paymentType);
				model.addAttribute("created_date", pr.get(0).getCreatedDate());

				// Return receipt information
				// return "Payment successful! Session ID: " + sessionId + "\n" +
				// "Amount Paid: " + amountTotal + " " + currency + "\n" +
				// "Payment Status: " + paymentStatus;

				List<PaymentHistory> paymentHistory = phs.wherePaymentHistoryByTid(sessionId);

				model.addAttribute("paymentHistory", paymentHistory);
				model.addAttribute("paymentMethod", paymentType);

				
				 String planId=null; for (PaymentHistory payment : paymentHistory) {
				 planId=payment.getPlan_id(); } String url = entity; String
				 pricingIndividualData = wraperService.postDataResp(url,"{\r\n" +
				 "    \"entityName\" : \"pricing\",\r\n" +
				  "    \"whereClause\" : \"id ='"+pr.get(0).getPlanId()+"' order by c_priority\"\r\n" + "}");
				  
				 
				 
				 JsonParser springParserPricingInd = JsonParserFactory.getJsonParser();
				 List<Object> pricingIndJsonList =springParserPricingInd.parseList(pricingIndividualData);
				 model.addAttribute("pricing", pricingIndJsonList); 
				 for (Object obj :pricingIndJsonList) { 
					 if (obj instanceof Map) { 
						 Map<String, Object> map =(Map<String, Object>) obj; 
 						 model.addAttribute("pricingname",map.get("c_name").toString()); 
						 } 
					 }
				
				if (paymentHistory.size() < 1||paymentHistory.isEmpty() ) {
					PaymentHistory phvo = new PaymentHistory();
					phvo.setAmount(String.valueOf(amountTotal));
					// Date date=new Date().getTime();
					// phvo.setDate((java.sql.Date) new Date());
					phvo.setAmount_status("Completed");
					phvo.setTransaction_id(pr.get(0).getTransactionId());
					phvo.setPayment_method("CARD");
					phvo.setDescription("Success your charge id is " + pr.get(0).getTransactionId());
					phvo.setCreated_by(principalName);
					phvo.setNofiles(model.getAttribute("Quantity").toString());
					phvo.setCreated_date(new Date());
					phvo.setPlan_id(planId);
					if(pr.get(0).getCouponCode()!=null) {
					phvo.setCoupon_code(pr.get(0).getCouponCode());
					}
					phs.savePaymentHistory(phvo);
					
					String pricingname = (String) model.asMap().get("pricingname");
 					String product = null;
					if (pricingname.equals("A")) {
						product = "Individual";
					} else if (pricingname.equals("B")) {
						product = "Professional";
					} 
					
					 MimeMessage message = mailSender.createMimeMessage();
				        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
				        helper.setFrom(sender);
				        helper.setTo(principalName);
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
				       		+ "        <p>Dear "+user.getName()+",</p>\r\n"
				       		+ "        <p>We are pleased to confirm that we have received your payment of $"+phvo.getAmount()+" for "+product+ " filing service. Thank you for your prompt payment.</p>\r\n"
				       		+ "        <p><strong>Payment Details:</strong></p>\r\n"
				       		+ "        <ul style=\"list-style-type: none; padding: 0;\">\r\n"
				       		+ "            <li><strong>Invoice Number:</strong> "+phvo.getTransaction_id()+"</li>\r\n"
				       		+ "            <li><strong>Payment Date:</strong> "+phvo.getCreated_date()+"</li>\r\n"
				       		+ "            <li><strong>Amount Received:</strong> $"+phvo.getAmount()+"</li>\r\n"
				       		+ "        </ul>\r\n"
				       		+ "        <p>Your transaction has been successfully processed, and your account has been credited accordingly.</p>\r\n"
				       		+ "        <p>If you have any questions or require further assistance, please feel free to contact us at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or call us at <a href=\"tel:+1 (888) 203-2246\">+1 (888) 203-2246</a>.</p>\r\n"
				       		+ "        <p>Thank you for your business!</p>\r\n"
				       		+ "        <p>Best Regards,</p>\r\n"
				       		+ "        <p>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n"
				       		+ "    </div>\r\n"
				       		+ "</body>\r\n"
				       		+ "</html>\r\n"
				       		+ "",true);
				       try {
				        mailSender.send(message);
				       }catch(Exception e) {}
					
					
					
				}
			}catch (InterruptedException e) {
			    Thread.currentThread().interrupt();
			} catch (Exception e) {
				e.printStackTrace();
				// return "Error retrieving payment details: " + e.getMessage();
			}
			
		} else {
			try {
				// Retrieve the session details using the session ID
				Session session = Session.retrieve(sessionId);
				String paymentIntentId = session.getPaymentIntent();
				// Extract payment details
				String paymentStatus = session.getPaymentStatus();
				String amountTotal = String.valueOf(session.getAmountTotal() / 100);
				String currency = session.getCurrency();
//				Long createDate = session.getCreated();

				SessionListLineItemsParams params = SessionListLineItemsParams.builder().build();
				List<LineItem> lineItems = session.listLineItems(params).getData();

				// Loop through line items and get the quantity
				for (LineItem item : lineItems) {
					model.addAttribute("pricingname", item.getDescription()); 
					model.addAttribute("Quantity", item.getQuantity());
					//   int costPerfile = (int) numberDouble; 
					int costPerfile = (int)(Double.valueOf(pr.get(0).getAmount()) / Double.valueOf(pr.get(0).getNooffiles()));
 					model.addAttribute("costPerfile", costPerfile);

				}

				// Add the session details to the model (if using Thymeleaf)
				model.addAttribute("sessionId", paymentIntentId);
				model.addAttribute("paymentStatus", paymentStatus);
				model.addAttribute("amountTotal", amountTotal);
				model.addAttribute("currency", currency);
				model.addAttribute("paymentMode", session.getMode());
				model.addAttribute("created_date", pr.get(0).getCreatedDate());

				// Return receipt information
				// return "Payment successful! Session ID: " + sessionId + "\n" +
				// "Amount Paid: " + amountTotal + " " + currency + "\n" +
				// "Payment Status: " + paymentStatus;
				List<PaymentHistory> paymentHistory = phs.wherePaymentHistoryByTid(sessionId);

				model.addAttribute("paymentHistory", paymentHistory);
				model.addAttribute("paymentMethod", session.getMode());
 				// +paymentHistory.get(0).getPayment_method());

				String planId = null;
				for (PaymentHistory payment : paymentHistory) {
					planId = payment.getPlan_id();
				}
				/*
				 * String planId1 =pr.get(0).getPlanId();  
				 */
				String url = entity;
				String pricingIndividualData = wraperService.postDataResp(url,
						"{\r\n" + "    \"entityName\" : \"pricing\",\r\n" + "    \"whereClause\" : \"id ='" +pr.get(0).getPlanId()+ "' order by c_priority\"\r\n" + "}");

				JsonParser springParserPricingInd = JsonParserFactory.getJsonParser();
				List<Object> pricingIndJsonList = springParserPricingInd.parseList(pricingIndividualData);
				model.addAttribute("pricing", pricingIndJsonList);
				for (Object obj : pricingIndJsonList) {
					if (obj instanceof Map) {
						Map<String, Object> map = (Map<String, Object>) obj;
 						model.addAttribute("pricingname", map.get("c_name").toString());
					}
				}
				if (paymentHistory.size() < 1 ||paymentHistory.isEmpty() ) {
					PaymentHistory phvo = new PaymentHistory();
					phvo.setAmount(String.valueOf(amountTotal));
					// Date date=new Date().getTime();
					// phvo.setDate((java.sql.Date) new Date());
					phvo.setAmount_status("Completed");
					phvo.setTransaction_id(session.getId());
					phvo.setPayment_method("CARD");
					phvo.setDescription("Success your charge id is " + paymentIntentId);
					phvo.setCreated_by(principalName);
					phvo.setNofiles(model.getAttribute("Quantity").toString());
					phvo.setCreated_date(new Date());
					phvo.setPlan_id(planId);
					if(pr.get(0).getCouponCode()!=null) {
						phvo.setCoupon_code(pr.get(0).getCouponCode());
					}
					phs.savePaymentHistory(phvo);
					
					
					String pricingname = (String) model.asMap().get("pricingname");
 					String product = null;
					if (pricingname.equals("A")) {
						product = "Individual";
					} else if (pricingname.equals("B")) {
						product = "Professional";
					} 
					
					
					
					MimeMessage message = mailSender.createMimeMessage();
			        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			        helper.setFrom(sender);
			        helper.setTo(principalName);
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
			       		+ "        <p>Dear "+user.getName()+",</p>\r\n"
			       		+ "        <p>We are pleased to confirm that we have received your payment of $"+phvo.getAmount()+" for "+product+ " filing service. Thank you for your prompt payment.</p>\r\n"
			       		+ "        <p><strong>Payment Details:</strong></p>\r\n"
			       		+ "        <ul style=\"list-style-type: none; padding: 0;\">\r\n"
			       		+ "            <li><strong>Invoice Number:</strong> "+phvo.getTransaction_id()+"</li>\r\n"
			       		+ "            <li><strong>Payment Date:</strong> "+phvo.getCreated_date()+"</li>\r\n"
			       		+ "            <li><strong>Amount Received:</strong> $"+phvo.getAmount()+"</li>\r\n"
			       		+ "        </ul>\r\n"
			       		+ "        <p>Your transaction has been successfully processed, and your account has been credited accordingly.</p>\r\n"
			       		+ "        <p>If you have any questions or require further assistance, please feel free to contact us at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or call us at <a href=\"tel:+1 (888) 203-2246\">+1 (888) 203-2246</a>.</p>\r\n"
			       		+ "        <p>Thank you for your business!</p>\r\n"
			       		+ "        <p>Best Regards,</p>\r\n"
			       		+ "        <p>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n"
			       		+ "    </div>\r\n"
			       		+ "</body>\r\n"
			       		+ "</html>\r\n"
			       		+ "",true);
			       try {
			        mailSender.send(message);
			       }catch(Exception e) {}
				
				}
			} catch (Exception e) {
				e.printStackTrace();
				// return "Error retrieving payment details: " + e.getMessage();
			}

		}

		User uservo = us.findByEmail(principalName);
		List<PaymentHistory> phvo = phs.wherePaymentHistoryByUser(String.valueOf(principalName));
		int totalboirFiles = 0;
		// Iterate over the list and sum the amountPaid values
		for (PaymentHistory ph : phvo) {
			if (ph.getNofiles() != null)
				totalboirFiles += Double.parseDouble(ph.getNofiles());
		}
		List<FilingInfo> fillingvo = fs.checkFilingAvalability(String.valueOf(uservo.getId()));

		fileCountSession.setAttribute("totalFiles", totalboirFiles);
		fileCountSession.setAttribute("filesFilled", fillingvo.size());
		fileCountSession.setAttribute("Pending", totalboirFiles - fillingvo.size());
		if (totalboirFiles - fillingvo.size() > 0) {
			model.addAttribute("canfile", "true");
		} else {
			model.addAttribute("canfile", "false");
		}

		return "receipt";
	}

}
