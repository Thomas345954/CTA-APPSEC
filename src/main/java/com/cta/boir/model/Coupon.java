package com.cta.boir.model;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "coupon_t")
public class Coupon extends AuditModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;
    private String couponCode;
    private Date fromDate;
    private Date toDate;
    private String paymentTransactionId;
    private String flag1;
    private String flag2;  
    
    
}
