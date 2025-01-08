package com.cta.boir.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Data
public class CompanyApplicant extends AuditModel  {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long companyApplicantId;
    private Long filingInfoId;
    private Boolean existingRepoCompany;
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "company_applicant_id")
    private List<CompanyApplicantInfo> companyApplicantInfo;
}
