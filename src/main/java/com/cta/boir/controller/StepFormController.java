package com.cta.boir.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.cta.boir.model.BeneficialOwner;
import com.cta.boir.model.CompanyApplicant;
import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.ReportingCompany;
import com.cta.boir.model.SubmitterDetails;
import com.cta.boir.model.User;
import com.cta.boir.repository.BeneficialOwnerRepository;
import com.cta.boir.repository.CompanyApplicantRepository;
import com.cta.boir.repository.FilingInfoRepository;
import com.cta.boir.repository.ReportingCompanyRepository;
import com.cta.boir.repository.SubmitterDetailsRepository;
import com.cta.boir.service.FillingService;
import com.cta.boir.service.PaymentHistoryService;
import com.cta.boir.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.server.PathParam;

@Controller
public class StepFormController {

	private final FilingInfoRepository filingInfoRepository;
	private final BeneficialOwnerRepository beneficialOwnerRepository;
	private final CompanyApplicantRepository companyApplicantRepository;
	private final ReportingCompanyRepository reportingCompanyRepository;
	private final SubmitterDetailsRepository submitterDetailsRepository;
	@Autowired
	private PaymentHistoryService phs;
	@Autowired
	private UserService us;
	@Autowired
	private FillingService fs;

	public StepFormController(FilingInfoRepository filingInfoRepository,
			BeneficialOwnerRepository beneficialOwnerRepository, CompanyApplicantRepository companyApplicantRepository,
			ReportingCompanyRepository reportingCompanyRepository,
			SubmitterDetailsRepository submitterDetailsRepository) {
		this.filingInfoRepository = filingInfoRepository;
		this.beneficialOwnerRepository = beneficialOwnerRepository;
		this.companyApplicantRepository = companyApplicantRepository;
		this.reportingCompanyRepository = reportingCompanyRepository;
		this.submitterDetailsRepository = submitterDetailsRepository;
	}

	@GetMapping("/boirfiling")
	public String getStepForm(@PathParam("filingInfoId") Long filingInfoId, Model model, HttpSession fileCountSession) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String principalName = "";
		if (authentication != null) {
			principalName = authentication.getName();
		}
		User uservo = us.findByEmail(principalName);
		List<PaymentHistory> phvo = phs.wherePaymentHistoryByUser(String.valueOf(uservo.getEmail()));
		int totalboirFiles = 0;
		for (PaymentHistory ph : phvo) {
			if (ph.getNofiles() != null)
				totalboirFiles += Double.parseDouble(ph.getNofiles());
		}
		List<FilingInfo> fillingvo = fs.checkFilingAvalability(String.valueOf(uservo.getId()));
		fileCountSession.setAttribute("totalFiles", totalboirFiles);
		fileCountSession.setAttribute("filesFilled", fillingvo.size());
		fileCountSession.setAttribute("Pending", totalboirFiles - fillingvo.size());
		Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(filingInfoId);

		boolean flag = false;
		if (totalboirFiles - fillingvo.size() <= 0) {
			flag = true;
		}
		if (!filingInfo.isEmpty()) {
			if (filingInfo.get().getStatus() != null && (filingInfo.get().getStatus().equals("submission_accepted")
					|| filingInfo.get().getStatus().equals("submission_rejected")
					|| filingInfo.get().getStatus().equals("submission_validation_failed"))) {
				flag = false;
			} else {
				if (totalboirFiles - fillingvo.size() <= 0) {
					flag = true;
				}
			}
		}

		if (!filingInfo.isEmpty() && filingInfo.get() != null && filingInfo.get().getCurrentStatus() != null
				&& filingInfo.get().getCurrentStatus().equals("correction")) {
			flag = false;
		}

		if (flag) {
			return "redirect:/pricing";
		}
//		boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
//			isAuthenticated = authentication.isAuthenticated();
			model.addAttribute("isAuthenticated", true);

			User user = us.findByEmail(principalName);
			model.addAttribute("image", user.getImage());
		}
		if (filingInfoId == null) {
			FilingInfo filingInfonew = new FilingInfo();
			model.addAttribute("filingInfo", filingInfonew);
			model.addAttribute("step", "1");
		} else {
			try {
				if (filingInfo.get().getCreatedBy().equals(principalName)) {
					if (filingInfo.isPresent()) {
						model.addAttribute("filingInfo", filingInfo.get());
						model.addAttribute("step", "2");
						ReportingCompany reportingCompany = new ReportingCompany();
						try {
							reportingCompany = reportingCompanyRepository.findByFilingInfoId(filingInfoId);
						} catch (Exception ex) {
						}
						if (reportingCompany != null) {
							model.addAttribute("reportingCompany", reportingCompany);
							model.addAttribute("step", "3");
						}
						CompanyApplicant companyApplicant = new CompanyApplicant();
						try {
							companyApplicant = companyApplicantRepository.findByFilingInfoId(filingInfoId);
						} catch (Exception ex) {
						}
						if (companyApplicant != null) {
							model.addAttribute("companyApplicant", companyApplicant);
							model.addAttribute("step", "4");
						}
						List<BeneficialOwner> beneficialOwners = new ArrayList();
						try {
							beneficialOwners = beneficialOwnerRepository.findByFilingInfoId(filingInfoId);
						} catch (Exception ex) {
						}
						if (beneficialOwners != null && !beneficialOwners.isEmpty()) {
							model.addAttribute("beneficialOwners", beneficialOwners);
							model.addAttribute("step", "4");
						}
	
						SubmitterDetails submitterDetails = new SubmitterDetails();
						try {
							submitterDetails = submitterDetailsRepository.findByFilingInfoId(filingInfoId);
						} catch (Exception e) {
							// TODO: handle exception
						}
						if (submitterDetails != null) {
							model.addAttribute("submitterDetails", submitterDetails);
							model.addAttribute("step", "4");
						}
	
						if (filingInfo.get().getStatus() != null
								&& (filingInfo.get().getStatus().equals("submission_accepted")
										|| filingInfo.get().getStatus().equals("submission_rejected")
										|| filingInfo.get().getStatus().equals("submission_validation_failed"))) {
							model.addAttribute("step", "1");
						}
						if (filingInfo.get().getFincenId() != null) {
							model.addAttribute("FincenId", filingInfo.get().getFincenId());
						}
	
						for (BeneficialOwner b : beneficialOwners) {
							if (b.getBeneficialStatus() != null && b.getBeneficialStatus().equalsIgnoreCase("pending")) {
								model.addAttribute("step", "4");
							}
						}
					}
				} else {
					return "redirect:/dashboard";
				}
			}catch(Exception e) {
				return "redirect:/dashboard";
			}
		}
		model.addAttribute("refferalOptionHide", "refferalOptionHide");
		return "step-form";
	}
	
	
 
	@GetMapping("/boirdetails")
	public String getBoirDetailsForm(@RequestParam("trackingid") String trackingid, Model model) throws ParseException {
 		Optional<BeneficialOwner> beneficialOwnerO = beneficialOwnerRepository.findByBeneficialTrackId(trackingid);
		if(beneficialOwnerO.isPresent()) {
		BeneficialOwner beneficialOwner =  beneficialOwnerO.get();
		String dateString = beneficialOwner.getBenficialEmailSentDate();
		// Calculate the expiration date (3 months from now)
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		
			Date date = sdf.parse(dateString);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.MONTH, 3);
			Date expirationDate = calendar.getTime();
//			String expirationDateString = sdf.format(expirationDate);
			Date currentDate = new Date();
			if (currentDate.after(expirationDate)) {
 		        model.addAttribute("isExpired", "expired");
		        return "expiredBoirdetails";	
		    } else {
 		        model.addAttribute("isExpired", "notExpired");
		        return "boirdetails";	
		    }
		}else {
			return"expiredBoirdetails";
		}
		
	}

	@GetMapping("/boirfilingpreview/{id}")
	public String getFilingInfo(Model model, @PathVariable Long id) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		String principalName = "";
//		if (authentication != null) {
//			principalName = authentication.getName();
//		}

//		boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser")) {
//			isAuthenticated = authentication.isAuthenticated();
			model.addAttribute("isAuthenticated", true);
		}
		Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(id);
//		Map<String, Object> response = new HashMap<>();
		if (filingInfo.isPresent()) {
			model.addAttribute("success", true);
			model.addAttribute("filingInfo", filingInfo.get());// dateprepared getting error for not a type of Optional
			model.addAttribute("reportingCompany", reportingCompanyRepository.findByFilingInfoId(id));
			model.addAttribute("companyApplicant", companyApplicantRepository.findByFilingInfoId(id));// unable retive
																										// data if it is
																										// in array
			model.addAttribute("beneficialOwner", beneficialOwnerRepository.findByFilingInfoId(id));
		} else {
			model.addAttribute("success", false);
			model.addAttribute("status", "No Data Found for given key");
		}
		return "stepform-preview";
	}

	@GetMapping("/editboirfiling")
	public String getStepFormById(Model model, @PathParam(value = "filingInfoId") Long filingInfoId) {
		Optional<FilingInfo> filingInfo = filingInfoRepository.findById(filingInfoId);
		if (filingInfo.isPresent()) {
			model.addAttribute("filingInfo", filingInfo.get());
			return "step-form";
		}
		return "not-found";
	}

}
