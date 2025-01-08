package com.cta.boir.service;

import com.cta.boir.model.Coupon;
import com.cta.boir.model.GeneratedCoupon;
import com.cta.boir.repository.CouponRepository;
import com.cta.boir.repository.GeneratedCouponRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CouponService {
	
	@Autowired
    private CouponRepository couponRepository;
	
	public List<Coupon> getAllCoupon() {
        return couponRepository.findAll();
    }

    public Optional<Coupon> getCouponById(Long id) {
        return couponRepository.findById(id);
    }

    public Coupon saveCoupon(Coupon coupon) {
        return couponRepository.save(coupon);
    }
   
}
