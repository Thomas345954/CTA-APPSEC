package com.cta.boir.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.UUID;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class OtpData extends AuditModel {
    @Id
    private UUID id = UUID.randomUUID(); 
    private Long otp;
    private Long phone;
    private String email;
	private int retry;
	private String otpVerify;
	private Timestamp expiryTime;
	private Date creationDate = new Date();
	private Date updateDate;
	public Long getOtp() {
		return otp;
	}
	public void setOtp(Long otp) {
		this.otp = otp;
	}
	public Long getPhone() {
		return phone;
	}
	public void setPhone(Long phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
     
}
