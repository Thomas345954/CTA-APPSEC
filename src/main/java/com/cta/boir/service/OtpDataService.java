package com.cta.boir.service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cta.boir.model.OtpData;
import com.cta.boir.repository.OtpDataRepository;

@Service
public class OtpDataService {
    @Autowired
    private OtpDataRepository otpDataRepository;

    public List<OtpData> getAllOtpData() {
        return otpDataRepository.findAll();
    }

    public Optional<OtpData> getOtpDataById(UUID id) {
        return otpDataRepository.findById(id);
    }

    public List<OtpData> getOtpDataByEmail(String email) {
        return otpDataRepository.findOtpDataByEmail(email);
    }
    
    
    public OtpData saveOtpData(OtpData otpData) {
        return otpDataRepository.save(otpData);
    }
 
}
