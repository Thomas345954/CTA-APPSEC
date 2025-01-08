package com.cta.boir.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cta.boir.model.User;

public interface UserRepository extends JpaRepository<User, Long> {
	User findByEmail(String email);
}
