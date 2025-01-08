package com.cta.boir.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.UUID;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class PaymentRequest extends AuditModel {
    @Id
    private UUID id = UUID.randomUUID(); 
    private String userId;
    private String paymentIntentId;
    private double amount;
    private String paymentGateway;
    private String transactionId;
    private String nooffiles;
    private String planId;
    private String couponCode;
     
}
