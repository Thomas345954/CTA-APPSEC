package com.cta.boir.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cta.boir.model.PaymentHistory;

public interface PaymentHistoryRepository extends JpaRepository<PaymentHistory, Long> {

	   @Query("SELECT u FROM PaymentHistory u WHERE u.created_by = :created_by order by created_date desc")
	    List<PaymentHistory> findBycreated_by(@Param("created_by") String created_by);
	   
	   
	   @Query("SELECT u FROM PaymentHistory u WHERE u.transaction_id = :transaction_id order by created_date desc")
	    List<PaymentHistory> findBytransaction_id(@Param("transaction_id") String transaction_id);
	   
	   @Query("SELECT u FROM PaymentHistory u WHERE u.coupon_code = :coupon_code order by created_date desc")
	    List<PaymentHistory> findbycoupon_code(@Param("coupon_code") String coupon_code);
	   
	   @Query("SELECT u FROM PaymentHistory u WHERE u.coupon_code IS NOT NULL AND coupon_code <> ''")	
	    List<PaymentHistory> findByCouponCodeIsNotNull();
	     
	   
}
