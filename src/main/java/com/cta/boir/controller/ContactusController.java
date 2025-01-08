package com.cta.boir.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.cta.boir.model.ContactUs;
import com.cta.boir.model.User;
import com.cta.boir.service.ContactUsService;
import com.cta.boir.service.EmployeeService;
import com.cta.boir.service.UserService;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpSession;

@Controller
public class ContactusController {
	@Autowired
	private JavaMailSender javaMailSender;

	@Value("${spring.mail.username}")
	private String sender;
	@Value("${gCapthca.sitekey}")
	private String siteKey;

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private ContactUsService contactUsService;

	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private UserService userService;

	@GetMapping("/contactus")
	public String getContactUs(Model model, Principal principal) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
			isAuthenticated = authentication.isAuthenticated();
			String userName = authentication.getName();
			User user = userService.findByEmail(userName);
			model.addAttribute("image", user.getImage());

		}
		model.addAttribute("isAuthenticated", isAuthenticated);
		model.addAttribute("sitekey", siteKey);

		ContactUs contactus = new ContactUs();
		model.addAttribute("contactus", contactus);
		return "contactus";
	}

	@Autowired
	RestTemplate restTemplate;

	public synchronized boolean isCaptchaValid(String secretKey, String response) {
		try {
			String url = "https://www.google.com/recaptcha/api/siteverify";
			String params = "secret=" + secretKey + "&response=" + response;

			HttpURLConnection http = (HttpURLConnection) new URL(url).openConnection();
			http.setDoOutput(true);
			http.setRequestMethod("POST");
			http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
			OutputStream out = http.getOutputStream();
			out.write(params.getBytes(StandardCharsets.UTF_8));
			out.flush();
			out.close();

			InputStream res = http.getInputStream();
			BufferedReader rd = new BufferedReader(new InputStreamReader(res, StandardCharsets.UTF_8));

			StringBuilder sb = new StringBuilder();
			int cp;
			while ((cp = rd.read()) != -1) {
				sb.append((char) cp);
			}
			// JSONObject json = new JSONObject(sb.toString());
			res.close();
			return true;
			// return json.getBoolean("success");
		} catch (Exception e) {
			// e.printStackTrace();
		}
		return false;
	}

	@PostMapping("/savecontact")
	public String saveContact(@ModelAttribute ContactUs contactus, Model model,
			@RequestParam("g-recaptcha-response") String recaptchaResponse, HttpSession session) {

		try {

//    		 Boolean flag=  isCaptchaValid("6LcP1h8qAAAAAE5PchzU1JMgQ-mhjXUzYta6bM8u",recaptchaResponse);
			boolean flag = true;
			if (flag) {
				contactUsService.saveContactUs(contactus);
				// Creating a simple mail message
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
				helper.setFrom(sender);
				helper.setTo(sender);
				helper.setBcc(contactus.getEmail_id());
				helper.setSubject("Contact Form Submission");
				helper.setText("<!DOCTYPE html>\r\n" + "<html lang='en'>\r\n" + "<head>\r\n"
						+ "    <meta charset='UTF-8'>\r\n"
						+ "    <meta name='viewport' content='width=device-width, initial-scale=1.0'>\r\n"
						+ "    <title>Contact Form Submission</title>\r\n" + "    <style>\r\n" + "        body {\r\n"
						+ "            font-family: Arial, sans-serif;\r\n" + "            margin: 0;\r\n"
						+ "            padding: 0;\r\n" + "            background-color: #f4f4f4;\r\n" + "        }\r\n"
						+ "        .container {\r\n" + "            width: 100%;\r\n"
						+ "            max-width: 600px;\r\n" + "            margin: 0 auto;\r\n"
						+ "            background-color: #ffffff;\r\n" + "            padding: 20px;\r\n"
						+ "            border-radius: 10px;\r\n"
						+ "            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);\r\n" + "        }\r\n"
						+ "        .header {\r\n" + "            text-align: center;\r\n"
						+ "            padding-bottom: 20px;\r\n" + "        }\r\n" + "        .header img {\r\n"
						+ "            max-width: 150px;\r\n" + "        }\r\n" + "        .content {\r\n"
						+ "            font-size: 16px;\r\n" + "            line-height: 1.6;\r\n"
						+ "            color: #333333;\r\n" + "        }\r\n" + "        .content h2 {\r\n"
						+ "            color: #333333;\r\n" + "        }\r\n" + "        .content p {\r\n"
						+ "            margin: 10px 0;\r\n" + "        }\r\n" + "        .footer {\r\n"
						+ "            text-align: center;\r\n" + "            padding-top: 20px;\r\n"
						+ "            font-size: 12px;\r\n" + "            color: #777777;\r\n" + "        }\r\n"
						+ "        .footer a {\r\n" + "            color: #1a73e8;\r\n"
						+ "            text-decoration: none;\r\n" + "        }\r\n" + "    </style>\r\n"
						+ "</head>\r\n" + "<body>\r\n" + "    <div class='container'>\r\n"
						+ "        <div class='header'>\r\n" + "            "
						+ "			<img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"Company Logo\">\r\n"
						+ "" + "        </div>\r\n" + "        <div class='content'>\r\n"
						+ "            <h2>Contact Form Submission</h2>\r\n" + "            <p>Dear "
						+ contactus.getName() + ",</p>\r\n"
						+ "            <p>Thank you for reaching out to us through our contact form. We have received your message and will review your inquiry promptly. Here are the details you submitted:</p>\r\n"
						+ "            <p><strong>Name:</strong> " + contactus.getName() + "</p>\r\n"
						+ "            <p><strong>Email:</strong> " + contactus.getEmail_id() + "</p>\r\n"
						+ "            <p><strong>Subject:</strong> Contact Form Submission</p>\r\n"
						+ "            <p><strong>Message:</strong> " + contactus.getComments() + "</p>\r\n"
						+ "            <p>If you have any questions or require further assistance, please feel free to contact us at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or call us at <a href=\"tel:+1 (888) 203-2246\">+1 (888) 203-2246</a>.</p>\r\n"
						+ "            <p>Thank you for your business!</p>\r\n" + "            <p>Best regards,</p>\r\n"
						+ " 		   <p>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a>\r\n"
						+ "				</p>\r\n" + "        <div class='footer'>\r\n"
						+ "            <p>&copy; [2024] CTAHarbor. All rights reserved.</p>\r\n"
						+ "            <p><a href='https://www.ctaharbor.com'>Visit our website</a></p>\r\n"
						+ "        </div>\r\n" + "</body>\r\n" + "</html>\r\n" + "", true);
				//String url = "https://www.google.com/recaptcha/api/siteverify";
				//String params = "?secret=6LcP1h8qAAAAAE5PchzU1JMgQ-mhjXUzYta6bM8u&response=" + recaptchaResponse;
//		        RecaptchaResponse recaptchaRes =restTemplate.exchange(url+params,HttpMethod.POST,null,RecaptchaResponse.class).getBody();
				if (true) {
					try {
						mailSender.send(message);
					} catch (Exception e) {
					}
//		        	model.addAttribute("message", "Your Contact Information has been submitted successfully");
					session.setAttribute("contactusMessage",
							"We’ve received your request and will get back to you shortly. Keep an eye on your inbox!");
				}
				return "redirect:/contactus";
			}
			return "redirect:/contactus";

		} catch (Exception e) {
//	        	   model.addAttribute("message", "Please resubmit the request");
			session.setAttribute("contactusMessage", "Please resubmit the request");
			return "redirect:/contactus";
		}

	}

}
