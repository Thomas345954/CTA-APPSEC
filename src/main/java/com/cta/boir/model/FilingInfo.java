package com.cta.boir.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class FilingInfo extends AuditModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long filingInfoId;
    private String datePrepared;
    private String userId;
    private String filingType;
    private String status;
    private String legalName;
    private String taxIdType;
    private String taxIdNum;
    private String countryOrJurisdiction;
    private String processId;
    private String boirId;
    private String fincenId;
    private Long parentFilingInfoId;
    private String currentStatus;
    private String prevSubmissionStatus;
}
