package com.cta.boir.exception;

public class FileWriteException extends RuntimeException{

    private final String message;
    
    public String getMessage() {
		return message;
	}

    public FileWriteException(String message) {
        super(message);
        this.message = message;
    }
}
