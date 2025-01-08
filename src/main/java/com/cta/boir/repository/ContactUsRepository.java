package com.cta.boir.repository;

import com.cta.boir.model.ContactUs;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ContactUsRepository extends JpaRepository<ContactUs, Long> {
	
	
}
