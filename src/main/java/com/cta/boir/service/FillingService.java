package com.cta.boir.service;


import com.cta.boir.model.BeneficialOwner;
import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.repository.FilingInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class FillingService {
    @Autowired
    private FilingInfoRepository filingInfoRepository;

    public List<FilingInfo> getAllFilingInfo() {
        return filingInfoRepository.findAll();
    }
    public Optional<FilingInfo> getFilingInfoWithMaxValue(List<FilingInfo> filingInfos) {
        return filingInfos.stream()
                .filter(filingInfo -> filingInfo.getBoirId() != null)  // Filter out null values
                .max((f1, f2) -> f1.getBoirId().compareTo(f2.getBoirId()));  // Get the max value
    }

    public Optional<FilingInfo> getFilingInfoById(Long id) {
        return filingInfoRepository.findById(id);
    }

    public FilingInfo saveFilingInfo(FilingInfo filingInfo) {
        return filingInfoRepository.save(filingInfo);
    }

    public void deleteFilingInfo(Long id) {
    	filingInfoRepository.deleteById(id);
    }
    public List<FilingInfo>  wherefillininfoByUser(String id) {
    	
	  	List<FilingInfo> filingInfo = filingInfoRepository.findByuserId(id);
		return filingInfo;
     }
    
    
    public List<FilingInfo>  checkFilingAvalability(String id) {
    	
	  	List<FilingInfo> filingInfo = filingInfoRepository.checkFilingAvalability(id);
		return filingInfo;
     }
    public List<FilingInfo>  findByuserandstatus(String id,String Status) {
    	
	  	List<FilingInfo> filingInfo = filingInfoRepository.findByuserandstatus(id,Status);
		return filingInfo;
     }
    
     public List<FilingInfo>  findByuserandcompletestatus(String id) {
    	
	  	List<FilingInfo> filingInfo = filingInfoRepository.findByuserandcompletestatus(id);
		return filingInfo;
     }
    
     public List<FilingInfo> convertToFilingInfo(List<Map<String, Object>> filingdata) {
         return filingdata.stream().map(data -> {
             FilingInfo filingInfo = new FilingInfo();
             // Map the fields from the map to the FilingInfo object
             filingInfo.setFilingInfoId(Long.valueOf(data.get("filing_info_id").toString()));
             filingInfo.setStatus((String) data.get("status"));
             filingInfo.setDatePrepared((String) data.get("date_prepared"));
             filingInfo.setUserId((String) data.get("companyname"));
             filingInfo.setCreatedBy((String) data.get("created_by"));
             filingInfo.setFilingType((String)data.get("filing_type"));
         	 filingInfo.setBoirId((String)data.get("boir_id"));
         	 filingInfo.setPrevSubmissionStatus((String) data.get("benemailsentdate"));
         	 filingInfo.setTaxIdNum((String) data.get("taxidnum"));
         	 if (data.get("reportingcompanyid") != null) {
				filingInfo.setCountryOrJurisdiction(data.get("reportingcompanyid").toString());
			 } else {
				filingInfo.setCountryOrJurisdiction(null);
			 }
			 if (data.get("ownerid") != null) {
				filingInfo.setUpdatedBy(data.get("ownerid").toString());
			 } else {
				filingInfo.setUpdatedBy(null);
			 }
			 if (data.get("submitterid") != null) {
				filingInfo.setLegalName(data.get("submitterid").toString());
			 } else {
				filingInfo.setLegalName(null);
			 }
			 if (data.get("applicantid") != null) {
				filingInfo.setCurrentStatus(data.get("applicantid").toString());
			 } else {
				filingInfo.setCurrentStatus(null);
			 }
             return filingInfo;
         }).collect(Collectors.toList());
     }
     
     public List<BeneficialOwner> convertToBeneficialInfo(List<Map<String, Object>> beneficialdata) {
         return beneficialdata.stream().map(data -> {
        	 BeneficialOwner beneficialOwner = new BeneficialOwner();
             // Map the fields from the map to the FilingInfo object
        	 //beneficialOwner.setFirstName((String) data.get("first_name"));
        	 beneficialOwner.setFilingInfoId(Long.valueOf(data.get("filing_info_id").toString()));
        	 beneficialOwner.setBeneficialStatus((String) data.get("beneficial_status"));
             beneficialOwner.setSuffix((String) data.get("companyname"));
        	 beneficialOwner.setCreatedBy((String) data.get("created_by"));
        	 beneficialOwner.setBenficialEmail((String) data.get("benficial_email"));
        	 beneficialOwner.setBeneficialTrackId((String) data.get("beneficial_track_id"));
             return beneficialOwner;
         }).collect(Collectors.toList());
     }

    
    
}
