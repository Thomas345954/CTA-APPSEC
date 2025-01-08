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
@Table(name = "generated_coupon_t")
public class GeneratedCoupon extends AuditModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;
    private String couponType;
    private String couponCode;
    private Date fromDate;
    private Date toDate;
    private String flag1;
    private String flag2;
    private String numberOfTimes; 
    private String percentage; 
    
    
}
