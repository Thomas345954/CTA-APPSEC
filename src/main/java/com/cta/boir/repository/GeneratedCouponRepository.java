package com.cta.boir.repository;


import com.cta.boir.model.GeneratedCoupon;
import com.cta.boir.model.PaymentRequest;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface GeneratedCouponRepository extends JpaRepository<GeneratedCoupon, Long> {
	
	@Query("SELECT u FROM GeneratedCoupon u WHERE u.couponCode = :couponCode")
	List<GeneratedCoupon> findBytransaction_couponCode(@Param("couponCode") String couponCode);

}
