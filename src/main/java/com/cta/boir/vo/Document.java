package com.cta.boir.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class Document{
    
    public String uri;
    public String mimeType;
    public String text;
    public ArrayList<Page> pages;
    public ArrayList<Entity> entities;
}
