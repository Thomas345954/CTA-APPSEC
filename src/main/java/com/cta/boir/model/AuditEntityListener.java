package com.cta.boir.model;

import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;

public class AuditEntityListener {

    @PrePersist
    @PreUpdate
    public void setIpAddress(AuditModel entity) {
        // Get the current IP address from the AuditorAware or Filter
        String ipAddress = AuditConfig.AuditorAwareImpl.getCurrentUserIpAddress().orElse("UNKNOWN");
        entity.setIpAddress(ipAddress);
    }
}
