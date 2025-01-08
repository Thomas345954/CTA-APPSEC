package com.cta.boir.controller;

import com.cta.boir.repository.*;
import com.cta.boir.model.BeneficialOwner;
import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.ReportingCompany;
import com.cta.boir.model.SubmitterDetails;
import com.cta.boir.repository.BeneficialOwnerRepository;
import com.cta.boir.repository.CompanyApplicantRepository;
import com.cta.boir.repository.FilingInfoRepository;
import com.cta.boir.repository.ReportingCompanyRepository;
import com.cta.boir.repository.SubmitterDetailsRepository;
import com.cta.boir.service.PdfGenerationService;
import com.cta.boir.service.UserService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itextpdf.text.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;
import java.net.URI;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class CertificateController {
	@Autowired
	RestTemplate restTemplate;
    @Autowired(required=true)
    private PdfGenerationService pdfGenerationService;
    private final FilingInfoRepository filingInfoRepository;
	private final BeneficialOwnerRepository beneficialOwnerRepository;
	private final ReportingCompanyRepository reportingCompanyRepository;
	private final SubmitterDetailsRepository submitterDetailsRepository;
	
	@Value("${certificateDomain}")
	private String certificateDomain;
	@Value("${certificatePdfDomain}")
	private String certificatePdfDomain;
	
	public CertificateController(FilingInfoRepository filingInfoRepository,
			BeneficialOwnerRepository beneficialOwnerRepository, CompanyApplicantRepository companyApplicantRepository,
			ReportingCompanyRepository reportingCompanyRepository,
			SubmitterDetailsRepository submitterDetailsRepository, UserService userService) {
		this.filingInfoRepository = filingInfoRepository;
		this.beneficialOwnerRepository = beneficialOwnerRepository;
		this.reportingCompanyRepository = reportingCompanyRepository;
		this.submitterDetailsRepository = submitterDetailsRepository;
	}
    @GetMapping("/pdfcertificate/{id}/{userName}")
    @ResponseBody
    public void generateCertificatePdf(@PathVariable("id") String id, 
                                       @PathVariable("userName") String username,
                                       jakarta.servlet.http.HttpServletResponse response) throws IOException, DocumentException, com.lowagie.text.DocumentException {
        // Define the URL of the HTML page
        String htmlPageUrl = certificatePdfDomain+id+"/"+username;

        // Fetch the HTML content from the URL
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> htmlResponse = restTemplate.getForEntity(htmlPageUrl, String.class);
        String htmlContent = htmlResponse.getBody();

        // Generate the PDF
        byte[] pdfBytes = pdfGenerationService.generatePdfFromHtml(htmlContent);

        // Set the response headers
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=certificate.pdf");
        response.getOutputStream().write(pdfBytes);
    }
    @GetMapping("/certificate/{id}/{userName}")
	public String getCertificate(@PathVariable Long id, Model model, @PathVariable String userName) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String principalName = "";
		if (authentication != null) {
			principalName = authentication.getName();
		}


		
	//	boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser") && authentication.isAuthenticated()) {
			// isAuthenticated = authentication.isAuthenticated();
			model.addAttribute("isAuthenticated", true);
		}
		model.addAttribute("certificatename", userName);
		Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(id);
		ReportingCompany reportingCompany = reportingCompanyRepository.findByFilingInfoId(id);
		model.addAttribute("filingInfoId", reportingCompany.getFilingInfoId());
		if (filingInfo.isPresent()) {
    	    model.addAttribute("boirid",filingInfo.get().getBoirId() );
    	    LocalDate date = LocalDate.parse(filingInfo.get().getDatePrepared());
    		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
    		String formattedDate = date.format(formatter);
    		model.addAttribute("filingInfodate", formattedDate);
		} else {
			model.addAttribute("filingInfodate", "Date not available");
		}
		model.addAttribute("reportingCompanyName", reportingCompany.getReportingCompanyLegalName());
		SubmitterDetails submitterDetails = submitterDetailsRepository.findByFilingInfoId(id);
		model.addAttribute("submitterFname", submitterDetails.getFirstName());
		model.addAttribute("submitterLname", submitterDetails.getLastName());

		 List<BeneficialOwner> beneficialOwner =beneficialOwnerRepository.findByFilingInfoId(id);
		 List<String> submitterNames = new ArrayList<>();

			
		 
		 
		// Added if condition for get names if user selects finCEN ID in beneficial
			for (BeneficialOwner owner : beneficialOwner) {
				if (!owner.getFirstName().isEmpty() && !owner.getLegalName().isEmpty()) {
					submitterNames.add(owner.getFirstName() + " " + owner.getLegalName());
					if(userName.equals("XXXXXXXX")) {
						userName=owner.getFirstName() + " " + owner.getLegalName();
						model.addAttribute("certificatename", userName);
					}
				} else if(owner.getFirstName().isEmpty() && !owner.getLegalName().isEmpty()) {
					submitterNames.add(owner.getLegalName());
					if(userName.equals("XXXXXXXX")) {
						userName=owner.getLegalName();
						model.addAttribute("certificatename", userName);
					}
				}else {
					submitterNames.add(owner.getFfirstName() + " " + owner.getFlegalName());
					if(userName.equals("XXXXXXXX")) {
						userName=owner.getFfirstName() + " " + owner.getFlegalName();
						model.addAttribute("certificatename", userName);
					}
				}
			}
			
		 model.addAttribute("submitternames",submitterNames);
		 model.addAttribute("DomainURL",certificateDomain+id+"/"+userName);
		 model.addAttribute("DownloadIcons", "true");
		 model.addAttribute("referralLink", "https://ctadev.micnxt.com");
		 if (beneficialOwner.size() > 1) {
			    model.addAttribute("multipleBeneficialOwners", true);
			}
		
		return "certificate";
	}
    @GetMapping("/BOIRCertificate/{id}/{userName}")
	public String getBoirCertificate(@PathVariable Long id, Model model, @PathVariable String userName) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		/*
		 * String principalName = ""; if (authentication != null) { principalName =
		 * authentication.getName(); }
		 */

		//boolean isAuthenticated = false;
		if (authentication != null && !authentication.getPrincipal().toString().equals("anonymousUser") && authentication.isAuthenticated()) {
			//isAuthenticated = authentication.isAuthenticated();
			model.addAttribute("isAuthenticated", true);
		}
		model.addAttribute("certificatename", userName);
		Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(id);
		ReportingCompany reportingCompany = reportingCompanyRepository.findByFilingInfoId(id);
		model.addAttribute("filingInfoId", reportingCompany.getFilingInfoId());
		if (filingInfo.isPresent()) {
    	    model.addAttribute("boirid",filingInfo.get().getBoirId() );
    	    LocalDate date = LocalDate.parse(filingInfo.get().getDatePrepared());
    		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
    		String formattedDate = date.format(formatter);
    		model.addAttribute("filingInfodate", formattedDate);
		} else {
			model.addAttribute("filingInfodate", "Date not available");
		}
		model.addAttribute("reportingCompanyName", reportingCompany.getReportingCompanyLegalName());
		SubmitterDetails submitterDetails = submitterDetailsRepository.findByFilingInfoId(id);
		model.addAttribute("submitterFname", submitterDetails.getFirstName());
		model.addAttribute("submitterLname", submitterDetails.getLastName());

		 List<BeneficialOwner> beneficialOwner =beneficialOwnerRepository.findByFilingInfoId(id);
		 for (BeneficialOwner owner : beneficialOwner) {
			 if (!owner.getFirstName().isEmpty() && !owner.getLegalName().isEmpty()) {
				 model.addAttribute("submitternames", owner.getFirstName() + " " + owner.getLegalName());
			} else if(owner.getFirstName().isEmpty() && !owner.getLegalName().isEmpty()) {
				model.addAttribute("submitternames", owner.getLegalName());
			}else {
				model.addAttribute("submitternames", owner.getFfirstName() + " " + owner.getFlegalName());
			}
		 }

		return "certificate";
	}
}
