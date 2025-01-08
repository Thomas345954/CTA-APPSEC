package com.cta.boir.dto;

	public class RecaptchaResponse {

	private boolean success;
	private String challengeTimestamp;
	private String hostName;
	
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getChallengeTimestamp() {
		return challengeTimestamp;
	}
	public void setChallengeTimestamp(String challengeTimestamp) {
		this.challengeTimestamp = challengeTimestamp;
	}
	public String getHostName() {
		return hostName;
	}
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}
	}