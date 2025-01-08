package com.cta.boir.vo;

import lombok.Data;

@Data
public class DocumentApiRequest {
	
	private boolean skipHumanReview;
	private RawDocument rawDocument;

}
