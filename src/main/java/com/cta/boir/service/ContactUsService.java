package com.cta.boir.service;

import com.cta.boir.model.ContactUs;
import com.cta.boir.repository.ContactUsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ContactUsService {
    @Autowired
    private ContactUsRepository contactUsRepository;

    public List<ContactUs> getAllContactUs() {
        return contactUsRepository.findAll();
    }

    public Optional<ContactUs> getContactUsById(Long id) {
        return contactUsRepository.findById(id);
    }

    public ContactUs saveContactUs(ContactUs contactUs) {
        return contactUsRepository.save(contactUs);
    }

    

}
