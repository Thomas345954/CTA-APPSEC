package com.cta.boir.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cta.boir.model.FilingInfo;

public interface FilingInfoRepository extends JpaRepository<FilingInfo, Long> {

	@Query("SELECT u FROM FilingInfo u WHERE u.userId = :userId  order by datePrepared desc")
	List<FilingInfo> findByuserId(@Param("userId") String userId);

	@Query("SELECT u FROM FilingInfo u WHERE u.userId = :userId and u.status=:status order by datePrepared desc")
	List<FilingInfo> findByuserandstatus(@Param("userId") String userId, @Param("status") String status);

	@Query("SELECT u FROM FilingInfo u WHERE u.userId = :userId and u.status in ('submission_validation_failed','submission_accepted','submission_rejected') order by datePrepared desc")

	List<FilingInfo> findByuserandcompletestatus(@Param("userId") String userId);
    
	@Query("SELECT u FROM FilingInfo u WHERE u.userId = :userId and ((u.status in ('submission_accepted') and u.filingType='initial' and u.currentStatus = 'new') or (u.status IN ('submission_accepted') and u.filingType = 'initial' and u.currentStatus = 'correction')  and u.parentFilingInfoId IS NOT NULL and COALESCE(u.prevSubmissionStatus, 'NA') != 'NA') order by datePrepared desc")
	List<FilingInfo> checkFilingAvalability(@Param("userId") String userId);

	@Query("SELECT u From FilingInfo u where u.status not in ('submission_validation_failed','submission_accepted','submission_rejected') and  u.parentFilingInfoId = :filingInfoId")
	List<FilingInfo> checkCorrectionFiling(@Param("filingInfoId") Long filingInfoId);

	Optional<FilingInfo> findByFilingInfoId(Long id);

	List<FilingInfo> findBycreatedBy(String email);
}