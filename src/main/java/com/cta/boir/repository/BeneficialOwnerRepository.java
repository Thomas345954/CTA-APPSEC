package com.cta.boir.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cta.boir.model.BeneficialOwner;

public interface BeneficialOwnerRepository extends JpaRepository<BeneficialOwner, Long> {
	
    List<BeneficialOwner> findByFilingInfoId(Long filingInfoId);
    


    List<BeneficialOwner> findBycreatedBy(String createdBy);
   
    Optional<BeneficialOwner> findByBeneficialTrackId(String uuid);
    void deleteByFilingInfoId(Long filingInfoId);
}
    
