package com.cta.boir.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class Page {

	public int pageNumber;
	public Dimension dimension;
	public Layout layout;
	public ArrayList<DetectedLanguage> detectedLanguages;
	public ArrayList<Block> blocks;
	public ArrayList<Paragraph> paragraphs;
	public ArrayList<Line> lines;
	public ArrayList<Token> tokens;
	public Image image;

}
