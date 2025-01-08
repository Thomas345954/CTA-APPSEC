package com.cta.boir.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class Line {
	public Layout layout;
    public ArrayList<DetectedLanguage> detectedLanguages;

}
