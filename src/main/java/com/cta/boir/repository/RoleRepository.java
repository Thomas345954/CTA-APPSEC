package com.cta.boir.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import com.cta.boir.model.Role;

public interface RoleRepository extends JpaRepository<Role, Long> {
    Role findByName(String name);
}
