package com.cta.boir.service;


import com.cta.boir.model.GeneratedCoupon;

import com.cta.boir.repository.GeneratedCouponRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class GeneratedCouponService {
	
	@Autowired
    private GeneratedCouponRepository generatedCouponRepository;
	
	public List<GeneratedCoupon> getAllGeneratedCoupon() {
        return generatedCouponRepository.findAll();
    }

    public Optional<GeneratedCoupon> getGeneratedCouponById(Long id) {
        return generatedCouponRepository.findById(id);
    }
    
    public List<GeneratedCoupon> getGeneratedCouponBycode(String couponcode) {
        return generatedCouponRepository.findBytransaction_couponCode(couponcode);
    }

    public GeneratedCoupon saveGeneratedCoupon(GeneratedCoupon generatedCoupon) {
        return generatedCouponRepository.save(generatedCoupon);
    }
}
