package com.cta.boir.repository;

import com.cta.boir.model.FilingInfo;
import com.cta.boir.model.ReportingCompany;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ReportingCompanyRepository extends JpaRepository<ReportingCompany, Long> {
	ReportingCompany findByFilingInfoId(Long filingInfoId);

	void deleteByFilingInfoId(Long filingInfoId);

	List<ReportingCompany> findBycreatedBy(String email);
	ReportingCompany findByReportingCompanyLegalNameAndCreatedBy(String companyName,String  email);
	List<ReportingCompany> findByReportingCompanyLegalName (String company);

}
