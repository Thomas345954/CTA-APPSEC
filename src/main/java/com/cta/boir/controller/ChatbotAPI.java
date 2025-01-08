
package com.cta.boir.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cta.boir.model.BeneficialOwner;
import com.cta.boir.model.Feedback;
import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.PaymentRequest;
import com.cta.boir.model.ReportingCompany;
import com.cta.boir.repository.BeneficialOwnerRepository;
import com.cta.boir.repository.FeedBackFormRepository;
import com.cta.boir.repository.FilingInfoRepository;
import com.cta.boir.repository.PaymentHistoryRepository;
import com.cta.boir.repository.PaymentRequestRepository;
import com.cta.boir.repository.ReportingCompanyRepository;

@RestController
public class ChatbotAPI {
	@Autowired
	FilingInfoRepository filingInfoRepository;
	@Autowired
	PaymentHistoryRepository paymentHistoryRepository;
	@Autowired
	BeneficialOwnerRepository beneficialOwnerRepository;
	@Autowired
	PaymentRequestRepository paymentRequestRepository;
	@Autowired
	ReportingCompanyRepository reportingCompanyRepository;
	@Autowired
	FeedBackFormRepository feedBackFormRepository;

	@GetMapping("/validate")
	public String getValidation() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String principalName = "";
		String validate = "false";
		try {
		if (authentication != null && !authentication.getName().equals("anonymousUser")) {
			principalName = authentication.getName();
			validate = "true";
		}
		String response = String.format("{\"validationResult\": \"%s\",\"userEmail\":\"%s\", \"messagecode\": \"200\"}",
				validate, principalName);

		return response;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			String response = String.format("{\"validationResult\": \null\",\"userEmail\":\"null\", \"messagecode\": \"200\"}",
					validate, principalName);

			return response;
		}

	}

	@GetMapping("/ctaHarborBoirStatus1")

	public ResponseEntity<String> ctaHarborBoirStatus(@RequestParam("companyName") String companyName,
			@RequestParam("email") String email) {
		ReportingCompany reportingCompany = reportingCompanyRepository.findByReportingCompanyLegalNameAndCreatedBy(companyName, email);
		Long fillingInfoId = null;
		fillingInfoId = reportingCompany.getFilingInfoId();

		String status = null;
		try {
		if(reportingCompany!=null) {

		Optional<FilingInfo> FilingInfoList = filingInfoRepository.findByFilingInfoId(fillingInfoId);
		
			status = FilingInfoList.get().getStatus();
		}
		if(status.equals(""))
		{
			status=null;
		}
		String response = String.format("{\"ctaHarborBoirStatus1\": \"%s\", \"messagecode\": \"200\"}",
				status != null? status : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			String response = String.format("{\"ctaHarborBoirStatus1\": \"null\", \"messagecode\": \"200\"}",
					status != null? status : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaHarborBoirStatus")
	public ResponseEntity<String> ctaHarborBoirStatus(@RequestParam("email") String email) {

		String response = null;
		List<FilingInfo> FilingInfoList = filingInfoRepository.findBycreatedBy(email);
		String status = null;
		try {
		for (FilingInfo filinfo : FilingInfoList) {
			status = filinfo.getStatus();
		}

		if(status.equals(""))
		{
			status=null;
		}
			
		response = String.format("{\"ctaHarborBoirStatus\": \"%s\", \"messagecode\": \"200\"}",
				status != null ? status : null);

		return ResponseEntity.ok(response);
		}catch(Exception e)
		{
			response = String.format("{\"ctaHarborBoirStatus\": \"null\", \"messagecode\": \"200\"}",
					status != null ? status : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaHarborBoirPurchasedReport")

	public ResponseEntity<String> ctaHarborBoirPurchasedReport(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);

		Integer noOfFiles = 0;
		try {
		for (PaymentHistory payHist : paymentHistoryList) {
			String status = payHist.getAmount_status();

			if (status != null && status.equals("Completed")) {

				noOfFiles = noOfFiles + Integer.parseInt(payHist.getNofiles());
			}
		}


		String response = String.format("{\"ctaHarborBoirPurchasedReport\": \"%s\", \"messagecode\": \"200\"}",
				noOfFiles != 0 ? noOfFiles : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"ctaHarborBoirPurchasedReport\": \"null\", \"messagecode\": \"200\"}",
					noOfFiles != 0 ? noOfFiles : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaharborBeneficialOwnersCount")
	public ResponseEntity<String> ctaharborBeneficialOwnersCount(@RequestParam("companyName") String companyName,
			@RequestParam("email") String email) {
		String reportingCompanyName = null;
		int beneficialOwnersCount = 0;
		try {
		ReportingCompany reportingCompany = reportingCompanyRepository
				.findByReportingCompanyLegalNameAndCreatedBy(companyName, email);
		reportingCompanyName = reportingCompany.getReportingCompanyLegalName();
		if (reportingCompanyName != null) {
			List<ReportingCompany> reportingCompanyList = reportingCompanyRepository
					.findByReportingCompanyLegalName(reportingCompanyName);
			beneficialOwnersCount = reportingCompanyList.size();
		}
       if(reportingCompanyName.equals(""))
       {
    	   reportingCompanyName=null;
       }
		String response = String.format("{\"ctaharborBeneficialOwnersCount\": \"%s\", \"messagecode\": \"200\"}",
				beneficialOwnersCount != 0 ? beneficialOwnersCount : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"ctaharborBeneficialOwnersCount\": \"null\", \"messagecode\": \"200\"}",
					beneficialOwnersCount != 0 ? beneficialOwnersCount : null);

			return ResponseEntity.ok(response);
		}
	}

	@GetMapping("/ctaHarborPaymentCount")
	public ResponseEntity<String> ctaHarborPaymentCount(@RequestParam("email") String email) {

		List<PaymentHistory> PaymentHistoryList = paymentHistoryRepository.findBycreated_by(email);

		int paymentCount = 0;
		try {

		for (PaymentHistory payHist : PaymentHistoryList) {
			String amountStatus = payHist.getAmount_status();

			if (amountStatus.equals("Completed")) {
				paymentCount = paymentCount + 1;
			}

		}

		String response = String.format("{\"ctaHarborPaymentCount\": \"%s\", \"messagecode\": \"200\"}",
				paymentCount != 0 ? paymentCount : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"ctaHarborPaymentCount\": \"null\", \"messagecode\": \"200\"}",
					paymentCount != 0 ? paymentCount : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaharborPaymentHistory0Amount")
	public ResponseEntity<String> paymentHistoryInquiry1Amount(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		String latestAmount = null;
		try {
		for (PaymentHistory payHist : paymentHistoryList) {
			latestAmount = payHist.getAmount();
		}

		if(latestAmount.equals(""))
		{
			latestAmount=null;
		}
		String response = String.format("{\"ctaharborPaymentHistory0Amount\": \"%s\", \"messagecode\": \"200\"}",
				latestAmount != null ? latestAmount : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"ctaharborPaymentHistory0Amount\": \"null\", \"messagecode\": \"200\"}",
					latestAmount != null ? latestAmount : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaharborPaymentHistory0Date")
	public ResponseEntity<String> paymentHistoryInquiry1Date(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		Date latestDate = null;
		String formattedDate = null;
		try {
		for (PaymentHistory payHist : paymentHistoryList) {
			latestDate = payHist.getCreated_date();
		}
		
		if (latestDate != null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			formattedDate = dateFormat.format(latestDate);
		}

		String response = String.format("{\"ctaharborPaymentHistory0Date\": \"%s\", \"messagecode\": \"200\"}",
				formattedDate != null ? formattedDate : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"ctaharborPaymentHistory0Date\": \"%s\", \"messagecode\": \"200\"}",
					formattedDate != null ? formattedDate : null);
			return ResponseEntity.ok(response);

		}

	}

	@GetMapping("/ctaharborPaymentHistory1Amount")
	public ResponseEntity<String> paymentHistoryInquiry2Amount(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		String lastSecondAmount = null;
		try {
		if (paymentHistoryList.size() >= 2) {

			PaymentHistory payHist = paymentHistoryList.get(paymentHistoryList.size() - 2);

			lastSecondAmount = payHist.getAmount();
		}
		if(lastSecondAmount.equals(""))
		{
			lastSecondAmount=null;
		}

		String response = String.format("{\"ctaharborPaymentHistory1Amount\": \"%s\", \"messagecode\": \"200\"}",
				lastSecondAmount != null ? lastSecondAmount : null);

		return ResponseEntity.ok(response);

	}
		catch(Exception e)
		{
			String response = String.format("{\"ctaharborPaymentHistory1Amount\": \"%s\", \"messagecode\": \"200\"}",
					lastSecondAmount != null ? lastSecondAmount : null);

			return ResponseEntity.ok(response);

		}
	}
	

	@GetMapping("/ctaharborPaymentHistory1Date")
	public ResponseEntity<String> paymentHistoryInquiry2Date(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		Date lastSecondDate = null;
		String formattedDate = null;
		try {
		if (paymentHistoryList.size() >= 2) {

			PaymentHistory payHist = paymentHistoryList.get(paymentHistoryList.size() - 2);

			lastSecondDate = payHist.getCreated_date();
		}
		if(formattedDate.equals(""))
		{
			formattedDate=null;
		}
		
		if (lastSecondDate != null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			formattedDate = dateFormat.format(lastSecondDate);
		}

		String response = String.format("{\"ctaharborPaymentHistory1Date\": \"%s\", \"messagecode\": \"200\"}",
				formattedDate != null ? formattedDate : null);

		return ResponseEntity.ok(response);
 }
 catch(Exception e)
 {
	 String response = String.format("{\"ctaharborPaymentHistory1Date\": \"null\", \"messagecode\": \"200\"}",
				formattedDate != null ? formattedDate : null);

		return ResponseEntity.ok(response);
 }

	}

	@GetMapping("/ctaharborPaymentHistory2Amount")
	public ResponseEntity<String> paymentHistoryInquiry3Amount(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		String lastThirdAmount = null;
		try {
		if (paymentHistoryList.size() >= 3) {

			PaymentHistory payHist = paymentHistoryList.get(paymentHistoryList.size() - 3);

			lastThirdAmount = payHist.getAmount();
		}
        if(lastThirdAmount.equals(""))
        {
        	lastThirdAmount=null;	
        }
		String response = String.format("{\"ctaharborPaymentHistory2Amount\": \"%s\", \"messagecode\": \"200\"}",
				lastThirdAmount != null ? lastThirdAmount : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"ctaharborPaymentHistory2Amount\": \"null\", \"messagecode\": \"200\"}",
					lastThirdAmount != null ? lastThirdAmount : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaharborPaymentHistory2Date")
	public ResponseEntity<String> paymentHistoryInquiry3Date(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		Date lastThirdDate = null;
		String formattedDate = null;
		try {
		if (paymentHistoryList.size() >= 3) {

			PaymentHistory payHist = paymentHistoryList.get(paymentHistoryList.size() - 3);

			lastThirdDate = payHist.getCreated_date();
		}
		
		if(formattedDate.equals(""))
		{
			formattedDate=null;	
		}
		
		if (lastThirdDate != null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			formattedDate = dateFormat.format(lastThirdDate);
		}

		String response = String.format("{\"ctaharborPaymentHistory2Amount\": \"%s\", \"messagecode\": \"200\"}",
				formattedDate != null ? formattedDate : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			e.printStackTrace();

			String response = String.format("{\"ctaharborPaymentHistory2Amount\": \"null\", \"messagecode\": \"200\"}",
					formattedDate != null ? formattedDate : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaharboirLastAccessDate")
	public ResponseEntity<String> ctaharboirLastAccessDate(@RequestParam("email") String email) {
		String formattedDate = null;
		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		
		try {
		Date lastAccessDate = null;
		for (PaymentHistory payHist : paymentHistoryList) {
			lastAccessDate = payHist.getCreated_date();
		}
		
		if (lastAccessDate != null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			formattedDate = dateFormat.format(lastAccessDate);
		}
		if(formattedDate.equals(""))
		{
			formattedDate=null;
		}

		String response = String.format("{\"ctaharboirLastAccessDate\": \"%s\", \"messagecode\": \"200\"}",
				formattedDate != null ? formattedDate : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			String response = String.format("{\"ctaharboirLastAccessDate\": \null\", \"messagecode\": \"200\"}",
					formattedDate != null ? formattedDate : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaharboirLastAccessTime")
	public ResponseEntity<String> ctaharboirLastAccessTime(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		Date lastAccessTime = null;
		String formattedTime =null;
		
		try {
		for (PaymentHistory payHist : paymentHistoryList) {
			lastAccessTime = payHist.getCreated_date();
		
		}
		
		if (lastAccessTime != null) {
			SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
			formattedTime = timeFormat.format(lastAccessTime);
		}
		if(formattedTime.equals(""))
		{
			formattedTime=null;
		}

		String response = String.format("{\"ctaharboirLastAccessTime\": \"%s\", \"messagecode\": \"200\"}",
				formattedTime != null ? formattedTime : null);

		return ResponseEntity.ok(response);
	
		
		}
		
		catch(Exception e)
		{

			String response = String.format("{\"ctaharboirLastAccessTime\": \"null\", \"messagecode\": \"200\"}",
					formattedTime != null ? formattedTime : null);
			
			return ResponseEntity.ok(response); 

		}
	}

	@GetMapping("/ctaharborLatestBoirId")
	public ResponseEntity<String> latestBoirId(@RequestParam("email") String email) {

		List<FilingInfo> filingInfoList = filingInfoRepository.findBycreatedBy(email);
		String latestBoirId = null;

		try {
		for (FilingInfo filInfo : filingInfoList) {
			String boirId = filInfo.getBoirId();

			if (boirId != null && !boirId.isEmpty() && !"null".equals(boirId)) {
				latestBoirId = boirId; 
			}
		}
		if(latestBoirId.equals(""))
		{
			latestBoirId=null;
		}

		String response = String.format("{\"ctaharborLatestBoirId\": \"%s\", \"messagecode\": \"200\"}",
				latestBoirId != null ? latestBoirId : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"ctaharborLatestBoirId\": \"null\", \"messagecode\": \"200\"}",
					latestBoirId != null ? latestBoirId : null);

			return ResponseEntity.ok(response);
			}
		}

	

	@GetMapping("/ctaharborLatestBoirStartDate")
	public ResponseEntity<String> ctaharborLatestBoirStartDate(@RequestParam("email") String email) {

		List<FilingInfo> filingInfoList = filingInfoRepository.findBycreatedBy(email);
		Date LatestBoirStartDate = null;
		String formattedDate = null;
		try {
		for (FilingInfo filInfo : filingInfoList) {
			LatestBoirStartDate = filInfo.getCreatedDate();
		}
		
		if (LatestBoirStartDate != null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			formattedDate = dateFormat.format(LatestBoirStartDate);
		}
         if(formattedDate.equals(""))
         {
        	 formattedDate=null;
         }
		String response = String.format("{\"ctaharborLatestBoirStartDate\": \"%s\", \"messagecode\": \"200\"}",
				formattedDate != null ? formattedDate : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"ctaharborLatestBoirStartDate\": \"null\", \"messagecode\": \"200\"}",
					formattedDate != null ? formattedDate : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/latestBoirTaxId")
	public ResponseEntity<String> latestBoirTaxId(@RequestParam("email") String email) {
		String LatestBoirTaxId = null;
		try {
		List<FilingInfo> filingInfoList = filingInfoRepository.findBycreatedBy(email);
		
		for (FilingInfo filInfo : filingInfoList) {
			String taxId = filInfo.getTaxIdNum();

			
			if (taxId != null && !taxId.isEmpty() && !"null".equals(taxId)) {
				LatestBoirTaxId = filInfo.getTaxIdNum();
			}
		}
		if(LatestBoirTaxId.equals(""))
		{
			LatestBoirTaxId=null;
		}
		if (LatestBoirTaxId == null || LatestBoirTaxId.equals("")) {
			LatestBoirTaxId = null;
		}

		String response = String.format("{\"latestBoirTaxId\": \"%s\", \"messagecode\": \"200\"}",
				LatestBoirTaxId != null ? LatestBoirTaxId : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{

			String response = String.format("{\"latestBoirTaxId\": \"null\", \"messagecode\": \"200\"}",
					LatestBoirTaxId != null ? LatestBoirTaxId : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/latestFinCenId")
	public ResponseEntity<String> latestFinCenId(@RequestParam("email") String email) {

		List<FilingInfo> filingInfoList = filingInfoRepository.findBycreatedBy(email);
		String latestFinCenId = null;
          try {
		for (FilingInfo filInfo : filingInfoList) {
			String fincenId = filInfo.getFincenId();



			if (fincenId != null && !fincenId.isEmpty() && !fincenId.equalsIgnoreCase("null")) {
				latestFinCenId = fincenId;
			}
		}
        if(latestFinCenId.equals(""))
        {
        	latestFinCenId=null;
        }
		String response = String.format("{\"latestFinCenId\": \"%s\", \"messagecode\": \"200\"}",
				latestFinCenId != null ? latestFinCenId : null);

		return ResponseEntity.ok(response);
          }
          catch(Exception e)
          {
        	  String response = String.format("{\"latestFinCenId\": \"null\", \"messagecode\": \"200\"}",
      				latestFinCenId != null ? latestFinCenId : null);

      		return ResponseEntity.ok(response);  
          }
	}

	@GetMapping("/latestPaymentMode")
	public ResponseEntity<String> latestPaymentMode(@RequestParam("email") String email) {

		List<PaymentRequest> paymentRequestList = paymentRequestRepository.findBycreatedBy(email);
		String paymentMode = null;
		try {
		for (PaymentRequest payReq : paymentRequestList) {
			paymentMode = payReq.getPaymentGateway();

		}
		if(paymentMode.equals(""))
		{
			paymentMode=null;
		}

		String response = String.format("{\"ctaharborlatestPaymentMode\": \"%s\", \"messagecode\": \"200\"}",
				paymentMode != null ? paymentMode : null);

		return ResponseEntity.ok(response);

	}
		catch(Exception e)
		{
			String response = String.format("{\"ctaharborlatestPaymentMode\": \"null\", \"messagecode\": \"200\"}",
					paymentMode != null ? paymentMode : null);

			return ResponseEntity.ok(response);
		}
		
	}

	@GetMapping("/totalBoirFilesAmount")
	public ResponseEntity<String> totalBoirFilesAmount(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		int totalBoirFilesAmount = 0;
		try {
		for (PaymentHistory payHis : paymentHistoryList) {
			if (!payHis.getAmount().equals(null)) {
				totalBoirFilesAmount = totalBoirFilesAmount + Integer.parseInt(payHis.getAmount());
			}

		}

		String response = String.format("{\"totalBoirFilesAmount\": \"%s\", \"messagecode\": \"200\"}",
				totalBoirFilesAmount != 0 ? totalBoirFilesAmount : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"totalBoirFilesAmount\": \"null\", \"messagecode\": \"200\"}",
					totalBoirFilesAmount != 0 ? totalBoirFilesAmount : null);

			return ResponseEntity.ok(response);
			
		}
	}

	@GetMapping("/lastNoOfFiles")
	public ResponseEntity<String> lastNoOfFiles(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		String lastNoOfFiles = null;
         try {
		for (PaymentHistory payHis : paymentHistoryList) {
			if (!payHis.getNofiles().equals(null) && payHis.getAmount_status().equals("Completed")) {
				lastNoOfFiles = payHis.getNofiles();
			}

		}
		if(lastNoOfFiles.equals(""))
		{
			lastNoOfFiles=null;
		}

		String response = String.format("{\"lastNoOfFiles\": \"%s\", \"messagecode\": \"200\"}",
				lastNoOfFiles != null ? lastNoOfFiles : null);

		return ResponseEntity.ok(response);
         }
         catch(Exception e)
         {
        	 String response = String.format("{\"lastNoOfFiles\": \"null\", \"messagecode\": \"200\"}",
     				lastNoOfFiles != null ? lastNoOfFiles : null);

     		return ResponseEntity.ok(response);
         }

	}

	@GetMapping("/lastCreatedDate")
	public ResponseEntity<String> lastCreatedDate(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		Date lastCreatedDate = null;
		String formattedDate = null;
		try {
		for (PaymentHistory payHis : paymentHistoryList) {
			if (!payHis.getCreated_date().equals(null)) {
				lastCreatedDate = payHis.getCreated_date();
			}

		}
		if(formattedDate.equals(""))
		{
			formattedDate=null;
		}
		
		if (lastCreatedDate != null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			formattedDate = dateFormat.format(lastCreatedDate);
		}

		String response = String.format("{\"lastCreatedDate\": \"%s\", \"messagecode\": \"200\"}",
				formattedDate != null ? formattedDate : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			
			String response = String.format("{\"lastCreatedDate\": \"null\", \"messagecode\": \"200\"}",
					formattedDate != null ? formattedDate : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/lastBoirCouponCode")
	public ResponseEntity<String> lastBoirCouponCode(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		String lastBoirCouponCode = null;
		try {
		for (PaymentHistory payHis : paymentHistoryList) {
			String couponCode = payHis.getCoupon_code();
			if (couponCode != null && !couponCode.isEmpty() && !couponCode.equalsIgnoreCase("null")) {
				lastBoirCouponCode = couponCode;
			}

		}
		if(lastBoirCouponCode.equals(""))
		{
			lastBoirCouponCode=null;
		}
		String response = String.format("{\"lastBoirCouponCode\": \"%s\", \"messagecode\": \"200\"}",
				lastBoirCouponCode != null ? lastBoirCouponCode : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"lastBoirCouponCode\": \"null\", \"messagecode\": \"200\"}",
					lastBoirCouponCode != null ? lastBoirCouponCode : null);

			return ResponseEntity.ok(response);
			
		}

	}

	@GetMapping("/lastReportingCompany")
	public ResponseEntity<String> lastReportingCompany(@RequestParam("email") String email) {

		List<ReportingCompany> reportingCompanyList = reportingCompanyRepository.findBycreatedBy(email);
		String lastReportingCompany = null;
		try {
		for (ReportingCompany repComp : reportingCompanyList) {
			String reportingCompany = repComp.getReportingCompanyLegalName();
			if (reportingCompany != null && !reportingCompany.isEmpty() && !reportingCompany.equalsIgnoreCase("null")) {
				lastReportingCompany = reportingCompany;
			}
			if(lastReportingCompany.equals(""))
			{
				lastReportingCompany=null;
			}

		}
		String response = String.format("{\"lastReportingCompany\": \"%s\", \"messagecode\": \"200\"}",
				lastReportingCompany != null ? lastReportingCompany : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"lastReportingCompany\": \"null\", \"messagecode\": \"200\"}",
					lastReportingCompany != null ? lastReportingCompany : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaharborUpdateDate")
	public ResponseEntity<String> ctaharborupdatedate(@RequestParam("company") String companyName,
			@RequestParam("email") String email) {
		Date updateDate = null;
		String formattedDate = null;
		try {
		ReportingCompany reportingCompany = reportingCompanyRepository
				.findByReportingCompanyLegalNameAndCreatedBy(companyName, email);
		if(reportingCompany!=null) {
		updateDate = reportingCompany.getUpdateDate();}
		
		if (updateDate != null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			formattedDate = dateFormat.format(updateDate);
		}
		if(formattedDate.equals(""))
		{
			formattedDate=null;
		}

		String response = String.format("{\"ctaharborupdatedate\": \"%s\", \"messagecode\": \"200\"}",
				formattedDate != null ? formattedDate : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"ctaharborupdatedate\": \"null\", \"messagecode\": \"200\"}",
					formattedDate != null ? formattedDate : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaharborPaymentStatus")
	public ResponseEntity<String> ctaharborPaymentStatus(@RequestParam("email") String email) {

		List<PaymentHistory> paymentHistoryList = paymentHistoryRepository.findBycreated_by(email);
		String latestBoirAmountStatus = null;
		try {
		for (PaymentHistory payHis : paymentHistoryList) {
			latestBoirAmountStatus = payHis.getAmount_status();

		}
		if(latestBoirAmountStatus.equals(""))
		{
			latestBoirAmountStatus=null;
		}
		String response = String.format("{\"ctaharborPaymentStatus\": \"%s\", \"messagecode\": \"200\"}",
				latestBoirAmountStatus != null ? latestBoirAmountStatus : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"ctaharborPaymentStatus\": \"null\", \"messagecode\": \"200\"}",
					latestBoirAmountStatus != null ? latestBoirAmountStatus : null);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/ctaharborBoirFilesInProgressCount")
	public ResponseEntity<String> ctaharborBoirFilesInProgressCount(@RequestParam("email") String email) {
		String status = null;
		Long parentFilingInfo = null;
		List<FilingInfo> FilingInfoList = filingInfoRepository.findBycreatedBy(email);
		int boirFilesInProgressCount = 0;
		try {
		for (FilingInfo fillInfo : FilingInfoList) {
			status = fillInfo.getStatus();
			parentFilingInfo = fillInfo.getParentFilingInfoId();

			if (parentFilingInfo == null && status != null && status.equals("In Progress")) {
				boirFilesInProgressCount = boirFilesInProgressCount + 1;
			}

		}
		String response = String.format(
			    "{\"ctaharborBoirFilesInProgressCount\": \"%s\", \"messagecode\": \"200\"}",
			    boirFilesInProgressCount != 0? boirFilesInProgressCount : null
			);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format(
				    "{\"ctaharborBoirFilesInProgressCount\": \"null\", \"messagecode\": \"200\"}",
				    boirFilesInProgressCount != 0? boirFilesInProgressCount : null
				);
			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/boirStartDate")
	public ResponseEntity<String> boirStartDate(@RequestParam("company") String companyName,
			@RequestParam("email") String email) {
		Date startDate = null;
		Long fillingInfoId = null;
		String formattedDate = null;
		ReportingCompany reportingCompany = reportingCompanyRepository.findByReportingCompanyLegalNameAndCreatedBy(companyName, email);
		try {
		if (reportingCompany != null) {
			fillingInfoId = reportingCompany.getFilingInfoId();
		}
		if (fillingInfoId != null) {
			Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(fillingInfoId);
			startDate = filingInfo.get().getCreatedDate();
		}
		
		if (startDate != null) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			formattedDate = dateFormat.format(startDate);
		}

		if(formattedDate.equals(""))
		{
			formattedDate=null;
		}
		String response = String.format("{\"boirStartDate\": \"%s\", \"messagecode\": \"200\"}",
				formattedDate != null|| !formattedDate.equals("")? formattedDate : null);
		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"boirStartDate\": \"null\", \"messagecode\": \"200\"}",
					formattedDate != null|| !formattedDate.equals("")? formattedDate : null);
			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/taxId")
	public ResponseEntity<String> taxId(@RequestParam("company") String companyName,
			@RequestParam("email") String email) {

		Long fillingInfoId = null;
		String taxId = null;
		ReportingCompany reportingCompany = reportingCompanyRepository.findByReportingCompanyLegalNameAndCreatedBy(companyName, email);
		try {
		if(reportingCompany!=null) {
		fillingInfoId = reportingCompany.getFilingInfoId();}
		if (fillingInfoId != null) {
			Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(fillingInfoId);
			taxId = filingInfo.get().getTaxIdNum();
		}
        if(taxId.equals(""))
        {
        	taxId=null;
        }
		String response = String.format("{\"taxId\": \"%s\", \"messagecode\": \"200\"}", taxId != null ||!taxId.equals("")? taxId : null);
		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"taxId\": \"null\", \"messagecode\": \"200\"}", taxId != null ||!taxId.equals("")? taxId : null);
			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/finCENID")
	public ResponseEntity<String> finCENID(@RequestParam("company") String companyName,
			@RequestParam("email") String email) {
		Long fillingInfoId = null;
		String fincenId = null;
		ReportingCompany reportingCompany = reportingCompanyRepository
				.findByReportingCompanyLegalNameAndCreatedBy(companyName, email);
		try {
		if (reportingCompany != null) {
			fillingInfoId = reportingCompany.getFilingInfoId();

		}
		if (fillingInfoId != null) {
			Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(fillingInfoId);
			fincenId = filingInfo.get().getFincenId();
		}
		if(fincenId.equals(""))
		{
			fincenId=null;
		}

		
		String response = String.format(
			    "{\"finCENID\": \"%s\", \"messagecode\": \"200\"}",
			    (fincenId != null && !fincenId.isEmpty()) ? fincenId : null);

		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format(
				    "{\"finCENID\": \"null\", \"messagecode\": \"200\"}",
				    (fincenId != null && !fincenId.isEmpty()) ? fincenId : null
				);

			return ResponseEntity.ok(response);
		}

	}

	@GetMapping("/boirId")
	public ResponseEntity<String> boirId(@RequestParam("company") String companyName,@RequestParam("email") String email) {
		long fillingInfoId = 0;
		String boirId = null;
		ReportingCompany reportingCompany = reportingCompanyRepository
				.findByReportingCompanyLegalNameAndCreatedBy(companyName, email);
		try {
		if (reportingCompany != null) {
			fillingInfoId = reportingCompany.getFilingInfoId();

		}
		if(boirId.equals(""))
		{
			boirId=null;
		}

		if (fillingInfoId != 0) {
			Optional<FilingInfo> filingInfo = filingInfoRepository.findByFilingInfoId(fillingInfoId);
			boirId = filingInfo.get().getBoirId();
		}

		String response = String.format("{\"finCENID\": \"%s\", \"messagecode\": \"200\"}",
				boirId != null ||boirId!=""? boirId : null);
		return ResponseEntity.ok(response);
		}
		catch(Exception e)
		{
			String response = String.format("{\"finCENID\": \"null\", \"messagecode\": \"200\"}",
					boirId != null ||boirId!=""? boirId : null);
			return ResponseEntity.ok(response);
			
		}

	}
	//saving the  data 
	@PostMapping("/saveFeedBack")
	public Feedback saveFeedback(@RequestParam("email") String email,
	                             @RequestParam("feedbackMessage") String feedbackMessage,
	                             @RequestParam("Rating") String rating) {
	    try {
	        Feedback form = new Feedback();
	        form.setEmail(email);
	        form.setFeedbackMessage(feedbackMessage);
	        form.setRating(rating);

	        return feedBackFormRepository.save(form);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null; // Return null or handle the error appropriately
	    }
	}
}



