package com.cta.boir.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;
import java.util.UUID;
import java.util.stream.Collectors;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cta.boir.dto.BeneficialOwnerDto;
import com.cta.boir.model.Address;
import com.cta.boir.model.AlternateName;
import com.cta.boir.model.BankReferal;
import com.cta.boir.model.BeneficialOwner;
import com.cta.boir.model.CompanyApplicant;
import com.cta.boir.model.CompanyApplicantInfo;
import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.IdentificationDocument;
import com.cta.boir.model.OtpData;
import com.cta.boir.model.ReportingCompany;
import com.cta.boir.model.SubmitterDetails;
import com.cta.boir.model.User;
import com.cta.boir.repository.BankReferalRepository;
import com.cta.boir.repository.BeneficialOwnerRepository;
import com.cta.boir.repository.CompanyApplicantRepository;
import com.cta.boir.repository.FilingInfoRepository;
import com.cta.boir.repository.ReportingCompanyRepository;
import com.cta.boir.repository.SubmitterDetailsRepository;
import com.cta.boir.repository.UserRepository;
import com.cta.boir.service.CustomEntityService;
import com.cta.boir.service.FillingService;
import com.cta.boir.service.OtpDataService;
import com.cta.boir.service.UserService;
import com.cta.boir.service.WraperService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.transaction.Transactional;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;
import net.minidev.json.parser.ParseException;

@Controller
public class BoirFilingController {
	@Autowired
	WraperService wraperService;
	@Autowired
	private FillingService fs;
	@Value("${nybacs.api.BOIR.service}")
	private String boir;

	@Value("${nybacs.api.BOIR.env}")
	private String env;
	
	
	@Value("${benificialDomain}")
	private String benificialDomain;
	
	@Value("${nybacs.payment.gateway.context}")
	private String contextDomain;
	
	@Value("${benificialEmailExpry}")
	private String benificialEmailExpry;

	@Autowired
	OtpDataService otpDataService;

	@Autowired
	private CustomEntityService entityService;

	@Autowired
	private JavaMailSender mailSender;

	@Value("${spring.mail.username}")
	private String sender;

	@Autowired
	private UserService userService1;
	private final FilingInfoRepository filingInfoRepository;
	private final BeneficialOwnerRepository beneficialOwnerRepository;
	private final CompanyApplicantRepository companyApplicantRepository;
	private final ReportingCompanyRepository reportingCompanyRepository;
	private final SubmitterDetailsRepository submitterDetailsRepository;
	private final BankReferalRepository bankReferalRepository;
	private final UserService userService;
	private final UserRepository userRepository;

	public BoirFilingController(FilingInfoRepository filingInfoRepository,
			BeneficialOwnerRepository beneficialOwnerRepository, CompanyApplicantRepository companyApplicantRepository,
			ReportingCompanyRepository reportingCompanyRepository, BankReferalRepository bankReferalRepository,
			SubmitterDetailsRepository submitterDetailsRepository, UserService userService, UserRepository userRepository) {
		this.filingInfoRepository = filingInfoRepository;
		this.beneficialOwnerRepository = beneficialOwnerRepository;
		this.companyApplicantRepository = companyApplicantRepository;
		this.reportingCompanyRepository = reportingCompanyRepository;
		this.submitterDetailsRepository = submitterDetailsRepository;
		this.bankReferalRepository = bankReferalRepository;
		this.userService = userService;
		this.userRepository = userRepository;
	}

	@PostMapping("filingInfo")
	@ResponseBody
	public Map<String, Object> saveFilingInfoStep1(@ModelAttribute FilingInfo filingInfo) {
		
		if(filingInfo.getCurrentStatus() == null || filingInfo.getCurrentStatus().trim().equals("") ){
			filingInfo.setCurrentStatus("new");
		}else {
		}
		
		setUserId(filingInfo);
		filingInfo.setStatus("In Progress");
		filingInfo = filingInfoRepository.save(filingInfo);
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("filingInfo", filingInfo);
		return response;
	}

	@GetMapping("getOTP/{email}")
	@ResponseBody
	public Map<String, Object> getOTP(@PathVariable("email") String email) throws MessagingException {

		Map<String, Object> response = new HashMap<>();
		User result = userService.findByEmail(email);
		if (result != null) {
			response.put("exists", true);
			response.put("message", "User already exists");
		} else {

			int otp = AuthController.generateOtp(); // Generate a 6-digit OTP
			response.put("OTP", otp);
			// Storing Otp to database
			OtpData otpdata = new OtpData();
			otpdata.setEmail(email);
			otpdata.setOtp((long) (otp));
			otpdata.setRetry(0);
			LocalDateTime expiryTime = LocalDateTime.now().plus(90, ChronoUnit.SECONDS); // Set OTP expiry time to 90 seconds
			otpdata.setExpiryTime(Timestamp.valueOf(expiryTime));
			otpdata.setCreationDate(new Date());
			otpDataService.saveOtpData(otpdata);
			// Sending email
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(sender);
			helper.setTo(email);
			helper.setBcc("ananth@microgridtechsol.com");
			helper.setSubject("Register  OTP");
//    		        helper.setText("Request has been submitted by"+contactus.getName()+"by email"+contactus.getEmail_id()+"with comments "+contactus.getComments(), true); // Setting the second parameter to true enables HTML

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
			helper.setText("<!DOCTYPE html>\r\n" + "<html lang=\"en\">\r\n" + "<head>\r\n" + "    <me"
					+ "ta charset=\"UTF-8\">\r\n"
					+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
					+ "    <title>Registration Email OTP</title>\r\n" + "    <style>\r\n" + "        body {\r\n"
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
					+ "            <td class=\"email-body\">\r\n" + "                <p>Dear " + email + ",</p>\r\n"
					+ "                <p>We have sent an OTP to your account. To proceed to the signup page, please use the One-Time Password (OTP) provided below:</p>\r\n"
					+ "                <p class=\"otp\">Your OTP: " + otp + "</p>\r\n"
					+ "                <p>This OTP is valid for the next 90 seconds. Please do not share this OTP with anyone for your account's security.</p>\r\n"
					+ "                <p></p>\r\n"
					+ "                <p>If you have any issues or concerns, feel free to contact our support team at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or +1 (888) 203-2246.</p>\r\n"
					+ "                <p>Best Regards,<br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n"
					+ "            </td>\r\n" + "        </tr>\r\n" + "    </table>\r\n" + "</body>\r\n" + "</html>\r\n"
					+ "", true);
			
			try {
				mailSender.send(message);
			} catch (Exception e) {
				e.printStackTrace();
			}
			response.put("success", true);
			response.put("message", "OTP has been sent to your email.");
			return response;
		}
		return response;
	}


	@PostMapping("/authenticationOTP/{otp}")
	public ResponseEntity<String> otpvalidator(@PathVariable String otp, @RequestParam("newUserEmail") String email) {
		
		List<OtpData> otpDataList = otpDataService.getOtpDataByEmail(email);
		if (otpDataList.isEmpty()) {
			return ResponseEntity.ok("No OTP data found for this email.");
		}
		OtpData otpData = otpDataList.get(0);
		long storedOtp = otpData.getOtp();

		if (storedOtp == Long.valueOf(otp)) {
			return ResponseEntity.ok("OTP validated successfully.");
		}
		return ResponseEntity.ok("Invalid OTP.");
	}

	@GetMapping("sendemailotp/{email}")
	@ResponseBody
	public Map<String, Object> sendOTP(@PathVariable("email") String email) throws MessagingException {

		Map<String, Object> response = new HashMap<>();
		User result = userService.findByEmail(email);
		if (result == null) {
			response.put("success", true);
			response.put("message", "If user present will receivie the OTP");
		} else {

			String otp = generateOTP(); // Generate a 6-digit OTP
			OtpData otpData = new OtpData();
			otpData.setEmail(email);
			otpData.setOtp(Long.parseLong(otp));
			otpData.setRetry(0);
			LocalDateTime expiryTime = LocalDateTime.now().plus(90, ChronoUnit.SECONDS); // Set OTP expiry time to 5
																							// minutes
			otpData.setExpiryTime(Timestamp.valueOf(expiryTime));
			otpData.setCreationDate(new Date());
			otpDataService.saveOtpData(otpData);
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(sender);
			helper.setTo(email);
			helper.setBcc("ananth@microgridtechsol.com");
			helper.setSubject("Forgot password  OTP");
			helper.setText("<!DOCTYPE html>\r\n" + "<html lang=\"en\">\r\n" + "<head>\r\n" + "    <me"
					+ "ta charset=\"UTF-8\">\r\n"
					+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
					+ "    <title>Registration Email OTP</title>\r\n" + "    <style>\r\n" + "        body {\r\n"
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
					+ "            <td class=\"email-body\">\r\n" + "                <p>Dear " + email + ",</p>\r\n"
					+ "                <p>We have sent an OTP to your account. To proceed to the signup page, please use the One-Time Password (OTP) provided below:</p>\r\n"
					+ "                <p class=\"otp\">Your OTP: " + otp + "</p>\r\n"
					+ "                <p>This OTP is valid for the next 90 seconds. Please do not share this OTP with anyone for your account's security.</p>\r\n"
					+ "                <p></p>\r\n"
					+ "                <p>If you have any issues or concerns, feel free to contact our support team at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or +1 (917) 675-1888.</p>\r\n"
					+ "                <p>Best Regards,<br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n"
					+ "            </td>\r\n" + "        </tr>\r\n" + "    </table>\r\n" + "</body>\r\n" + "</html>\r\n"
					+ "", true);
			try {
				mailSender.send(message);
			} catch (Exception e) {
				e.printStackTrace();
			}
			response.put("success", true);
			response.put("message", "If user present will receivie the OTP");
			return response;
		}
		return response;
	}

	@GetMapping("/verifyemailotp/{email}/{otp}")
	@ResponseBody
	public Map<String, Object> verifyOtp(@PathVariable("email") String email, @PathVariable("otp") String otp) {

		String query = "SELECT id,expiry_time FROM otp_data WHERE email = '" + email + "' AND otp = '" + otp
				+ "' ORDER BY creation_date DESC LIMIT 1";
		Map<String, Object> parameters = null;
		Map<String, Object> response = new HashMap<>();
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
		return response;
	}

	public String generateOTP() {
		SecureRandom random = new SecureRandom();
		int otpLength = 6; // Length of OTP
		StringBuilder otp = new StringBuilder(otpLength);
		for (int i = 0; i < otpLength; i++) {
			otp.append(random.nextInt(10));
		}
		return otp.toString();
	}

	private void setUserId(FilingInfo filingInfo) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String principalName = "";
		if (authentication != null) {
			principalName = authentication.getName();
		}

		User user = userService.findByEmail(principalName);
		filingInfo.setUserId(String.valueOf(user.getId()));
	}

	@PostMapping("reportingCompany")
	@ResponseBody
	@Transactional
	public Map<String, Object> saveFilingInfoStep2(@ModelAttribute ReportingCompany reportingCompany) {
		reportingCompanyRepository.deleteByFilingInfoId(reportingCompany.getFilingInfoId());
		if (reportingCompany.getAlternateName() != null)
			reportingCompany.setAlternateName(reportingCompany.getAlternateName().stream()
					.filter(data -> StringUtils.isNotEmpty(data.getName())).collect(Collectors.toList()));
		// reportingCompany.setReportingAddress(null);
		reportingCompany = reportingCompanyRepository.save(reportingCompany);
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("reportingCompany", reportingCompany);
		return response;
	}

	@PostMapping("companyApplicant")
	@ResponseBody
	@Transactional
	public Map<String, Object> saveFilingInfoStep3(@ModelAttribute CompanyApplicant companyApplicant) {
		companyApplicantRepository.deleteByFilingInfoId(companyApplicant.getFilingInfoId());
		companyApplicant.setCompanyApplicantInfo(companyApplicant.getCompanyApplicantInfo().stream()
				.filter(data -> StringUtils.isNotEmpty(data.getFinCenId())
						|| StringUtils.isNotEmpty(data.getIndividualsLastName()))
				.toList());

		companyApplicant = companyApplicantRepository.save(companyApplicant);
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("companyApplicant", companyApplicant);
		return response;
	}

	@PostMapping("beneficialOwner11")
	@ResponseBody
	@Transactional
	public Map<String, Object> saveFilingInfoStep4(@ModelAttribute BeneficialOwnerDto beneficialOwnerDto) {
		beneficialOwnerRepository.deleteByFilingInfoId(beneficialOwnerDto.getFilingInfoId());

		List<BeneficialOwner> beneficialOwners = new ArrayList<>();
		for (BeneficialOwner b : beneficialOwnerDto.getBeneficialOwner()) {
			if (StringUtils.isNotEmpty(b.getFinCenId()) || StringUtils.isNotEmpty(b.getLegalName())) {
				b.setFilingInfoId(beneficialOwnerDto.getFilingInfoId());
				beneficialOwners.add(b);
			}
		}
		beneficialOwnerDto.setBeneficialOwner(beneficialOwnerRepository.saveAll(beneficialOwners));
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("beneficialOwner", beneficialOwnerDto.getBeneficialOwner());
		return response;
	}
	
	//@PostMapping("beneficialOwnerSendMail")
	@PostMapping("beneficialOwner")
	@ResponseBody
	@Transactional
	public Map<String, Object> beneficialOwnerSendMail(@ModelAttribute BeneficialOwnerDto beneficialOwnerDto) throws MessagingException {
		//ReportingCompany company= reportingCompanyRepository.findByFilingInfoId(beneficialOwnerDto.getFilingInfoId());
		 
		beneficialOwnerRepository.deleteByFilingInfoId(beneficialOwnerDto.getFilingInfoId());
		List<BeneficialOwner> beneficialOwners = new ArrayList<>();
		for (BeneficialOwner b : beneficialOwnerDto.getBeneficialOwner()) {
				b.setFilingInfoId(beneficialOwnerDto.getFilingInfoId());
//				CompanyApplicant applicant=companyApplicantRepository.findByFilingInfoId(b.getFilingInfoId());
//				String CompanyApplicantName;
//				if(!applicant.getCompanyApplicantInfo().isEmpty()||applicant.getCompanyApplicantInfo()!=null) {
//				CompanyApplicantName=applicant.getCompanyApplicantInfo().get(0).getFirstName()+" "+applicant.getCompanyApplicantInfo().get(0).getIndividualsLastName();
//				}else {
//					CompanyApplicantName="Company applicant";
//				}
				if(b.getBenficialEmail()!=null && b.getBenficialEmail().trim().length()>0 && (b.getBeneficialStatus()==null || b.getBeneficialStatus().trim().equals("") )){
					String trackId = UUID.randomUUID().toString();
					b.setBeneficialTrackId(trackId);
					b.setBeneficialStatus("pending");
					 Date date = new Date(); // current date
				    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				    String dateString = sdf.format(date);
				 // Calculate the expiration date (3 months from now)
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(date);
					calendar.add(Calendar.MONTH, 3);
					Date expirationDate = calendar.getTime();
					String expirationDateString = sdf.format(expirationDate);
					
					b.setBenficialEmailSentDate(dateString);
					String benficalLink = benificialDomain+"?trackingid="+trackId;
//					User user = userRepository.findByEmail(b.getCreatedBy());
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
					helper.setFrom(sender);
					helper.setTo(b.getBenficialEmail());
					helper.setBcc("ananth@microgridtechsol.com");
					helper.setSubject("Action Required: Complete Your Beneficial Ownership Information");
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
				     		+ "  <h3 style=\"color:#003B6A;\">Dear Beneficial Owner,</h3>\r\n"
				     		+ "  <p style=\"color:#003B6A;\">I hope you're well.</p>\r\n"
				     		+ "  <p style=\"color:#003B6A;\">As part of our compliance with the Corporate Transparency Act (CTA), we need you to provide your Beneficial Ownership Information. Please click the link below to complete your details securely:</p>\r\n"
				     		+ "	 <a style=\"border-width:0px; text-decoration:none; background-color:#003B6A; color:#FFFFFF !important; border-radius:20px; padding:10px;\" href=\""+ benficalLink+"\" >Get Started</a><br>"
							+ "  <h4 style=\"color:#003B6A;\">Why This Matters:</h4>\r\n"
				     		+ "  <p style=\"color:#003B6A;\">Your information ensures we meet regulatory requirements and maintain accurate records.</p>\r\n"
				     		+ "  <h4 style=\"color:#003B6A;\">Need Help?</h4>\r\n"
				     		+ "  <p style=\"color:#003B6A;\">Contact us at <a style=\"color:#003B6A;\" href=\"mailto:support@ctaharbor.com\">support@ctaharbor.com</a> or call <a style=\"color:#003B6A;\" href=\"tel:+1 (888) 203-2246\" class=\"fw-500\">+1 (888) 203-2246</a>.</p>\r\n"
				     		+ "  <h4 style=\"color:#003B6A;\">Deadline:</h4>\r\n"
				     		+ "  <p style=\"color:#003B6A;\">Please complete your information by ["+expirationDateString+"].</p>\r\n"
							+ "  <p style=\"color:#003B6A;\">Thank you for your prompt attention.</p>\r\n"
				     		+ "  <p style=\"color:#003B6A;\">Best regards,</p>\r\n"
				     		+ "  <p style=\"color:#003B6A;\"><br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a style=\"color:#003B6A;\" href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a>\r\n"
				     		+ "  <p><a style=\"color:#003B6A;\"href=\"mailto:support@ctaharbor.com\">support@ctaharbor.com</a></p>\r\n"
				     		+ "  <p style=\"color:#003B6A;\">\r\n"
//				     		+ "   <a class=\"unsub\"href=\"#\">Unsubscribe</a><br> You can opt out of reminder emails, and your in-progress reports will remain accessible on your dashboard.\r\n"
				     		+ "  </p>\r\n"
				     		+ "</body>\r\n"
				     		+ "</html>",true);
					try {
						mailSender.send(message);
					} catch (Exception e) {
					}
					beneficialOwners.add(b);
				}if (StringUtils.isNotEmpty(b.getFinCenId()) || StringUtils.isNotEmpty(b.getLegalName())) {
					beneficialOwners.add(b);
				}
				
		}
		beneficialOwnerDto.setBeneficialOwner(beneficialOwnerRepository.saveAll(beneficialOwners));
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("beneficialOwner", beneficialOwnerDto.getBeneficialOwner());
		
		return response;
	}
	
	
	@PostMapping("beneficialOwnerSaveTracking")
	@ResponseBody
	@Transactional
	public Map<String, Object> beneficialOwnerSaveTracking(@ModelAttribute BeneficialOwnerDto beneficialOwnerDto) throws MessagingException {
		//beneficialOwnerRepository.deleteByFilingInfoId(beneficialOwnerDto.getFilingInfoId());
		List<BeneficialOwner> beneficialOwners = new ArrayList<>();
		Map<String, Object> response = new HashMap<>();
		for (BeneficialOwner b : beneficialOwnerDto.getBeneficialOwner()) {
//			CompanyApplicant applicant=companyApplicantRepository.findByFilingInfoId(b.getFilingInfoId());
//			String CompanyApplicantName;
//			if(!applicant.getCompanyApplicantInfo().isEmpty()||applicant.getCompanyApplicantInfo()!=null) {
//			CompanyApplicantName=applicant.getCompanyApplicantInfo().get(0).getFirstName()+" "+applicant.getCompanyApplicantInfo().get(0).getIndividualsLastName();
//			}else {
//				CompanyApplicantName="";
//			}
			String trackId = beneficialOwnerDto.getTrackingid();
			 Optional<BeneficialOwner> beneficialOwnerO = beneficialOwnerRepository.findByBeneficialTrackId(trackId);
			 if(beneficialOwnerO.isPresent()) {
			 BeneficialOwner beneficialOwner =  beneficialOwnerO.get();
			 BeneficialOwner duplicateBeneficialOwner = new BeneficialOwner();
			 duplicateBeneficialOwner.setBeneficialOwnerId(beneficialOwner.getBeneficialOwnerId());
			 duplicateBeneficialOwner.setFilingInfoId(beneficialOwner.getFilingInfoId());
			 duplicateBeneficialOwner.setBenficialEmail(beneficialOwner.getBenficialEmail());
			 duplicateBeneficialOwner.setBeneficialTrackId(beneficialOwner.getBeneficialTrackId());
			 duplicateBeneficialOwner.setBenficialEmailSentDate(beneficialOwner.getBenficialEmailSentDate());
			 duplicateBeneficialOwner.setAddress(b.getAddress());
			 duplicateBeneficialOwner.setBeneficialStatus("completed");
			 duplicateBeneficialOwner.setExemptEntity(b.getExemptEntity());
			 duplicateBeneficialOwner.setFfirstName(b.getFfirstName());
			 duplicateBeneficialOwner.setDateOfBirth(b.getDateOfBirth());
			 duplicateBeneficialOwner.setFinCenId(b.getFinCenId());
			 duplicateBeneficialOwner.setFirstName(b.getFirstName());
			 duplicateBeneficialOwner.setFlegalName(b.getFlegalName());
			 duplicateBeneficialOwner.setIdentificationDocuments(b.getIdentificationDocuments());
			 duplicateBeneficialOwner.setIsMinorChild(b.getIsMinorChild());
			 duplicateBeneficialOwner.setLegalName(b.getLegalName());
			 duplicateBeneficialOwner.setMiddleName(b.getMiddleName());
			 duplicateBeneficialOwner.setSuffix(b.getSuffix());
			 beneficialOwners.add(duplicateBeneficialOwner);
			 String beneficialOwnerName;
			 if(duplicateBeneficialOwner.getFirstName().equals("")&&duplicateBeneficialOwner.getLegalName().equals("")) {
				 beneficialOwnerName=duplicateBeneficialOwner.getFfirstName()+" "+duplicateBeneficialOwner.getFlegalName();
			 }else {
				 beneficialOwnerName=duplicateBeneficialOwner.getFirstName()+" "+duplicateBeneficialOwner.getLegalName();
			 }
			 ReportingCompany company= reportingCompanyRepository.findByFilingInfoId(beneficialOwner.getFilingInfoId());
			 MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
				helper.setFrom(sender);
				helper.setTo(beneficialOwner.getCreatedBy());
				helper.setBcc("ananth@microgridtechsol.com");
				helper.setSubject("Beneficial Owner Submission Received for "+ company.getReportingCompanyLegalName());
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
			     		+ "</head>\r\n"
			     		+ "<body>\r\n"
			     		+ " <div class=\"header\">\r\n"
			     		+ " <center><img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"CTA Harbor Logo\" /></center>\r\n"
			     		+ " </div>\r\n"
			     		+ "  <h2 style= \"color:#003B6A; \">Hi,</h2>\r\n"
			     		+ "  <p style=\"color:#003B6A;\">We’ve received the Beneficial Ownership Information for "+ company.getReportingCompanyLegalName()+".</p>\r\n"
			     		+ "  <p style=\"color:#003B6A;\">"+beneficialOwnerName+" has successfully submitted their form</p>\r\n"
						+ "  <p style=\"color:#003B6A;\"><strong>Please use the link below to get started.</strong></p>\r\n"
						+ "	 <a  style=\"border-width:0px; background-color:#003B6A; color:#FFFFFF !important; border-radius:20px; text-decoration:none; padding:10px;\" href=\""+contextDomain+"boirfiling?filingInfoId="+company.getFilingInfoId()+"\" >Complete Your Information</a>"
						+ "  <p style=\"color:#003B6A;\">Thank you for your prompt attention.</p>\r\n"
			     		+ "  <p style= \"color:#003B6A; \">Best regards,</p>\r\n"
			     		+ "  <p style= \"color:#003B6A; \"><br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a>\r\n"
			     		+ "  <p><a href=\"mailto:support@ctaharbor.com\">support@ctaharbor.com</a></p>\r\n"
			     		+ "  <p style= \"color:#003B6A; \">\r\n"
//			     		+ "   <a class=\"unsub\"href=\"#\">Unsubscribe</a><br> You can opt out of reminder emails, and your in-progress reports will remain accessible on your dashboard.\r\n"
			     		+ "  </p>\r\n"
			     		+ "</body>\r\n"
			     		+ "</html>",true);
				try {
					mailSender.send(message);
				} catch (Exception e) {
				}
				
			}else {
				response.put("success", false);
				response.put("message", "Beneficial owner not found for the given track ID");
				return response; 
			}
		}
		beneficialOwnerDto.setBeneficialOwner(beneficialOwnerRepository.saveAll(beneficialOwners));
		response.put("success", true);
		response.put("beneficialOwner", beneficialOwnerDto.getBeneficialOwner());
		return response;
	}
	

	@PostMapping("submitterDetails")
	@ResponseBody
	@Transactional
	public Map<String, Object> saveFilingInfoStep5(@ModelAttribute SubmitterDetails submitterDetails) {
		submitterDetailsRepository.deleteByFilingInfoId(submitterDetails.getFilingInfoId());
		submitterDetails = submitterDetailsRepository.save(submitterDetails);
		Map<String, Object> response = new HashMap<>();
		response.put("success", true);
		response.put("submitterDetails", submitterDetails);
		response.put("filingInfo",
				filingInfoRepository.findByFilingInfoId(submitterDetails.getFilingInfoId()).orElse(new FilingInfo()));
		response.put("reportingCompany",
				reportingCompanyRepository.findByFilingInfoId(submitterDetails.getFilingInfoId()));
		response.put("companyApplicant",
				companyApplicantRepository.findByFilingInfoId(submitterDetails.getFilingInfoId()));
		response.put("beneficialOwner",
				beneficialOwnerRepository.findByFilingInfoId(submitterDetails.getFilingInfoId()));
		return response;
	}

	@PostMapping("submitBoir/{filingInfoId}")
	@ResponseBody
	//@Transactional
	public Map<String, Object> saveFilingInfoFinalStep(@PathVariable("filingInfoId") Long filingInfoId,
			@ModelAttribute BankReferal bankReferal) {
		Map<String, Object> response = new HashMap<>();
		// filingInfoId= 1526L;
		// API to be triggered here on submit get the response and set to response
		String url = boir;
		String processId = null;
		String boirId = null;
		String status = null;
		String fincenId = "";

		try {
			SubmitterDetails submitterDetails = submitterDetailsRepository.findByFilingInfoId(filingInfoId);

			BankReferal br = bankReferalRepository.findByFilingInfoId(filingInfoId);

			bankReferal.setEmail(submitterDetails.getEmail());
			bankReferal.setFirstName(submitterDetails.getFirstName());
			bankReferal.setLastName(submitterDetails.getLastName());

			/*
			 * if (br != null) { // bankReferalRepository.deleteById(br.getId());
			 * bankReferalRepository.save(bankReferal); } else { //
			 * bankReferal.setId(br.getId()); bankReferalRepository.save(bankReferal); }
			 */
			
			bankReferalRepository.save(bankReferal); 

			JSONObject requestObject = new JSONObject();
			requestObject.put("filingId", String.valueOf(filingInfoId));// 1013 1117 1122
			requestObject.put("env", env);// 1013 1117 1122
			// Creating the outer JSON object
			JSONObject outerObject = new JSONObject();
			outerObject.put("endpoint", "submit");
			outerObject.put("request", requestObject);
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject) parser.parse(wraperService.postDataResp(url, outerObject.toJSONString()));
			JSONObject data = (JSONObject) jsonObj.get("data");
			JSONObject submitObject = new JSONObject();
			submitObject.put("processId", (String) data.get("processId"));// 1013 1117 1122
			// Creating the outer JSON object
			JSONObject submitouterObject = new JSONObject();
			submitouterObject.put("endpoint", "submitstatus");
			submitouterObject.put("request", submitObject);
			JSONObject submitObj = null;
			JSONObject submitdata = null;
			outerLoop: // Label for the outer loop
			for (int i = 0; i < 100; i++) {
				submitObj = (JSONObject) parser
						.parse(wraperService.postDataResp(url, submitouterObject.toJSONString()));
				submitdata = (JSONObject) submitObj.get("data");
				if (submitdata.get("submissionStatus") != null
						&& (String) submitdata.get("submissionStatus").toString() != null
						&& submitdata.get("submissionStatus").toString().equals("submission_validation_failed")) {
					break outerLoop; // Exit both loops
				}
				if (submitdata.get("submissionStatus") != null
						&& (String) submitdata.get("submissionStatus").toString() != null
						&& submitdata.get("submissionStatus").toString().equals("submission_accepted")) {

					break outerLoop; // Exit both loops
				}
				if (submitdata.get("submissionStatus") != null
						&& (String) submitdata.get("submissionStatus").toString() != null
						&& submitdata.get("submissionStatus").toString().equals("submission_rejected")) {
					break outerLoop; // Exit both loops
				}
				if (submitdata.get("submissionStatus") != null
						&& (String) submitdata.get("submissionStatus").toString() != null
						&& submitdata.get("submissionStatus").toString().equals("submission_failed")) {
					break outerLoop; // Exit both loops
				}
				 
				try {
				    Thread.sleep(5000);
				} catch (InterruptedException e) {
				    Thread.currentThread().interrupt();
				}
			}

			response.put("processId", (String) data.get("processId"));
			processId = (String) data.get("processId");
			if (submitdata.get("submissionStatus") != null && (String) submitdata.get("submissionStatus") != null) {
				response.put("submissionStatus", (String) submitdata.get("submissionStatus"));
				status = (String) submitdata.get("submissionStatus");
			} else {
				response.put("submissionStatus", "Submission Status Failed");
			}
			if (submitdata.get("BOIRID") != null && submitdata.get("BOIRID").toString() != null) {
				response.put("boirid", submitdata.get("BOIRID").toString());
				boirId = submitdata.get("BOIRID").toString();
			} else {
				response.put("boirid", "BOIR Not Available");
			}
			if (submitdata.get("fincenID") != null && (String) submitdata.get("fincenID") != null) {
				response.put("fincenID", (String) submitdata.get("fincenID"));
				fincenId = (String) submitdata.get("fincenID");
			} else {
				response.put("fincenID", "Fincen Not Available");
			}
			Date currentDate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
			String formattedDate = dateFormat.format(currentDate);
			response.put("initiatedTimestamp", formattedDate);
			SubmitterDetails sd = submitterDetailsRepository.findByFilingInfoId(filingInfoId);
			response.put("firstName", sd.getFirstName());
			response.put("lastName", sd.getLastName());
			response.put("email", sd.getEmail());

			if (submitdata.get("submissionStatus") != null
					&& (String) submitdata.get("submissionStatus").toString() != null
					&& submitdata.get("submissionStatus").toString().equals("submission_accepted")) {
				// send success email and exit the loop by Ananth
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
				helper.setFrom(sender);
				helper.setTo(sd.getEmail());
				helper.setBcc("ananth@microgridtechsol.com");
				helper.setSubject("BOIR Form Submission Confirmation");
				helper.setText("<!DOCTYPE html>\r\n" + "<html lang=\"en\">\r\n" + "<head>\r\n"
						+ "    <meta charset=\"UTF-8\">\r\n"
						+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
						+ "    <title>BOIR Form Submission Confirmation</title>\r\n" + "    <style>\r\n"
						+ "        body {\r\n" + "            font-family: Arial, sans-serif;\r\n" + "        }\r\n"
						+ "        .email-container {\r\n" + "            background-color: #ffffff;\r\n"
						+ "            width: 100%;\r\n" + "            max-width: 600px;\r\n"
						+ "            margin: 0 auto;\r\n" + "            border-radius: 8px;\r\n"
						+ "            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\r\n"
						+ "            overflow: hidden;\r\n" + "        }\r\n" + "        .email-header {\r\n"
						+ "            background-color: #ffffff;\r\n" + "            color: #ffffff;\r\n"
						+ "            text-align: center;\r\n" + "            padding: 20px;\r\n" + "        }\r\n"
						+ "        .email-header img {\r\n" + "            max-width: 150px;\r\n" + "        }\r\n"
						+ "        .email-content {\r\n" + "            padding: 30px;\r\n"
						+ "            color: #333333;\r\n" + "            line-height: 1.6;\r\n" + "        }\r\n"
						+ "        .email-footer {\r\n" + "            background-color: #f4f4f4;\r\n"
						+ "            text-align: center;\r\n" + "            padding: 15px;\r\n"
						+ "            font-size: 12px;\r\n" + "            color: #666666;\r\n" + "        }\r\n"
						+ "        .email-footer a {\r\n" + "            color: #0073e6;\r\n"
						+ "            text-decoration: none;\r\n" + "        }\r\n" + "    </style>\r\n"
						+ "</head>\r\n" + "<body>\r\n" + "    <div class=\"email-container\">\r\n"
						+ "        <div class=\"email-header\">\r\n"
						+ "          <img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"Company Logo\">\r\n"
						+ "        </div>\r\n" + "        <div class=\"email-content\">\r\n"
						+ "            <h2>Confirmation of BOIR Form Submission</h2>\r\n" + "            <p>Dear "
						+ sd.getFirstName() + ",</p>\r\n"
						+ "            <p>Thank you for submitting your Beneficial Ownership Information Report (BOIR) through CTAHarbor. We have successfully received your submission</p>\r\n"
						+ "            <p><strong>Submission Details:</strong></p>\r\n" + "            <ul>\r\n"
						+ "                <li><strong>Beneficial Ownership Submission ID:</strong> " + processId
						+ "</li>\r\n" + "                <li><strong>Date of Submission:</strong> " + formattedDate
						+ "</li>\r\n"
						// + " <li><strong>Reporting Company:</strong> [Company Name]</li>\r\n"
						// + " <li><strong>Beneficial Owners Included:</strong> [Number of Beneficial
						// Owners]</li>\r\n"
						+ "                <li><strong>BOIR ID:</strong> " + boirId + "</li>\r\n"
						+ "                <li><strong>Fincen ID:</strong> " + fincenId + "</li>\r\n"
						+ "            </ul>\r\n"
						+ "            <p>Please note that the processing of your BOIR submission may take some time. If any additional information is required, our team will reach out to you using the contact details provided.</p>\r\n"
						+ "            <p>You can review the status of your submission at any time by logging into your account on <a href=\"https://www.ctaharbor.com\">CTAHarbor.com</a>.</p>\r\n"
						+ "            <p>If you have any questions or need further assistance, please don't hesitate to contact our support team at <a href=\"mailto:service@ctaharbor.com\">service@ctaharbor.com</a> or call us at +1 (888) 203-2246.</p>\r\n"
						+ "            <p>Thank you for choosing CTAHarbor for your reporting needs.</p>\r\n"
						+ "            <p>Best Regards,</p>\r\n"
						+ "            <p>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)\r\n"
						+ "<a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a></p>\r\n"
						+ "        </div>\r\n" + "        <div class=\"email-footer\">\r\n"
						+ "            <p>This email is for the intended recipient only. If you received this email in error, please delete it immediately and notify us.</p>\r\n"
						+ "        </div>\r\n" + "    </div>\r\n" + "</body>\r\n" + "</html>\r\n" + "", true);
				try {
					mailSender.send(message);
				} catch (Exception e) {
				}

				// end the logic

			}

			List<BeneficialOwner> beneficialOwner = beneficialOwnerRepository.findByFilingInfoId(filingInfoId);
			response.put("Beneficialowner", beneficialOwner);
			if (submitdata.get("validationErrors") != null && submitdata.get("validationErrors").toString() != null) {
				response.put("errordata", submitdata.get("validationErrors").toString());
			} else if (submitdata.get("errors") != null && submitdata.get("errors").toString() != null) {
				response.put("errordata", submitdata.get("errors").toString());
			} else {
				response.put("errordata", "No errors found");
			}

		} catch (Exception e) {
			e.printStackTrace();
			 e.printStackTrace(); // Prints full stack trace of the exception
			response.put("processId", "No Process ID");
			response.put("submissionStatus", "Exception");
			response.put("boirid", "Exception in response");
			response.put("fincenID", "Exception in response");
			response.put("initiatedTimestamp", "2024-08-13T04:43:48Z");
			response.put("firstName", "Raj");
			response.put("lastName", "Ananth");
			response.put("email", "ananth@microgridtechsol.com");
		}
		// ended

		Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(filingInfoId);
		if (filingInfo.isPresent()) {
			response.put("success", true);
			filingInfo.get().setStatus(status);
			filingInfo.get().setProcessId(processId);
			filingInfo.get().setBoirId(boirId);
			filingInfo.get().setFincenId(fincenId);
			filingInfoRepository.save(filingInfo.get());
		} else {
			response.put("success", false);
			response.put("status", "No Data Found for given key");
		}
		return response;
	}

	@GetMapping("filingInfo/{id}")
	@ResponseBody
	public Map<String, Object> getFilingInfoById(@PathVariable("id") Long id) {
		Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(id);
		Map<String, Object> response = new HashMap<>();
		if (filingInfo.isPresent()) {
			response.put("success", true);
			response.put("filingInfo", filingInfo);
			response.put("reportingCompany", reportingCompanyRepository.findByFilingInfoId(id));
			response.put("companyApplicant", companyApplicantRepository.findByFilingInfoId(id));
			response.put("beneficialOwner", beneficialOwnerRepository.findByFilingInfoId(id));
			response.put("submitterDetails", submitterDetailsRepository.findByFilingInfoId(id));
			try {
			response.put("bankReferal", bankReferalRepository.findByFilingInfoId(id));
			}catch(Exception ex) {}
		} else {
			response.put("success", false);
			response.put("status", "No Data Found for given key");
		}

		return response;
	}

	@GetMapping("/transcript/{id}")
	public ResponseEntity<ByteArrayResource> getTranscript(@PathVariable Long id, Model model) {
		//Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		//String principalName = "";
		String url = boir;
		JSONObject requestObject = new JSONObject();
		requestObject.put("filingId", id.toString());
		// Creating the outer JSON object
		JSONObject outerObject = new JSONObject();
		outerObject.put("endpoint", "transcript");
		outerObject.put("request", requestObject);
		// wraperService.postDataResp(url, outerObject.toJSONString());
		byte[] decodedPdfBytes = null;

		try {
			// Parse JSON using net.minidev.json.parser.JSONParser
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject) parser.parse(wraperService.postDataResp(url, outerObject.toJSONString()));
			JSONObject data = new JSONObject();
			try {
			// Navigate through the JSON structure to get the pdfBinary value
			  data = (JSONObject)((JSONArray) jsonObj.get("data")).get(0);
			}catch (Exception e) {
			}
			String pdfBinary = null;
			if (data != null && data.get("pdfBinary") != null && (String) data.get("pdfBinary") != null) {
				pdfBinary = (String) data.get("pdfBinary");
			} else {
				pdfBinary = "JVBERi0xLjQKJeLjz9MKMyAwIG9iaiA8PC9MZW5ndGggNDEzMS9GaWx0ZXIvRmxhdGVEZWNvZGU+P"
						+ "gpcW1QKc3RyZWFtCmjuoyjFqyDQDsv/Z";
			}
			// Decode the Base64 string to byte array
			decodedPdfBytes = Base64.getDecoder().decode(pdfBinary);

			// Save the decoded bytes to a PDF file
			try (FileOutputStream fos = new FileOutputStream("output.pdf")) {
				fos.write(decodedPdfBytes);
			} catch (IOException e) {
				e.printStackTrace();
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}

		try (FileOutputStream fos = new FileOutputStream("output.pdf")) {
			fos.write(decodedPdfBytes);
		} catch (IOException e) {
			e.printStackTrace();
		}

		if (decodedPdfBytes == null || decodedPdfBytes.length == 0) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
		}
		Optional<FilingInfo> filingInfo =filingInfoRepository.findByFilingInfoId(id);
		// Prepare HTTP headers for PDF response
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_PDF);
		ReportingCompany reportingCompany = reportingCompanyRepository.findByFilingInfoId(id);
		if(reportingCompany!=null) {
		headers.setContentDispositionFormData("attachment", "FinCEN_Filed BOIR Transcript_"
				+ reportingCompany.getReportingCompanyLegalName() + "_CTAHarbor" + ".pdf");
		}else if(filingInfo.isPresent()){
			headers.setContentDispositionFormData("attachment", "FinCEN_Filed BOIR Transcript_"
					+ filingInfo.get().getLegalName() + "_CTAHarbor" + ".pdf");
		}
		// Create the ByteArrayResource
		ByteArrayResource resource = new ByteArrayResource(decodedPdfBytes);

		// Return the ResponseEntity with the PDF data
		return ResponseEntity.ok().headers(headers).contentLength(decodedPdfBytes.length).body(resource);

	}

	@GetMapping("updatefilingInfo/{id}")
	@ResponseBody
	public Map<String, Object> getDuplicateBoirRecords(@PathVariable("id") Long id) {

		Map<String, Object> response = new HashMap<>();
		List<FilingInfo> filingInfoList = filingInfoRepository.checkCorrectionFiling(id); // for modify submited records
																							// check

		if (filingInfoList.isEmpty()) {

			Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(id);
			// duplicate the record and modify
			if (filingInfo.isPresent() && (filingInfo.get().getStatus().equalsIgnoreCase("submission_validation_failed")
					|| filingInfo.get().getStatus().equalsIgnoreCase("submission_accepted")
					|| filingInfo.get().getStatus().equalsIgnoreCase("submission_rejected"))) {
				FilingInfo filingInfoObj = filingInfo.get();
				FilingInfo correctedFilingInfo = new FilingInfo();
				correctedFilingInfo.setDatePrepared(filingInfoObj.getDatePrepared());
				correctedFilingInfo.setUserId(filingInfoObj.getUserId());
				correctedFilingInfo.setFilingType(filingInfoObj.getFilingType());
				correctedFilingInfo.setStatus("In Progress");
				correctedFilingInfo.setLegalName(filingInfoObj.getLegalName());
				correctedFilingInfo.setTaxIdType(filingInfoObj.getTaxIdType());
				correctedFilingInfo.setTaxIdNum(filingInfoObj.getTaxIdNum());
				correctedFilingInfo.setCountryOrJurisdiction(filingInfoObj.getCountryOrJurisdiction());
				correctedFilingInfo.setProcessId(filingInfoObj.getProcessId());
				correctedFilingInfo.setBoirId(filingInfoObj.getBoirId());
				correctedFilingInfo.setFincenId(filingInfoObj.getFincenId());
				correctedFilingInfo.setCurrentStatus("correction");
				correctedFilingInfo.setPrevSubmissionStatus(filingInfoObj.getStatus());
				if(filingInfoObj!=null && filingInfoObj.getParentFilingInfoId()!=null && filingInfoObj.getParentFilingInfoId()>0) {
				  correctedFilingInfo.setParentFilingInfoId(filingInfoObj.getParentFilingInfoId());
				}else {
				   correctedFilingInfo.setParentFilingInfoId(filingInfoObj.getFilingInfoId());	
				}
				correctedFilingInfo = filingInfoRepository.save(correctedFilingInfo);

				CompanyApplicant companyApplicant = companyApplicantRepository.findByFilingInfoId(id);
				CompanyApplicant duplicateCompanyApplicant = new CompanyApplicant();
				if (companyApplicant != null) {
					duplicateCompanyApplicant = duplicateCompanyApplicant(companyApplicant,
							correctedFilingInfo.getFilingInfoId());
					duplicateCompanyApplicant = companyApplicantRepository.save(duplicateCompanyApplicant);
				}

				ReportingCompany reportingCompany = reportingCompanyRepository.findByFilingInfoId(id);
				ReportingCompany duplicateReportingCompany = new ReportingCompany();
				if (reportingCompany != null) {
					duplicateReportingCompany = duplicateReportingCompany(reportingCompany,
							correctedFilingInfo.getFilingInfoId());
					duplicateReportingCompany = reportingCompanyRepository.save(duplicateReportingCompany);
				}

				List<BeneficialOwner> beneficialOwnerList = beneficialOwnerRepository.findByFilingInfoId(id);
				List<BeneficialOwner> duplicateBeneficialOwnerList = new ArrayList<>();
				if (!beneficialOwnerList.isEmpty()) {
					duplicateBeneficialOwnerList = duplicateBeneficialOwners(beneficialOwnerList,
							correctedFilingInfo.getFilingInfoId());
					duplicateBeneficialOwnerList = beneficialOwnerRepository.saveAll(duplicateBeneficialOwnerList);
				}
				SubmitterDetails submitterDetailsObj = submitterDetailsRepository.findByFilingInfoId(id);
				SubmitterDetails duplicateSubmitterDetails = new SubmitterDetails();
				if (submitterDetailsObj != null) {
					duplicateSubmitterDetails.setEmail(submitterDetailsObj.getEmail());
					duplicateSubmitterDetails.setFirstName(submitterDetailsObj.getFirstName());
					duplicateSubmitterDetails.setLastName(submitterDetailsObj.getLastName());
					duplicateSubmitterDetails.setFilingInfoId(correctedFilingInfo.getFilingInfoId());
					duplicateSubmitterDetails = submitterDetailsRepository.save(duplicateSubmitterDetails);
				}
				response.put("success", true);
				response.put("filingInfo", correctedFilingInfo);
				response.put("companyApplicant", duplicateCompanyApplicant);
				response.put("reportingCompany", duplicateReportingCompany);
				response.put("beneficialOwner", duplicateBeneficialOwnerList);
				response.put("submitterDetails", duplicateSubmitterDetails);
			} else if(filingInfo.isPresent()) { // edit in progress
				response.put("success", true);
				response.put("filingInfo", filingInfo.get());
				response.put("reportingCompany",
						reportingCompanyRepository.findByFilingInfoId(filingInfo.get().getFilingInfoId()));
				response.put("companyApplicant",
						companyApplicantRepository.findByFilingInfoId(filingInfo.get().getFilingInfoId()));
				response.put("beneficialOwner",
						beneficialOwnerRepository.findByFilingInfoId(filingInfo.get().getFilingInfoId()));
				response.put("submitterDetails",
						submitterDetailsRepository.findByFilingInfoId(filingInfo.get().getFilingInfoId()));
			}

		} else { // modify record which alredy duplicated
			FilingInfo filingInfo = filingInfoList.get(0);
			response.put("success", true);
			response.put("filingInfo", filingInfo);
			response.put("reportingCompany",
					reportingCompanyRepository.findByFilingInfoId(filingInfo.getFilingInfoId()));
			response.put("companyApplicant",
					companyApplicantRepository.findByFilingInfoId(filingInfo.getFilingInfoId()));
			response.put("beneficialOwner", beneficialOwnerRepository.findByFilingInfoId(filingInfo.getFilingInfoId()));
			response.put("submitterDetails",
					submitterDetailsRepository.findByFilingInfoId(filingInfo.getFilingInfoId()));

		}
		return response;
	}

	public CompanyApplicant duplicateCompanyApplicant(CompanyApplicant companyApplicant, Long filingInfoId) {
		CompanyApplicant duplicateCompanyApplicant = new CompanyApplicant();
		duplicateCompanyApplicant.setFilingInfoId(filingInfoId);
		duplicateCompanyApplicant.setExistingRepoCompany(companyApplicant.getExistingRepoCompany());

		// Duplicate the company applicant info
		List<CompanyApplicantInfo> duplicateCompanyApplicantInfo = new ArrayList<>();
		for (CompanyApplicantInfo companyApplicantInfo : companyApplicant.getCompanyApplicantInfo()) {
			CompanyApplicantInfo duplicateCompanyApplicantInfoItem = new CompanyApplicantInfo();
			duplicateCompanyApplicantInfoItem.setFinCenId(companyApplicantInfo.getFinCenId());
			duplicateCompanyApplicantInfoItem.setIndividualsLastName(companyApplicantInfo.getIndividualsLastName());
			duplicateCompanyApplicantInfoItem.setFirstName(companyApplicantInfo.getFirstName());
			duplicateCompanyApplicantInfoItem.setMiddleName(companyApplicantInfo.getMiddleName());
			duplicateCompanyApplicantInfoItem.setSuffix(companyApplicantInfo.getSuffix());
			duplicateCompanyApplicantInfoItem.setDateOfBirth(companyApplicantInfo.getDateOfBirth());

			// Duplicate the address
			Address duplicateAddress = new Address();
			if (companyApplicantInfo.getAddress() != null) {
				duplicateAddress.setAddress(companyApplicantInfo.getAddress().getAddress());
				duplicateAddress.setAddressType(companyApplicantInfo.getAddress().getAddressType());
				duplicateAddress.setCity(companyApplicantInfo.getAddress().getCity());
				duplicateAddress.setCountry(companyApplicantInfo.getAddress().getCountry());
				duplicateAddress.setPostalCode(companyApplicantInfo.getAddress().getPostalCode());
				duplicateAddress.setState(companyApplicantInfo.getAddress().getState());
				duplicateCompanyApplicantInfoItem.setAddress(duplicateAddress);
			}
			// Duplicate the identification documents
			IdentificationDocument duplicateIdentificationDocument = new IdentificationDocument();
			if (companyApplicantInfo.getIdentificationDocuments() != null) {
				duplicateIdentificationDocument
						.setDocumentName(companyApplicantInfo.getIdentificationDocuments().getDocumentName());
				duplicateIdentificationDocument
						.setDocumentNumber(companyApplicantInfo.getIdentificationDocuments().getDocumentNumber());
				duplicateIdentificationDocument
						.setDocumentPath(companyApplicantInfo.getIdentificationDocuments().getDocumentPath());
				duplicateIdentificationDocument
						.setDocumentType(companyApplicantInfo.getIdentificationDocuments().getDocumentType());
				duplicateIdentificationDocument
						.setIssuerCountry(companyApplicantInfo.getIdentificationDocuments().getIssuerCountry());
				duplicateIdentificationDocument.setIssuerLocalOrTribal(
						companyApplicantInfo.getIdentificationDocuments().getIssuerLocalOrTribal());
				duplicateIdentificationDocument
						.setIssuerState(companyApplicantInfo.getIdentificationDocuments().getIssuerState());
				duplicateIdentificationDocument
						.setOtherLocalDesc(companyApplicantInfo.getIdentificationDocuments().getOtherLocalDesc());
				duplicateCompanyApplicantInfoItem.setIdentificationDocuments(duplicateIdentificationDocument);
			}
			duplicateCompanyApplicantInfo.add(duplicateCompanyApplicantInfoItem);
		}
		duplicateCompanyApplicant.setCompanyApplicantInfo(duplicateCompanyApplicantInfo);
		return duplicateCompanyApplicant;
	}

	public ReportingCompany duplicateReportingCompany(ReportingCompany reportingCompany, Long filingInfoId) {

		ReportingCompany duplicateReportingCompany = new ReportingCompany();
		duplicateReportingCompany.setFilingInfoId(filingInfoId);
		duplicateReportingCompany.setRequestToReceiveFinCenId(reportingCompany.getRequestToReceiveFinCenId());
		duplicateReportingCompany
				.setForeignPooledInvestmentVehicle(reportingCompany.getForeignPooledInvestmentVehicle());
		duplicateReportingCompany
				.setForeignPooledInvestmentVehicle2(reportingCompany.getForeignPooledInvestmentVehicle2());
		duplicateReportingCompany.setReportingCompanyLegalName(reportingCompany.getReportingCompanyLegalName());
		duplicateReportingCompany.setTaxIdentificationType(reportingCompany.getTaxIdentificationType());
		duplicateReportingCompany.setTaxIdentificationNumber(reportingCompany.getTaxIdentificationNumber());
		duplicateReportingCompany.setCountryOrJurisdictionRep(reportingCompany.getCountryOrJurisdictionRep());
		duplicateReportingCompany
				.setCountryOrJurisdictionFormation(reportingCompany.getCountryOrJurisdictionFormation());
		duplicateReportingCompany.setStateFormation(reportingCompany.getStateFormation());
		duplicateReportingCompany.setTribalJurisdictionFormation(reportingCompany.getTribalJurisdictionFormation());
		duplicateReportingCompany.setOtherTribeFormation(reportingCompany.getOtherTribeFormation());
		duplicateReportingCompany.setStateFirstRegistration(reportingCompany.getStateFirstRegistration());
		duplicateReportingCompany
				.setTribalJurisdictionFirstRegistration(reportingCompany.getTribalJurisdictionFirstRegistration());
		duplicateReportingCompany.setOtherTribeFirstRegistration(reportingCompany.getOtherTribeFirstRegistration());
		duplicateReportingCompany.setDateOfIncorporation(reportingCompany.getDateOfIncorporation());

		// Duplicate the reporting address
		Address duplicateReportingAddress = new Address();
		if (reportingCompany.getReportingAddress() != null) {
			duplicateReportingAddress.setAddress(reportingCompany.getReportingAddress().getAddress());
			duplicateReportingAddress.setAddressType(reportingCompany.getReportingAddress().getAddressType());
			duplicateReportingAddress.setCity(reportingCompany.getReportingAddress().getCity());
			duplicateReportingAddress.setCountry(reportingCompany.getReportingAddress().getCountry());
			duplicateReportingAddress.setPostalCode(reportingCompany.getReportingAddress().getPostalCode());
			duplicateReportingAddress.setState(reportingCompany.getReportingAddress().getState());
			duplicateReportingCompany.setReportingAddress(duplicateReportingAddress);
		}
		// Duplicate the alternate names
		List<AlternateName> duplicateAlternateNames = new ArrayList<>();
		if (reportingCompany.getAlternateName() != null && !reportingCompany.getAlternateName().isEmpty()) {
			for (AlternateName alternateName : reportingCompany.getAlternateName()) {
				AlternateName duplicateAlternateName = new AlternateName();
				duplicateAlternateName.setName(alternateName.getName());
				duplicateAlternateNames.add(duplicateAlternateName);
			}
		}
		duplicateReportingCompany.setAlternateName(duplicateAlternateNames);
		return duplicateReportingCompany;
	}

	public List<BeneficialOwner> duplicateBeneficialOwners(List<BeneficialOwner> beneficialOwners, Long filingInfoId) {
		List<BeneficialOwner> duplicateBeneficialOwners = new ArrayList<>();
		for (BeneficialOwner beneficialOwner : beneficialOwners) {
			BeneficialOwner duplicateBeneficialOwner = new BeneficialOwner();
			duplicateBeneficialOwner.setFilingInfoId(filingInfoId);
			duplicateBeneficialOwner.setIsMinorChild(beneficialOwner.getIsMinorChild());
			duplicateBeneficialOwner.setFinCenId(beneficialOwner.getFinCenId());
			duplicateBeneficialOwner.setExemptEntity(beneficialOwner.getExemptEntity());
			duplicateBeneficialOwner.setLegalName(beneficialOwner.getLegalName());
			duplicateBeneficialOwner.setFirstName(beneficialOwner.getFirstName());
			duplicateBeneficialOwner.setFlegalName(beneficialOwner.getFlegalName());
			duplicateBeneficialOwner.setFfirstName(beneficialOwner.getFfirstName());
			duplicateBeneficialOwner.setMiddleName(beneficialOwner.getMiddleName());
			duplicateBeneficialOwner.setSuffix(beneficialOwner.getSuffix());
			duplicateBeneficialOwner.setDateOfBirth(beneficialOwner.getDateOfBirth());
			duplicateBeneficialOwner.setBeneficialStatus("");
			duplicateBeneficialOwner.setBeneficialTrackId("");
			duplicateBeneficialOwner.setBenficialEmail("");
			duplicateBeneficialOwner.setBenficialEmailSentDate("");
			// Duplicate the address
			Address duplicateAddress = new Address();
			if (beneficialOwner.getAddress() != null) {
				duplicateAddress.setAddress(beneficialOwner.getAddress().getAddress());
				duplicateAddress.setAddressType(beneficialOwner.getAddress().getAddressType());
				duplicateAddress.setCity(beneficialOwner.getAddress().getCity());
				duplicateAddress.setCountry(beneficialOwner.getAddress().getCountry());
				duplicateAddress.setPostalCode(beneficialOwner.getAddress().getPostalCode());
				duplicateAddress.setState(beneficialOwner.getAddress().getState());
				duplicateBeneficialOwner.setAddress(duplicateAddress);
			}
			// Duplicate the identification documents
			IdentificationDocument duplicateIdentificationDocument = new IdentificationDocument();
			if (beneficialOwner.getIdentificationDocuments() != null) {
				duplicateIdentificationDocument
						.setDocumentName(beneficialOwner.getIdentificationDocuments().getDocumentName());
				duplicateIdentificationDocument
						.setDocumentNumber(beneficialOwner.getIdentificationDocuments().getDocumentNumber());
				duplicateIdentificationDocument
						.setDocumentPath(beneficialOwner.getIdentificationDocuments().getDocumentPath());
				duplicateIdentificationDocument
						.setDocumentType(beneficialOwner.getIdentificationDocuments().getDocumentType());
				duplicateIdentificationDocument
						.setIssuerCountry(beneficialOwner.getIdentificationDocuments().getIssuerCountry());
				duplicateIdentificationDocument
						.setIssuerLocalOrTribal(beneficialOwner.getIdentificationDocuments().getIssuerLocalOrTribal());
				duplicateIdentificationDocument
						.setIssuerState(beneficialOwner.getIdentificationDocuments().getIssuerState());
				duplicateIdentificationDocument
						.setOtherLocalDesc(beneficialOwner.getIdentificationDocuments().getOtherLocalDesc());
				duplicateBeneficialOwner.setIdentificationDocuments(duplicateIdentificationDocument);
			}
			duplicateBeneficialOwners.add(duplicateBeneficialOwner);
		}
		return duplicateBeneficialOwners;
	}

}
