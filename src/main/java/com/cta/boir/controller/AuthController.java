package com.cta.boir.controller;

import java.security.Principal;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;
import java.util.UUID;
import java.time.ZoneId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cta.boir.dto.UserDto;
import com.cta.boir.model.BeneficialOwner;
import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.OtpData;
import com.cta.boir.model.User;
import com.cta.boir.repository.BeneficialOwnerRepository;
import com.cta.boir.service.CustomEntityService;
import com.cta.boir.service.FillingService;
import com.cta.boir.service.OtpDataService;
import com.cta.boir.service.UserService;
import com.cta.boir.service.WraperService;
import com.cta.boir.util.GlobalVariables;

import jakarta.annotation.PostConstruct;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import jakarta.websocket.server.PathParam;
import net.minidev.json.JSONObject;
import net.minidev.json.JSONValue;

@Controller
public class AuthController {

	private UserService userService;
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	WraperService wraperService;
	@Autowired
	private FillingService fs;
	@Autowired
	private HttpServletRequest httpServletRequest;
	@Autowired
	private HttpServletResponse httpServletResponse;
	@Autowired
	private OtpDataService otpDataService;
	@Autowired
	private BeneficialOwnerRepository beneficialOwnerRepository;
	
	@Autowired
	private CustomEntityService entityService;
	@Value("${nybacsAdmin.api.entity.service}")
	private String entity;
	@Value("${spring.mail.username}")
	private String sender;


	public AuthController(UserService userService, PasswordEncoder passwordEncoder) {
		this.userService = userService;
		this.passwordEncoder = passwordEncoder;
	}

	@GetMapping("index")
	public String home() {
		return "index";
	}
	
	private static final SecureRandom secureRandom = new SecureRandom();
	
	// Method to generate a 6-digit OTP
    public static int generateOtp() {
        return secureRandom.nextInt(900000) + 100000; // Generates a random OTP between 100000 and 999999
    }
		
	@GetMapping("/login")
	public String loginForm(Model model) {

		String url = entity;
		Long boirCount = 3000000L;
		String result = null;
		String pricingData = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"pricing\",\r\n"
				+ "    \"whereClause\" : \"c_price in ('119','149') order by c_priority\"\r\n" + "}");
		String faqData = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"faq\",\r\n"
				+ "    \"whereClause\" : \"c_feature_type = 'A. General Questions' order by datecreated\"\r\n" + "}");
		String testimonialData = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"testimonials\",\r\n"
				+ "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}");
		String blogData = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"blogs\",\r\n"
				+ "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}");

		String partners = wraperService.postDataResp(url, "{\r\n"+
		    	" \"entityName\" :\"partners\", \r\n" +
		    	"\"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}");
		    	
    	//partners data
    	JsonParser springParserPartners = JsonParserFactory.getJsonParser();
        List<Object> partnersJsonList = springParserPartners.parseList(partners);
        model.addAttribute("partnersObjectList", partnersJsonList);
        
		// pricing data
		JsonParser springParserPricing = JsonParserFactory.getJsonParser();
		List<Object> pricingJsonList = springParserPricing.parseList(pricingData);
		model.addAttribute("pricingObjectList", pricingJsonList);

		// faq data
		JsonParser springParserFaq = JsonParserFactory.getJsonParser();
		List<Object> faqJsonList = springParserFaq.parseList(faqData);
		model.addAttribute("faqObjectList", faqJsonList);

		// testimonial data
		JsonParser springParserTestimonial = JsonParserFactory.getJsonParser();
		List<Object> testimonialJsonList = springParserTestimonial.parseList(testimonialData);
		model.addAttribute("testimonialObjectList", testimonialJsonList);

		// blog data
		JsonParser springParserBlog = JsonParserFactory.getJsonParser();
		List<Object> blogJsonList = springParserBlog.parseList(blogData);
		model.addAttribute("blogObjectList", blogJsonList);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		//boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser") && authentication.isAuthenticated()) {
			//isAuthenticated = authentication.isAuthenticated();
			model.addAttribute("isAuthenticated", true);
		}

		List<FilingInfo> filingInfos = fs.getAllFilingInfo();
		Optional<FilingInfo> maxFilingInfo = fs.getFilingInfoWithMaxValue(filingInfos);

		if (maxFilingInfo.isPresent()) {
			Long lastFourDigits = Long
					.parseLong(maxFilingInfo.get().getBoirId().substring(maxFilingInfo.get().getBoirId().length() - 4));
			result = boirCount + lastFourDigits + "L";

		} else {
		}
		if (result != null) {
			model.addAttribute("boirCount", result.replace("L", ""));
		}
		

		AnonymousUserController auc = new AnonymousUserController();
		model.addAttribute("firstTimeUser", auc.checkFirstTimeAnonymousUser(httpServletRequest, httpServletResponse));

		model.addAttribute("loadlogin", "true");
		return "index";
	}

	@PostConstruct
	public void loadGlobalData() {
		try {
			String url = entity; // Add your API URL here

			// Load certifiedBy/poweredBy data
			String certifiedBy = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"certifiedby\",\r\n"
					+ "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}");
			JsonParser springParserCertifiedBy = JsonParserFactory.getJsonParser();
			List<Object> certifiedByJsonList = springParserCertifiedBy.parseList(certifiedBy);
			GlobalVariables.certProvideByImageURL = certifiedByJsonList;

			// Load announcement data
			String announcement = wraperService.postDataResp(url, "{\r\n" + "    \"entityName\" : \"announcement\",\r\n"
					+ "    \"whereClause\" : \"modifiedby = 'admin'\"\r\n" + "}");
			JsonParser springParserAnnouncement = JsonParserFactory.getJsonParser();
			List<Object> announcementJsonList = springParserAnnouncement.parseList(announcement);

			// Create a list to store announcement data
			List<String> announcementLists = new ArrayList<>();

			for (Object anno : announcementJsonList) {
				// Cast to Map to access properties
				Map<String, Object> annouce = (Map<String, Object>) anno;
				String announce = (String) annouce.get("c_announcement");
				String navigationUrl = (String) annouce.get("c_navigation_url");
				String hyperLinkText = (String) annouce.get("c_hyperlink_text");
				announcementLists.add(announce);
				announcementLists.add(navigationUrl);
				announcementLists.add(hyperLinkText);
			}

			// Store in global variables
			GlobalVariables.announcement = announcementLists;

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// handler method to handle user registration request
	@GetMapping("register")
	public String showRegistrationForm(Model model) {
		UserDto user = new UserDto();
		model.addAttribute("user", user);
		return "register";
	}

	// handler method to handle register user form submit request
	@PostMapping("/register/save")
	public String registration(@Valid @ModelAttribute("user") UserDto user, BindingResult result, Model model,
			HttpSession session) throws MessagingException {
		User existing = userService.findByEmail(user.getEmail());
		if (existing != null) {
			result.rejectValue("email", null, "There is already an account registered with that Email");
			session.setAttribute("registerMessage", "There is already an account registered with this Email");
		}
		if (result.hasErrors()) {
			model.addAttribute("user", user);
			// return "register";
			return "redirect:/home";
		}
		userService.saveUser(user);
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setFrom(sender);
		helper.setTo(user.getEmail());
		helper.setBcc("ananth@microgridtechsol.com");
		helper.setSubject("Registration Acknowledgment");
//	        helper.setText("Request has been submitted by"+contactus.getName()+"by email"+contactus.getEmail_id()+"with comments "+contactus.getComments(), true); // Setting the second parameter to true enables HTML

		// helper.setText("<!DOCTYPE html><html lang='en'><head> <meta charset='UTF-8'>
		// <meta name='viewport' content='width=device-width, initial-scale=1.0'>
		// <title>Contact Form Submission</title> <style> body { font-family: Arial,
		// sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; } .container {
		// width: 100%; max-width: 600px; margin: 0 auto; background-color: #ffffff;
		// padding: 20px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0,
		// 0.1); } .header { text-align: center; padding-bottom: 20px; } .header img {
		// max-width: 150px; } .content { font-size: 16px; line-height: 1.6; color:
		// #333333; } .content h2 { color: #333333; } .content p { margin: 10px 0; }
		// .footer { text-align: center; padding-top: 20px; font-size: 12px; color:
		// #777777; } .footer a { color: #1a73e8; text-decoration: none; }
		// </style></head><body> <div class='container'> <div class='header'><img
		// src='Logo.png' alt='Company Logo'> </div> <div class='content'> <h2>Contact
		// Form Submission</h2> <p>Dear [Recipient Name],</p> <p>You have received a new
		// contact form submission. Here are the details:</p> <p><strong>Name:</strong>
		// [User's Name]</p> <p><strong>Email:</strong> [User's Email]</p>
		// <p><strong>Subject:</strong> [User's Subject]</p>
		// <p><strong>Message:</strong> [User's Message]</p> <p>Please respond to this
		// inquiry at your earliest convenience.</p> <p>Best regards,<br>CTAHarbor</p>
		// </div> <div class='footer'> <p>&copy; [2024] CTAHarbor. All rights
		// reserved.</p> <p><a href='https://www.ctaharbor.com'>Visit our
		// website</a></p> </div> </div></body></html>");
		helper.setText("<!DOCTYPE html>\r\n" + "<html lang=\"en\">\r\n" + "<head>\r\n"
				+ "    <meta charset=\"UTF-8\">\r\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
				+ "    <title>Registration Acknowledgment</title>\r\n" + "    <style>\r\n" + "        body {\r\n"
				+ "            font-family: Arial, sans-serif;\r\n" + "            background-color: #f4f4f4;\r\n"
				+ "            margin: 0;\r\n" + "            padding: 20px;\r\n" + "        }\r\n"
				+ "        .email-container {\r\n" + "            background-color: #ffffff;\r\n"
				+ "            padding: 20px;\r\n" + "            border-radius: 8px;\r\n"
				+ "            max-width: 600px;\r\n" + "            margin: 0 auto;\r\n"
				+ "            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\r\n" + "        }\r\n"
				+ "        .email-header {\r\n" + "            text-align: center;\r\n"
				+ "            margin-bottom: 20px;\r\n" + "        }\r\n" + "        .email-header img {\r\n"
				+ "            max-width: 150px;\r\n" + "        }\r\n" + "        .email-body {\r\n"
				+ "            color: #333333;\r\n" + "            line-height: 1.6;\r\n" + "        }\r\n"
				+ "        .email-footer {\r\n" + "            margin-top: 20px;\r\n"
				+ "            text-align: center;\r\n" + "            font-size: 12px;\r\n"
				+ "            color: #777777;\r\n" + "        }\r\n" + "        .email-footer a {\r\n"
				+ "            color: #777777;\r\n" + "            text-decoration: none;\r\n" + "        }\r\n"
				+ "    </style>\r\n" + "</head>\r\n" + "<body>\r\n" + "    <div class=\"email-container\">\r\n"
				+ "        <div class=\"email-header\">\r\n"
				+ "			<img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"Company Logo\">\r\n"
				+ "       </div>\r\n" + "        <div class=\"email-body\">\r\n" + "            <p>Dear "
				+ user.getFirstName() + ",</p>\r\n"
				+ "            <p>Thank you for registering with <strong>CTAHarbor</strong>! We are excited to have you on board.</p>\r\n"
				+ "            <p>This email is to confirm that we have successfully received your registration. You can now enjoy the full range of features and services we offer. Here are your registration details:</p>\r\n"
				+ "            <ul style=\"padding-left: 20px;\">\r\n" + "                <li><strong>Name:</strong> "
				+ user.getFirstName() + "</li>\r\n" + "                <li><strong>Username:</strong> "
				+ user.getLastName() + "</li>\r\n" + "                <li><strong>Email:</strong> " + user.getEmail()
				+ "</li>\r\n" + "            </ul>\r\n" + "            <p><strong>Next Steps:</strong></p>\r\n"
				+ "            <ol style=\"padding-left: 20px;\">\r\n"
				+ "                <li><strong>Log in:</strong> Visit <a href=\"[www.ctaharbor.com]\">[www.ctaharbor.com]</a> and log in using your credentials.</li>\r\n"
				+ "                <li><strong>Explore:</strong> Start exploring our services and tools designed to enhance your experience.</li>\r\n"
				+ "                <li><strong>Support:</strong> If you need assistance, don't hesitate to reach out to our support team at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or call us at <a href=\"tel:+1 (888) 203-2246\">+1 (888) 203-2246</a>.</li>\r\n"
				+ "            </ol>\r\n"
				+ "            <p>We're thrilled to have you with us and look forward to supporting your journey.</p>\r\n"
				+ "            <p>Best regards,<br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br>\r\n"
				+ "<a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n" + "        </div>\r\n"
				+ "        <div class=\"email-footer\">\r\n"
				+ "            <p>This email was sent to [User's Email Address]. If you received this email in error or wish to unsubscribe from future emails, please <a href=\"[Unsubscribe Link]\">click here</a>.</p>\r\n"
				+ "            <p><em>Please do not reply to this email as it is sent from an unmonitored account.</em></p>\r\n"
				+ "        </div>\r\n" + "    </div>\r\n" + "</body>\r\n" + "</html>\r\n" + "", true);
		try {
			mailSender.send(message);
		} catch (Exception e) {
		}
		session.setAttribute("registerMessage",
				"Your registration was successful. You’re all set—go ahead and log in to get started!");
		return "redirect:/home";
	}

	@GetMapping("/users")
	public String listRegisteredUsers(Model model) {
		List<UserDto> users = userService.findAllUsers();
		model.addAttribute("users", users);
		return "users";
	}

	@GetMapping("/forgotpassword")
	public String forgotpassword(Model model) {
		return "forgotpassword";
	}

	@GetMapping("/forgotpwd")
	public String forgotpwd(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
			isAuthenticated = authentication.isAuthenticated();
			String userName = authentication.getName();
			User user = userService.findByEmail(userName);
			model.addAttribute("image", user.getImage());
		}
		model.addAttribute("isAuthenticated", isAuthenticated);
		OtpData od = new OtpData();
		model.addAttribute("OtpData", od);

		return "forgot-password";// "forgot-password"; // TO KEEP THE OLD ONE WHICH LOKESH ENABLED IS
									// forgotpassword
	}

	@PostMapping("/sendOTP")
	public String sendOTP(@Valid @ModelAttribute("OtpData") OtpData otpData, BindingResult result, Principal principal,
			Model model, HttpSession session) throws MessagingException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
			isAuthenticated = authentication.isAuthenticated();
			String userName = authentication.getName();
			User user = userService.findByEmail(userName);
			model.addAttribute("image", user.getImage());
		}
		model.addAttribute("isAuthenticated", isAuthenticated);
		boolean validEmail = false;
		User users = null;
		String userEmail = null;
		if (otpData != null && otpData.getEmail() != null && otpData.getEmail().length() > 0) {
			users = userService.findByEmail(otpData.getEmail());
			userEmail = otpData.getEmail();
		} else {
			users = userService.findByEmail((String) session.getAttribute("email"));//
			userEmail = (String) session.getAttribute("email");

		}
		if (users != null) {
			validEmail = true;
		}
		if (validEmail) {
			model.addAttribute("userEmail", userEmail);
			// Generate OTP
			int otp = generateOtp(); // Generate a 6-digit OTP
			users.setOtp(String.valueOf(otp)); // Save OTP to the database
			users.setotpCreatedTime(new Date());// Save OTP date to database
			userService.save(users);
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(sender);
			helper.setTo(userEmail);
			helper.setBcc("ananth@microgridtechsol.com");
			helper.setSubject("Forgot Password OTP");
			helper.setText("<!DOCTYPE html>\r\n" + "<html lang=\"en\">\r\n" + "<head>\r\n" + "    <me"
					+ "ta charset=\"UTF-8\">\r\n"
					+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
					+ "    <title>Forgot Password OTP</title>\r\n" + "    <style>\r\n" + "        body {\r\n"
					+ "            font-family: Arial, sans-serif;\r\n" + "            background-color: #f9f9f9;\r\n"
					+ "            margin: 0;\r\n" + "            padding: 0;\r\n" + "        }\r\n"
					+ "        .email-container {\r\n" + "            background-color: #ffffff;\r\n"
					+ "            max-width: 600px;\r\n" + "            margin: 0 auto;\r\n"
					+ "            padding: 20px;\r\n" + "            border-radius: 10px;\r\n"
					+ "            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\r\n" + "        }\r\n"
					+ "        .email-header {\r\n" + "            text-align: center;\r\n"
					+ "            margin-bottom: 20px;\r\n" + "        }\r\n" + "        .email-header img {\r\n"
					+ "            width: 150px;\r\n" + "            height: auto;\r\n" + "        }\r\n"
					+ "        .email-body {\r\n" + "            color: #333333;\r\n"
					+ "            font-size: 16px;\r\n" + "        }\r\n" + "        .otp {\r\n"
					+ "            font-size: 20px;\r\n" + "            font-weight: bold;\r\n"
					+ "            color: #333333;\r\n" + "            text-align: center;\r\n"
					+ "            margin: 20px 0;\r\n" + "        }\r\n" + "    </style>\r\n" + "</head>\r\n"
					+ "<body>\r\n"
					+ "    <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"email-container\">\r\n"
					+ "        <tr>\r\n" + "            <td class=\"email-header\">\r\n"
					+ "                <img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"Company Logo\">\r\n"
					+ "            </td>\r\n" + "        </tr>\r\n" + "        <tr>\r\n"
					+ "            <td class=\"email-body\">\r\n" + "                <p>Dear " + userEmail + ",</p>\r\n"
					+ "                <p>We received a request to reset your password for your " + users.getName()
					+ " account. To proceed with resetting your password, please use the One-Time Password (OTP) provided below:</p>\r\n"
					+ "                <p class=\"otp\">Your OTP: " + otp + "</p>\r\n"
					+ "                <p>This OTP is valid for the next 90 seconds. Please do not share this OTP with anyone for your account's security.</p>\r\n"
					+ "                <p>If you did not request a password reset, please ignore this email. Your account will remain secure.</p>\r\n"
					+ "                <p>If you have any issues or concerns, feel free to contact our support team at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or +1 (888) 203-2246.<br></p>\r\n"
					+ "                <p>Best Regards,<br>BOIR Filing Team<br>\r\n"
					+ "CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)\r\n"
					+ "                <a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n"
					+ "            </td>\r\n" + "        </tr>\r\n" + "    </table>\r\n" + "</body>\r\n" + "</html>\r\n"
					+ "", true);
			try {
				mailSender.send(message);
			} catch (Exception e) {
			}
			session.setAttribute("otp", otp);
			session.setAttribute("email", userEmail);
			return "validateOTP";
		} else {
			model.addAttribute("message", "User email doesn't exist. Please register");
			return "forgot-password";
		}
	}

	 
	@GetMapping("/customBoirOTP/{trackId}")
	@ResponseBody
	public Map<String, Object> getOTP(@PathVariable("trackId") String trackId) throws MessagingException {
	 Optional<BeneficialOwner> beneficialOwnerO = beneficialOwnerRepository.findByBeneficialTrackId(trackId);
	 Map<String, Object> respMap = new HashMap();
	 if(beneficialOwnerO.isPresent()) {
		 BeneficialOwner beneficialOwner =  beneficialOwnerO.get();
		 if (beneficialOwner.getBeneficialStatus().equalsIgnoreCase("pending")) {
			
			int otp = generateOtp(); // Generate a 6-digit OTP
			OtpData otpdata = new OtpData();
			otpdata.setEmail(beneficialOwner.getBenficialEmail());
			otpdata.setOtp((long) (otp));
			otpdata.setRetry(0);
			LocalDateTime expiryTime = LocalDateTime.now().plus(90, ChronoUnit.SECONDS); // Set OTP expiry time to 5
																							// minutes
			otpdata.setExpiryTime(Timestamp.valueOf(expiryTime));
			otpdata.setCreationDate(new Date());
			otpDataService.saveOtpData(otpdata);

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(sender);
			helper.setTo(beneficialOwner.getBenficialEmail());
			//helper.setBcc("ananth@microgridtechsol.com");
			helper.setSubject("Pending BOIR MFA");
			helper.setText("<!DOCTYPE html>\r\n" + "<html>\r\n" + "<head>\r\n" + "    <meta charset=\"UTF-8\">\r\n"
					+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
					+ "    <title>OTP for BOIRDetails Form Request</title>\r\n" + "    <style>\r\n" + "        body {\r\n"
					+ "            font-family: Arial, sans-serif;\r\n" + "            background-color: #f4f4f4;\r\n"
					+ "            margin: 0;\r\n" + "            padding: 0;\r\n" + "        }\r\n"
					+ "        .container {\r\n" + "            width: 100%;\r\n" + "            max-width: 600px;\r\n"
					+ "            margin: 0 auto;\r\n" + "            background-color: #ffffff;\r\n"
					+ "            padding: 20px;\r\n" + "            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);\r\n"
					+ "        }\r\n" + "        .header {\r\n" + "            text-align: center;\r\n"
					+ "            padding-bottom: 20px;\r\n" + "        }\r\n" + "        .header img {\r\n"
					+ "            max-width: 150px;\r\n" + "        }\r\n" + "        .content {\r\n"
					+ "            font-size: 16px;\r\n" + "            color: #333333;\r\n"
					+ "            line-height: 1.6;\r\n" + "        }\r\n" + "        .otp {\r\n"
					+ "            font-size: 18px;\r\n" + "            font-weight: bold;\r\n"
					+ "            color: #333333;\r\n" + "            text-align: center;\r\n" + "        }\r\n"
					+ "        .footer {\r\n" + "            margin-top: 20px;\r\n" + "            font-size: 14px;\r\n"
					+ "            color: #777777;\r\n" + "        }\r\n" + "        .footer a {\r\n"
					+ "            color: #0056b3;\r\n" + "            text-decoration: none;\r\n" + "        }\r\n"
					+ "    </style>\r\n" + "</head>\r\n" + "<body>\r\n" + "    <div class=\"container\">\r\n"
					+ "        <div class=\"header\">\r\n"
					+ "            <img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"CTA Harbor Logo\" />\r\n"
					+ "        </div>\r\n" + "        <div class=\"content\">\r\n" + "            <p>Dear "
					+ beneficialOwner.getBenficialEmail() + ",</p>\r\n"
					+ "            <p>We have received a request for BOIR Details (Beneficial Ownership Information Reporting) Form. To proceed with the requested changes, please use the One-Time Password (OTP) provided below:</p>\r\n"
					+ "            <p class=\"otp\">Your OTP: " + otp + "</p>\r\n"
					+ "            <p>This OTP is valid for 90 seconds and is required to complete your request. For your security, please do not share this OTP with anyone.</p>\r\n"
					+ "            <p>If you did not request this change, you can safely disregard this email. Your account will remain secure.</p>\r\n"
					+ "            <p>Should you encounter any issues or have any concerns, feel free to contact our support team at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or call us at +1 (888) 203-2246.</p>\r\n"
					+ "            <p>Thank you for your attention.</p>\r\n" + "        </div>\r\n"
					+ "        <div class=\"footer\">\r\n"
					+ "            <p>Best regards,<br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)\r\n"
					+ "</p>\r\n"
					+ "            <p><br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n"
					+ "        </div>\r\n" + "    </div>\r\n" + "</body>\r\n" + "</html>\r\n" + "" + "", true);
			try {
				mailSender.send(message);
				respMap.put("message", "success");
				respMap.put("status", true);
				respMap.put("email", beneficialOwner.getBenficialEmail());
			} catch (Exception e) {
				respMap.put("status", false);
				respMap.put("message", "Not a Valid Request");
			}
		} else {
			if(!beneficialOwner.getBeneficialStatus().equalsIgnoreCase("pending")) {
				respMap.put("status", false);
				respMap.put("message", "Response alredy recorded");
			}
		}
	 }else {
        respMap.put("status", false);
        respMap.put("message", "Beneficial owner not found for the given track ID");
	   }
	 return respMap;
	}

	@PostMapping("/customOTP")
	public String customOTP(@Valid @ModelAttribute("OtpData") OtpData otpData, BindingResult result,
			Principal principal, Model model, HttpSession session) throws MessagingException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		// boolean isAuthenticated = false;

		// isAuthenticated = authentication.isAuthenticated();
		String userName = authentication.getName();
		User user = userService.findByEmail(userName);
		if (true) {

			// Generate OTP
			int otp = generateOtp(); // Generate a 6-digit OTP

			OtpData otpdata = new OtpData();
			otpdata.setEmail(user.getEmail());
			otpdata.setOtp((long) (otp));
			otpdata.setRetry(0);
			LocalDateTime expiryTime = LocalDateTime.now().plus(90, ChronoUnit.SECONDS); // Set OTP expiry time to 5
																							// minutes
			otpdata.setExpiryTime(Timestamp.valueOf(expiryTime));
			otpdata.setCreationDate(new Date());
			otpDataService.saveOtpData(otpdata);

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(sender);
			helper.setTo(user.getEmail());
			helper.setBcc("ananth@microgridtechsol.com");
			helper.setSubject("Edit BOIR MFA");
			helper.setText("<!DOCTYPE html>\r\n" + "<html>\r\n" + "<head>\r\n" + "    <meta charset=\"UTF-8\">\r\n"
					+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
					+ "    <title>OTP for BOIR Form Edit Request</title>\r\n" + "    <style>\r\n" + "        body {\r\n"
					+ "            font-family: Arial, sans-serif;\r\n" + "            background-color: #f4f4f4;\r\n"
					+ "            margin: 0;\r\n" + "            padding: 0;\r\n" + "        }\r\n"
					+ "        .container {\r\n" + "            width: 100%;\r\n" + "            max-width: 600px;\r\n"
					+ "            margin: 0 auto;\r\n" + "            background-color: #ffffff;\r\n"
					+ "            padding: 20px;\r\n" + "            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);\r\n"
					+ "        }\r\n" + "        .header {\r\n" + "            text-align: center;\r\n"
					+ "            padding-bottom: 20px;\r\n" + "        }\r\n" + "        .header img {\r\n"
					+ "            max-width: 150px;\r\n" + "        }\r\n" + "        .content {\r\n"
					+ "            font-size: 16px;\r\n" + "            color: #333333;\r\n"
					+ "            line-height: 1.6;\r\n" + "        }\r\n" + "        .otp {\r\n"
					+ "            font-size: 18px;\r\n" + "            font-weight: bold;\r\n"
					+ "            color: #333333;\r\n" + "            text-align: center;\r\n" + "        }\r\n"
					+ "        .footer {\r\n" + "            margin-top: 20px;\r\n" + "            font-size: 14px;\r\n"
					+ "            color: #777777;\r\n" + "        }\r\n" + "        .footer a {\r\n"
					+ "            color: #0056b3;\r\n" + "            text-decoration: none;\r\n" + "        }\r\n"
					+ "    </style>\r\n" + "</head>\r\n" + "<body>\r\n" + "    <div class=\"container\">\r\n"
					+ "        <div class=\"header\">\r\n"
					+ "            <img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"CTA Harbor Logo\" />\r\n"
					+ "        </div>\r\n" + "        <div class=\"content\">\r\n" + "            <p>Dear "
					+ user.getEmail() + ",</p>\r\n"
					+ "            <p>We have received a request to edit your BOIR (Beneficial Ownership Information Reporting) Form. To proceed with the requested changes, please use the One-Time Password (OTP) provided below:</p>\r\n"
					+ "            <p class=\"otp\">Your OTP: " + otp + "</p>\r\n"
					+ "            <p>This OTP is valid for 90 seconds and is required to complete your request. For your security, please do not share this OTP with anyone.</p>\r\n"
					+ "            <p>If you did not request this change, you can safely disregard this email. Your account will remain secure.</p>\r\n"
					+ "            <p>Should you encounter any issues or have any concerns, feel free to contact our support team at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or call us at +1 (888) 203-2246.</p>\r\n"
					+ "            <p>Thank you for your attention.</p>\r\n" + "        </div>\r\n"
					+ "        <div class=\"footer\">\r\n"
					+ "            <p>Best regards,<br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)\r\n"
					+ "</p>\r\n"
					+ "            <p><br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n"
					+ "        </div>\r\n" + "    </div>\r\n" + "</body>\r\n" + "</html>\r\n" + "" + "", true);
			try {
				mailSender.send(message);
			} catch (Exception e) {
			}

			return "";
		} else {
			model.addAttribute("message", "Please enter valid Email ID");
			return "";
		}
	}

	@GetMapping("/validateOTP")
	public String validateOTP(Model model, HttpSession session) {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
			isAuthenticated = authentication.isAuthenticated();

		}
		model.addAttribute("isAuthenticated", isAuthenticated);

		// String storedOtp = session.getAttribute("otp").toString();
		model.addAttribute("otp", session.getAttribute("otp"));
		model.addAttribute("email", session.getAttribute("email"));
		OtpData od = new OtpData();
		model.addAttribute("OtpData", od);

		return "validateOTP";
	}
	
	@GetMapping("/validateOTPBOIR/{trackId}/{otp}")
	@ResponseBody
	public Map<String, Object> validateOTPdata(@PathVariable("trackId") String trackId,@PathVariable("otp") String otp) {
		
		Optional<BeneficialOwner> beneficialOwnerO = beneficialOwnerRepository.findByBeneficialTrackId(trackId);
		Map<String, Object> response = new HashMap<>();
		if(beneficialOwnerO.isPresent()) {
			BeneficialOwner beneficialOwner =  beneficialOwnerO.get(); 
			String query = "SELECT id,expiry_time FROM otp_data WHERE email = '" + beneficialOwner.getBenficialEmail() + "' AND otp = '" + otp
					+ "' ORDER BY creation_date DESC LIMIT 1";
			Map<String, Object> parameters = null;
			List<Map<String, Object>> otpResult = entityService.getDynamicQueryResults(query, parameters);
			if (!otpResult.isEmpty()) {
				Map<String, Object> otpData = otpResult.get(0);
				Timestamp expiryTime = (Timestamp) otpData.get("expiry_time");
				UUID id = (UUID) otpData.get("id");
				Timestamp now = new Timestamp(System.currentTimeMillis());
				 
				Optional<OtpData> optDataOptional = otpDataService.getOtpDataById(id);

			   if (optDataOptional.isPresent()) {
	                OtpData optData = optDataOptional.get();
	                
					if (now.before(expiryTime)) { // Check if OTP is still valid
						optData = otpDataService.getOtpDataById(id).get();
						optData.setOtpVerify("true");
						optData.setUpdateDate(new Date());
						response.put("success", true);
					} else {
					   optData = otpDataService.getOtpDataById(id).get();
						optData.setRetry(optData.getRetry() + 1);
						response.put("success", false);
						response.put("message", "OTP is expired");
					}
			   } else {
	                response.put("success", false);
	                response.put("message", "OTP data not found for the provided ID");
	            }
			} else {
				response.put("success", false);
				response.put("message", "Invalid OTP, please try again");
			}
		}else {
			response.put("success", false);
			response.put("message", "Beneficial owner not found for the given track ID");
		}
		return response;
	}

	@PostMapping("/validateOTPsubmit")
	public String validateOTPdata(Model model, HttpSession session, @ModelAttribute("OtpData") OtpData otpData) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
			isAuthenticated = authentication.isAuthenticated();
			String userName = authentication.getName();
			User user = userService.findByEmail(userName);
			model.addAttribute("image", user.getImage());
		}
		model.addAttribute("isAuthenticated", isAuthenticated);
		String email = (String) session.getAttribute("email");
		User existing = userService.findByEmail(email);
		String storedOtp = existing.getOtp();
		String userOtp = String.valueOf(otpData.getOtp());
		//UserDto user = new UserDto();

		Date otpCreatedTime = existing.getotpCreatedTime(); // Fetch the OTP created time from your existing object
		long secondsDifference = calculateSecondsDifference(otpCreatedTime);
		if (storedOtp.equals(userOtp) && secondsDifference <= 90) {
			// OTP is valid, redirect to password reset page
			return "resetPassword";
		} else {
			if (secondsDifference > 90) {
				model.addAttribute("message", "Oops! The OTP you provided is not valid. Please enter the correct OTP");
			} else {
				model.addAttribute("message",
						"Oops! It seems the OTP is incorrect. Please double-check and enter the correct code.");
			}
			// OTP is invalid, redirect back to OTP validation page with error message
			return "validateOTP";
		}

	}

	@PostMapping("/resetPassword")
	public String resetPassword(Model model, @ModelAttribute("UserDto") UserDto userDto, HttpSession session)
			throws MessagingException {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
			isAuthenticated = authentication.isAuthenticated();
			String userName = authentication.getName();
			User user = userService.findByEmail(userName);
			model.addAttribute("image", user.getImage());

		}
		model.addAttribute("isAuthenticated", isAuthenticated);

		User users = userService.findByEmail((String) session.getAttribute("email"));
		if (passwordEncoder.matches(userDto.getPassword(), users.getPassword())) {
			model.addAttribute("message", "New Password cannot be the same as Old Password");
			return "resetPassword";
		}
		String userEmail = (String) session.getAttribute("email");
		String userName = (users != null && users.getName() != null) ? users.getName() : userEmail;
		// Sending email
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setFrom(sender);
		helper.setTo(userEmail);
		helper.setBcc("ananth@microgridtechsol.com");
		helper.setSubject("Password Successfully Changed");
		helper.setText("<!DOCTYPE html>\r\n" + "<html lang=\"en\">\r\n" + "<head>\r\n"
				+ "    <meta charset=\"UTF-8\">\r\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
				+ "    <title>Password Successfully Changed</title>\r\n" + "    <style>\r\n" + "        body {\r\n"
				+ "            font-family: Arial, sans-serif;\r\n" + "            background-color: #f4f4f4;\r\n"
				+ "            margin: 0;\r\n" + "            padding: 0;\r\n" + "        }\r\n"
				+ "        .email-container {\r\n" + "            max-width: 600px;\r\n"
				+ "            margin: 20px auto;\r\n" + "            background-color: #ffffff;\r\n"
				+ "            padding: 20px;\r\n" + "            border-radius: 8px;\r\n"
				+ "            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);\r\n" + "        }\r\n" + "        .logo {\r\n"
				+ "            text-align: center;\r\n" + "            margin-bottom: 20px;\r\n" + "        }\r\n"
				+ "        .logo img {\r\n" + "            max-width: 150px;\r\n" + "        }\r\n"
				+ "        .content {\r\n" + "            color: #333333;\r\n" + "            font-size: 16px;\r\n"
				+ "            line-height: 1.5;\r\n" + "        }\r\n" + "        .content h1 {\r\n"
				+ "            font-size: 24px;\r\n" + "            margin-bottom: 20px;\r\n"
				+ "            color: #333333;\r\n" + "        }\r\n" + "        .content p {\r\n"
				+ "            margin-bottom: 20px;\r\n" + "        }\r\n" + "        .content a {\r\n"
				+ "            color: #1a73e8;\r\n" + "            text-decoration: none;\r\n" + "        }\r\n"
				+ "        .footer {\r\n" + "            text-align: left;\r\n" + "            margin-top: 20px;\r\n"
				+ "            font-size: 14px;\r\n" + "            color: #777777;\r\n" + "        }\r\n"
				+ "    </style>\r\n" + "</head>\r\n" + "<body>\r\n" + "    <div class=\"email-container\">\r\n"
				+ "        <div class=\"logo\">\r\n"
				+ "            <!-- Replace 'Logo.png' with the actual path to your logo image -->\r\n"
				+ "            <img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\\\"CTAHarbor Logo\\\">\r\n"
				+ "        </div>\r\n" + "        <div class=\"content\">\r\n" + "            <p>Dear "
				+ userName + ",</p>\r\n"
				+ "            <p>We’re writing to inform you that your password for your <strong>CTAHarbor</strong> account has been successfully updated. If you initiated this change, no further action is needed.</p>\r\n"
				+ "            <p><strong>If you did not change your password:</strong></p>\r\n"
				+ "            <p>Please contact our support team immediately at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a>. We recommend taking steps to secure your account, such as resetting your password and reviewing your recent account activity.</p>\r\n"
				+ "            <p><strong>For your security:</strong></p>\r\n" + "            <ul>\r\n"
				+ "                <li>Use a unique password that isn't used on other websites.</li>\r\n"
				+ "                <li>Keep your password confidential and do not share it with anyone.</li>\r\n"
				+ "            </ul>\r\n"
				+ "            <p>If you have any questions or concerns, please don't hesitate to contact us.</p>\r\n"
				+ "            <p>Thank you for trusting <strong>CTAHarbor</strong>.</p>\r\n" + "        </div>\r\n"
				+ "        <div class=\"footer\">\r\n" + "            <p>Best regards,\r\n"
				+ "            <p>BOIR Filing Team</p><br><br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)\r\n"
				+ "            <a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n"
				+ "        </div>\r\n" + "    </div>\r\n" + "</body>\r\n" + "</html>\r\n" + "", true);
		try {
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		userService.saveUserObject(users, userDto.getPassword());
		model.addAttribute("message", "Your password has been changed. You're all set!");
		return "resetPassword";
	}

	public static long calculateSecondsDifference(Date otpCreatedTime) {
		// Convert Date to LocalDateTime
		LocalDateTime otpTime = otpCreatedTime.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();

		// Get the current time as LocalDateTime
		LocalDateTime currentTime = LocalDateTime.now();

		// Calculate the duration between the two times
		Duration duration = Duration.between(otpTime, currentTime);

		// Return the difference in seconds
		return duration.getSeconds();
	}

	@PostMapping("/savepassword")
	@ResponseBody
	public Map<String, Object> resetPassword(@RequestBody String data, HttpSession session) throws MessagingException {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		/*
		 * boolean isAuthenticated = false; if (authentication != null &&
		 * !authentication.getPrincipal().toString().equals("anonymousUser")) {
		 * isAuthenticated = authentication.isAuthenticated(); }
		 */
		Object obj = JSONValue.parse(data);
		JSONObject datajson = (JSONObject) obj;
		String newvalue = datajson.getAsString("password");
		String query = "SELECT id,expiry_time FROM otp_data WHERE email = '" + datajson.getAsString("email")
				+ "' AND otp = '" + datajson.getAsString("otp") + "' ORDER BY creation_date DESC LIMIT 1";
		Map<String, Object> parameters = null;
		List<Map<String, Object>> otpResult = entityService.getDynamicQueryResults(query, parameters);
		if (otpResult.isEmpty()) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", false);
			response.put("message", "Otp not matched, Password reset failed.");// New Password cannot be the same as Old
																				// // Password
			return response;
		}
		User users = userService.findByEmail(datajson.getAsString("email"));
		if (users != null && users.getEmail() != null && users.getPassword() != null
				&& passwordEncoder.matches(newvalue, users.getPassword())) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", true);
			response.put("message", "Password does not meet the requirement");// New Password cannot be the same as Old
																				// // Password
			return response;
		}
		String userEmail = datajson.getAsString("email");// (String) session.getAttribute("email");
		String userName = (users != null && users.getName() != null) ? users.getName() : userEmail;
		// Sending email
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setFrom(sender);
		helper.setTo(userEmail);
		helper.setBcc("ananth@microgridtechsol.com");
		helper.setSubject("Password Successfully Changed");
		helper.setText("<!DOCTYPE html>\r\n" + "<html lang=\"en\">\r\n" + "<head>\r\n"
				+ "    <meta charset=\"UTF-8\">\r\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
				+ "    <title>Password Successfully Changed</title>\r\n" + "    <style>\r\n" + "        body {\r\n"
				+ "            font-family: Arial, sans-serif;\r\n" + "            background-color: #f4f4f4;\r\n"
				+ "            margin: 0;\r\n" + "            padding: 0;\r\n" + "        }\r\n"
				+ "        .email-container {\r\n" + "            max-width: 600px;\r\n"
				+ "            margin: 20px auto;\r\n" + "            background-color: #ffffff;\r\n"
				+ "            padding: 20px;\r\n" + "            border-radius: 8px;\r\n"
				+ "            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);\r\n" + "        }\r\n" + "        .logo {\r\n"
				+ "            text-align: center;\r\n" + "            margin-bottom: 20px;\r\n" + "        }\r\n"
				+ "        .logo img {\r\n" + "            max-width: 150px;\r\n" + "        }\r\n"
				+ "        .content {\r\n" + "            color: #333333;\r\n" + "            font-size: 16px;\r\n"
				+ "            line-height: 1.5;\r\n" + "        }\r\n" + "        .content h1 {\r\n"
				+ "            font-size: 24px;\r\n" + "            margin-bottom: 20px;\r\n"
				+ "            color: #333333;\r\n" + "        }\r\n" + "        .content p {\r\n"
				+ "            margin-bottom: 20px;\r\n" + "        }\r\n" + "        .content a {\r\n"
				+ "            color: #1a73e8;\r\n" + "            text-decoration: none;\r\n" + "        }\r\n"
				+ "        .footer {\r\n" + "            text-align: left;\r\n" + "            margin-top: 20px;\r\n"
				+ "            font-size: 14px;\r\n" + "            color: #777777;\r\n" + "        }\r\n"
				+ "    </style>\r\n" + "</head>\r\n" + "<body>\r\n" + "    <div class=\"email-container\">\r\n"
				+ "        <div class=\"logo\">\r\n"
				+ "            <!-- Replace 'Logo.png' with the actual path to your logo image -->\r\n"
				+ "            <img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\\\"CTAHarbor Logo\\\">\r\n"
				+ "        </div>\r\n" + "        <div class=\"content\">\r\n" + "            <p>Dear "
				+ userName+ ",</p>\r\n"
				+ "            <p>We’re writing to inform you that your password for your <strong>CTAHarbor</strong> account has been successfully updated. If you initiated this change, no further action is needed.</p>\r\n"
				+ "            <p><strong>If you did not change your password:</strong></p>\r\n"
				+ "            <p>Please contact our support team immediately at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a>. We recommend taking steps to secure your account, such as resetting your password and reviewing your recent account activity.</p>\r\n"
				+ "            <p><strong>For your security:</strong></p>\r\n" + "            <ul>\r\n"
				+ "                <li>Use a unique password that isn't used on other websites.</li>\r\n"
				+ "                <li>Keep your password confidential and do not share it with anyone.</li>\r\n"
				+ "            </ul>\r\n"
				+ "            <p>If you have any questions or concerns, please don't hesitate to contact us.</p>\r\n"
				+ "            <p>Thank you for trusting <strong>CTAHarbor</strong>.</p>\r\n" + "        </div>\r\n"
				+ "        <div class=\"footer\">\r\n" + "            <p>Best regards,<br>\r\n"
				+ "            <strong>BOIR Filing Team</strong><br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)\r\n"
				+ "<br>\r\n" + "            <a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n"
				+ "        </div>\r\n" + "    </div>\r\n" + "</body>\r\n" + "</html>\r\n" + "", true);
		try {
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// $2a$10$.BvOuaaBUS7XBeyt1nNEV.zECwETUv3BJO32VMNPwW1.cvZybvB4G
		// $2a$10$h66vtlk2gl6CRqy7C5/3h.5dkaVLjVIdH.HTXsXgPI2DjxWvdYXJu
		// $2a$10$IlgLTmKzYSH55Le/e3jp5ughdI15mTnrgQU9ycpuli5lOwPCiChQ.
		// $2a$10$xNhiMgdgQ7Z4Qfd3l1A6z.ezBMQ4zAUAPgkf0fO4tH9K7lfyDQVbS
		// $2a$10$Mog8WRhdFsDdOIrlxkIb7.sbSRnXokjuoNJgK41uWZUoUe9Hx2N4i
		// $2a$10$PEGh.75PYbjDgypLpYAcjOYzVFQRl8RAaKv2eUHYLOnhWqEObG9Se
		userService.saveUserObject(users, newvalue);
		// model.addAttribute("message", "Password has been changed successfully");
		// return "resetPassword";
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("message", "Password has been changed successfully");
		return response;
	}
}
