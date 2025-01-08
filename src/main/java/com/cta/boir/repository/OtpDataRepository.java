package com.cta.boir.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cta.boir.model.OtpData;
import com.cta.boir.model.PaymentRequest;

public interface OtpDataRepository extends JpaRepository<OtpData, UUID> {
	
	@Query("SELECT u FROM OtpData u WHERE u.email = :email order by creationDate desc")
	List<OtpData> findOtpDataByEmail(@Param("email") String email);
	
}
