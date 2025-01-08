package com.cta.boir.exception;

public class GCPFileUploadException extends RuntimeException{

    private final String message;

    public String getMessage() {
		return message;
	}
    
    public GCPFileUploadException(String message) {
        super(message);
        this.message = message;
    }
}
