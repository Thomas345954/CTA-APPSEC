package com.cta.boir.model;

import java.util.Optional;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.cta.boir.config.IpAddressAuditorFilter;

@Configuration
@EnableJpaAuditing(auditorAwareRef = "auditorProvider")
public class AuditConfig {

    @Bean
    public AuditorAware<String> auditorProvider() {
        return new AuditorAwareImpl();
    }

    public static class AuditorAwareImpl implements AuditorAware<String> {

        @Override
        public Optional<String> getCurrentAuditor() {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

            if (authentication == null || !authentication.isAuthenticated()) {
                return Optional.empty();
            }

            // Assuming the logged-in user implements UserDetails
            if (authentication.getPrincipal() instanceof UserDetails) {
                UserDetails userDetails = (UserDetails) authentication.getPrincipal();
                 return Optional.ofNullable(userDetails.getUsername());
            } else {
                 return Optional.of(authentication.getPrincipal().toString());
            }
        }
        
        public static Optional<String> getCurrentUserIpAddress() {
            String ipAddress = IpAddressAuditorFilter.getCurrentIpAddress();
            return Optional.ofNullable(ipAddress);
        }
    }
    
 
}
