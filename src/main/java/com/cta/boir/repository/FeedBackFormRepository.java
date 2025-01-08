package com.cta.boir.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cta.boir.model.Feedback;

public interface FeedBackFormRepository extends JpaRepository<Feedback, Long> {

}
