package com.cta.boir.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class IdentificationDocument extends AuditModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long identificationDocumentId;
    private String documentType;
    private String documentNumber;
    private String issuerCountry;
    private String issuerState;
    private String issuerLocalOrTribal;
    private String otherLocalDesc;
    private String documentPath;
    private String documentName;
}
