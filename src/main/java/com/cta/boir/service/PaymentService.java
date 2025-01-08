package com.cta.boir.service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cta.boir.model.OtpData;
import com.cta.boir.model.PaymentHistory;
import com.cta.boir.model.PaymentRequest;
import com.cta.boir.repository.OtpDataRepository;
import com.cta.boir.repository.PaymentRequestRepository;

@Service
public class PaymentService {
    @Autowired
    private PaymentRequestRepository paymentRequestRepository;

    public List<PaymentRequest> getAllPaymentRequestData() {
        return paymentRequestRepository.findAll();
    }

    public Optional<PaymentRequest> getPaymentRequestDataById(UUID id) {
        return paymentRequestRepository.findById(id);
    }

    public PaymentRequest savePaymentRequest(PaymentRequest paymentRequest) {
        return paymentRequestRepository.save(paymentRequest);
    }
 
    
 public List<PaymentRequest>  wherePaymentHistoryByTid(String id) {
    	
	  	List<PaymentRequest> paymentRequest = paymentRequestRepository.findBytransaction_id(id);
		return paymentRequest;
    }
    
}
