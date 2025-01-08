package com.cta.boir.repository;

import com.cta.boir.model.CompanyApplicant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompanyApplicantRepository extends JpaRepository<CompanyApplicant, Long> {
    CompanyApplicant findByFilingInfoId(Long filingInfoId);

    void deleteByFilingInfoId(Long filingInfoId);
}
