package com.cta.boir.vo;

import lombok.Data;

@Data
public class Entity {
	
	private TextAnchor textAnchor;
    private String type;
    private String mentionText;
    private double confidence;
    private PageAnchor pageAnchor;
    private String id;
    private NormalizedValue normalizedValue;

}
