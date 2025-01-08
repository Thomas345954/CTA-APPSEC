package com.cta.boir.vo;

import lombok.Data;

@Data
public class Layout {
	public TextAnchor textAnchor;
	public double confidence;
	public BoundingPoly boundingPoly;
	public String orientation;

}
