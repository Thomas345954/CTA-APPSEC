package com.cta.boir.model;

import java.io.Serializable;
import java.util.Date;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import jakarta.persistence.Column;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Data;


@MappedSuperclass
@EntityListeners({AuditingEntityListener.class, AuditEntityListener.class})
@Data
public abstract class AuditModel implements Serializable {
	
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date",  updatable = false)
    @CreatedDate
    private Date createdDate;

    @Column(name = "created_by",updatable = false)
    @CreatedBy
    private String createdBy;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "update_date")
    @LastModifiedDate
    private Date updateDate;
    
 
    @Column(name = "updated_by")
    @LastModifiedBy
    private String updatedBy;
    
    @Column(name = "ip_address")
    private String ipAddress;
    
}