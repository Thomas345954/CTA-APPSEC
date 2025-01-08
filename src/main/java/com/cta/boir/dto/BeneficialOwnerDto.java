package com.cta.boir.dto;

import com.cta.boir.model.BeneficialOwner;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BeneficialOwnerDto {
    private Long filingInfoId;
    private String trackingid;
    private List<BeneficialOwner> beneficialOwner;
}

