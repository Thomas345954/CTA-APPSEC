package com.cta.boir.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cta.boir.model.OtpData;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.PaymentRequest;

public interface PaymentRequestRepository extends JpaRepository<PaymentRequest, UUID> {
	@Query("SELECT u FROM PaymentRequest u WHERE u.transactionId = :transactionId")
	List<PaymentRequest> findBytransaction_id(@Param("transactionId") String transaction_id);

	List<PaymentRequest> findBycreatedBy(String email);
}
