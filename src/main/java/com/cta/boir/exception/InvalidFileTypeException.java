package com.cta.boir.exception;

public class InvalidFileTypeException extends RuntimeException{

    private final String message;

    public String getMessage() {
		return message;
	}
    
    public InvalidFileTypeException(String message) {
        super(message);
        this.message = message;
    }
}
