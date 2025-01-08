package com.cta.boir.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class Token {
	public Layout layout;
    public DetectedBreak detectedBreak;
    public ArrayList<DetectedLanguage> detectedLanguages;

}
