package com.cta.boir.model;

import java.util.Date;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class BeneficialOwner extends AuditModel  {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long beneficialOwnerId;
    private Long filingInfoId;
    private Boolean isMinorChild;
    private String finCenId;
    private Boolean exemptEntity;
    private String legalName;
    private String firstName;
    private String flegalName;
    private String ffirstName;
    private String middleName;
    private String benficialEmail;
    private String benficialEmailSentDate;
    private String beneficialTrackId;
    private String beneficialStatus;
    private String suffix;
    private String dateOfBirth;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "address_id")
    private Address address;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "identification_document_id")
    private IdentificationDocument identificationDocuments;

}

