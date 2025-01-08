package com.cta.boir.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Data
public class ReportingCompany extends AuditModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long reportingCompanyId;
    private Long filingInfoId;
    private Boolean requestToReceiveFinCenId;
    private Boolean foreignPooledInvestmentVehicle;
    private Boolean foreignPooledInvestmentVehicle2;
    private String reportingCompanyLegalName;
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "reporting_company_id")
    private List<AlternateName> alternateName;
    private String taxIdentificationType;
    private String taxIdentificationNumber;
    private String countryOrJurisdictionRep;
    private String countryOrJurisdictionFormation;
    private String stateFormation;
    private String tribalJurisdictionFormation;
    private String otherTribeFormation;
    private String stateFirstRegistration;
    private String tribalJurisdictionFirstRegistration;
    private String otherTribeFirstRegistration;
    private String dateOfIncorporation;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "address_id")
    private Address reportingAddress;
}
