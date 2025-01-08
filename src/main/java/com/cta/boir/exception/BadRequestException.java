package com.cta.boir.exception;



public class BadRequestException extends RuntimeException{

    private final String message;

    public String getMessage() {
		return message;
	}

	public BadRequestException(String message) {
        super(message);
        this.message = message;
    }
}
