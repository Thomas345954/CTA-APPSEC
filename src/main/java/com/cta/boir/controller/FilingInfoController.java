package com.cta.boir.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cta.boir.model.BeneficialOwner;
import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.User;
import com.cta.boir.repository.BeneficialOwnerRepository;
import com.cta.boir.repository.CompanyApplicantRepository;
import com.cta.boir.repository.FilingInfoRepository;
import com.cta.boir.repository.ReportingCompanyRepository;
import com.cta.boir.service.CustomEntityService;
import com.cta.boir.service.FillingService;
import com.cta.boir.service.UserService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Controller
public class FilingInfoController {
	@Autowired
	private FillingService fillingService;
	@Autowired
	private UserService us;
	@Autowired
	private CustomEntityService entityService;

	@Autowired
	private JavaMailSender mailSender;
	@Value("${benificialDomain}")
	private String benificialDomain;
	@Value("${spring.mail.username}")
	private String sender;

	private final FilingInfoRepository filingInfoRepository;
	private final BeneficialOwnerRepository beneficialOwnerRepository;
	private final CompanyApplicantRepository companyApplicantRepository;
	private final ReportingCompanyRepository reportingCompanyRepository;

	public FilingInfoController(FilingInfoRepository filingInfoRepository,
			BeneficialOwnerRepository beneficialOwnerRepository, CompanyApplicantRepository companyApplicantRepository,
			ReportingCompanyRepository reportingCompanyRepository) {
		this.filingInfoRepository = filingInfoRepository;
		this.beneficialOwnerRepository = beneficialOwnerRepository;
		this.companyApplicantRepository = companyApplicantRepository;
		this.reportingCompanyRepository = reportingCompanyRepository;
	}

	@GetMapping("/inprogress")
	public String getFilingInfo(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String principalName = "";
		if (authentication != null) {
			principalName = authentication.getName();
		}
		User uservo = us.findByEmail(principalName);
		List<Map<String, Object>> filingdata = entityService.getDynamicQueryResults(
				"SELECT a.*, b.reporting_company_legal_name AS companyname, b.tax_identification_number AS taxidnum, \r\n"
						+ "a.filing_info_id AS filinginfoid, \r\n"
						+ "b.reporting_company_id AS reportingcompanyid, \r\n"
						+ "c.company_applicant_id AS applicantid, \r\n"
						+ "d.beneficial_owner_id AS ownerid, d.benficial_email_sent_date AS benemailsentdate, \r\n"
						+ "e.submitter_id AS submitterid \r\n" + "FROM public.filing_info a \r\n"
						+ "LEFT JOIN public.reporting_company b ON a.filing_info_id = b.filing_info_id \r\n"
						+ "LEFT JOIN public.company_applicant c ON a.filing_info_id = c.filing_info_id \r\n"
						+ "LEFT JOIN public.beneficial_owner d ON a.filing_info_id = d.filing_info_id \r\n"
						+ "LEFT JOIN public.submitter_details e ON a.filing_info_id = e.filing_info_id \r\n"
						+ "WHERE a.status NOT IN ('submission_validation_failed', 'submission_accepted', 'submission_rejected') \r\n"
						+ "AND a.user_id = '" + uservo.getId() + "' \r\n" + "ORDER BY a.date_prepared DESC",
				null);
		List<FilingInfo> filingInfo = fillingService.convertToFilingInfo(filingdata);
		model.addAttribute("filingInfo", filingInfo);
		model.addAttribute("principalName", principalName);
		return "inprogresslist";
	}

	@GetMapping("/insubmit")
	public String getFilingList(Model model, Long id) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String principalName = "";
		if (authentication != null) {
			principalName = authentication.getName();
		}
		User uservo = us.findByEmail(principalName);
		List<Map<String, Object>> filingdata = entityService.getDynamicQueryResults(
				"SELECT a.*, b.reporting_company_legal_name as companyname, b.tax_identification_number as taxidnum\r\n"
						+ "FROM public.filing_info a\r\n" + "INNER JOIN public.reporting_company b \r\n"
						+ "ON a.filing_info_id = b.filing_info_id \r\n"
						+ "WHERE a.status in ('submission_validation_failed','submission_accepted','submission_rejected') and a.user_id = '"
						+ uservo.getId() + "' order by a.date_prepared desc",
				null);
		List<FilingInfo> filingInfo = fillingService.convertToFilingInfo(filingdata);
		/*
		 * for (FilingInfo data : filingInfo) { int count = 0; count++; }
		 */
		model.addAttribute("filingInfo", filingInfo);
		model.addAttribute("principalName", principalName);
		return "submitlist";
	}

	@GetMapping("/getBeneficalDetails/{id}")
	@ResponseBody
	public Map<String, Object> getBeneficialDetails(@PathVariable("id") Long id) {
		Map<String, Object> response = new HashMap<>();
		List<BeneficialOwner> beneficialOwnerList = beneficialOwnerRepository.findByFilingInfoId(id);
		response.put("beneficialOwnerList", beneficialOwnerList);
		return response;
	}

	@PostMapping("/manualBeneficialFormRemainder")
	public ResponseEntity<String> manualBeneficialFormRemainder(@RequestParam String email, @RequestParam Long id)
			throws MessagingException {
		List<Map<String, Object>> beneficialdata = entityService.getDynamicQueryResults(
				"select ben.*, r.reporting_company_legal_name AS companyname \r\n"
						+ "from public.beneficial_owner ben\r\n"
						+ "join public.reporting_company r on ben.filing_info_id = r.filing_info_id\r\n"
						+ "where benficial_email = '" + email + "' and ben.filing_info_id = '" + id + "'\r\n" + "",
				null);
		List<BeneficialOwner> beneficialOwner = fillingService.convertToBeneficialInfo(beneficialdata);
		if (beneficialOwner.isEmpty()) {
			return ResponseEntity.ok("Data is empty");
		}
		for (int i = 0; i < beneficialOwner.size(); i++) {

			String beneficialCompanyName = beneficialOwner.get(i).getSuffix();

			// System.out.println(beneficialOwner.get(i));
			String trackId = beneficialOwner.get(i).getBeneficialTrackId(); // Get tracking id from db
			String url = benificialDomain + "?trackingid=" + trackId; // URL which will used to navigate beneficialOwner
																		// form
			String creatorEmail = beneficialOwner.get(i).getCreatedBy();
			User user = us.findByEmail(creatorEmail);
			String benEmail = beneficialOwner.get(i).getBenficialEmail();

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(sender);
			helper.setTo(benEmail);
			helper.setBcc("ananth@microgridtechsol.com");
			helper.setSubject("Action Needed: Start Your Beneficial Ownership Form for" + beneficialCompanyName);
			helper.setText("<!DOCTYPE html>\r\n" + "<html lang=\"en\">\r\n" + "<head>\r\n"
					+ "  <meta charset=\"UTF-8\">\r\n"
					+ "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
					+ "  <title>CTAHarbor - Start Your Beneficial Ownership Form</title>\r\n" + "  <style>\r\n"
					+ "    body {\r\n" + "      font-family: Arial, sans-serif;\r\n" + "      margin: 0;\r\n"
					+ "      padding: 20px;\r\n" + "    }\r\n" + "    h2 {\r\n" + "      font-size: 20px;\r\n"
					+ "      margin-bottom: 10px;\r\n" + "    }\r\n" + "    p {\r\n" + "      line-height: 1.5;\r\n"
					+ "    }\r\n" + "    a {\r\n" + "      text-decoration: none;\r\n" + "     color: #fff;\r\n"
					+ "    }\r\n" + "    .header img {\r\n" + "     max-width: 150px;\r\n" + "    }\r\n"
					+ "    .btn-four {\r\n" + "     padding: 10px 20px;\r\n" + "     border-radius: 20px;\r\n"
					+ "     background: #003B6A;\r\n" + "     color: #fff;\r\n" + "    }\r\n"
					+ "    .btn-four:hover {\r\n" + "     background: #B31942;\r\n" + "     color: #fff;\r\n"
					+ "    }\r\n" + "    .unsub {\r\n" + "     color: #008EFF;\r\n" + "     font-weight: 500px;\r\n"
					+ "     font-size: 14px;\r\n" + "    }\r\n" + "    .unsub:hover {\r\n"
					+ "     text-decoration: underline;\r\n" + "    }\r\n" + "  </style>\r\n" + "	</head>\r\n"
					+ "	<body>\r\n" + " <div class=\"header\">\r\n"
					+ " <center><img src='https://micassets.micnxt.com/CTA/CTA-logo.png' alt=\"CTA Harbor Logo\" /></center>\r\n"
					+ " </div>\r\n" + "  <h2 style=\"color:#003B6A;\">Hi " + benEmail + ",</h2>\r\n"
					+ "  <p style=\"color:#003B6A;\"> " + user.getName()
					+ " has requested that you complete the Beneficial Ownership Information for "
					+ beneficialCompanyName + ". We noticed you haven’t started the form yet."
					+ ". Your submission is important to finalize the report.</p>\r\n"
					+ "  <p style=\"color:#003B6A;\"><strong>Please click the link below to complete your form:</strong></p>\r\n"
					+ "	 <a style=\"border-width:0px; background-color:#003B6A; color:#FFFFFF !important; border-radius:20px; padding:10px;\" href=\""
					+ url + "\" style=\"color:#FFFFFF;text-decoration:none;\">Complete Your Information</a>"
					+ "  <p style=\"color:#003B6A;\">Thank you for your prompt attention.</p>\r\n"
					+ "  <p>Best regards,</p>\r\n"
					+ "  <p><br>BOIR Filing Team<br>CTAHarbor (a d.b.a. of New York Business Advisory & Corporate Services Inc.)<br><a href=\"https://www.ctaharbor.com\">www.ctaharbor.com</a>\r\n"
					+ "  <p><a href=\"mailto:support@ctaharbor.com\">support@ctaharbor.com</a></p>\r\n" + "</body>\r\n"
					+ "</html>", true);
			try {
				mailSender.send(message);
			} catch (Exception e) {
			}
		}
		return ResponseEntity.ok("Mail sent");
	}

}
