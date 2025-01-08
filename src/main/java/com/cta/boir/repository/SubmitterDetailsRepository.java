package com.cta.boir.repository;

import com.cta.boir.model.ReportingCompany;
import com.cta.boir.model.SubmitterDetails;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SubmitterDetailsRepository extends JpaRepository<SubmitterDetails, Long> {
    SubmitterDetails findByFilingInfoId(Long filingInfoId);

    void deleteByFilingInfoId(Long filingInfoId);
}
