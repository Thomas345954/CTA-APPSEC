package com.cta.boir.repository;

import com.cta.boir.model.BankReferal;
import com.cta.boir.model.ReportingCompany;
import com.cta.boir.model.SubmitterDetails;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BankReferalRepository extends JpaRepository<BankReferal, Long> {
	BankReferal findByFilingInfoId(Long filingInfoId);

    void deleteByFilingInfoId(Long filingInfoId);
}
