package com.cta.boir.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cta.boir.model.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
}
