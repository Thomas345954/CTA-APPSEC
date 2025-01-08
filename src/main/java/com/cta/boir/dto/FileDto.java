package com.cta.boir.dto;

import com.cta.boir.vo.DocumentResponse;

public class FileDto {

    private String fileName;
    private String fileUrl;
    private transient DocumentResponse response;
    
	public FileDto(String fileName, String fileUrl) {
		this.fileName = fileName;
		this.fileUrl = fileUrl;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public DocumentResponse getResponse() {
		return response;
	}
	public void setResponse(DocumentResponse response) {
		this.response = response;
	}
	
	
    
}
