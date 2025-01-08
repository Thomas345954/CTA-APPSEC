package com.cta.boir.service;

import com.cta.boir.model.Employee;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.repository.EmployeeRepository;
import com.cta.boir.repository.PaymentHistoryRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PaymentHistoryService {
    @Autowired
    private PaymentHistoryRepository paymentHistoryRepository;

    public List<PaymentHistory> getAllPaymentHistory() {
        return paymentHistoryRepository.findAll();
    }
    
    public List<PaymentHistory> getAllCouponcodePaymentHistory() {
        return paymentHistoryRepository.findByCouponCodeIsNotNull();
    }
    
    public Optional<PaymentHistory> getPaymentHistoryById(Long id) {
        return paymentHistoryRepository.findById(id);
    }

    public PaymentHistory savePaymentHistory(PaymentHistory paymentHistory) {
        return paymentHistoryRepository.save(paymentHistory);
    }

    public void deletePaymentHistory(Long id) {
    	paymentHistoryRepository.deleteById(id);
    }
    public List<PaymentHistory>  wherePaymentHistoryByUser(String id) {
    	
    	  	List<PaymentHistory> paymentHistory = paymentHistoryRepository.findBycreated_by(id);
			return paymentHistory;
    }
    public List<PaymentHistory>  wherePaymentHistoryByTid(String id) {
    	
	  	List<PaymentHistory> paymentHistory = paymentHistoryRepository.findBytransaction_id(id);
		return paymentHistory;
    }
    
 public List<PaymentHistory>  findbycoupon_code(String couponcode) {
    	
	  	List<PaymentHistory> paymentHistory = paymentHistoryRepository.findbycoupon_code(couponcode);
		return paymentHistory;
    }
    
    
}
